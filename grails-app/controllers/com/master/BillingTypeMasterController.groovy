package com.master

import annotation.ParentScreen
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "Billing Type Master", subUnder = "Master")
class BillingTypeMasterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [billingTypeMasterInstanceList: BillingTypeMaster.findAllByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true), billingTypeMasterInstanceTotal: BillingTypeMaster.countByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true)]
    }

    def create() {
        [billingTypeMasterInstance: new BillingTypeMaster(params)]
    }

    def save() {
        def billingTypeMasterInstance = new BillingTypeMaster(params)

        billingTypeMasterInstance.dateCreated = new Date();
        billingTypeMasterInstance.financialYear = session['financialYear'];
        billingTypeMasterInstance.createdBy = session['activeUser'];
        billingTypeMasterInstance.branch = session['branch'];


        if (!billingTypeMasterInstance.save(flush: true)) {
            render(view: "create", model: [billingTypeMasterInstance: billingTypeMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'billingTypeMaster.label', default: 'BillingTypeMaster'), billingTypeMasterInstance.id])
        redirect(action: "list", id: billingTypeMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def billingTypeMasterInstance = BillingTypeMaster.get(id)
        if (!billingTypeMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'billingTypeMaster.label', default: 'BillingTypeMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [billingTypeMasterInstance: billingTypeMasterInstance]
    }

    def edit(Long id) {
        def billingTypeMasterInstance = BillingTypeMaster.get(id)
        if (!billingTypeMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'billingTypeMaster.label', default: 'BillingTypeMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [billingTypeMasterInstance: billingTypeMasterInstance]
    }

    def update(Long id, Long version) {
        def billingTypeMasterInstance = BillingTypeMaster.get(id)
        if (!billingTypeMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'billingTypeMaster.label', default: 'BillingTypeMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (billingTypeMasterInstance.version > version) {
                billingTypeMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'billingTypeMaster.label', default: 'BillingTypeMaster')] as Object[],
                        "Another user has updated this BillingTypeMaster while you were editing")
                render(view: "edit", model: [billingTypeMasterInstance: billingTypeMasterInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        billingTypeMasterInstance.properties = params
        billingTypeMasterInstance.lastUpdatedBy = session['activeUser'];
        billingTypeMasterInstance.lastUpdated = new Date();

        if (!billingTypeMasterInstance.save(flush: true)) {
            render(view: "edit", model: [billingTypeMasterInstance: billingTypeMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'billingTypeMaster.label', default: 'BillingTypeMaster'), billingTypeMasterInstance.id])
        redirect(action: "list", id: billingTypeMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def billingTypeMasterInstance = BillingTypeMaster.get(id)

        if (!billingTypeMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'billingTypeMaster.label', default: 'BillingTypeMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            billingTypeMasterInstance.isActive = false
            billingTypeMasterInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'billingTypeMaster.label', default: 'BillingTypeMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'billingTypeMaster.label', default: 'BillingTypeMaster'), id])
            redirect(action: "list", id: id,params: [scrid: session['activeScreen'].id])
        }
    }
}
