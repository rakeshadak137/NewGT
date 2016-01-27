package com.master

import annotation.ParentScreen
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "Customer Master", subUnder = "Master")
class CustomerMasterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [customerMasterInstanceList: CustomerMaster.findAllByIsActive(true), customerMasterInstanceTotal: CustomerMaster.countByIsActive(true)]
    }

    def create() {
        [customerMasterInstance: new CustomerMaster(params)]
    }

    def save() {
        def customerMasterInstance = new CustomerMaster(params)

        customerMasterInstance.dateCreated = new Date();
        customerMasterInstance.financialYear = session['financialYear'];
        customerMasterInstance.createdBy = session['activeUser'];
        customerMasterInstance.branch = session['branch'];


        if (!customerMasterInstance.save(flush: true)) {
            render(view: "create", model: [customerMasterInstance: customerMasterInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'customerMaster.label', default: 'CustomerMaster'), customerMasterInstance.id])
        redirect(action: "show", id: customerMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def customerMasterInstance = CustomerMaster.get(id)
        if (!customerMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'customerMaster.label', default: 'CustomerMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [customerMasterInstance: customerMasterInstance]
    }

    def edit(Long id) {
        def customerMasterInstance = CustomerMaster.get(id)
        if (!customerMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'customerMaster.label', default: 'CustomerMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [customerMasterInstance: customerMasterInstance]
    }

    def update(Long id, Long version) {
        def customerMasterInstance = CustomerMaster.get(id)
        if (!customerMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'customerMaster.label', default: 'CustomerMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (customerMasterInstance.version > version) {
                customerMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'customerMaster.label', default: 'CustomerMaster')] as Object[],
                        "Another user has updated this CustomerMaster while you were editing")
                render(view: "edit", model: [customerMasterInstance: customerMasterInstance])
                return
            }
        }

        customerMasterInstance.properties = params
        customerMasterInstance.lastUpdatedBy = session['activeUser'];
        customerMasterInstance.lastUpdated = new Date();

        if (!customerMasterInstance.save(flush: true)) {
            render(view: "edit", model: [customerMasterInstance: customerMasterInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'customerMaster.label', default: 'CustomerMaster'), customerMasterInstance.id])
        redirect(action: "show", id: customerMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def customerMasterInstance = CustomerMaster.get(id)

        if (!customerMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'customerMaster.label', default: 'CustomerMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            customerMasterInstance.isActive = false
            customerMasterInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'customerMaster.label', default: 'CustomerMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'customerMaster.label', default: 'CustomerMaster'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    def checkDuplicate(){
        def data = CustomerMaster.createCriteria().list {
            eq("isActive",true)
            like("name",params.name)
        }

        if(data){
            render true
        }else{
            render false
        }
    }
}
