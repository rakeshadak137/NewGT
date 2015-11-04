package com.transaction

import annotation.ParentScreen
import com.master.AccountMaster
import com.master.DivisionMaster
import com.master.GodownMaster
import com.master.ProductMaster

@ParentScreen(name = "Report", subUnder = "Report", fullName = "Stock Report")
class StockReportController {
    def jasperService
    def index() {
        render(view: "print");
    }
    def stockOutDatewise(){

        def reportDetails=[]
        def child=[]
        def parent
        if(params.fdate && params.tdate){
            def data=OutEntry.findAllByVoucherDateBetween(Date.parse("yyyy-MM-dd",params.fdate),Date.parse("yyyy-MM-dd",params.tdate))
            if(data){
                data.each {d->
                    def data2=OutEntryDetails.findAllByOutEntry(d as OutEntry)
                    if(data2){
                        data2.each {d2->
                            def prodName=LREntryDetails.findByLrEntryAndInvoiceNo(LREntry.findByLrNo(d2.lrNo),d2.invoiceNo)
//                            def prodName=LREntryDetails.findByLrEntryAndInvoiceNo(LREntry.findByLrNoAndFinancialYear(d2.lrNo,FinancialYear.findById(session['financialYear'].id)),d2.invoiceNo)
                            child.push([
                                    vehicleNo:d?.vehicle?:"",
                                    inv:d2?.invoiceNo?:"",
                                    fromTo:(d?.fromCustomer?.accountName)+" To "+(d?.toCustomer?.accountName),
                                    partNo:prodName?.productName?.productCode?:"",
                                    desc:prodName?.productName?.productName?:"",
                                    qty:d2?.invoiceQty?:""
                            ])
                        }

                    }
                }
                if(child){
                    parent=[
                            details:child,
                            fromDate:Date.parse("yyyy-MM-dd",params.fdate).format("dd-MM-yyyy"),
                            toDate:Date.parse("yyyy-MM-dd",params.tdate).format("dd-MM-yyyy")
                    ]
                }
                if(parent){
                    reportDetails.push(parent);
                }
            }
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/datewiseoutentry"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"

        chain(controller: 'transactionReport', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def print_action(){
        def reportDetails = [];
        def parent;
        def child = [];

        def Data = StockInOut.createCriteria().list {
            eq("branch",session['branch'])
            eq("status","IN")

            if(params.fromParty){
                eq("fromCustomer",AccountMaster.findById(params.fromParty as Long))
            }
            if(params.toParty){
                eq("toCustomer",AccountMaster.findById(params.toParty as Long))
            }
            if(params.itemName){
                eq("productName",ProductMaster.findById(params.itemName as Long))
            }
            if(params.fromDate && params.toDate){
                between("lrDate",Date.parse("yyyy-MM-dd",params.fromDate),Date.parse("yyyy-MM-dd",params.toDate))
            }else if(params.fromDate){
                ge("lrDate",Date.parse("yyyy-MM-dd",params.fromDate))
            }else if(params.toDate){
                le("lrDate",Date.parse("yyyy-MM-dd",params.toDate))
            }
        }

        if(Data){
            int srNo = 0;
            Data.each {d ->
                srNo++;

                child.push([
                        srNo : srNo,
                        itemCode : d?.productName?.productCode?:"",
                        fromParty : d?.fromCustomer?.accountName?:"",
                        toParty : d?.toCustomer?.accountName?:"",
                        invoiceNo : d.invoiceNo?:"",
                        date : d?.invoiceDate?.format("dd-MM-yyyy")?:"",
                        qty : d?.invoiceQty?:0
                ])
            }
        }

        parent = [
                child : child,
                fromParty : params.fromParty?AccountMaster.findById(params.fromParty as Long).accountName:"",
                toParty : params.toParty?AccountMaster.findById(params.toParty as Long).accountName:"",
                fromDate: params.fromDate?Date.parse("yyyy-MM-dd",params.fromDate)?.format("dd-MM-yyyy"):"",
                toDate: params.toDate?Date.parse("yyyy-MM-dd",params.toDate)?.format("dd-MM-yyyy"):"",
                itemName : params.itemName?ProductMaster.findById(params.itemName as Long).productCode + " - "+ ProductMaster.findById(params.itemName as Long).productName:""
        ];

        reportDetails.push(parent);
        params._format = params.format;
        params._file = "../reports/transactionReport/stockReportPartyDatewise"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'stockReport', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def print_action1(){
        def reportDetails = [];
        def finalData;
        def godownParent = [];
        def divParent = [];
        def child = [];

        def divisionData = DivisionMaster.createCriteria().list {
            eq("isActive",true)
        }

        if(params.godownName){
            def godownData = GodownMaster.createCriteria().list {
                eq("id",params.godownName as Long)
                eq("isActive",true)
            }

            if(godownData){
                godownData.each {g ->
                    divParent = [];
                    if(divisionData){
                        divisionData.each {d ->
                            child = [];
                            def Data = StockInOut.createCriteria().list {
                                eq("branch",session['branch'])
                                eq("status","IN")
                                eq("godown",g as GodownMaster)
                                eq("productName",ProductMaster.findByDivision(d as DivisionMaster))

                                if(params.fromDate && params.toDate){
                                    between("lrDate",Date.parse("yyyy-MM-dd",params.fromDate),Date.parse("yyyy-MM-dd",params.toDate))
                                }else if(params.fromDate){
                                    ge("lrDate",Date.parse("yyyy-MM-dd",params.fromDate))
                                }else if(params.toDate){
                                    le("lrDate",Date.parse("yyyy-MM-dd",params.toDate))
                                }
                            }

                            if(Data){
                                int srNo = 0;

                                Data.each {d1 ->
                                    srNo++;
                                    child.push([
                                            srNo : srNo,
                                            itemCode : d1?.productName?.productCode?:"",
                                            fromParty : d1?.fromCustomer?.accountName?:"",
                                            toParty : d1?.toCustomer?.accountName?:"",
                                            invoiceNo : d1.invoiceNo?:"",
                                            date : "",
                                            qty : d1?.invoiceQty?:0
                                    ])
                                }
                            }
                            if(child) {
                                divParent.push([
                                        child       : child,
                                        divisionName: d?.divisionName ?: ""
                                ])
                            }
                        }
                    }
                    if(divParent) {
                        godownParent.push([
                                divParent : divParent,
                                godownName: g?.godownName ?: ""
                        ])
                    }
                }
            }
        }else{
            def godownData = GodownMaster.createCriteria().list {
                eq("isActive",true)
            }

            if(godownData){
                godownData.each {g ->
                    divParent = [];
                    if(divisionData){
                        divisionData.each {d ->
                            child = [];

                            def Data = StockInOut.createCriteria().list {
                                eq("branch",session['branch'])
                                eq("status","IN")
                                eq("godown",g as GodownMaster)
                                eq("productName",ProductMaster.findByDivision(d as DivisionMaster))

                                if(params.fromDate && params.toDate){
                                    between("lrDate",Date.parse("yyyy-MM-dd",params.fromDate),Date.parse("yyyy-MM-dd",params.toDate))
                                }else if(params.fromDate){
                                    ge("lrDate",Date.parse("yyyy-MM-dd",params.fromDate))
                                }else if(params.toDate){
                                    le("lrDate",Date.parse("yyyy-MM-dd",params.toDate))
                                }
                            }

                            if(Data){
                                int srNo = 0;
                                Data.each {d1 ->
                                    srNo++;
                                    child.push([
                                            srNo : srNo,
                                            itemCode : d1?.productName?.productCode?:"",
                                            fromParty : d1?.fromCustomer?.accountName?:"",
                                            toParty : d1?.toCustomer?.accountName?:"",
                                            invoiceNo : d1.invoiceNo?:"",
                                            date : "",
                                            qty : d1?.invoiceQty?:0
                                    ])
                                }
                            }
                            if(child) {
                                divParent.push([
                                        child       : child,
                                        divisionName: d?.divisionName ?: ""
                                ])
                            }
                        }
                    }
                    if(divParent) {
                        godownParent.push([
                                divParent : divParent,
                                godownName: g?.godownName ?: ""
                        ])
                    }
                }
            }
        }

        finalData = [
                details : godownParent
        ];

        reportDetails.push(finalData);
        params._format = params.format;
        params._file = "../reports/transactionReport/stockReportGodownwise"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'stockReport', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def print_action2(){
        def reportDetails = [];
        def finalData;
        def parent = [];
        def child = [];

        if(params.divName){
            def divisionData = DivisionMaster.createCriteria().list {
                eq("isActive",true)
                eq("id",params.divName as Long)
            }

            if(divisionData){
                divisionData.each {d ->
                    child = [];

                    def Data = StockInOut.createCriteria().list {
                        eq("branch",session['branch'])
                        eq("status","IN")
                        eq("productName",ProductMaster.findByDivision(d as DivisionMaster))

                        if(params.fromDate && params.toDate){
                            between("lrDate",Date.parse("yyyy-MM-dd",params.fromDate),Date.parse("yyyy-MM-dd",params.toDate))
                        }else if(params.fromDate){
                            ge("lrDate",Date.parse("yyyy-MM-dd",params.fromDate))
                        }else if(params.toDate){
                            le("lrDate",Date.parse("yyyy-MM-dd",params.toDate))
                        }
                    }

                    if(Data){
                        int srNo = 0;
                        Data.each {d1 ->
                            srNo++;
                            child.push([
                                    srNo : srNo,
                                    itemCode : d1?.productName?.productCode?:"",
                                    fromParty : d1?.fromCustomer?.accountName?:"",
                                    toParty : d1?.toCustomer?.accountName?:"",
                                    invoiceNo : d1.invoiceNo?:"",
                                    date : "",
                                    qty : d1?.invoiceQty?:0
                            ])
                        }
                    }
                    if(child) {
                        parent.push([
                                child       : child,
                                divisionName: d?.divisionName ?: ""
                        ])
                    }
                }
            }
        }else{
            def divisionData = DivisionMaster.createCriteria().list {
                eq("isActive",true)
            }

            if(divisionData){
                divisionData.each {d ->
                    child = [];

                    def Data = StockInOut.createCriteria().list {
                        eq("branch",session['branch'])
                        eq("status","IN")
                        eq("productName",ProductMaster.findByDivision(d as DivisionMaster))

                        if(params.fromDate && params.toDate){
                            between("lrDate",Date.parse("yyyy-MM-dd",params.fromDate),Date.parse("yyyy-MM-dd",params.toDate))
                        }else if(params.fromDate){
                            ge("lrDate",Date.parse("yyyy-MM-dd",params.fromDate))
                        }else if(params.toDate){
                            le("lrDate",Date.parse("yyyy-MM-dd",params.toDate))
                        }
                    }

                    if(Data){
                        int srNo = 0;
                        Data.each {d1 ->
                            srNo++;
                            child.push([
                                    srNo : srNo,
                                    itemCode : d1?.productName?.productCode?:"",
                                    fromParty : d1?.fromCustomer?.accountName?:"",
                                    toParty : d1?.toCustomer?.accountName?:"",
                                    invoiceNo : d1.invoiceNo?:"",
                                    date : "",
                                    qty : d1?.invoiceQty?:0
                            ])
                        }
                    }
                    if(child) {
                        parent.push([
                                child       : child,
                                divisionName: d?.divisionName ?: ""
                        ])
                    }
                }
            }
        }

        finalData = [
                details : parent
        ];

        reportDetails.push(finalData);
        params._format = params.format;
        params._file = "../reports/transactionReport/stockReportDivionwise"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'stockReport', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def generateReport = {
        def reportModel = this.getProperties().containsKey('chainModel') ? chainModel : null
        def report = jasperService.buildReportDefinition(params, request.getLocale(), reportModel)
        generateResponse(report)
    }

    def generateResponse = { reportDef ->
        if (!reportDef.fileFormat.inline && !reportDef.parameters._inline) {
            //response.setHeader("Content-disposition", "attachment; filename=\"${reportDef.parameters._name ?: reportDef.name}.${reportDef.fileFormat.extension}\"");
            response.contentType = reportDef.fileFormat.mimeTyp
            response.characterEncoding = "UTF-8"
            response.outputStream << reportDef.contentStream.toByteArray()
        } else {
            render(text: reportDef.contentStream, contentType: reportDef.fileFormat.mimeTyp, encoding: reportDef.parameters.encoding ? reportDef.parameters.encoding : 'UTF-8');
        }
    }
}
