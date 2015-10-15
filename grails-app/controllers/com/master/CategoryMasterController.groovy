package com.master

import annotation.ParentScreen
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "Category Master", subUnder = "Master")

class CategoryMasterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [categoryMasterInstanceList: CategoryMaster.findAllByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true), categoryMasterInstanceTotal: CategoryMaster.findAllByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true)]
    }

    def create() {
        [categoryMasterInstance: new CategoryMaster(params)]
    }

    def save() {

        def categoryMasterInstance = new CategoryMaster(params)

        categoryMasterInstance.dateCreated=new Date();
        categoryMasterInstance.financialYear=session['financialYear'];
        categoryMasterInstance.createdBy=session['activeUser'];
        categoryMasterInstance.branch=session['branch'];

        if (!categoryMasterInstance.save(flush: true)) {
            render(view: "create", model: [categoryMasterInstance: categoryMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'categoryMaster.label', default: 'CategoryMaster'), categoryMasterInstance.id])
        redirect(action: "list", id: categoryMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def categoryMasterInstance = CategoryMaster.get(id)
        if (!categoryMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'categoryMaster.label', default: 'CategoryMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [categoryMasterInstance: categoryMasterInstance]
    }

    def edit(Long id) {
        def categoryMasterInstance = CategoryMaster.get(id)
        if (!categoryMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'categoryMaster.label', default: 'CategoryMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [categoryMasterInstance: categoryMasterInstance]
    }

    def update(Long id, Long version) {
        def categoryMasterInstance = CategoryMaster.get(id)
        if (!categoryMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'categoryMaster.label', default: 'CategoryMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (categoryMasterInstance.version > version) {
                categoryMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'categoryMaster.label', default: 'CategoryMaster')] as Object[],
                          "Another user has updated this CategoryMaster while you were editing")
                render(view: "edit", model: [categoryMasterInstance: categoryMasterInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        categoryMasterInstance.properties = params

        categoryMasterInstance.lastUpdatedBy=session['activeUser'];
        categoryMasterInstance.lastUpdated=new Date();

        if (!categoryMasterInstance.save(flush: true)) {
            render(view: "edit", model: [categoryMasterInstance: categoryMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'categoryMaster.label', default: 'CategoryMaster'), categoryMasterInstance.id])
        redirect(action: "list", id: categoryMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def categoryMasterInstance = CategoryMaster.get(id)
        if (!categoryMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'categoryMaster.label', default: 'CategoryMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            categoryMasterInstance.isActive = false;
            categoryMasterInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'categoryMaster.label', default: 'CategoryMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'categoryMaster.label', default: 'CategoryMaster'), id])
            redirect(action: "list", id: id,params: [scrid: session['activeScreen'].id])
        }
    }
}
