package com.master

import annotation.ParentScreen
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "Unit Master", subUnder = "Master")
class UnitMasterController {

    def jasperService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [unitMasterInstanceList: UnitMaster.findAllByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true), unitMasterInstanceTotal: UnitMaster.countByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true)]
    }

    def create() {
        [unitMasterInstance: new UnitMaster(params)]
    }

    def save() {
        def unitMasterInstance = new UnitMaster(params)

        unitMasterInstance.dateCreated=new Date();
        unitMasterInstance.financialYear=session['financialYear'];
        unitMasterInstance.createdBy = session['activeUser'];
        unitMasterInstance.branch=session['branch'];

        if (!unitMasterInstance.save(flush: true)) {
            render(view: "create", model: [unitMasterInstance: unitMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'unitMaster.label', default: 'UnitMaster'), unitMasterInstance.id])
        redirect(action: "list", id: unitMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def unitMasterInstance = UnitMaster.get(id)
        if (!unitMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'unitMaster.label', default: 'UnitMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [unitMasterInstance: unitMasterInstance]
    }

    def edit(Long id) {
        def unitMasterInstance = UnitMaster.get(id)
        if (!unitMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'unitMaster.label', default: 'UnitMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [unitMasterInstance: unitMasterInstance]
    }

    def update(Long id, Long version) {
        def unitMasterInstance = UnitMaster.get(id)
        if (!unitMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'unitMaster.label', default: 'UnitMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (unitMasterInstance.version > version) {
                unitMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'unitMaster.label', default: 'UnitMaster')] as Object[],
                          "Another user has updated this UnitMaster while you were editing")
                render(view: "edit", model: [unitMasterInstance: unitMasterInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        unitMasterInstance.properties = params
        unitMasterInstance.lastUpdatedBy=session['activeUser'];
        unitMasterInstance.lastUpdated=new Date();

        if (!unitMasterInstance.save(flush: true)) {
            render(view: "edit", model: [unitMasterInstance: unitMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'unitMaster.label', default: 'UnitMaster'), unitMasterInstance.id])
        redirect(action: "list", id: unitMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def unitMasterInstance = UnitMaster.get(id)

        if (!unitMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'unitMaster.label', default: 'UnitMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            unitMasterInstance.isActive = false
            unitMasterInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'unitMaster.label', default: 'UnitMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'unitMaster.label', default: 'UnitMaster'), id])
            redirect(action: "list", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    def generateReport = {
        def reportModel = this.getProperties().containsKey('chainModel') ? chainModel : null
        def report = jasperService.buildReportDefinition(params, request.getLocale(), reportModel)
        generateResponse(report)
    }

    def generateResponse = { reportDef ->
        if (!reportDef.fileFormat.inline && !reportDef.parameters._inline) {
            //response.setHeader("Content-disposition", "attachment; filename=\"${reportDef.parameters._name ?: reportDef.name}.${reportDef.fileFormat.extension}\"");
            response.contentType = reportDef.fileFormat.mimeTyp
            response.characterEncoding = "UTF-8"
            response.outputStream << reportDef.contentStream.toByteArray()

        } else {
            render(text: reportDef.contentStream, contentType: reportDef.fileFormat.mimeTyp, encoding: reportDef.parameters.encoding ? reportDef.parameters.encoding : 'UTF-8');
        }
    }
}
