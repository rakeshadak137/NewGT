package com.transaction

import NumbersToWords.NumToWords
import annotation.ParentScreen
import com.master.AccountMaster
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Transaction", subUnder = "Transaction", fullName = "Bill Agaist LR")
class BillAgainstLRController {
    def jasperService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [billAgainstLRInstanceList: BillAgainstLR.findAllByIsActive(true), billAgainstLRInstanceTotal: BillAgainstLR.countByIsActive(true)]
    }

    def create() {
        [billAgainstLRInstance: new BillAgainstLR(params)]
    }

    def save() {
        def billAgainstLRInstance = new BillAgainstLR(params)

        billAgainstLRInstance.dateCreated = new Date();
        billAgainstLRInstance.financialYear = session['financialYear'];
        billAgainstLRInstance.createdBy = session['activeUser'];
        billAgainstLRInstance.branch = session['branch'];

//        int no = 0;
//        def data = BillAgainstLR.last();

//        if(data){
//            no = Integer.parseInt(data.billNo) + 1;
//        }
//        else{
//            no = 1;
//        }

//        billAgainstLRInstance.billNo = no;
        billAgainstLRInstance.company = AccountMaster.findById(params.mainComp as Long);
        billAgainstLRInstance.fromCompany = AccountMaster.findById(params.fromComp as Long);
        billAgainstLRInstance.toCompany = AccountMaster.findById(params.toComp as Long);
        billAgainstLRInstance.poNo = params.poNo;
        billAgainstLRInstance.totalAmount = params.totalAmount as BigDecimal;
        billAgainstLRInstance.poDate = Date.parse("yyyy-MM-dd",params.poDate);

        def childs = JSON.parse(params.ChildJSON);

        childs.each {c ->
            billAgainstLRInstance.addToBillAgainstLRDetails(BillAgainstLRDetails.saveChildData(c));
        }

        if (!billAgainstLRInstance.save(flush: true)) {
            render(view: "create", model: [billAgainstLRInstance: billAgainstLRInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'billAgainstLR.label', default: 'BillAgainstLR'), billAgainstLRInstance.id])
        redirect(action: "list", id: billAgainstLRInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def billAgainstLRInstance = BillAgainstLR.get(id)
        if (!billAgainstLRInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'billAgainstLR.label', default: 'BillAgainstLR'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [billAgainstLRInstance: billAgainstLRInstance]
    }

    def edit(Long id) {
        def billAgainstLRInstance = BillAgainstLR.get(id)
        if (!billAgainstLRInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'billAgainstLR.label', default: 'BillAgainstLR'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [billAgainstLRInstance: billAgainstLRInstance]
    }

    def update(Long id, Long version) {
        def billAgainstLRInstance = BillAgainstLR.get(id)
        if (!billAgainstLRInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'billAgainstLR.label', default: 'BillAgainstLR'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (billAgainstLRInstance.version > version) {
                billAgainstLRInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'billAgainstLR.label', default: 'BillAgainstLR')] as Object[],
                        "Another user has updated this BillAgainstLR while you were editing")
                render(view: "edit", model: [billAgainstLRInstance: billAgainstLRInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        billAgainstLRInstance.properties = params
        billAgainstLRInstance.lastUpdatedBy = session['activeUser'];
        billAgainstLRInstance.lastUpdated = new Date();

        if (!billAgainstLRInstance.save(flush: true)) {
            render(view: "edit", model: [billAgainstLRInstance: billAgainstLRInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'billAgainstLR.label', default: 'BillAgainstLR'), billAgainstLRInstance.id])
        redirect(action: "create", id: billAgainstLRInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def billAgainstLRInstance = BillAgainstLR.get(id)

        if (!billAgainstLRInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'billAgainstLR.label', default: 'BillAgainstLR'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            billAgainstLRInstance.isActive = false
            billAgainstLRInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'billAgainstLR.label', default: 'BillAgainstLR'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'billAgainstLR.label', default: 'BillAgainstLR'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }
    def print(){
       [newId: params.billId,params: [scrid: session['activeScreen'].id]]
    }

    def getLRData(){
        def Data = [];
        def child = [];

        if(params.fromDate && params.toDate && params.fComp && params.tComp){

            Data = LREntry.findAllByFromCustomerAndToCustomerAndLrDateBetween(AccountMaster.findById(params.fComp as Long),AccountMaster.findById(params.tComp as Long),Date.parse("yyyy-MM-dd",params.fromDate),Date.parse("yyyy-MM-dd",params.toDate));

            if(Data){
                Data.each {d ->
                    child.push([
                            bool: false,
                            lrNo: d.lrNo,
                            lrDate: d.lrDate,
                            fromCompany: d.fromCustomer.accountName,
                            toCompany: d.toCustomer.accountName,
                            vehicleNo: d.vehicleNo.vehicleNo,
                            poNo: d?.poNO?:"",
                            poDate: d?.poID?.purchaseOrder?.poDate?:Date.parse("yyyy-MM-dd","0000-00-00 00:00:00"),
                            poId: d?.poID?:"",
                            Id: d.id
                    ])
                }
            }
            print child;
            render child as JSON;
        }else{
            render '';
        }
    }

    def getProductData(){
        def Data = [];
        def child = [];

        if(params.chId){
            Data = LREntry.findById(params.chId).lrEntryDetails;

            if(Data){
                Data.each {d ->
                    child.push([
                            lrId: d.lrEntry.id,
                            lrNo: d.lrEntry.lrNo,
                            itemId: d.productName.id,
                            itemName: d.productName.productCode +' - '+ d.productName.productName,
                            unitId: d.unit.id,
                            unit: d.unit.unitName,
                            qty: d.qty,
                            rate: d.rate,
                            wtPiece: d.weight,
                            totalWeight: d.weight * d.qty,
                            amount: d.totalAmount,
                            customerPartNo: d.productName.customerPartNo
                    ])
                }
            }
        }
        render child as JSON;
    }

    def findParentData(){
        def Data = [];
        def child = [];
        BigDecimal otherTotal=0;
        if(params.chId){
            Data = LREntry.findById(params.chId)
            if(Data){
                otherTotal = (Data?.freight?:0)+(Data?.loading?:0)+(Data?.unloading?:0)+(Data?.collection?:0)+(Data?.cartage?:0)+(Data?.cata?:0)+(Data?.bilty?:0)+(Data?.doorDelivery?:0)

            }
        }
        render otherTotal
    }

    def billPrint(){
        def reportDetails = [];
        def parent;
        def details = [];
        NumToWords nm = new NumToWords();
        def serviceTaxNo="",serviceTaxString="",panNo=""
        if(params.id){
            def Data = BillAgainstLR.findById(params.id as Long);
            def monthName = Data?.fromDate?.format("MMMM-yyyy")?.toUpperCase()?:""
            if(Data){
                def custId = Data?.company?.id
                if((custId==1006)||(custId==1011)||(custId==1021)||(custId==1023)||(custId==1055)||(custId==1101)){
                    serviceTaxNo=""
                    panNo="ALOPK7594C"
                }
                else{
                    serviceTaxNo="AQIPK4895RST001"
                    panNo="AQIPK4895R"
                }
                parent =
                        [
                                srNo: 1,
                                mainCompany: Data?.company?.accountName?:"",
                                mainCompanyAddress: Data?.company?.address?:"",
                                billNo: Data.billNo,
                                billDate: (Data.billDate).format("dd/MM/yyyy"),
                                poNo: Data.poNo,
                                poDate: Data.poNo?(Data.poDate).format("dd/MM/yyyy"):"",
                                vendor: "",
                                monthName:monthName?:"",
                                fromDate: (Data.fromDate).format("dd/MM/yyyy"),
                                toDate: (Data.toDate).format("dd/MM/yyyy"),
                                fromCompany: Data?.fromCompany?.accountName?:"",
                                toCompany: Data?.toCompany?.accountName?:"",
                                amount: Data.totalAmount,
                                amountinWords: nm.convert((Data.totalAmount).intValue()),
                                details: details,
                                panno: panNo,
                                staxno:serviceTaxNo
                        ]
            }
            if(parent){
                reportDetails.push(parent);
            }
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/bill_report"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'pumpMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def LRSummary(){
        def reportDetails = [];
        def child = [];
        def parent;
        int srNo;
        def totalAmount = 0;

        if(params.id){
            def Data = BillAgainstLR.findById(params.id as Long);

            if(Data){
                def childData = BillAgainstLRDetails.findAllByBillAgainstLR(Data as BillAgainstLR).unique {it.lrEntry};

                if(childData){
                    srNo = 0;
                    childData.each {ch ->
                        srNo++;
                        def total = 0;

                        def lrData = BillAgainstLRDetails.findAllByLrEntryAndBillAgainstLR(LREntry.findById(ch.lrEntry.id as Long),Data as BillAgainstLR);

                        if(lrData){
                            lrData.each {l ->
                                total = total + l.amount;
                            }
                        }
                        totalAmount = totalAmount + total;

                        child.push([
                                srNo: srNo,
                                lrDate: (ch.lrEntry.lrDate).format("dd-MM-yyyy"),
                                lrNo: ch.lrEntry.lrNo,
                                amount: total
                        ])
                    }
                }

                if(child){
                    parent =
                            [
                                    details: child,
                                    totalAmount: totalAmount,
                                    billNo: Data.billNo
                            ]
                }


            }
            if(parent){
                reportDetails.push(parent);
            }
            print reportDetails;
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/LR_Summary"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'pumpMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def LRDetails(){
        def reportDetails = [];
        def child = [];
        def parent = [];
        int srNo;

        if(params.id) {
            def Data = BillAgainstLR.findById(params.id as Long);

            if (Data) {
                def childData = BillAgainstLRDetails.findAllByBillAgainstLR(Data as BillAgainstLR).unique {it.lrEntry};

                if (childData) {
                    srNo = 0;
                    childData.each {ch ->
                        def LRData = LREntry.findById(ch.lrEntry.id as Long);

                        if(LRData){
                            def childLR = LREntryDetails.findAllByLrEntry(LRData as LREntry);

                            if(childLR){
                                childLR.each {c ->
                                    srNo++;
                                    child.push([
                                            srNO: srNo,
                                            LrDate: LRData.lrDate,
                                            form: LRData?.fromCustomer?.accountName?:"",
                                            to: LRData?.toCustomer?.accountName?:"",
                                            lrNo: LRData.lrNo,
                                            invoiceNo: c.invoiceNo,
                                            qty: c.invoiceQty
                                    ])
                                }
                            }
                        }
                    }
                }
                if(child){
                    parent =
                            [
                                    billNo: Data.billNo,
                                    child: child
                            ]
                }
            }
            if(parent){
                reportDetails.push(parent);
            }
            print reportDetails;
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/LR_Details"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'pumpMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def LRPrint() {
        def reportDetails = [];
        def child = [];
        def parent = [];
        def finalData;

        if (params.id) {
            def Data = BillAgainstLR.findById(params.id as Long);

            if (Data) {
                def childData = BillAgainstLRDetails.findAllByBillAgainstLR(Data as BillAgainstLR).unique {
                    it.lrEntry
                };

                if (childData) {
                    childData.each { ch ->
                        def LRData = LREntry.findById(ch.lrEntry.id as Long);

                        if (LRData) {
                            child = [];
                            def childLR = LREntryDetails.findAllByLrEntry(LRData as LREntry);

                            if (childLR) {
                                childLR.each { c ->
                                    child.push([
                                            invoiceNo: c.invoiceNo,
                                            description: c.productName.productCode,
                                            qty: c.qty,
                                            packing: c.invoiceQty,
                                            weight: c.weight,
                                            totalWeight : c.qty * c.weight,
                                            rate: c.rate,
                                            amount: c.totalAmount
                                    ]);
                                }
                            }
                            parent.push([
                                    details: child,
                                    fromLocation: LRData.fromLocation,
                                    toLocation: LRData.toLocation,
                                    lrDate: LRData.lrDate.format("yyyy-MM-dd"),
                                    vehicleNo: LRData.vehicleNo,
                                    lrNo: LRData.lrNo,
                                    fromAddress: LRData.fromCustomer.address,
                                    toAddress: LRData.toCustomer.address,
                                    billPayType: LRData.billPayType,
                                    freight: LRData.freight,
                                    loading: LRData.loading,
                                    unloading: LRData.unloading,
                                    collection: LRData.collection,
                                    cartage: LRData.cartage,
                                    cata: LRData.cata,
                                    bilty: LRData.bilty,
                                    doorDelivery: LRData.doorDelivery,
                                    grandTotal: LRData.grandTotal,
                                    panNo:"",
                                    staxNo:""
                            ])
                        }

                    }
                }
            }
            if(parent){
                reportDetails.push(details:parent);
            }
            print reportDetails;
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/Bill_LR"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'pumpMaster', action: 'generateReport', model: [data: reportDetails], params: params);
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

    def getList(){
        def child = [];

        def Data = BillAgainstLR.findAllByIsActive(true);

        if(Data){
            Data.each {d ->
                child.push([
                        id: d.id,
                        version: d.version,
                        billNo: d.billNo,
                        billDate: d.billDate,
                        company: d.company.accountName,
                        amount: d.totalAmount
                ])
            }
        }
        render child as JSON;
    }

    def fetchAllLRData(){
        def Data = [];
        def child = [];

        if(params.fComp){
            Data = LREntry.findAllByFromCustomerOrToCustomer(AccountMaster.findById(params.fComp as Long),AccountMaster.findById(params.fComp as Long));

//          def data2=LREntry.findAllByLrDateLessThanEquals(Date.parse("yyyy-MM-dd",params.toDate))
            if(Data){
                Data.each {d ->
                    if(d?.lrDate <= (Date.parse("yyyy-MM-dd",params.toDate))){
                        child.push([
                                bool: false,
                                lrNo: d.lrNo,
                                lrDate: d.lrDate,
                                fromCompany: d?.fromCustomer?.accountName?:"",
                                toCompany: d?.toCustomer?.accountName?:"",
                                vehicleNo: d?.vehicleNo?.vehicleNo?:"",
                                poNo: d?.poNO?:"",
                                poDate: d?.poID?.purchaseOrder?.poDate?:Date.parse("yyyy-MM-dd","0000-00-00 00:00:00"),
                                poId: d?.poID?:"",
                                Id: d.id
                        ])
                    }

                }
            }
//            print child;
            render child as JSON;
        }else{
            render '';
        }
    }
}
