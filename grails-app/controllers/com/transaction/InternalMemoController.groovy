package com.transaction

import annotation.ParentScreen
import com.master.AccountMaster
import com.master.PumpMaster
import com.master.TripRate
import com.master.VehicleMaster
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Transaction", subUnder = "Transaction", fullName = "Internal Memo")
class InternalMemoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [internalMemoInstanceList: InternalMemo.findAllByIsActive(true), internalMemoInstanceTotal: InternalMemo.countByIsActive(true)]
    }

    def create() {
        [internalMemoInstance: new InternalMemo(params)]
    }

    def save() {
        def internalMemoInstance = new InternalMemo(params)
//        bindData(internalMemoInstance,params,'vehicleNo');
        bindData(internalMemoInstance, params, [exclude: ['vehicleNo','pumpName','tripLocation']])

        internalMemoInstance.voucherNo = voucherNO();
        internalMemoInstance.vehicleNo = VehicleMaster.findById(params.vehicle_no_id as Long);
        internalMemoInstance.tripLocation = TripRate.findById(params.tripId as Long);
        if(params?.Pumpid){
            internalMemoInstance.pumpName = PumpMaster.findById(params.Pumpid as Long);
        }
        if(params.dieselLtr){
            internalMemoInstance.dieselLtr = (params.dieselLtr as BigDecimal);
        }
        if(params.dieselRate){
            internalMemoInstance.dieselRate = params.dieselRate as BigDecimal;
        }
        if(params.dieselAmount){
            internalMemoInstance.dieselAmount = params.dieselAmount as BigDecimal;
        }
        if(params.freight){
            internalMemoInstance.freight = params.freight as BigDecimal;
        }
        if(params.totalTripRate){
            internalMemoInstance.totalTripRate = params.totalTripRate as BigDecimal;
        }
        if(params.advance){
            internalMemoInstance.advance = params.advance as BigDecimal;
        }
        if(params.balance){
            internalMemoInstance.balance = params.balance as BigDecimal;
        }
        if(params.tripRate){
            internalMemoInstance.tripRate = params.tripRate as BigDecimal;
        }
        if(params.totalBalance){
            internalMemoInstance.totalBalance = params.totalBalance as BigDecimal;
        }

        internalMemoInstance.dateCreated = new Date();
        internalMemoInstance.financialYear = session['financialYear'];
        internalMemoInstance.createdBy = session['activeUser'];
        internalMemoInstance.branch = session['branch'];

        def childs = JSON.parse(params.ChildJSON);

        childs.each { c ->
            if (c.bool) {
                internalMemoInstance.addToInternalMemoDetails(InternalMemoDetails.saveChildData(c));
            }
        }

        if (!internalMemoInstance.save(flush: true)) {
            render(view: "create", model: [internalMemoInstance: internalMemoInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'internalMemo.label', default: 'InternalMemo'), internalMemoInstance.id])
        redirect(action: "show", id: internalMemoInstance.id, params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def internalMemoInstance = InternalMemo.get(id)
        if (!internalMemoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'internalMemo.label', default: 'InternalMemo'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        [internalMemoInstance: internalMemoInstance]
    }

    def edit(Long id) {
        def internalMemoInstance = InternalMemo.get(id)
        if (!internalMemoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'internalMemo.label', default: 'InternalMemo'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        [internalMemoInstance: internalMemoInstance]
    }

    def update(Long id, Long version) {
        def internalMemoInstance = InternalMemo.get(id)
        bindData(internalMemoInstance, params, [exclude: ['vehicleNo','tripLocation']])

        InternalMemo.executeUpdate("delete InternalMemoDetails as b where b.internalMemo.id=:id", [id: internalMemoInstance.id]);
        internalMemoInstance.save(flush: true);

        if (!internalMemoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'internalMemo.label', default: 'InternalMemo'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
//            if (internalMemoInstance.version > version) {
//                internalMemoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
//                        [message(code: 'internalMemo.label', default: 'InternalMemo')] as Object[],
//                        "Another user has updated this InternalMemo while you were editing")
//                render(view: "edit", model: [internalMemoInstance: internalMemoInstance])
//                return
//            }
        }

        internalMemoInstance.properties = params
        internalMemoInstance.vehicleNo = VehicleMaster.findById(params.vehicle_no_id as Long);
        internalMemoInstance.tripLocation = TripRate.findById(params.tripId as Long);

        if(params?.Pumpid && params?.Pumpid!="null"){
            internalMemoInstance.pumpName = PumpMaster.findById(params.Pumpid as Long);
        }
        if(params.dieselLtr){
            internalMemoInstance.dieselLtr = (params.dieselLtr as BigDecimal);
        }
        if(params.dieselRate){
            internalMemoInstance.dieselRate = params.dieselRate as BigDecimal;
        }
        if(params.dieselAmount){
            internalMemoInstance.dieselAmount = params.dieselAmount as BigDecimal;
        }
        if(params.freight){
            internalMemoInstance.freight = params.freight as BigDecimal;
        }
        if(params.totalTripRate){
            internalMemoInstance.totalTripRate = params.totalTripRate as BigDecimal;
        }
        if(params.advance){
            internalMemoInstance.advance = params.advance as BigDecimal;
        }
        if(params.balance){
            internalMemoInstance.balance = params.balance as BigDecimal;
        }
        if(params.tripRate){
            internalMemoInstance.tripRate = params.tripRate as BigDecimal;
        }
        if(params.totalBalance){
            internalMemoInstance.totalBalance = params.totalBalance as BigDecimal;
        }

        internalMemoInstance.lastUpdatedBy = session['activeUser'];
        internalMemoInstance.lastUpdated = new Date();

        def childs = JSON.parse(params.ChildJSON);

        childs.each { c ->
            if (c.bool) {
                internalMemoInstance.addToInternalMemoDetails(InternalMemoDetails.saveChildData(c));
            }
        }

        if (!internalMemoInstance.save(flush: true)) {
            render(view: "edit", model: [internalMemoInstance: internalMemoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'internalMemo.label', default: 'InternalMemo'), internalMemoInstance.id])
        redirect(action: "show", id: internalMemoInstance.id, params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def internalMemoInstance = InternalMemo.get(id)

        if (!internalMemoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'internalMemo.label', default: 'InternalMemo'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            internalMemoInstance.isActive = false
            internalMemoInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'internalMemo.label', default: 'InternalMemo'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'internalMemo.label', default: 'InternalMemo'), id])
            redirect(action: "show", id: id, params: [scrid: session['activeScreen'].id])
        }
    }

    // JSON of LRData After Clicking on Show Data in Create Page
    def lrData() {
        def child = [];

        if (params.vehicleNo && params.fromDate && params.toDate) {
            def lrEntry = LREntry.findAllByVehicleNoAndLrDateBetween(VehicleMaster.findById(params.vehicleNo as Long), Date.parse("yyyy-MM-dd", params.fromDate), Date.parse("yyyy-MM-dd", params.toDate));

            if (lrEntry) {
                lrEntry.each { l ->
                    def lrChild = l.lrEntryDetails;

                    if(lrChild){
                        lrChild.each {ch ->
                            def checkData = InternalMemoDetails.findByLrChild(ch as LREntryDetails);
                            if(!checkData){
                                child.push([
                                        bool          : false,
                                        lrNo          : l.lrNo,
                                        lrDate        : l.lrDate,
                                        invoiceNo     : ch?.invoiceNo?:"",
                                        lrChild       : ch?.id?:"",
                                        fromCustomer  : l?.fromCustomer?.accountName ?: "",
                                        fromCustomerId: l?.fromCustomer?.id ?: "",
                                        toCustomer    : l?.toCustomer?.accountName ?: "",
                                        toCustomerId  : l?.toCustomer?.id ?: "",
                                        totalQty      : ch?.invoiceQty ?: 0,
                                        unit          : ch?.invoiceUnit?.unitName ?: "",
                                        unitId        : ch?.invoiceUnit?.id ?: ""
                                ])
                            }
                        }
                    }
                }
            }
        }
        render child as JSON;
    }

    // Function of Unique Voucher Number.
    def voucherNO() {
        int no = 1;

        def Data = InternalMemo.last();

        if (Data) {
            no = Integer.parseInt(Data.voucherNo) + 1;
        }
        return no;
    }

    // JSON of LRData At the time of Edit Functionality.
    def editLRData() {
        def child = [];
        def Data = [];

        if (params.id) {
            Data = InternalMemo.findById(params.id as Long);

            if (Data) {
                def lrEntry = LREntry.findAllByVehicleNoAndLrDateBetween(VehicleMaster.findById(Data.vehicleNo.id as Long),Data.fromDate, Data.toDate);

                if (lrEntry) {
                    lrEntry.each { l ->
                        def lrChild = l.lrEntryDetails;

                        if (lrChild) {
                            lrChild.each {ch ->

                                def lrData = InternalMemoDetails.findByLrChildAndInternalMemo(ch as LREntryDetails,Data as InternalMemo);

                                if(lrData){
                                    child.push([
                                            bool          : true,
                                            lrNo          : l.lrNo,
                                            lrDate        : l.lrDate,
                                            invoiceNo     : lrData?.invoiceNo?:"",
                                            lrChild       : lrData?.lrChild?.id?:"",
                                            fromCustomer  : l?.fromCustomer?.accountName ?: "",
                                            fromCustomerId: l?.fromCustomer?.id ?: "",
                                            toCustomer    : l?.toCustomer?.accountName ?: "",
                                            toCustomerId  : l?.toCustomer?.id ?: "",
                                            totalQty      : lrData?.qty ?: 0,
                                            unit          : lrData?.unit?.unitName ?: "",
                                            unitId        : lrData?.unit?.id ?: ""
                                    ])
                                }else{
                                    child.push([
                                            bool          : false,
                                            lrNo          : l.lrNo,
                                            lrDate        : l.lrDate,
                                            invoiceNo     : ch?.invoiceNo?:"",
                                            lrChild       : ch?.id?:"",
                                            fromCustomer  : l?.fromCustomer?.accountName ?: "",
                                            fromCustomerId: l?.fromCustomer?.id ?: "",
                                            toCustomer    : l?.toCustomer?.accountName ?: "",
                                            toCustomerId  : l?.toCustomer?.id ?: "",
                                            totalQty      : ch?.invoiceQty ?: 0,
                                            unit          : ch?.invoiceUnit?.unitName ?: "",
                                            unitId        : ch?.invoiceUnit?.id ?: ""
                                    ])
                                }
                            }
                        }
                    }
                }
            }
        }
        render child as JSON;
    }

    //Internal Memo Report JSON
    def print_action(){
        def memoData = InternalMemo.findById(params.id as Long);
        if(memoData){
            if((memoData.print_status>0) && !(session['activeUser'].admin)){
                flash.message = message(code: 'This Memo Has been Already Printed Once. Please Contact Ganesh Transport,Pune. For Further Query', args: [message(code: 'internalMemo.label', default: 'InternalMemo'), memoData.id])
                redirect(action: "list", params: [scrid: session['activeScreen'].id]);
            }
            else{


        def reportDetails = [];
        def parent = [];
        def finalData;
        def child = [];
        def totalQty = 0;
        def srNo = 1;

        if(params.id) {
            def internalMemo = InternalMemo.findById(params.id as Long);

            if (internalMemo) {
//                def internalMemoChild = internalMemo.internalMemoDetails;
                def distinctCustomer = InternalMemoDetails.executeQuery( "select distinct a.fromCustomer,a.toCustomer from InternalMemoDetails a where a.internalMemo = " + internalMemo.id );;

                if(distinctCustomer){
                    
                    distinctCustomer.each {d ->
                        totalQty = 0;
                        child = [];
                        def internalMemoChild = InternalMemoDetails.findAllByInternalMemoAndFromCustomerAndToCustomer(internalMemo as InternalMemo,AccountMaster.findById(d[0].id as Long),AccountMaster.findById(d[1].id as Long));

                        if(internalMemoChild){
                            internalMemoChild.each {c ->
                                totalQty = totalQty + c?.qty?:0;
                                child.push([
//                                        fromCustomer: c?.fromCustomer?.accountName?:"",
//                                        toCustomer: c?.toCustomer?.accountName?:"",
                                        srNo:srNo++,
                                        lrNo: c?.lrNo?:"",
                                        lrDate: c?.lrDate?.format("dd-MM-yyyy")?:"",
                                        invoiceNo: c?.invoiceNo?:"",
                                        qty: c?.qty?:0,
                                        unit: c?.unit?.unitName?:""
                                ])
                            }
                        }

                        if(child){
                            parent.push([
                                    fromCustomer: d[0]?.accountName?:"",
                                    toCustomer: d[1]?.accountName?:"",
                                    totalQty: totalQty,
                                    details: child
                            ])
                        }
                    }

                    if(parent) {
                        finalData =
                                [
                                        voucherNo        : internalMemo?.voucherNo ?: "",
                                        voucherDate      : internalMemo?.voucherDate?.format("dd-MM-yyyy") ?: "",
                                        transportName    : internalMemo?.transportName ?: "",
                                        driverName       : internalMemo?.driverName ?: "",
                                        ownerName        : internalMemo?.ownerName ?: "",
                                        address          : internalMemo?.address ?: "",
                                        phoneNo          : internalMemo?.phoneNo ?: "",
                                        vehicleNo        : (internalMemo?.vehicleNo?.state?:"")+" "+(internalMemo?.vehicleNo?.rto?:"")+" "+(internalMemo?.vehicleNo?.series?:"")+" "+(internalMemo?.vehicleNo?.vehicleNo?:""),
                                        fright           : internalMemo?.freight ?: "",
                                        advance          : internalMemo?.advance ?: "",
                                        balance          : internalMemo?.balance ?: "",
                                        dieselReceiptNo  : internalMemo?.dieselReceiptNo ?: "",
                                        dieselReceiptDate: internalMemo?.dieselReceiptDate?.format("dd-MM-yyyy") ?: "",
                                        dieselLtr        : internalMemo?.dieselLtr ?: "",
                                        dieselRate       : internalMemo?.dieselRate ?: "",
                                        dieselAmount     : internalMemo?.dieselAmount ?: "",
                                        totalTripRate    : internalMemo?.totalTripRate ?: "",
                                        pumpName         : internalMemo?.pumpName?.pumpName ?: "",
                                        outTime          : internalMemo?.dateCreated?.format("hh:mm:ss a")?:"",
                                        details          : parent,
                                ]
                    }
                }
            }
        }
        if(finalData){
            reportDetails.push(finalData);
        }
//        print reportDetails;
        params._format = "PDF";
        params._file = "../reports/transactionReport/Internal_Memo"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"

        chain(controller: 'cityMaster', action: 'generateReport', model: [data: reportDetails], params: params);
            }
        }
    }

    // JSON of List Page
    def getList(){
        def child = [];

        def Data = InternalMemo.findAllByIsActive(true);
        if(Data){
            Data.each {d ->
                child.push([
                        id: d.id,
                        version: d.version,
                        voucherNo: d?.voucherNo?:"",
                        voucherDate: d?.voucherDate?.format("dd-MM-yyyy")?:"",
                        vehicleNo: d?.vehicleNumber?:"",
                        tripRate: d?.totalTripRate?:"",
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

    // Function to Show Diesel Rate According to Pump Name
    def dieselRate(){
        def rate = 0;

        if(params.pumpId){
            def Data = PumpMaster.findById(params.pumpId as Long);

            if(Data){
                rate = Data?.dieselRate?:0;
            }
        }
        render rate;
    }

    def showVehicleNo(){
        def result=[];
        def data=VehicleMaster.findAllByIsActive(true);
        if(data){
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
}
