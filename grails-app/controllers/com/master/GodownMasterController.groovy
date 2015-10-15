package com.master

import annotation.ParentScreen
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "Godown Master", subUnder = "Master")

class GodownMasterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [godownMasterInstanceList: GodownMaster.findAllByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true), godownMasterInstanceTotal: GodownMaster.countByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true)]
    }

    def create() {
        [godownMasterInstance: new GodownMaster(params)]
    }

    def save() {
        def godownMasterInstance = new GodownMaster(params)

        godownMasterInstance.dateCreated=new Date();
        godownMasterInstance.financialYear=session['financialYear'];
        godownMasterInstance.createdBy=session['activeUser'];
        godownMasterInstance.branch=session['branch'];

        if (!godownMasterInstance.save(flush: true)) {
            render(view: "create", model: [godownMasterInstance: godownMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'godownMaster.label', default: 'GodownMaster'), godownMasterInstance.id])
        redirect(action: "list", id: godownMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def godownMasterInstance = GodownMaster.get(id)
        if (!godownMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'godownMaster.label', default: 'GodownMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [godownMasterInstance: godownMasterInstance]
    }

    def edit(Long id) {
        def godownMasterInstance = GodownMaster.get(id)
        if (!godownMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'godownMaster.label', default: 'GodownMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [godownMasterInstance: godownMasterInstance]
    }

    def update(Long id, Long version) {
        def godownMasterInstance = GodownMaster.get(id)
        if (!godownMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'godownMaster.label', default: 'GodownMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (godownMasterInstance.version > version) {
                godownMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'godownMaster.label', default: 'GodownMaster')] as Object[],
                        "Another user has updated this GodownMaster while you were editing")
                render(view: "edit", model: [godownMasterInstance: godownMasterInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        godownMasterInstance.properties = params
        godownMasterInstance.lastUpdatedBy=session['activeUser'];
        godownMasterInstance.lastUpdated=new Date();

        if (!godownMasterInstance.save(flush: true)) {
            render(view: "edit", model: [godownMasterInstance: godownMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'godownMaster.label', default: 'GodownMaster'), godownMasterInstance.id])
        redirect(action: "list", id: godownMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def godownMasterInstance = GodownMaster.get(id)
        if (!godownMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'godownMaster.label', default: 'GodownMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            godownMasterInstance.isActive = false;
            godownMasterInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'godownMaster.label', default: 'GodownMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'godownMaster.label', default: 'GodownMaster'), id])
            redirect(action: "list", id: id,params: [scrid: session['activeScreen'].id])
        }
    }
}
