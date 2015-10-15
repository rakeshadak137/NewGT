package com.master

import annotation.ParentScreen
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "Division Master", subUnder = "Master")

class DivisionMasterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [divisionMasterInstanceList: DivisionMaster.findAllByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true), divisionMasterInstanceTotal: DivisionMaster.countByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true)]
    }

    def create() {
        [divisionMasterInstance: new DivisionMaster(params)]
    }

    def save() {
        def divisionMasterInstance = new DivisionMaster(params)

        divisionMasterInstance.dateCreated = new Date();
        divisionMasterInstance.financialYear = session['financialYear'];
        divisionMasterInstance.createdBy = session['activeUser'];
        divisionMasterInstance.branch = session['branch'];


        if (!divisionMasterInstance.save(flush: true)) {
            render(view: "create", model: [divisionMasterInstance: divisionMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'divisionMaster.label', default: 'DivisionMaster'), divisionMasterInstance.id])
        redirect(action: "list", id: divisionMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def divisionMasterInstance = DivisionMaster.get(id)
        if (!divisionMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'divisionMaster.label', default: 'DivisionMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [divisionMasterInstance: divisionMasterInstance]
    }

    def edit(Long id) {
        def divisionMasterInstance = DivisionMaster.get(id)
        if (!divisionMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'divisionMaster.label', default: 'DivisionMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [divisionMasterInstance: divisionMasterInstance]
    }

    def update(Long id, Long version) {
        def divisionMasterInstance = DivisionMaster.get(id)
        if (!divisionMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'divisionMaster.label', default: 'DivisionMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (divisionMasterInstance.version > version) {
                divisionMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'divisionMaster.label', default: 'DivisionMaster')] as Object[],
                        "Another user has updated this DivisionMaster while you were editing")
                render(view: "edit", model: [divisionMasterInstance: divisionMasterInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        divisionMasterInstance.properties = params
        divisionMasterInstance.lastUpdatedBy = session['activeUser'];
        divisionMasterInstance.lastUpdated = new Date();

        if (!divisionMasterInstance.save(flush: true)) {
            render(view: "edit", model: [divisionMasterInstance: divisionMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'divisionMaster.label', default: 'DivisionMaster'), divisionMasterInstance.id])
        redirect(action: "list", id: divisionMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def divisionMasterInstance = DivisionMaster.get(id)

        if (!divisionMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'divisionMaster.label', default: 'DivisionMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            divisionMasterInstance.isActive = false
            divisionMasterInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'divisionMaster.label', default: 'DivisionMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'divisionMaster.label', default: 'DivisionMaster'), id])
            redirect(action: "list", id: id,params: [scrid: session['activeScreen'].id])
        }
    }
}
