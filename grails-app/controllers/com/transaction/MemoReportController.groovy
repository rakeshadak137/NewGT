package com.transaction

import annotation.ParentScreen
import com.master.AccountMaster
import com.master.VehicleMaster
import grails.converters.JSON

@ParentScreen(name = "Report", subUnder = "Report", fullName = "Memo Report")

class MemoReportController {
    def jasperService

    def index() {
        render(view: "print");
    }

    def memoData() {
        def child = [];
        def iData = InternalMemo.createCriteria().list {
            eq("branch", session['branch'])
            eq("isActive",true)

            if ((params.fromDate != "undefined") && (params.toDate != "undefined")) {
                between("voucherDate", Date.parse("yyyy-MM-dd", params.fromDate), Date.parse("yyyy-MM-dd", params.toDate))
            } else if (params.fromDate != "undefined") {
                ge("voucherDate", Date.parse("yyyy-MM-dd", params.fromDate))
            } else if (params.toDate != "undefined") {
                le("voucherDate", Date.parse("yyyy-MM-dd", params.toDate))
            }
        }

        def Data = InternalMemoDetails.createCriteria().list {
            if (params.fromParty != "undefined") {
                eq("fromCustomer", AccountMaster.findById(params.fromParty as Long))
            }

            if (params.toParty != "undefined") {
                eq("toCustomer", AccountMaster.findById(params.toParty as Long))
            }

            projections {
                property("internalMemo")
                inList("internalMemo",iData)
            }
        }

        def uniqueData = Data.unique();

        if (uniqueData) {
            uniqueData.each { c ->
                def data = InternalMemo.createCriteria().get {
                    eq("branch", session['branch'])
                    eq("id",c.id as Long)
                    eq("isActive",true)

                    if ((params.fromDate != "undefined") && (params.toDate != "undefined")) {
                        between("voucherDate", Date.parse("yyyy-MM-dd", params.fromDate), Date.parse("yyyy-MM-dd", params.toDate))
                    } else if (params.fromDate != "undefined") {
                        ge("voucherDate", Date.parse("yyyy-MM-dd", params.fromDate))
                    } else if (params.toDate != "undefined") {
                        le("voucherDate", Date.parse("yyyy-MM-dd", params.toDate))
                    }
                }

                if(data){
                    child.push(data);
                }
            }
        }

        if (child) {
            render child as JSON;
        }else{
            render iData as JSON;
        }
    }

