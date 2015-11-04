package com.transaction

import annotation.ParentScreen
import com.master.*
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Transaction", subUnder = "Transaction", fullName = "LR Entry")
class LREntryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [LREntryInstanceList: LREntry.findAllByIsActive(true), LREntryInstanceTotal: LREntry.countByIsActive(true)]
    }

    def create() {
        [LREntryInstance: new LREntry(params)]
    }

    def save() {
        def LREntryInstance = new LREntry(params)
        bindData(LREntryInstance,params,['lrNo','poID','poNo','fromCustomer','toCustomer','fromLocation','toLocation','amount','totalAmount','grandTotal','billPayType'])

        LREntryInstance.dateCreated = new Date();
        LREntryInstance.financialYear = session['financialYear'];
        LREntryInstance.createdBy = session['activeUser'];
        LREntryInstance.branch = session['branch'];

        int no = 0;
        def data = LREntry.last();

        if(data){
            no = Integer.parseInt(data.lrNo) + 1;
        }
        else{
            no = 1;
        }

        LREntryInstance.lrNo = no;
        LREntryInstance.billPayType = params.billPay;
        if(params.poNo){
            def poData = PurchaseOrderDetails.findById(params.poNo as Long);
            LREntryInstance.poNO = poData.purchaseOrder.poNo;
            LREntryInstance.poID = PurchaseOrderDetails.findById(params.poNo as Long);
        }

//        if(params.fromCustomer && params.toCustomer){
//            LREntryInstance.fromCustomer = AccountMaster.findById(params.fromCustomer as Long);
//            LREntryInstance.toCustomer = AccountMaster.findById(params.toCustomer as Long);
//        }

        LREntryInstance.fCustomer = params.fromCustomerManual;
        LREntryInstance.tCustomer = params.toCustomerManual;

        LREntryInstance.fromAddress = params.fromAddress;
        LREntryInstance.toAddress = params.toAddress;

        LREntryInstance.fromLocation = params.fromLocation;
        LREntryInstance.toLocation = params.toLocation;0
//        LREntryInstance.amount = params.amount as BigDecimal;
//        LREntryInstance.totalAmount = params.totalAmount as BigDecimal;
//        LREntryInstance.grandTotal = params.grandTotal as BigDecimal;

        LREntryInstance.fCustomer = params.fCustomerManual;
        LREntryInstance.tCustomer = params.tCustomerManual;

        LREntryInstance.freight = params.freight as BigDecimal;
        LREntryInstance.loading = params.loading as BigDecimal;
        LREntryInstance.unloading = params.unloading as BigDecimal;
        LREntryInstance.collection = params.collection as BigDecimal;
        LREntryInstance.cartage = params.cartage as BigDecimal;
        LREntryInstance.cata = params.cata as BigDecimal;
        LREntryInstance.bilty = params.bilty as BigDecimal;
        LREntryInstance.doorDelivery = params.doorDelivery as BigDecimal;

        def childs = JSON.parse(params.ChildJSON);

        childs.each {c ->
            LREntryInstance.addToLrEntryDetails(LREntryDetails.saveChildData(c));
            //stock update code
        }

        if (!LREntryInstance.save(flush: true)) {
            render(view: "create", model: [LREntryInstance: LREntryInstance])
            return
        }
        else{

            //mail sending code
            def toName="";
            def fromName="";
            def fromCustMail="";
            def vehicle = "";
            if(params?.toCustomer?.id){
                toName = AccountMaster.findById(params?.toCustomer?.id as Long)?.accountName;
            }
            if(params?.fromCustomer?.id){
                fromName = AccountMaster.findById(params?.fromCustomer?.id as Long)?.accountName;
                fromCustMail = AccountMaster.findById(params?.fromCustomer?.id as Long)?.email;
            }
            if(params?.vehicleNo?.id){
                vehicle = VehicleMaster.findById(params.vehicleNo.id)?.vehicleNo
            }

            if(!fromCustMail){
                fromCustMail="rakesh.adak12@gmail.com"
            }

//            try {
//                sendMail {
//                    multipart true
//                    to 'ganeshtransport92@gmail.com',fromCustMail
////                    to 'rakeshadak137@gmail.com'
//                    subject "LR From Ganesh Transport Created"
////                  html "LR No:"+LREntryInstance?.lrNo   +"<BR>" +"Bill Pay Type:"+ LREntryInstance?.billPayType  +"<BR>" + "From Customer:" + fromName  +"<BR>" + "To Customer:" + toName  +"<BR>" + "Total Amount:" + LREntryInstance?.grandTotal +"<BR>" + "Vehicle No:" + vehicle
//                    html g.render(template: '/LREntry/mailTemplate',model: [LREntryInstance:LREntryInstance])
//                }
//            }
//            catch (Exception e){
//                e.printStackTrace();
//            }
        }

        def childData = LREntryInstance.lrEntryDetails;

        if(childData){
            childData.each {ch ->
                def stockInstance = new StockInOut();
                stockInstance.lrNo = LREntryInstance.lrNo;
                stockInstance.lrDate = LREntryInstance.lrDate;

                stockInstance.invoiceNo = ch.invoiceNo;
                stockInstance.invoiceDate = ch?.invoiceDate?:""
                stockInstance.invoiceUnit = UnitMaster.findById(ch.invoiceUnit.id as Long);
                stockInstance.invoiceQty = ch.invoiceQty as BigDecimal;
                stockInstance.fromCustomer = AccountMaster.findById(LREntryInstance.fromCustomer.id as Long);
                stockInstance.toCustomer = AccountMaster.findById(LREntryInstance.toCustomer.id as Long);
                stockInstance.godown = GodownMaster.findById(LREntryInstance.goDown.id as Long);
                stockInstance.status = "IN";
                stockInstance.inDate = LREntryInstance.lrDate;
                if(ch?.productName?.division?.id){
                    stockInstance.divisionName = DivisionMaster.findById(ch?.productName?.division?.id);
                }
                if(ch?.productName?.id){
                    stockInstance.productName = ProductMaster.findById(ch.productName.id);
                }

                stockInstance.financialYear = session['financialYear'];
                stockInstance.createdBy = session['activeUser'];
                stockInstance.branch = session['branch'];
                stockInstance.lastUpdatedBy = session['activeUser'];
                stockInstance.save();
            }
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'LREntry.label', default: 'LREntry'), LREntryInstance.id])
        redirect(action: "show", id: LREntryInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def LREntryInstance = LREntry.get(id)
        if (!LREntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'LREntry.label', default: 'LREntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [LREntryInstance: LREntryInstance]
    }

    def edit(Long id) {
        def LREntryInstance = LREntry.get(id)
        if (!LREntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'LREntry.label', default: 'LREntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [LREntryInstance: LREntryInstance]
    }

    def update(Long id, Long version) {
        def LREntryInstance = LREntry.get(id)
//        bindData(LREntryInstance,params,['poID','poNo','fromCustomer','toCustomer','fromLocation','toLocation','amount','totalAmount','grandTotal'])
        if (!LREntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'LREntry.label', default: 'LREntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (LREntryInstance.version > version) {
                LREntryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'LREntry.label', default: 'LREntry')] as Object[],
                        "Another user has updated this LREntry while you were editing")
                render(view: "edit", model: [LREntryInstance: LREntryInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        LREntry.executeUpdate("delete LREntryDetails as b where b.lrEntry.id=:id", [id:LREntryInstance.id]);
        LREntryInstance.save(flush: true);

        LREntryInstance.properties = params
        LREntryInstance.lastUpdatedBy = session['activeUser'];
        LREntryInstance.lastUpdated = new Date();

        LREntryInstance.billPayType = params.billPay;
        if(params.poNo){
            def poData = PurchaseOrderDetails.findById(params.poNo as Long);
            LREntryInstance.poNO = poData.purchaseOrder.poNo;
            LREntryInstance.poID = PurchaseOrderDetails.findById(params.poNo as Long);
        }

//        if(params.fromCustomer && params.toCustomer){
//            LREntryInstance.fromCustomer = AccountMaster.findById(params.fromCustomer as Long);
//            LREntryInstance.toCustomer = AccountMaster.findById(params.toCustomer as Long);
//        }

        LREntryInstance.fromAddress = params.fromAddress
        LREntryInstance.toAddress = params.toAddress
        LREntryInstance.fromLocation = params.fromLocation;
        LREntryInstance.toLocation = params.toLocation;
//        LREntryInstance.amount = params.amount as BigDecimal;
//        LREntryInstance.totalAmount = params.totalAmount as BigDecimal;
//        LREntryInstance.grandTotal = params.grandTotal as BigDecimal;

        LREntryInstance.fCustomer = params.fCustomerManual;
        LREntryInstance.tCustomer = params.tCustomerManual;

        LREntryInstance.freight = params.freight as BigDecimal;
        LREntryInstance.loading = params.loading as BigDecimal;
        LREntryInstance.unloading = params.unloading as BigDecimal;
        LREntryInstance.collection = params.collection as BigDecimal;
        LREntryInstance.cartage = params.cartage as BigDecimal;
        LREntryInstance.cata = params.cata as BigDecimal;
        LREntryInstance.bilty = params.bilty as BigDecimal;
        LREntryInstance.doorDelivery = params.doorDelivery as BigDecimal;


        def childs = JSON.parse(params.ChildJSON);

        childs.each {c ->
            LREntryInstance.addToLrEntryDetails(LREntryDetails.saveChildData(c));
        }

        if (!LREntryInstance.save(flush: true)) {
            render(view: "edit", model: [LREntryInstance: LREntryInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'LREntry.label', default: 'LREntry'), LREntryInstance.id])
        redirect(action: "show", id: LREntryInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def LREntryInstance = LREntry.get(id)

        if (!LREntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'LREntry.label', default: 'LREntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            LREntryInstance.isActive = false
            LREntryInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'LREntry.label', default: 'LREntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'LREntry.label', default: 'LREntry'), id])
            redirect(action: "list", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    def getCustomerData(){
        def Data = [];
        def child;

        if(params.id){
            Data = AccountMaster.findById(params.id as Long);

            if(Data){
                child = [
                        address: Data?.address?:"",
                        city: Data?.city?.cityName?:"",
                        billingType: Data?.billType?.type?:""
                ]
            }
        }
        if(child) {
            render child as JSON;
        }
        else{
            render '[]';
        }
    }

    def getPOData(){
        def Data = [];
        def child = [];

        if(params.id && params.id1){
            Data = PurchaseOrderDetails.findAllByFromCustomerAndToCustomer(AccountMaster.findById(params.id as Long),AccountMaster.findById(params.id1 as Long));

            if(Data){
                Data.each {d ->
                    if(d?.purchaseOrder?.poType=="Original"){
                        child.push([
                                id: d.id,
                                poNo: d.purchaseOrder.poNo
                        ])
                    }

                }
            }
        }
        render child as JSON;
    }

    def getProductData(){
        def Data = [];
        def child;

        if(params.id){
            Data = ProductMaster.findById(params.id as Long);

            if(Data){
                child =
                        [
                                unitId: Data.unit.id,
                                unitName: Data.unit.unitName,
                                rate: Data.rate,
                                weight: Data.weight
                        ]
            }
        }

        if(child){
            render child as JSON;
        }
        else{
            render '[]';
        }
    }

    def getData(){
        def Data = [];
        def child = [];

        if(params.id){
            Data = LREntry.findById(params.id as Long).lrEntryDetails;

            if(Data){
                Data.each {d ->
                    child.push([
                            productId: d.productName.id,
                            productName: d.productName.productCode +'-'+ d.productName.productName,
                            invoiceNo: d.invoiceNo,
                            invoiceDate: d?.invoiceDate?:"",
                            qty: d.qty,
                            unitId: d.unit.id,
                            unitName: d.unit.unitName,
                            invoiceQty: d.invoiceQty,
                            invoiceUnitId: d.invoiceUnit.id,
                            invoiceUnitName: d.invoiceUnit.unitName,
                            rate: d.rate,
                            weight: d.weight,
                            tAmount: d.totalAmount
                    ]);
                }
            }
        }
        render child as JSON;
    }

    def getOtherData(){
        def Data = [];
        def child;

        if(params.id){
            Data = LREntry.findById(params.id as Long);

            if(Data){
                child =
                        [
                                fromCustomerID: Data?.fromCustomer?.id?:"",
                                toCustomerID: Data?.toCustomer?.id?:"",
                                fCustomer: Data?.fCustomer?:"",
                                tCustomer: Data?.tCustomer?:"",
                                fromAddress: Data.fromAddress,
                                toAddress: Data.toAddress,
                                fromLocation: Data.fromLocation,
                                toLocation: Data.toLocation,
                                poID: Data?.poID?.id?:"",
                                amount: Data.amount,
                                totalAmount: Data.totalAmount,
                                grandTotal: Data.grandTotal,
                                billingType: Data?.fromCustomer?.billType?.type?:""
                        ]
            }
        }
        if(child){
            render child as JSON;
        }
        else{
            render '[]';
        }
    }

    def getOtherChild(){
        def Data = [];
        def child;

        if(params.id){
            Data = PurchaseOrderDetails.findById(params.id as Long);

            if(Data){
                child = [
                        freight : Data?.freight?:0,
                        loading : Data?.loading?:0,
                        unloading : Data?.unLoading?:0,
                        collection : Data?.collection?:0,
                        cartage : Data?.cartage?:0,
                        cata : Data?.cata?:0,
                        bilty : Data?.bilty?:0,
                        doorDelivery : Data?.doorDelivery?:0,
                        tripRate : Data?.tripRate?:0,
                        fromCustId : Data?.fromCustomer?.id,
                        toCustId : Data?.toCustomer?.id,
                        fromAddress: Data?.fromCustomer?.address,
                        toAddress: Data?.toCustomer?.address
                        ]
            }
            else{
                child=[
                        freight : 0,
                        loading : 0,
                        unloading : 0,
                        collection : 0,
                        cartage : 0,
                        cata : 0,
                        bilty : 0,
                        doorDelivery : 0,
                        tripRate: 0,
                        fromCustId:"",
                        toCustId:"",
                        fromAddress: "",
                        toAddress: ""
                      ]
            }
        }
        else{
            child=[
                    freight : 0,
                    loading : 0,
                    unloading : 0,
                    collection : 0,
                    cartage : 0,
                    cata : 0,
                    bilty : 0,
                    doorDelivery : 0,
                    fromCustId:"",
                    toCustId:"",
                    fromAddress: "",
                    toAddress: ""
            ]
        }
        render child as JSON;
    }

    def getList(){
        def child = [];
        def todaysDate = new Date();
        def tillDate = todaysDate-30;
        def Data = LREntry.findAllByIsActiveAndLrDateGreaterThan(true,tillDate);
        def invNo = "";
        if(Data){
            Data.each {d ->
//                invNo="";
//                if(d?.lrEntryDetails) {
//                    invNo = d?.lrEntryDetails?.first()?.invoiceNo;
//                }
                child.push([
                        id: d.id,
                        version: d.version,
                        lrNo: d.lrNo,
                        lrDate: d.lrDate,
                        fromCust: d?.fromCustomer ? d.fromCustomer?.accountName : d?.fCustomer,
                        toCust: d?.toCustomer ? d.toCustomer?.accountName : d?.tCustomer,
                        vehicleNo: d.vehicleNo.vehicleNo,
                        grandTotal: d.grandTotal,
                        invoiceNo: ""
                ])
            }
        }
        if(child){
            render child as JSON
        }
        else{
            render '[]'
        }
        render child as JSON;
    }

    def getItemData()
    {
        def data = [];
        if(params?.id){
            data= ProductMaster.findAllByCustomerNameAndIsActive(AccountMaster.findById(params?.id),true);
        }
        if(data){
            render data as JSON
        }
        else{
            render '[]'
        }
    }

    def getSearchList(){
        def result=[];
        def data = [];
        def invNo = "";
        if(params?.fDate && params?.tDate){
            if(params?.fid && params?.tid){
                data = LREntry.findAllByFromCustomerAndToCustomerAndLrDateBetweenAndIsActive(AccountMaster.findById(params?.fid),AccountMaster.findById(params?.tid),Date.parse("yyyy-MM-dd",params.fDate),Date.parse("yyyy-MM-dd",params.tDate),true);
            }
            else{
                data = LREntry.findAllByLrDateBetweenAndIsActive(Date.parse("yyyy-MM-dd",params.fDate),Date.parse("yyyy-MM-dd",params.tDate),true);
            }
            if(data){
                data.each {d ->

                    invNo="";
                    if(d?.lrEntryDetails) {
                        invNo = d?.lrEntryDetails?.first()?.invoiceNo;
                    }

                    result.push([
                            id: d.id,
                            version: d.version,
                            lrNo: d.lrNo,
                            lrDate: d.lrDate,
                            fromCust: d?.fromCustomer ? d.fromCustomer?.accountName : d?.fCustomer,
                            toCust: d?.toCustomer ? d.toCustomer?.accountName : d?.tCustomer,
                            vehicleNo: d.vehicleNo.vehicleNo,
                            grandTotal: d.grandTotal,
                            invoiceNo: invNo
                    ])
                }
            }
        }

        if(result){
            render result as JSON
        }
        else{
            render '[]'
        }
    }

    def sendPartyMail(){
        def result=[];
        if(params?.id){
            def LREntryInstance=LREntry.findById(params.id);

            try {
                sendMail {
                    multipart true
                    to LREntryInstance?.fromCustomer?.email
//                    to 'rakeshadak137@gmail.com'
                    subject "LR From Ganesh Transport"
//                  html "LR No:"+LREntryInstance?.lrNo   +"<BR>" +"Bill Pay Type:"+ LREntryInstance?.billPayType  +"<BR>" + "From Customer:" + fromName  +"<BR>" + "To Customer:" + toName  +"<BR>" + "Total Amount:" + LREntryInstance?.grandTotal +"<BR>" + "Vehicle No:" + vehicle
                    html g.render(template: '/LREntry/mailTemplate',model: [LREntryInstance:LREntryInstance])
                }
            }
            catch (Exception e){
                e.printStackTrace();
            }
            redirect(action: "show", id: LREntryInstance.id,params: [scrid: session['activeScreen'].id])
        }

    }

    def exportData(){
        def data=[];
        def reportDetails=[];
        def result=[];
        def srNo=1;

        if(params?.fDate && params?.tDate){
            if(params?.fid && params?.tid){
                data = LREntry.findAllByFromCustomerAndToCustomerAndLrDateBetweenAndIsActive(AccountMaster.findById(params?.fid),AccountMaster.findById(params?.tid),Date.parse("yyyy-MM-dd",params.fDate),Date.parse("yyyy-MM-dd",params.tDate),true);
            }
            else{
                data = LREntry.findAllByLrDateBetweenAndIsActive(Date.parse("yyyy-MM-dd",params.fDate),Date.parse("yyyy-MM-dd",params.tDate),true);
            }
            if(data){
                data.each {d ->

                    result.push([
                            srNo: srNo++,
                            lrNo: d?.lrNo?:"",
                            lrDate: d?.lrDate? d?.lrDate?.format("dd-MM-yyyy"):"",
                            vehicleNo: d?.vehicleNo?.vehicleNo?:"",
                            fromName: d?.fromCustomer?.accountName?:"",
                            toName: d?.toCustomer?.accountName?:"",
                            amount:d?.amount?:""

                    ])
                }
            }
        }
        if(result){
            reportDetails.push([
                    details:result,
                    fromDate:Date.parse("yyyy-MM-dd",params?.fDate)?.format("dd-MM-yyyy"),
                    toDate:Date.parse("yyyy-MM-dd",params?.tDate)?.format("dd-MM-yyyy")
            ]);
        }

        params._format = "XLSX";
        params._file = "../reports/transactionReport/LRexportReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"

        chain(controller: 'transactionReport', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def findBillType(){
        def data=[];
        if(params?.id){
            data = BillingTypeMaster.findById(params.id);
            if(data){
                render data?.type?:""
            }
            else {
                render '[]'
            }
        }
        else{
            render '[]'
        }

    }

    def checkDuplicateInvoiceNo(){
        def data=[];
        def data2;
        def result = [];
        if(params?.no && params?.from && params?.to){
            data = LREntry.findAllByFromCustomerAndToCustomerAndFinancialYear(AccountMaster.findById(params.from),AccountMaster.findById(params.to),session['financialYear']);
            if(data){
                data.each{d->
                    data2= LREntryDetails.findByLrEntryAndInvoiceNo(d as LREntry,params.no);
                    if(data2 && !(data2?.productName?.productName=="EMPTY BIN")){
                        result=[];
                        result.push([
                                lrNo:data2?.lrEntry?.lrNo,
                                invNo:data2?.invoiceNo
                        ])
                    }
                }
            }
        }
        if(result){
            render result as JSON ;
        }
        else{
            render '[]'
        }
    }

    def showVehicleNo(){
        def result=[];
        def data=VehicleMaster.findAllByIsActive(true);
        if(data)
        {
            data.each {d->
                result.push([
                        id:d?.id,
                        vehicleNo:(d?.state?:"")+" "+(d?.rto?:"")+" "+(d?.series?:"")+" "+(d?.vehicleNo?:"")
                ])
            }
        }
        if(result){
            render result as JSON
        }
        else{
            render '[]'
        }
    }
    def findCustomerList(){
        def result=AccountMaster.createCriteria().list {
            eq("isActive",true)
        }
        if(result){
            render result as JSON
        }
        else{
            render '[]'
        }

    }
    def findProductList(){
        def result=ProductMaster.createCriteria().list {
            eq("isActive",true)
        }
        if(result){
            render result as JSON
        }
        else{
            render '[]'
        }

    }
    def findUnitList(){
        def result=UnitMaster.createCriteria().list {
            eq("isActive",true)
        }
        if(result){
            render result as JSON
        }
        else{
            render '[]'
        }

    }
}


