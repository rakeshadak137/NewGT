package com.master

import annotation.ParentScreen
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", subUnder = "Master", fullName = "Trip Rate")

class TripRateController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [tripRateInstanceList: TripRate.findAllByIsActive(true), tripRateInstanceTotal: TripRate.countByIsActive(true)]
    }

    def create() {
        [tripRateInstance: new TripRate(params)]
    }

    def save() {
        def tripRateInstance = new TripRate(params)

        tripRateInstance.dateCreated = new Date();
        tripRateInstance.financialYear = session['financialYear'];
        tripRateInstance.createdBy = session['activeUser'];
        tripRateInstance.branch = session['branch'];


        if (!tripRateInstance.save(flush: true)) {
            render(view: "create", model: [tripRateInstance: tripRateInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'tripRate.label', default: 'TripRate'), tripRateInstance.id])
        redirect(action: "show", id: tripRateInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def tripRateInstance = TripRate.get(id)
        if (!tripRateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tripRate.label', default: 'TripRate'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [tripRateInstance: tripRateInstance]
    }

    def edit(Long id) {
        def tripRateInstance = TripRate.get(id)
        if (!tripRateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tripRate.label', default: 'TripRate'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [tripRateInstance: tripRateInstance]
    }

    def update(Long id, Long version) {
        def tripRateInstance = TripRate.get(id)
        if (!tripRateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tripRate.label', default: 'TripRate'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (tripRateInstance.version > version) {
                tripRateInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'tripRate.label', default: 'TripRate')] as Object[],
                        "Another user has updated this TripRate while you were editing")
                render(view: "edit", model: [tripRateInstance: tripRateInstance])
                return
            }
        }

        tripRateInstance.properties = params
        tripRateInstance.lastUpdatedBy = session['activeUser'];
        tripRateInstance.lastUpdated = new Date();

        if (!tripRateInstance.save(flush: true)) {
            render(view: "edit", model: [tripRateInstance: tripRateInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'tripRate.label', default: 'TripRate'), tripRateInstance.id])
        redirect(action: "show", id: tripRateInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def tripRateInstance = TripRate.get(id)

        if (!tripRateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tripRate.label', default: 'TripRate'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            tripRateInstance.isActive = false
            tripRateInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'tripRate.label', default: 'TripRate'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tripRate.label', default: 'TripRate'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }
}
