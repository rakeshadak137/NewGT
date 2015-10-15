package com.master

import annotation.ParentScreen
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", subUnder = "Master", fullName = "Bank Master")

class BankMasterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [bankMasterInstanceList: BankMaster.findAllByIsActive(true), bankMasterInstanceTotal: BankMaster.countByIsActive(true)]
    }

    def create() {
        [bankMasterInstance: new BankMaster(params)]
    }

    def save() {
        def bankMasterInstance = new BankMaster(params)

        bankMasterInstance.dateCreated = new Date();
        bankMasterInstance.financialYear = session['financialYear'];
        bankMasterInstance.createdBy = session['activeUser'];
        bankMasterInstance.branch = session['branch'];
        bankMasterInstance.lastUpdatedBy = session['activeUser'];


        if (!bankMasterInstance.save(flush: true)) {
            render(view: "create", model: [bankMasterInstance: bankMasterInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'bankMaster.label', default: 'BankMaster'), bankMasterInstance.id])
        redirect(action: "show", id: bankMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def bankMasterInstance = BankMaster.get(id)
        if (!bankMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bankMaster.label', default: 'BankMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [bankMasterInstance: bankMasterInstance]
    }

    def edit(Long id) {
        def bankMasterInstance = BankMaster.get(id)
        if (!bankMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bankMaster.label', default: 'BankMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [bankMasterInstance: bankMasterInstance]
    }

    def update(Long id, Long version) {
        def bankMasterInstance = BankMaster.get(id)
        if (!bankMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bankMaster.label', default: 'BankMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (bankMasterInstance.version > version) {
                bankMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'bankMaster.label', default: 'BankMaster')] as Object[],
                        "Another user has updated this BankMaster while you were editing")
                render(view: "edit", model: [bankMasterInstance: bankMasterInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        bankMasterInstance.properties = params
        bankMasterInstance.lastUpdatedBy = session['activeUser'];
        bankMasterInstance.lastUpdated = new Date();

        if (!bankMasterInstance.save(flush: true)) {
            render(view: "edit", model: [bankMasterInstance: bankMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'bankMaster.label', default: 'BankMaster'), bankMasterInstance.id])
        redirect(action: "show", id: bankMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def bankMasterInstance = BankMaster.get(id)

        if (!bankMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bankMaster.label', default: 'BankMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            bankMasterInstance.isActive = false
            bankMasterInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'bankMaster.label', default: 'BankMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'bankMaster.label', default: 'BankMaster'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }
}
