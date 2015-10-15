package com.master

import annotation.ParentScreen
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "Branch Master", subUnder = "Master")

class BranchMasterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [branchMasterInstanceList: BranchMaster.findAllByIsActive(true), branchMasterInstanceTotal: BranchMaster.countByIsActive(true)]
    }

    def create() {
        [branchMasterInstance: new BranchMaster(params)]
    }

    def save() {
        def branchMasterInstance = new BranchMaster(params)

        if (!branchMasterInstance.save(flush: true)) {
            render(view: "create", model: [branchMasterInstance: branchMasterInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'branchMaster.label', default: 'BranchMaster'), branchMasterInstance.id])
        redirect(action: "list", id: branchMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def branchMasterInstance = BranchMaster.get(id)
        if (!branchMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'branchMaster.label', default: 'BranchMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [branchMasterInstance: branchMasterInstance]
    }

    def edit(Long id) {
        def branchMasterInstance = BranchMaster.get(id)
        if (!branchMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'branchMaster.label', default: 'BranchMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [branchMasterInstance: branchMasterInstance]
    }

    def update(Long id, Long version) {
        def branchMasterInstance = BranchMaster.get(id)
        if (!branchMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'branchMaster.label', default: 'BranchMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (branchMasterInstance.version > version) {
                branchMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'branchMaster.label', default: 'BranchMaster')] as Object[],
                        "Another user has updated this BranchMaster while you were editing")
                render(view: "edit", model: [branchMasterInstance: branchMasterInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        branchMasterInstance.properties = params

        if (!branchMasterInstance.save(flush: true)) {
            render(view: "edit", model: [branchMasterInstance: branchMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'branchMaster.label', default: 'BranchMaster'), branchMasterInstance.id])
        redirect(action: "list", id: branchMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def branchMasterInstance = BranchMaster.get(id)

        if (!branchMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'branchMaster.label', default: 'BranchMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            branchMasterInstance.isActive = false;
            branchMasterInstance.save();

            flash.message = message(code: 'default.deleted.message', args: [message(code: 'branchMaster.label', default: 'BranchMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'branchMaster.label', default: 'BranchMaster'), id])
            redirect(action: "list", id: id,params: [scrid: session['activeScreen'].id])
        }
    }
}
