package com.template

import org.springframework.dao.DataIntegrityViolationException

class ChildTemplateController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [childTemplateInstanceList: ChildTemplate.list(params), childTemplateInstanceTotal: ChildTemplate.count()]
    }

    def create() {
        [childTemplateInstance: new ChildTemplate(params)]
    }

    def save() {
        def childTemplateInstance = new ChildTemplate(params)
        if (!childTemplateInstance.save(flush: true)) {
            render(view: "create", model: [childTemplateInstance: childTemplateInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'childTemplate.label', default: 'ChildTemplate'), childTemplateInstance.id])
        redirect(action: "show", id: childTemplateInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def childTemplateInstance = ChildTemplate.get(id)
        if (!childTemplateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'childTemplate.label', default: 'ChildTemplate'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [childTemplateInstance: childTemplateInstance]
    }

    def edit(Long id) {
        def childTemplateInstance = ChildTemplate.get(id)
        if (!childTemplateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'childTemplate.label', default: 'ChildTemplate'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [childTemplateInstance: childTemplateInstance]
    }

    def update(Long id, Long version) {
        def childTemplateInstance = ChildTemplate.get(id)
        if (!childTemplateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'childTemplate.label', default: 'ChildTemplate'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (childTemplateInstance.version > version) {
                childTemplateInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'childTemplate.label', default: 'ChildTemplate')] as Object[],
                        "Another user has updated this ChildTemplate while you were editing")
                render(view: "edit", model: [childTemplateInstance: childTemplateInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        childTemplateInstance.properties = params

        if (!childTemplateInstance.save(flush: true)) {
            render(view: "edit", model: [childTemplateInstance: childTemplateInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'childTemplate.label', default: 'ChildTemplate'), childTemplateInstance.id])
        redirect(action: "show", id: childTemplateInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def childTemplateInstance = ChildTemplate.get(id)
        if (!childTemplateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'childTemplate.label', default: 'ChildTemplate'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            childTemplateInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'childTemplate.label', default: 'ChildTemplate'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'childTemplate.label', default: 'ChildTemplate'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }
    def getDetailsInfo(){

    }
}
