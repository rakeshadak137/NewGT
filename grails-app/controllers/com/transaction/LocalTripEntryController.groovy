package com.transaction

import annotation.ParentScreen
import com.master.AccountMaster
import com.master.GodownMaster
import com.master.ProductMaster
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Transaction", subUnder = "Transaction", fullName = "Local Trip Entry")
class LocalTripEntryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [localTripEntryInstanceList: LocalTripEntry.findAllByIsActive(true), localTripEntryInstanceTotal: LocalTripEntry.countByIsActive(true)]
    }

    def create() {
        [localTripEntryInstance: new LocalTripEntry(params)]
    }

    def save() {
        def localTripEntryInstance = new LocalTripEntry(params)

        localTripEntryInstance.localOutEntryNo = outEntryNo();

        localTripEntryInstance.totalTripRate = params.totalTripRate as BigDecimal;
        localTripEntryInstance.advance = params.advance as BigDecimal;
        localTripEntryInstance.balance = params.balance as BigDecimal;
        localTripEntryInstance.localOutTime = new Date();

        localTripEntryInstance.dateCreated = new Date();
        localTripEntryInstance.financialYear = session['financialYear'];
        localTripEntryInstance.createdBy = session['activeUser'];
        localTripEntryInstance.branch = session['branch'];
        localTripEntryInstance.lastUpdatedBy = session['activeUser'];

        def childs = JSON.parse(params.ChildJSON);
        childs.each { c ->
            localTripEntryInstance.addToLocalOutEntryDetails(LocalOutEntryDetails.saveChildData(c));
        }


        if (!localTripEntryInstance.save(flush: true)) {
            render(view: "create", model: [localTripEntryInstance: localTripEntryInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'localTripEntry.label', default: 'LocalTripEntry'), localTripEntryInstance.id])
        redirect(action: "show", id: localTripEntryInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def localTripEntryInstance = LocalTripEntry.get(id)
        if (!localTripEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'localTripEntry.label', default: 'LocalTripEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [localTripEntryInstance: localTripEntryInstance]
    }

    def edit(Long id) {
        def localTripEntryInstance = LocalTripEntry.get(id)
        if (!localTripEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'localTripEntry.label', default: 'LocalTripEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [localTripEntryInstance: localTripEntryInstance]
    }

    def update(Long id, Long version) {
        def localTripEntryInstance = LocalTripEntry.get(id)
        if (!localTripEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'localTripEntry.label', default: 'LocalTripEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (localTripEntryInstance.version > version) {
                localTripEntryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'localTripEntry.label', default: 'LocalTripEntry')] as Object[],
                        "Another user has updated this LocalTripEntry while you were editing")
                render(view: "edit", model: [localTripEntryInstance: localTripEntryInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        localTripEntryInstance.executeUpdate("delete LocalOutEntryDetails l where l.localTripEntry.id=:id",[id:localTripEntryInstance?.id])
        localTripEntryInstance.save(flush: true);

        localTripEntryInstance.properties = params
        localTripEntryInstance.lastUpdatedBy = session['activeUser'];
        localTripEntryInstance.lastUpdated = new Date();

        localTripEntryInstance.totalTripRate = params.totalTripRate as BigDecimal;
        localTripEntryInstance.advance = params.advance as BigDecimal;
        localTripEntryInstance.balance = params.balance as BigDecimal;

        localTripEntryInstance.dateCreated = new Date();
        localTripEntryInstance.financialYear = session['financialYear'];
        localTripEntryInstance.createdBy = session['activeUser'];
        localTripEntryInstance.branch = session['branch'];

        def childs = JSON.parse(params.ChildJSON);
        childs.each { c ->
            localTripEntryInstance.addToLocalOutEntryDetails(LocalOutEntryDetails.saveChildData(c));
        }

        if (!localTripEntryInstance.save(flush: true)) {
            render(view: "edit", model: [localTripEntryInstance: localTripEntryInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'localTripEntry.label', default: 'LocalTripEntry'), localTripEntryInstance.id])
        redirect(action: "show", id: localTripEntryInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def localTripEntryInstance = LocalTripEntry.get(id)

        if (!localTripEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'localTripEntry.label', default: 'LocalTripEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            localTripEntryInstance.isActive = false
            localTripEntryInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'localTripEntry.label', default: 'LocalTripEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'localTripEntry.label', default: 'LocalTripEntry'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    def outEntryNo(){
        int no = 1;
        def Data = LocalTripEntry.last();

        if (Data) {
            no = Integer.parseInt(Data?.localOutEntryNo) + 1;
        } else {
            no = 1;
        }
        return no;
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
            Data = LocalTripEntry.findById(params.id as Long).localOutEntryDetails;

            if(Data){
                Data.each {d ->
                    child.push([
                            productId: d?.productCode?.id?:"",
                            productName: d?.productCode?.id ?(d?.productCode?.productCode +'-'+ d?.productCode?.productName) :d?.productName,
                            manualProductName: d?.productName?:"",
                            qty: d?.quantity?:0,
                            unitId: d?.unit?.unitName?:"",
                            unitName: d?.unit?.id?:"",
                            invoiceNo:d?.invoiceNo?:""
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
//                                fromAddress: Data.fromAddress,
//                                toAddress: Data.toAddress,
//                                fromLocation: Data.fromLocation,
//                                toLocation: Data.toLocation,
                                poID: Data?.poID?.id?:"",
                                amount: Data.amount,
                                totalAmount: Data.totalAmount,
                                grandTotal: Data.grandTotal
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

    def getList() {
        def child = [];

        def Data = LocalTripEntry.findAllByIsActive(true);

        if (Data) {
            Data.each { d ->
                child.push([
                        id          : d.id,
                        version     : d.version,
                        entryNo     : d?.localOutEntryNo?:"",
                        entryDate   : d?.localOutEntryDate?.format("dd-MM-yyyy")?:"",
                        fromCustomer: d?.fromCustomer?.accountName?:"",
                        toCustomer  : d?.toCustomer?.accountName?:"",
                        godown      : d?.godown?.godownName?:"",
                        vehicleNo      : d?.vehicleNo?.vehicleNo?:"",
                        outTime     : d?.localOutTime?.format("hh:mm a")?:""
                ])
            }
        }
        render child as JSON;
    }

    def checkDuplicateInvoice(){
        def data=[];
        def data2;
        def result = [];
        if(params?.no && params?.from && params?.to){
            data = LocalTripEntry.findAllByFromCustomerAndToCustomer(AccountMaster.findById(params.from),AccountMaster.findById(params.to));
            if(data){
                data.each{d->
                    data2= LocalOutEntryDetails.findByLocalTripEntryAndInvoiceNo(d as LocalTripEntry,params.no);
                    if(data2){
                        result=[];
                        result.push([
                                tripNo:data2?.localTripEntry?.localOutEntryNo?:"",
                                invNo:data2?.invoiceNo?:""
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

    def getPOData(){
        def Data = [];
        def child = [];

        if(params.id){
            Data = PurchaseOrderDetails.findAllByFromCustomer(AccountMaster.findById(params.id as Long));

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

    def print_action(){


        def data=[];
        def parent;
        def child=[];
        def reportDetails=[];
        int srNo=1;
        if(params?.id){
            data = LocalTripEntry.findById(params?.id as Long);
            if(data){

                def data2 = LocalOutEntryDetails.findAllByLocalTripEntry(data as LocalTripEntry);
                if(data2){
                    data2.each {d2->
                        child.push([
                                srNo:srNo++,
                                name: d2.productCode ? d2?.productCode?.productName :d2.productName,
                                unit: d2?.unit?.unitName?:"",
                                qty: d2?.quantity?:0,
                        ])
                    }
                    if(child){
                        parent=[
                                child:child,
                                entryNo: data?.localOutEntryNo?:"",
                                entryDate:data?.localOutEntryDate?.format("dd-MM-yyyy")?:"",
                                entryTime:data?.localOutTime?.format("hh:mm a")?:"",
                                fromCust:data?.fromCustomer?.accountName?:"",
                                toCust:data?.toCustomer?.accountName?:"",
                                godown:data?.godown?.godownName?:"",
                                vehicleNo:data?.vehicleNo?.vehicleNo?:"",
                                tripRate:data?.totalTripRate?:0,
                                advance:data?.advance?:0,
                                grandTotal: data?.balance?:0,
                        ]
                    }
                }
            }
            if(parent){
                reportDetails.push(parent);
            }
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/LocalOutEntryReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"

        chain(controller: 'cityMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def saveData(){
        def data=[];
        print(data);

        def localTripEntryInstance = new LocalTripEntry(params)

        localTripEntryInstance.localOutEntryNo = outEntryNo();

        localTripEntryInstance.totalTripRate = params.tripRate as BigDecimal;
        localTripEntryInstance.advance = params.advance as BigDecimal;
        localTripEntryInstance.balance = params.balance as BigDecimal;
        localTripEntryInstance.localOutTime = new Date();
        localTripEntryInstance.fromCustomer = AccountMaster.findById(params?.fCust as Long);
        localTripEntryInstance.toCustomer = AccountMaster.findById(params?.tCust as Long);
        if(params?.godownId){
            localTripEntryInstance.godown = GodownMaster.findById(params.godownId);
        }

        localTripEntryInstance.dateCreated = new Date();
        localTripEntryInstance.localOutEntryDate = new Date();
        localTripEntryInstance.localOutTime = new Date();
        localTripEntryInstance.financialYear = session['financialYear'];
        localTripEntryInstance.createdBy = session['activeUser'];
        localTripEntryInstance.branch = session['branch'];
        localTripEntryInstance.lastUpdatedBy = session['activeUser'];

        def childs = JSON.parse(params.childData);
        childs.each { c ->
            localTripEntryInstance.addToLocalOutEntryDetails(LocalOutEntryDetails.saveChildData(c));
        }

        if (!localTripEntryInstance.save(flush: true)) {
            render "Data Not Saved";
        }
        else{
            render "Data Saved Successfully";
        }

    }

    def getSearchList(){
        def result=[];
        def data = [];
        def invNo = "";
        if(params?.fDate && params?.tDate){
            if(params?.fid && params?.tid){
                data = LocalTripEntry.findAllByFromCustomerAndToCustomerAndDateCreatedBetweenAndIsActive(AccountMaster.findById(params?.fid),AccountMaster.findById(params?.tid),Date.parse("yyyy-MM-dd",params.fDate),Date.parse("yyyy-MM-dd",params.tDate),true);
            }
            else{
                data = LocalTripEntry.findAllByDateCreatedBetweenAndIsActive(Date.parse("yyyy-MM-dd",params.fDate),Date.parse("yyyy-MM-dd",params.tDate),true);
            }
            if(data){
                data.each {d ->

                    result.push([
                            id: d.id,
                            version: d.version,
                            entryNo: d?.localOutEntryNo?:"",
                            entryDate: d?.localOutEntryDate?.format("dd-MM-yyyy")?:"",
                            fromCustomer: d?.fromCustomer ? d.fromCustomer?.accountName:"",
                            toCustomer: d?.toCustomer ? d.toCustomer?.accountName:"",
                            godown: d?.godown?.godownName?:"",
                            vehicleNo: d?.vehicleNo?.vehicleNo,
                            outTime: d?.localOutTime?.format("hh:mm a")?:"",
                            grandTotal: d?.balance?:""
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

}
