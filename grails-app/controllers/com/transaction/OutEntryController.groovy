package com.transaction

import annotation.ParentScreen
import com.master.AccountMaster
import com.master.DivisionMaster
import com.master.GodownMaster
import com.master.Parameter
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Transaction", subUnder = "Transaction", fullName = "OUT Entry")
class OutEntryController {
    def jasperService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [outEntryInstanceList: OutEntry.findAllByIsActive(true), outEntryInstanceTotal: OutEntry.countByIsActive(true)]
    }

    def create() {
        [outEntryInstance: new OutEntry(params)]
    }

    def save() {
        def outEntryInstance = new OutEntry(params)

        outEntryInstance.voucherNo = voucherNO();

//        outEntryInstance.dieselLtr = params.dieselLtr as BigDecimal;
//        outEntryInstance.dieselRate = params.dieselRate as BigDecimal;
//        outEntryInstance.dieselAmount = params.dieselAmount as BigDecimal;
//        outEntryInstance.freight = params.freight as BigDecimal;
//        outEntryInstance.totalTripRate = params.totalTripRate as BigDecimal;
//        outEntryInstance.advance = params.advance as BigDecimal;
//        outEntryInstance.balance = params.balance as BigDecimal;

        outEntryInstance.outTime = new Date();
        outEntryInstance.dateCreated = new Date();
        outEntryInstance.financialYear = session['financialYear'];
        outEntryInstance.createdBy = session['activeUser'];
        outEntryInstance.branch = session['branch'];

        def childs = JSON.parse(params.ChildJSON);

        childs.each { c ->
            if (c.bool) {
                outEntryInstance.addToOutEntryDetails(OutEntryDetails.saveChildData(c));

                //stock update code
                def stockData = StockInOut.findByFromCustomerAndToCustomerAndGodownAndLrNoAndInvoiceNo(AccountMaster.findById(outEntryInstance.fromCustomer.id as Long), AccountMaster.findById(outEntryInstance.toCustomer.id as Long), GodownMaster.findById(outEntryInstance.godown.id as Long), c.lrNo, c.invoiceNo);

                if (stockData) {
                    stockData.status = "OUT";
                    stockData.save();
                }
            }
        }

        if (!outEntryInstance.save(flush: true)) {
            render(view: "create", model: [outEntryInstance: outEntryInstance])
            return
        }
//        else{
//            try {
//                sendMail {
//                    multipart true
//                    to 'ganeshtransport92@gmail.com'
////                    to 'rakeshadak137@gmail.com'
//                    subject "Out Entry From Ganesh Transport Created"
//                    html ""+outEntryInstance?.voucherNo
//                    attachBytes 'OutEntry.pdf','application/pdf',reportDef.contentStream.toByteArray()
//                }
//            }
//            catch (Exception e){
//                e.printStackTrace();
//            }
//        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'outEntry.label', default: 'OutEntry'), outEntryInstance.id])
        redirect(action: "show", id: outEntryInstance.id, params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def outEntryInstance = OutEntry.get(id)
        if (!outEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'outEntry.label', default: 'OutEntry'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        [outEntryInstance: outEntryInstance]
    }

    def edit(Long id) {
        def outEntryInstance = OutEntry.get(id)
        if (!outEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'outEntry.label', default: 'OutEntry'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        [outEntryInstance: outEntryInstance]
    }

    def update(Long id, Long version) {
        def outEntryInstance = OutEntry.get(id)

        def childData = outEntryInstance.outEntryDetails;

        if (childData) {
            childData.each { c ->
                def stockData1 = StockInOut.findByFromCustomerAndToCustomerAndGodownAndLrNoAndInvoiceNo(AccountMaster.findById(outEntryInstance.fromCustomer.id as Long), AccountMaster.findById(outEntryInstance.toCustomer.id as Long), GodownMaster.findById(outEntryInstance.godown.id as Long), c.lrNo, c.invoiceNo);

                if (stockData1) {
                    stockData1.status = "IN";
                    stockData1.save();
                }
            }
        }

        OutEntry.executeUpdate("delete OutEntryDetails as b where b.outEntry.id=:id", [id: outEntryInstance.id]);
        outEntryInstance.save(flush: true);

        if (!outEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'outEntry.label', default: 'OutEntry'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (outEntryInstance.version > version) {
                outEntryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'outEntry.label', default: 'OutEntry')] as Object[],
                        "Another user has updated this OutEntry while you were editing")
                render(view: "edit", model: [outEntryInstance: outEntryInstance])
                return
            }
        }

        outEntryInstance.properties = params

//        outEntryInstance.dieselLtr = params.dieselLtr as BigDecimal;
//        outEntryInstance.dieselRate = params.dieselRate as BigDecimal;
//        outEntryInstance.dieselAmount = params.dieselAmount as BigDecimal;
//        outEntryInstance.freight = params.freight as BigDecimal;
//        outEntryInstance.totalTripRate = params.totalTripRate as BigDecimal;
//        outEntryInstance.advance = params.advance as BigDecimal;
//        outEntryInstance.balance = params.balance as BigDecimal;

        def childs = JSON.parse(params.ChildJSON);

        childs.each { c ->
            if (c.bool) {
                outEntryInstance.addToOutEntryDetails(OutEntryDetails.saveChildData(c));

                //stock update code
                def stockData = StockInOut.findByFromCustomerAndToCustomerAndGodownAndLrNoAndInvoiceNo(AccountMaster.findById(outEntryInstance.fromCustomer.id as Long), AccountMaster.findById(outEntryInstance.toCustomer.id as Long), GodownMaster.findById(outEntryInstance.godown.id as Long), c.lrNo, c.invoiceNo);

                if (stockData) {
                    stockData.status = "OUT";
                    stockData.save();
                }
            }
        }

        outEntryInstance.lastUpdatedBy = session['activeUser'];
        outEntryInstance.lastUpdated = new Date();

        if (!outEntryInstance.save(flush: true)) {
            render(view: "edit", model: [outEntryInstance: outEntryInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'outEntry.label', default: 'OutEntry'), outEntryInstance.id])
        redirect(action: "show", id: outEntryInstance.id, params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def outEntryInstance = OutEntry.get(id);

        def childData = outEntryInstance.outEntryDetails;

        if (childData) {
            childData.each { c ->
                def stockData1 = StockInOut.findByFromCustomerAndToCustomerAndGodownAndLrNoAndInvoiceNo(AccountMaster.findById(outEntryInstance.fromCustomer.id as Long), AccountMaster.findById(outEntryInstance.toCustomer.id as Long), GodownMaster.findById(outEntryInstance.godown.id as Long), c.lrNo, c.invoiceNo);

                if (stockData1) {
                    stockData1.status = "IN";
                    stockData1.save();
                }
            }
        }

        if (!outEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'outEntry.label', default: 'OutEntry'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            outEntryInstance.isActive = false
            outEntryInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'outEntry.label', default: 'OutEntry'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'outEntry.label', default: 'OutEntry'), id])
            redirect(action: "show", id: id, params: [scrid: session['activeScreen'].id])
        }
    }

    def stockData() {
        def Data = [];
        def child = [];
        def productName="";
        int sr=0;

        if (params.fCustomer && params.tCustomer && params.godown) {
            Data = StockInOut.findAllByFromCustomerAndToCustomerAndGodownAndStatus(AccountMaster.findById(params.fCustomer as Long), AccountMaster.findById(params.tCustomer as Long), GodownMaster.findById(params.godown as Long), "IN");
        }
        else if (params.fCustomer && !params.tCustomer && params.godown) {
            Data = StockInOut.findAllByFromCustomerAndGodownAndStatus(AccountMaster.findById(params.fCustomer as Long), GodownMaster.findById(params.godown as Long), "IN");
        }
        if (Data) {
            Data.each { d ->
//                    if(d?.productName?.id) {
//                    productName="";
//                    productName=LREntryDetails.findByInvoiceNoAndLrEntry(d?.invoiceNo,LREntry.findByLrNo(d?.lrNo))?.productName?.productName?:""
                child.push([
                        bool         : false,
                        id           : d.id,
                        lrNo         : d?.lrNo ?: "",
                        lrDate       : d?.lrDate ?: "",
                        invoiceNo    : d?.invoiceNo ?: "",
                        productName  : d?.productName?.productName?:"",
                        productId    : d?.productName?.id?:"",
                        invoiceQty   : d?.invoiceQty ?: "",
                        invoiceUnitId: d?.invoiceUnit?.id ?: "",
                        invoiceUnit  : d?.invoiceUnit?.unitName ?: "",
                        sr:sr,
                        from:d?.fromCustomer?.accountName?:"",
                        to:d?.toCustomer?.accountName?:""
                ])
                sr++
//                    }
            }
        }

        render child as JSON;
    }

    def voucherNO() {
        int no = 1;
        def Data = OutEntry.last();

        if (Data) {
            no = Integer.parseInt(Data?.voucherNo) + 1;
        } else {
            no = 1;
        }
        return no;
    }

    def getList() {
        def child = [];

        def Data = OutEntry.findAllByIsActive(true);

        if (Data) {
            Data.each { d ->
                child.push([
                        id          : d.id,
                        version     : d.version,
                        voucherNo   : d?.voucherNo?:"",
                        voucherDate : d?.voucherDate?:"",
                        fromCustomer: d?.fromCustomer?.accountName?:"",
                        toCustomer  : d?.toCustomer?.accountName?:"",
                        vehicleNo   : d?.vehicle?:"",
                        outTime     : d?.outTime?.format("hh:mm:ss a")?:""
                ])
            }
        }
        render child as JSON;
    }

    def editStockData() {
        def child = [];
        if (params.id) {
            def outData = OutEntry.findById(params.id as Long)

            if (outData) {
                def stockDatas = StockInOut.findAllByFromCustomerAndToCustomerAndGodown(AccountMaster.findById(outData.fromCustomer.id as Long), AccountMaster.findById(outData.toCustomer.id as Long), GodownMaster.findById(outData.godown.id as Long));

                if (stockDatas) {
                    stockDatas.each { s ->

                        def outChildData = OutEntryDetails.findByLrNoAndInvoiceNoAndOutEntry(s.lrNo, s.invoiceNo, outData as OutEntry);

                        if (outChildData) {
                            child.push([
                                    bool         : true,
                                    id           : s.id,
                                    lrNo         : s.lrNo,
                                    lrDate       : s.lrDate,
                                    invoiceNo    : s.invoiceNo,
                                    productName: s?.productName?.productName ?: "",
                                    productId  : s?.productName?.id ?: "",
                                    invoiceQty   : s.invoiceQty,
                                    invoiceUnitId: s.invoiceUnit.id,
                                    invoiceUnit  : s.invoiceUnit.unitName,
                                    parameterId  : null
                            ])
                        } else {
                            child.push([
                                    bool         : false,
                                    id           : s.id,
                                    lrNo         : s.lrNo,
                                    lrDate       : s.lrDate,
                                    invoiceNo    : s.invoiceNo,
                                    productName: s?.productName?.productName ?: "",
                                    productId  : s?.productName?.id ?: "",
                                    invoiceQty   : s.invoiceQty,
                                    invoiceUnitId: s.invoiceUnit.id,
                                    invoiceUnit  : s.invoiceUnit.unitName,
                                    parameterId  : null
                            ])
                        }
                    }
                }
            }
        }
        render child as JSON;
    }

    def editStockData1() {
        def child = [];
        if (params.id) {
            def outData = OutEntry.findById(params.id as Long)

            if (outData) {
                def stockDatas = StockInOut.findAllByFromCustomerAndToCustomerAndGodown(AccountMaster.findById(outData.fromCustomer.id as Long), AccountMaster.findById(outData.toCustomer.id as Long), GodownMaster.findById(outData.godown.id as Long));

                if (stockDatas) {
                    stockDatas.each { s ->

                        def outChildData = OutEntryDetails.findByLrNoAndInvoiceNoAndOutEntry(s.lrNo, s.invoiceNo, outData as OutEntry);

                        if (outChildData) {
                            child.push([
                                    bool         : true,
                                    id           : s.id,
                                    lrNo         : s.lrNo,
                                    lrDate       : s.lrDate,
                                    invoiceNo    : s.invoiceNo,
                                    productName: s?.productName?.productName ?: "",
                                    productId  : s?.productName?.id ?: "",
                                    invoiceQty   : s.invoiceQty,
                                    invoiceUnitId: s.invoiceUnit.id,
                                    invoiceUnit  : s.invoiceUnit.unitName,
                                    parameterId  : outChildData?.parameter?.id?:null,
                                    from         : outChildData?.from?:"",
                                    to           : outChildData?.to?:""
                            ])
                        }
                    }
                }
            }
        }
        render child as JSON;
    }

    def print_action(){
        def data=[];
        def parent;
        def child=[];
        def reportDetails=[];
        String productName="";
        int srNo=1;
        if(params?.id){
            data = OutEntry.findById(params?.id as Long);
            if(data){

                def data2 = OutEntryDetails.findAllByOutEntry(data as OutEntry);
                if(data2){
                    data2.each {d2->
                        productName="";
//                        LREntry lrObj=LREntry.createCriteria().listDistinct {
//                            eq("lrNo",d2.lrNo as String)
//                            eq("financialYear",session['financialYear'])
//                        }
//                        productName=LREntryDetails.findByInvoiceNoAndLrEntry(d2?.invoiceNo,LREntry.findByLrNo(d2?.lrNo))?.productName?.productName?:""

                        def lrDetailsData = LREntryDetails.findAllByInvoiceNoAndLrEntry(d2.invoiceNo,LREntry.findByLrNo(d2.lrNo));
//                        String lrNo=d2.lrNo;

                        if(lrDetailsData){
                            lrDetailsData.each {ch ->
//                                def lrData = LREntry.findByLrNo(lrNo);

//                                if(ch?.lrEntry?.id == lrData.id){
                                    productName = ch?.productName?.productName?:"";
                                    child.push([
                                            srNo:srNo++,
                                            invoiceNo: d2?.invoiceNo?:"",
                                            lrNo: d2?.lrNo?:"",
                                            lrDate: d2?.lrDate?.format("dd-MM-yyyy")?:"",
                                            qty: d2?.invoiceQty?:0.00,
                                            product: productName?:"",
                                            unit: d2?.invoiceUnit?.unitName?:""
                                    ])
//                                }
                            }
                        }


                    }
                    if(child){
                        parent=[
                                child:child,
                                rcptNo:data?.voucherNo?:"",
                                rcptDate:data?.voucherDate?.format("dd-MM-yyyy")?:"",
                                fromCust:data?.fromCustomer?.accountName?:"",
                                toCust:data?.toCustomer?.accountName?:"",
                                godown:data?.godown?.godownName?:"",
                                vehicleNo:data?.vehicle?:"",
                                outTime:data?.outTime?.format("hh:mm:ss a")?:"",
                        ]
                    }
                }
            }
            if(parent){
                reportDetails.push(parent);
            }
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/Out_Entry_Report"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"

        chain(controller: 'states', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def print_action2(){
        def data=[];
        def parent;
        def child=[];
        def reportDetails=[];
        int srNo=1;
        def productName = "";
        if(params?.id){
            data = OutEntry.findById(params?.id as Long);
            if(data){

                def data2 = StockInOut.findAllByFromCustomerAndToCustomerAndGodownAndStatus(data?.fromCustomer as AccountMaster,data?.toCustomer as AccountMaster,data?.godown as GodownMaster,"IN");
                if(data2){

                    data2.each {d2->
                        productName="";
                        productName=LREntryDetails.findByInvoiceNoAndLrEntry(d2?.invoiceNo,LREntry.findByLrNo(d2?.lrNo))?.productName?.productName?:""
                        child.push([
                                srNo:srNo++,
                                invoiceNo: d2?.invoiceNo?:"",
                                lrNo: d2?.lrNo?:"",
                                lrDate: d2?.lrDate?.format("dd-MM-yyyy")?:"",
                                product:productName?:"",
                                qty: d2?.invoiceQty?:0.00,
                                unit: d2?.invoiceUnit?.unitName?:""
                        ])
                    }
                    if(child){
                        parent=[
                                child:child,
                                rcptNo:data?.voucherNo?:"",
                                rcptDate:data?.voucherDate?.format("dd-MM-yyyy")?:"",
                                fromCust:data?.fromCustomer?.accountName?:"",
                                toCust:data?.toCustomer?.accountName?:"",
                                godown:data?.godown?.godownName?:"",
                                vehicleNo:data?.vehicle?:"",
                                outTime:data?.outTime?.format("hh:mm:ss")?:""
                        ]
                    }
                }
            }
            if(parent){
                reportDetails.push(parent);
            }
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/Out_Entry_Remaining_Stock"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"

        chain(controller: 'states', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def print_action3(){
        def data=[];
        def reportDetails=[];
        def child=[];
        def subChild=[];
        int srNo = 1;
        def divisionList = DivisionMaster.list();
        if(divisionList){
            divisionList.each {d->
                def stockData = StockInOut.findAllByDivisionNameAndGodownAndStatus(d as DivisionMaster,GodownMaster.findById(2),"IN");
                if(stockData){
                    stockData.each {sd->
                        subChild.push([
                                srNo:srNo++,
                                itemName:sd?.productName?.productName?:"",
                                partyName:sd?.fromCustomer?.accountName?:"",
                                invoiceNo:sd?.invoiceNo?:"",
                                qty:sd?.invoiceQty,
                                lrNo:sd?.lrNo?:""
                        ])
                    }
                    if(subChild){
                        child.push([
                                divisionName:d?.divisionName,
                                subchild:subChild
                        ])
                    }
                }
            }
            if(child){
                reportDetails.push([child:child])

            }
        }

        params._format = "XLSX";
        params._file = "../reports/transactionReport/closingStock"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"

        chain(controller: 'states', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def findParametersList(){
        def result = Parameter.findAllByIsActive(true)
        render result as JSON
    }


}


