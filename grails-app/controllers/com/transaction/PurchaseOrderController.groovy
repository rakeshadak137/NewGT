package com.transaction

import annotation.ParentScreen
import com.master.BranchMaster
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Transaction", subUnder = "Transaction", fullName = "Purchase Order")

class PurchaseOrderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [purchaseOrderInstanceList: PurchaseOrder.findAllByIsActiveAndBranch(true,BranchMaster.findById(session['branch'].id)), purchaseOrderInstanceTotal: PurchaseOrder.countByIsActiveAndBranch(true,BranchMaster.findById(session['branch'].id))]
    }

    def create() {
        [purchaseOrderInstance: new PurchaseOrder(params)]
    }

    def save() {
        def purchaseOrderInstance = new PurchaseOrder(params)

        purchaseOrderInstance.dateCreated = new Date();
        purchaseOrderInstance.financialYear=session['financialYear'];
        purchaseOrderInstance.createdBy=session['activeUser'];
        purchaseOrderInstance.branch=session['branch'];

        def childs = JSON.parse(params.ChildJSON);

        childs.each {c ->
            purchaseOrderInstance.addToPurchaseOrderDetails(PurchaseOrderDetails.saveChildData(c));
        }


        if (!purchaseOrderInstance.save(flush: true)) {
            render(view: "create", model: [purchaseOrderInstance: purchaseOrderInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'purchaseOrder.label', default: 'PurchaseOrder'), purchaseOrderInstance.id])
        redirect(action: "list", id: purchaseOrderInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def purchaseOrderInstance = PurchaseOrder.get(id)
        if (!purchaseOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'purchaseOrder.label', default: 'PurchaseOrder'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [purchaseOrderInstance: purchaseOrderInstance]
    }

    def edit(Long id) {
        def purchaseOrderInstance = PurchaseOrder.get(id)
        if (!purchaseOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'purchaseOrder.label', default: 'PurchaseOrder'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [purchaseOrderInstance: purchaseOrderInstance]
    }

    def update(Long id, Long version) {
        def purchaseOrderInstance = PurchaseOrder.get(id)
        if (!purchaseOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'purchaseOrder.label', default: 'PurchaseOrder'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (purchaseOrderInstance.version > version) {
                    purchaseOrderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                            [message(code: 'purchaseOrder.label', default: 'PurchaseOrder')] as Object[],
                            "Another user has updated this PurchaseOrder while you were editing")
                render(view: "edit", model: [purchaseOrderInstance: purchaseOrderInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        PurchaseOrder.executeUpdate("delete PurchaseOrderDetails as b where b.purchaseOrder.id=:id", [id:purchaseOrderInstance.id]);
        purchaseOrderInstance.save(flush: true);

        purchaseOrderInstance.properties = params
        purchaseOrderInstance.lastUpdatedBy = session['activeUser'];
        purchaseOrderInstance.lastUpdated = new Date();

        def childs = JSON.parse(params.ChildJSON);

        childs.each {c ->
            purchaseOrderInstance.addToPurchaseOrderDetails(PurchaseOrderDetails.saveChildData(c));
        }

        if (!purchaseOrderInstance.save(flush: true)) {
            render(view: "edit", model: [purchaseOrderInstance: purchaseOrderInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'purchaseOrder.label', default: 'PurchaseOrder'), purchaseOrderInstance.id])
        redirect(action: "list", id: purchaseOrderInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def purchaseOrderInstance = PurchaseOrder.get(id)

        if (!purchaseOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'purchaseOrder.label', default: 'PurchaseOrder'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            purchaseOrderInstance.isActive = false
            purchaseOrderInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'purchaseOrder.label', default: 'PurchaseOrder'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'purchaseOrder.label', default: 'PurchaseOrder'), id])
            redirect(action: "list", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    def getData(){
        def Data = [];
        def child = [];

        if(params.id){
            Data = PurchaseOrder.findById(params.id as Long).purchaseOrderDetails;

            if(Data){
                Data.each {d ->
                    child.push([
                            fromCustomerId: d.fromCustomer.id,
                            fromCustomerName: d.fromCustomer.accountName,
                            toCustomerId: d.toCustomer.id,
                            toCustomerName: d.toCustomer.accountName,
                            freight: d.freight,
                            loading:d.loading,
                            unLoading: d.unLoading,
                            collection: d.collection,
                            cartage: d.cartage,
                            cata: d.cata,
                            bilty: d.bilty,
                            doorDelivery: d.doorDelivery,
                            total: d.total,
                            advance: d.advance,
                            haulting: d.haulting,
                            balance: d.balance,
                            tripRate: d.tripRate,
                            amount: d.amount,
                            billType: d.billType.id,
//                            billTypeId: d.billType.id
                    ]);
                }
            }
        }
        render child as JSON;
    }

    def getList(){
        def child = [];

        def Data = PurchaseOrder.findAllByIsActive(true);

        if(Data){
            Data.each{d ->
                child.push([
                        id: d.id,
                        version: d.version,
                        poNO: d.poNo,
                        poDate: d.poDate,
                        customer: d.customer.accountName,
                        type: d.poType
                ])
            }
        }
        render child as JSON;
    }
}
