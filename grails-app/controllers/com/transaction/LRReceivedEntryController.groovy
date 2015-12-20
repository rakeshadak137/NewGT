package com.transaction

import annotation.ParentScreen
import com.master.AccountMaster
import com.master.VehicleMaster
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Transaction", subUnder = "Transaction", fullName = "LR Receive Entry")
class LRReceivedEntryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [LRReceivedEntryInstanceList: LRReceivedEntry.findAllByIsActive(true), LRReceivedEntryInstanceTotal: LRReceivedEntry.countByIsActive(true)]
    }

    def create() {
        [LRReceivedEntryInstance: new LRReceivedEntry(params)]
    }

    def save() {
        def LRReceivedEntryInstance = new LRReceivedEntry(params)
        bindData(LRReceivedEntryInstance,params,['goDown'])

        LRReceivedEntryInstance.dateCreated = new Date();
        LRReceivedEntryInstance.financialYear = session['financialYear'];
        LRReceivedEntryInstance.createdBy = session['activeUser'];
        LRReceivedEntryInstance.branch = session['branch'];

        int no = 0;
        def data = LRReceivedEntry.last();

        if(data){
            no = data.srNo+ 1;
        }
        else{
            no = 1;
        }

        LRReceivedEntryInstance.srNo = no;

        def childs = JSON.parse(params.ChildJSON);

        childs.each {c ->
            LRReceivedEntryInstance.addToChild(LRReceivedEntryDetails.saveChildData(c));

            def lrEntryInstance = LREntry.findById(c?.id as Long);
            lrEntryInstance.received = true;
            lrEntryInstance.save(flush: true);
        }

        if (!LRReceivedEntryInstance.save(flush: true)) {
            render(view: "create", model: [LRReceivedEntryInstance: LRReceivedEntryInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'LRReceivedEntry.label', default: 'LRReceivedEntry'), LRReceivedEntryInstance.id])
        redirect(action: "show", id: LRReceivedEntryInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def LRReceivedEntryInstance = LRReceivedEntry.get(id)
        if (!LRReceivedEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'LRReceivedEntry.label', default: 'LRReceivedEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [LRReceivedEntryInstance: LRReceivedEntryInstance,params: [scrid: session['activeScreen'].id]]
    }

    def edit(Long id) {
        def LRReceivedEntryInstance = LRReceivedEntry.get(id)
        if (!LRReceivedEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'LRReceivedEntry.label', default: 'LRReceivedEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [LRReceivedEntryInstance: LRReceivedEntryInstance,params: [scrid: session['activeScreen'].id]]
    }

    def update(Long id, Long version) {
        def LRReceivedEntryInstance = LRReceivedEntry.get(id)

        def childData = LRReceivedEntryInstance?.child;

        if(childData){
            childData.each {c ->
                def lrEntryInstance = LREntry.findById(c?.lrEntry?.id as Long);
                lrEntryInstance.received = false;
                lrEntryInstance.save(flush: true);
            }
        }

        LRReceivedEntry.executeUpdate("delete LRReceivedEntryDetails as b where b.parent.id=:id", [id:LRReceivedEntryInstance.id]);
        LRReceivedEntryInstance.save(flush: true);

        if (!LRReceivedEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'LRReceivedEntry.label', default: 'LRReceivedEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (LRReceivedEntryInstance.version > version) {
                LRReceivedEntryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'LRReceivedEntry.label', default: 'LRReceivedEntry')] as Object[],
                        "Another user has updated this LRReceivedEntry while you were editing")
                render(view: "edit", model: [LRReceivedEntryInstance: LRReceivedEntryInstance])
                return
            }
        }

        LRReceivedEntryInstance.properties = params
        bindData(LRReceivedEntryInstance,params,['goDown'])

        LRReceivedEntryInstance.lastUpdatedBy = session['activeUser'];
        LRReceivedEntryInstance.lastUpdated = new Date();

        def childs = JSON.parse(params.ChildJSON);

        childs.each {c ->
            LRReceivedEntryInstance.addToChild(LRReceivedEntryDetails.saveChildData(c));

            def lrEntryInstance = LREntry.findById(c?.id as Long);
            lrEntryInstance.received = true;
            lrEntryInstance.save(flush: true);
        }

        if (!LRReceivedEntryInstance.save(flush: true)) {
            render(view: "edit", model: [LRReceivedEntryInstance: LRReceivedEntryInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'LRReceivedEntry.label', default: 'LRReceivedEntry'), LRReceivedEntryInstance.id])
        redirect(action: "show", id: LRReceivedEntryInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def LRReceivedEntryInstance = LRReceivedEntry.get(id)

        def childData = LRReceivedEntryInstance?.child;

        if(childData){
            childData.each {c ->
                def lrEntryInstance = LREntry.findById(c?.lrEntry?.id as Long);
                lrEntryInstance.received = false;
                lrEntryInstance.save(flush: true);
            }
        }

        if (!LRReceivedEntryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'LRReceivedEntry.label', default: 'LRReceivedEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            LRReceivedEntryInstance.isActive = false
            LRReceivedEntryInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'LRReceivedEntry.label', default: 'LRReceivedEntry'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'LRReceivedEntry.label', default: 'LRReceivedEntry'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    def showLrData(){
        def child = [];

        def data = LREntry.createCriteria().list {
            eq("branch",session['branch'])
            eq("isActive",true)
            eq("received",false)

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
                child.push([
                        id : d?.id,
                        lrNo : d?.lrNo?:"",
                        lrDate : d?.lrDate?.format("dd-MM-yyyy")?:"",
                        fromParty : d?.fromCustomer?.accountName?:"",
                        toParty : d?.toCustomer?.accountName?:"",
                        vehicleNo : d?.vehicleNo?.vehicleNo?:"",
                        godown : d?.goDown?.godownName?:""
                ])
            }
        }

        render child as JSON;
    }

    def editLRData(){
        def child = [];

        if(params.id){
            def data = LRReceivedEntry.findById(params.id as Long);

            if(data){
                def childData = data?.child;

                if(childData){
                    childData.each {d ->
                        child.push([
                                id : d?.lrEntry?.id,
                                lrNo : d?.lrEntry?.lrNo?:"",
                                lrDate : d?.lrEntry?.lrDate?.format("dd-MM-yyyy")?:"",
                                fromParty : d?.lrEntry?.fromCustomer?.accountName?:"",
                                toParty : d?.lrEntry?.toCustomer?.accountName?:"",
                                vehicleNo : d?.lrEntry?.vehicleNo?.vehicleNo?:"",
                                godown : d?.lrEntry?.goDown?.godownName?:""
                        ])
                    }
                }
            }
        }
        render child as JSON;
    }

    def getList(){
        def child = [];

        def data = LRReceivedEntry.findAllByIsActive(true);

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