    def print_action(){
        def reportDetails = [];
        def finalData;
        def parent = [];
        def child = [];

        if(params.memoNo){
            def Data = [];

            Data = InternalMemo.createCriteria().get {
                eq("id",params.memoNo as Long)
            }

            if(Data){
                Data.each {d ->
                    int srNo = 0;
                    def childData = d?.internalMemoDetails;

                    if(childData){
                        childData.each {c ->
                            srNo++;

                            child.push([
                                    srNo : srNo,
                                    lrNo : c?.lrNo?:"",
                                    lrDate : c?.lrDate?.format("dd-MM-yyyy")?:"",
                                    fromParty : c?.fromCustomer?.accountName?:"",
                                    toParty : c?.toCustomer?.accountName?:"",
                                    vehicleNo : (d?.vehicleNo?.state?:"")+" - "+(d?.vehicleNo?.rto?:"")+
                                            " "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:"")
                            ]);
                        }
                    }

                    if(child){
                        parent.push([
                                child : child,
                                memoNo : d?.voucherNo?:"",
                                memoDate : d?.voucherDate?.format("dd-MM-yyyy")?:"",
                                vehicleNo : (d?.vehicleNo?.state?:"")+" - "+(d?.vehicleNo?.rto?:"")+
                                        " "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:""),
                                tripLocation : d?.tripLocation?.location?:"",
                                tripRate : d?.tripRate?:0,
                                balance : d?.totalBalance?:0,
                                receiptNo : d?.dieselReceiptNo?:"",
                                pumpName : d?.pumpName?.pumpName?:""
                        ]);
                    }
                }
            }
        }else {
            def iData = InternalMemo.createCriteria().list {
                eq("branch", session['branch'])
                eq("isActive",true)

                if ((params.fromDate) && (params.toDate)) {
                    between("voucherDate", Date.parse("yyyy-MM-dd", params.fromDate), Date.parse("yyyy-MM-dd", params.toDate))
                } else if (params.fromDate) {
                    ge("voucherDate", Date.parse("yyyy-MM-dd", params.fromDate))
                } else if (params.toDate) {
                    le("voucherDate", Date.parse("yyyy-MM-dd", params.toDate))
                }
            }

            def Data = InternalMemoDetails.createCriteria().list {
                if (params.fromParty) {
                    eq("fromCustomer", AccountMaster.findById(params.fromParty as Long))
                }

                if (params.toParty) {
                    eq("toCustomer", AccountMaster.findById(params.toParty as Long))
                }

                projections {
                    property("internalMemo")
                    inList("internalMemo",iData)
                }
            }.unique()

            if(!Data){
                Data = InternalMemo.createCriteria().list {
                    eq("branch", session['branch'])
                    eq("isActive",true)

                    if ((params.fromDate) && (params.toDate)) {
                        between("voucherDate", Date.parse("yyyy-MM-dd", params.fromDate), Date.parse("yyyy-MM-dd", params.toDate))
                    } else if (params.fromDate) {
                        ge("voucherDate", Date.parse("yyyy-MM-dd", params.fromDate))
                    } else if (params.toDate) {
                        le("voucherDate", Date.parse("yyyy-MM-dd", params.toDate))
                    }
                }
            }

            if(Data){
                Data.each {d ->
                    int srNo = 0;
                    child = [];
                    def childData = d?.internalMemoDetails;

                    if(childData){
                        childData.each {c ->
                            srNo++;

                            child.push([
                                    srNo : srNo,
                                    lrNo : c?.lrNo?:"",
                                    lrDate : c?.lrDate?.format("dd-MM-yyyy")?:"",
                                    fromParty : c?.fromCustomer?.accountName?:"",
                                    toParty : c?.toCustomer?.accountName?:"",
                                    vehicleNo : (d?.vehicleNo?.state?:"")+" - "+(d?.vehicleNo?.rto?:"")+
                                            " "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:"")
                            ]);
                        }
                    }

                    if(child){
                        parent.push([
                                child : child,
                                memoNo : d?.voucherNo?:"",
                                memoDate : d?.voucherDate?.format("dd-MM-yyyy")?:"",
                                vehicleNo : (d?.vehicleNo?.state?:"")+" - "+(d?.vehicleNo?.rto?:"")+
                                        " "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:""),
                                tripLocation : d?.tripLocation?.location?:"",
                                tripRate : d?.tripRate?:0,
                                balance : d?.totalBalance?:0,
                                receiptNo : d?.dieselReceiptNo?:"",
                                pumpName : d?.pumpName?.pumpName?:""
                        ]);
                    }
                }
            }
        }

        finalData = [
                parent : parent,
                reportName : "memoReportPartyDatewise_subreport1.jasper",
                fromParty : params.fromParty?AccountMaster.findById(params.fromParty as Long).accountName:"",
                toParty : params.toParty?AccountMaster.findById(params.toParty as Long).accountName:"",
                fromDate: params.fromDate?Date.parse("yyyy-MM-dd",params.fromDate)?.format("dd-MM-yyyy"):"",
                toDate: params.toDate?Date.parse("yyyy-MM-dd",params.toDate)?.format("dd-MM-yyyy"):"",
        ];

        reportDetails.push(finalData);
        params._format = params.format;
        params._file = "../reports/transactionReport/memoReportPartyDatewise"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'stockReport', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def print_action1(){
        def reportDetails = [];
        def parent;
        def child = [];

        def lrData = LREntry.createCriteria().list {
            eq("branch", session['branch'])
            eq("isActive",true)

            if (params.fromParty) {
                eq("fromCustomer", AccountMaster.findById(params.fromParty as Long))
            }

            if (params.toParty) {
                eq("toCustomer", AccountMaster.findById(params.toParty as Long))
            }

            if ((params.fromDate) && (params.toDate)) {
                between("lrDate", Date.parse("yyyy-MM-dd", params.fromDate), Date.parse("yyyy-MM-dd", params.toDate))
            } else if (params.fromDate) {
                ge("lrDate", Date.parse("yyyy-MM-dd", params.fromDate))
            } else if (params.toDate) {
                le("lrDate", Date.parse("yyyy-MM-dd", params.toDate))
            }
        }

        if(lrData){
            int srNo = 0;
            lrData.each {c ->
                def Data = InternalMemoDetails.createCriteria().list {
                    eq("lrNo",c.lrNo)
                }

                if(!Data){
                    srNo++;
                    child.push([
                            srNo : srNo,
                            lrNo : c?.lrNo?:"",
                            lrDate : c?.lrDate?.format("dd-MM-yyyy")?:"",
                            fromParty : c?.fromCustomer?.accountName?:"",
                            toParty : c?.toCustomer?.accountName?:"",
                            vehicleNo :(c?.vehicleNo?.state?:"")+" - "+(c?.vehicleNo?.rto?:"")+
                                    " "+(c?.vehicleNo?.series?:"")+" "+(c?.vehicleNo?.vehicleNo?:""),
                    ]);
                }
            }
        }

        parent = [
                parent : child,
                reportName : "memoReportPartyDatewise_subreport1_subreport1.jasper",
                fromParty : params.fromParty?AccountMaster.findById(params.fromParty as Long).accountName:"",
                toParty : params.toParty?AccountMaster.findById(params.toParty as Long).accountName:"",
                fromDate: params.fromDate?Date.parse("yyyy-MM-dd",params.fromDate)?.format("dd-MM-yyyy"):"",
                toDate: params.toDate?Date.parse("yyyy-MM-dd",params.toDate)?.format("dd-MM-yyyy"):"",
        ];

        reportDetails.push(parent);
        params._format = params.format;
        params._file = "../reports/transactionReport/memoReportPartyDatewise"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'stockReport', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def print_action2(){
        def reportDetails = [];
        def finalData;
        def parent = [];
        def child = [];

        def Data = [];

        Data = InternalMemo.createCriteria().list {
            eq("branch", session['branch'])
            eq("isActive",true)

            if(params.vNo) {
                eq("vehicleNo", VehicleMaster.createCriteria().get {
                    eq("id", params.vNo as Long)
                })
            }

            if ((params.fromDate) && (params.toDate)) {
                between("voucherDate", Date.parse("yyyy-MM-dd", params.fromDate), Date.parse("yyyy-MM-dd", params.toDate))
            } else if (params.fromDate) {
                ge("voucherDate", Date.parse("yyyy-MM-dd", params.fromDate))
            } else if (params.toDate) {
                le("voucherDate", Date.parse("yyyy-MM-dd", params.toDate))
            }
        }

        if(Data){
            Data.each {d ->
                int srNo = 0;
                def childData = d?.internalMemoDetails;

                if(childData){
                    childData.each {c ->
                        srNo++;

                        child.push([
                                srNo : srNo,
                                lrNo : c?.lrNo?:"",
                                lrDate : c?.lrDate?.format("dd-MM-yyyy")?:"",
                                fromParty : c?.fromCustomer?.accountName?:"",
                                toParty : c?.toCustomer?.accountName?:"",
                                vehicleNo : (d?.vehicleNo?.state?:"")+" - "+(d?.vehicleNo?.rto?:"")+
                                        " "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:"")
                        ]);
                    }
                }

                if(child){
                    parent.push([
                            child : child,
                            memoNo : d?.voucherNo?:"",
                            memoDate : d?.voucherDate?.format("dd-MM-yyyy")?:"",
                            vehicleNo : (d?.vehicleNo?.state?:"")+" - "+(d?.vehicleNo?.rto?:"")+
                                    " "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:""),
                            tripLocation : d?.tripLocation?.location?:"",
                            tripRate : d?.tripRate?:0,
                            balance : d?.totalBalance?:0,
                            receiptNo : d?.dieselReceiptNo?:"",
                            pumpName : d?.pumpName?.pumpName?:""
                    ]);
                }
            }
        }

        finalData = [
                parent : parent,
                reportName : "memoReportPartyDatewise_subreport1.jasper",
                fromParty : params.fromParty?AccountMaster.findById(params.fromParty as Long).accountName:"",
                toParty : params.toParty?AccountMaster.findById(params.toParty as Long).accountName:"",
                fromDate: params.fromDate?Date.parse("yyyy-MM-dd",params.fromDate)?.format("dd-MM-yyyy"):"",
                toDate: params.toDate?Date.parse("yyyy-MM-dd",params.toDate)?.format("dd-MM-yyyy"):"",
        ];

        reportDetails.push(finalData);
        params._format = params.format;
        params._file = "../reports/transactionReport/memoReportPartyDatewise"
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
