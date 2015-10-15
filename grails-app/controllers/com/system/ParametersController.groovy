package com.system

import annotation.ParentScreen
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Utilities", subUnder = "Utilities", fullName = "Parameters")
class ParametersController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [parametersInstanceList: Parameters.findAllByIsActive(true), parametersInstanceTotal: Parameters.countByIsActive(true)]
    }

    def create() {
        [parametersInstance: new Parameters(params)]
    }

    def save() {
        def parametersInstance = new Parameters(params)

        parametersInstance.dateCreated = new Date();
        parametersInstance.financialYear = session['financialYear'];
        parametersInstance.createdBy = session['activeUser'];
        parametersInstance.branch = session['branch'];


        if (!parametersInstance.save(flush: true)) {
            render(view: "create", model: [parametersInstance: parametersInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'parameters.label', default: 'Parameters'), parametersInstance.id])
        redirect(action: "show", id: parametersInstance.id)
    }

    def show(Long id) {
        def parametersInstance = Parameters.get(id)
        if (!parametersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameters.label', default: 'Parameters'), id])
            redirect(action: "list")
            return
        }

        [parametersInstance: parametersInstance]
    }

    def edit(Long id) {
        def parametersInstance = Parameters.get(id)
        if (!parametersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameters.label', default: 'Parameters'), id])
            redirect(action: "list")
            return
        }

        [parametersInstance: parametersInstance]
    }

    def update(Long id, Long version) {
        def parametersInstance = Parameters.get(id)
        if (!parametersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameters.label', default: 'Parameters'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (parametersInstance.version > version) {
                parametersInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'parameters.label', default: 'Parameters')] as Object[],
                        "Another user has updated this Parameters while you were editing")
                render(view: "edit", model: [parametersInstance: parametersInstance])
                return
            }
        }

        parametersInstance.properties = params
        parametersInstance.lastUpdatedBy = session['activeUser'];
        parametersInstance.lastUpdated = new Date();

        if (!parametersInstance.save(flush: true)) {
            render(view: "edit", model: [parametersInstance: parametersInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'parameters.label', default: 'Parameters'), parametersInstance.id])
        redirect(action: "show", id: parametersInstance.id)
    }

    def delete(Long id) {
        def parametersInstance = Parameters.get(id)

        if (!parametersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'parameters.label', default: 'Parameters'), id])
            redirect(action: "list")
            return
        }

        try {
            parametersInstance.isActive = false
            parametersInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'parameters.label', default: 'Parameters'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'parameters.label', default: 'Parameters'), id])
            redirect(action: "show", id: id)
        }
    }
}
