package com.master

import annotation.ParentScreen
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", subUnder = "Master", fullName = "Parameter Master")

class ParameterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [parameterInstanceList: Parameter.findAllByIsActive(true), parameterInstanceTotal: Parameter.countByIsActive(true)]
    }

    def create() {
        [parameterInstance: new Parameter(params)]
    }

    def save() {
        def parameterInstance = new Parameter(params)

        parameterInstance.dateCreated = new Date();
        parameterInstance.financialYear = session['financialYear'];
        parameterInstance.createdBy = session['activeUser'];
        parameterInstance.branch = session['branch'];


        if (!parameterInstance.save(flush: true)) {
            render(view: "create", model: [parameterInstance: parameterInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'parameter.label', default: 'Parameter'), parameterInstance.id])
        redirect(action: "show", id: parameterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def parameterInstance = Parameter.get(id)
        if (!parameterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameter.label', default: 'Parameter'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [parameterInstance: parameterInstance]
    }

    def edit(Long id) {
        def parameterInstance = Parameter.get(id)
        if (!parameterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameter.label', default: 'Parameter'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [parameterInstance: parameterInstance]
    }

    def update(Long id, Long version) {
        def parameterInstance = Parameter.get(id)
        if (!parameterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameter.label', default: 'Parameter'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (parameterInstance.version > version) {
                parameterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'parameter.label', default: 'Parameter')] as Object[],
                        "Another user has updated this Parameter while you were editing")
                render(view: "edit", model: [parameterInstance: parameterInstance])
                return
            }
        }

        parameterInstance.properties = params
        parameterInstance.lastUpdatedBy = session['activeUser'];
        parameterInstance.lastUpdated = new Date();

        if (!parameterInstance.save(flush: true)) {
            render(view: "edit", model: [parameterInstance: parameterInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'parameter.label', default: 'Parameter'), parameterInstance.id])
        redirect(action: "show", id: parameterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def parameterInstance = Parameter.get(id)

        if (!parameterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameter.label', default: 'Parameter'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            parameterInstance.isActive = false
            parameterInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'parameter.label', default: 'Parameter'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'parameter.label', default: 'Parameter'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }
}
