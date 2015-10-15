package com.template

import annotation.ParentScreen
import org.springframework.dao.DataIntegrityViolationException

//import com.master.InstituteType
@ParentScreen(name = "Mail/SMS", fullName = "Create Subject", subUnder = "Mail/SMS")
class TemplateSubjectController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [templateSubjectInstanceList: TemplateSubject.list(params), templateSubjectInstanceTotal: TemplateSubject.count()]
    }

    def create() {
        [templateSubjectInstance: new TemplateSubject(params)]
    }

    def save() {
        def templateSubjectInstance = new TemplateSubject(params)
        templateSubjectInstance.lastUpdatedBy = session['activeUser'];
        templateSubjectInstance.financialYear = session['financialYear'];
        if (!templateSubjectInstance.save(flush: true)) {
            render(view: "create", model: [templateSubjectInstance: templateSubjectInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'templateSubject.label', default: 'TemplateSubject'), templateSubjectInstance.id])
        redirect(action: "show", id: templateSubjectInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def templateSubjectInstance = TemplateSubject.get(id)
        if (!templateSubjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'templateSubject.label', default: 'TemplateSubject'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [templateSubjectInstance: templateSubjectInstance]
    }

    def edit(Long id) {
        def templateSubjectInstance = TemplateSubject.get(id)
        if (!templateSubjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'templateSubject.label', default: 'TemplateSubject'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [templateSubjectInstance: templateSubjectInstance]
    }

    def update(Long id, Long version) {
        def templateSubjectInstance = TemplateSubject.get(id)
        if (!templateSubjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'templateSubject.label', default: 'TemplateSubject'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (templateSubjectInstance.version > version) {
                templateSubjectInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'templateSubject.label', default: 'TemplateSubject')] as Object[],
                        "Another user has updated this TemplateSubject while you were editing")
                render(view: "edit", model: [templateSubjectInstance: templateSubjectInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        templateSubjectInstance.properties = params

        if (!templateSubjectInstance.save(flush: true)) {
            render(view: "edit", model: [templateSubjectInstance: templateSubjectInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'templateSubject.label', default: 'TemplateSubject'), templateSubjectInstance.id])
        redirect(action: "show", id: templateSubjectInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def templateSubjectInstance = TemplateSubject.get(id)
        if (!templateSubjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'templateSubject.label', default: 'TemplateSubject'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            templateSubjectInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'templateSubject.label', default: 'TemplateSubject'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'templateSubject.label', default: 'TemplateSubject'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }
}
