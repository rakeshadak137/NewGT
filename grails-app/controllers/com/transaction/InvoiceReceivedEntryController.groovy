package com.transaction

import annotation.ParentScreen
import com.master.AccountMaster
import com.master.VehicleMaster
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Transaction", subUnder = "Transaction", fullName = "Invoice Receive Entry")
class InvoiceReceivedEntryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [invoiceReceivedEntryInstanceList: InvoiceReceivedEntry.findAllByIsActive(true), invoiceReceivedEntryInstanceTotal: InvoiceReceivedEntry.countByIsActive(true)]
    }

    def create() {
        [invoiceReceivedEntryInstance: new InvoiceReceivedEntry(params)]
    }

    def save() {
        def invoiceReceivedEntryInstance = new InvoiceReceivedEntry(params)
        bindData(invoiceReceivedEntryInstance,params,['goDown'])

        invoiceReceivedEntryInstance.dateCreated = new Date();
        invoiceReceivedEntryInstance.financialYear = session['financialYear'];
        invoiceReceivedEntryInstance.createdBy = session['activeUser'];
        invoiceReceivedEntryInstance.branch = session['branch'];

        int no = 0;
        def data = InvoiceReceivedEntry.last();

        if(data){
            no = data.srNo+ 1;
        }
        else{
            no = 1;
        }

        invoiceReceivedEntryInstance.srNo = no;

        def childs = JSON.parse(params.ChildJSON);

        childs.each {c ->
            invoiceReceivedEntryInstance.addToChild(InvoiceReceivedEntryDetails.saveChildData(c));

            def lrEntryDetailsInstance = LREntryDetails.findById(c?.id as Long);
            lrEntryDetailsInstance.received = true;
            lrEntryDetailsInstance.save(flush: true);
        }

        if (!invoiceReceivedEntryInstance.save(flush: true)) {
            render(view: "create", model: [invoiceReceivedEntryInstance: invoiceReceivedEntryInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'invoiceReceivedEntry.label', default: 'InvoiceReceivedEntry'), invoiceReceivedEntryInstance.id])
        redirect(action: "show", id: invoiceReceivedEntryInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def invoiceReceivedEntryInstance = InvoiceReceivedEntry.get(id)
        if (!invoiceReceivedEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoiceReceivedEntry.label', default: 'InvoiceReceivedEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [invoiceReceivedEntryInstance: invoiceReceivedEntryInstance]
    }

    def edit(Long id) {
        def invoiceReceivedEntryInstance = InvoiceReceivedEntry.get(id)
        if (!invoiceReceivedEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoiceReceivedEntry.label', default: 'InvoiceReceivedEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [invoiceReceivedEntryInstance: invoiceReceivedEntryInstance]
    }

    def update(Long id, Long version) {
        def invoiceReceivedEntryInstance = InvoiceReceivedEntry.get(id)

        def childData = invoiceReceivedEntryInstance?.child;

        if(childData){
            childData.each {c ->
                def lrEntryInstance = LREntryDetails.findById(c?.lrEntryDetails?.id as Long);
                lrEntryInstance.received = false;
                lrEntryInstance.save(flush: true);
            }
        }

        InvoiceReceivedEntry.executeUpdate("delete InvoiceReceivedEntryDetails as b where b.parent.id=:id", [id:invoiceReceivedEntryInstance.id]);
        invoiceReceivedEntryInstance.save(flush: true);

        if (!invoiceReceivedEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoiceReceivedEntry.label', default: 'InvoiceReceivedEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (invoiceReceivedEntryInstance.version > version) {
                invoiceReceivedEntryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'invoiceReceivedEntry.label', default: 'InvoiceReceivedEntry')] as Object[],
                        "Another user has updated this InvoiceReceivedEntry while you were editing")
                render(view: "edit", model: [invoiceReceivedEntryInstance: invoiceReceivedEntryInstance])
                return
            }
        }

        invoiceReceivedEntryInstance.properties = params
        bindData(invoiceReceivedEntryInstance,params,['goDown'])

        invoiceReceivedEntryInstance.lastUpdatedBy = session['activeUser'];
        invoiceReceivedEntryInstance.lastUpdated = new Date();

        def childs = JSON.parse(params.ChildJSON);

        childs.each {c ->
            invoiceReceivedEntryInstance.addToChild(InvoiceReceivedEntryDetails.saveChildData(c));

            def lrEntryDetailsInstance = LREntryDetails.findById(c?.id as Long);
            lrEntryDetailsInstance.received = true;
            lrEntryDetailsInstance.save(flush: true);
        }

        if (!invoiceReceivedEntryInstance.save(flush: true)) {
            render(view: "edit", model: [invoiceReceivedEntryInstance: invoiceReceivedEntryInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'invoiceReceivedEntry.label', default: 'InvoiceReceivedEntry'), invoiceReceivedEntryInstance.id])
        redirect(action: "show", id: invoiceReceivedEntryInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def invoiceReceivedEntryInstance = InvoiceReceivedEntry.get(id)

        def childData = invoiceReceivedEntryInstance?.child;

        if(childData){
            childData.each {c ->
                def lrEntryDetailsInstance = LREntryDetails.findById(c?.lrEntryDetails?.id as Long);
                lrEntryDetailsInstance.received = false;
                lrEntryDetailsInstance.save(flush: true);
            }
        }

        if (!invoiceReceivedEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invoiceReceivedEntry.label', default: 'InvoiceReceivedEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            invoiceReceivedEntryInstance.isActive = false
            invoiceReceivedEntryInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'invoiceReceivedEntry.label', default: 'InvoiceReceivedEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'invoiceReceivedEntry.label', default: 'InvoiceReceivedEntry'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    def showInvoiceData(){
        def child = [];

        def data = LREntry.createCriteria().list {
            eq("branch",session['branch'])
            eq("isActive",true)

            if(params.fromParty != "undefined"){
                eq("fromCustomer",AccountMaster.findById(params.fromParty as Long))
            }

            if(params.toParty != "undefined"){
                eq("toCustomer",AccountMaster.findById(params.toParty as Long))
            }

            if(params.vNo != "undefined"){
                eq("vehicleNo",VehicleMaster.findById(params.vNo))
            }

            if((params.fromDate != "undefined") && (params.toDate != "undefined")){
                between("lrDate",Date.parse("yyyy-MM-dd",params.fromDate),Date.parse("yyyy-MM-dd",params.toDate))
            }else if(params.fromDate != "undefined"){
                ge("lrDate",Date.parse("yyyy-MM-dd",params.fromDate))
            }else if(params.toDate != "undefined"){
                le("lrDate",Date.parse("yyyy-MM-dd",params.toDate))
            }
        }

        if(data){
            data.each {d ->
                def childData = LREntryDetails.createCriteria().list {
                    eq("lrEntry",d as LREntry)
                    eq("received",false)
                }

                if(childData){
                    childData.each {ch ->
                        child.push([
                                id : ch?.id,
                                invoiceNo : ch?.invoiceNo?:"",
                                fromParty : d?.fromCustomer?.accountName?:"",
                                toParty : d?.toCustomer?.accountName?:"",
                                vehicleNo : d?.vehicleNo?.vehicleNo?:"",
                                godown : d?.goDown?.godownName?:""
                        ])
                    }
                }
            }
        }

        render child as JSON;
    }

    def editInvoiceData(){
        def child = [];

        if(params.id){
            def data = InvoiceReceivedEntry.findById(params.id as Long);

            if(data){
                def childData = data?.child;

                if(childData){
                    childData.each {d ->
                        child.push([
                                id : d?.lrEntryDetails?.id,
                                invoiceNo : d?.lrEntryDetails?.invoiceNo?:"",
                                fromParty : d?.lrEntryDetails?.lrEntry?.fromCustomer?.accountName?:"",
                                toParty : d?.lrEntryDetails?.lrEntry?.toCustomer?.accountName?:"",
                                vehicleNo : d?.lrEntryDetails?.lrEntry?.vehicleNo?.vehicleNo?:"",
                                godown : d?.lrEntryDetails?.lrEntry?.goDown?.godownName?:""
                        ])
                    }
                }
            }
        }
        render child as JSON;
    }

    def getList(){
        def child = [];

        def data = InvoiceReceivedEntry.findAllByIsActive(true);

        if(data){
            data.each {d ->
                child.push([
                        id : d?.id,
                        version : d?.version?:0,
                        srNo : d?.srNo?:"",
                        date : d?.receiveDate?.format("dd-MM-yyyy"),
                        goDown : d?.goDown?.godownName?:""
                ]);
            }
        }
        render child as JSON;
    }
}
