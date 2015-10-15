package com.master

import annotation.ParentScreen
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "Pump Master", subUnder = "Master")
class PumpMasterController {
    def jasperService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [pumpMasterInstanceList: PumpMaster.findAllByIsActive(true), pumpMasterInstanceTotal: PumpMaster.countByIsActive(true)]
    }

    def create() {
        [pumpMasterInstance: new PumpMaster(params)]
    }

    def save() {
        def pumpMasterInstance = new PumpMaster(params)

        pumpMasterInstance.dateCreated = new Date();
        pumpMasterInstance.financialYear = session['financialYear'];
        pumpMasterInstance.createdBy = session['activeUser'];
        pumpMasterInstance.branch = session['branch'];


        if (!pumpMasterInstance.save(flush: true)) {
            render(view: "create", model: [pumpMasterInstance: pumpMasterInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'pumpMaster.label', default: 'PumpMaster'), pumpMasterInstance.id])
        redirect(action: "show", id: pumpMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def pumpMasterInstance = PumpMaster.get(id)
        if (!pumpMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'pumpMaster.label', default: 'PumpMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [pumpMasterInstance: pumpMasterInstance]
    }

    def edit(Long id) {
        def pumpMasterInstance = PumpMaster.get(id)
        if (!pumpMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'pumpMaster.label', default: 'PumpMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [pumpMasterInstance: pumpMasterInstance]
    }

    def update(Long id, Long version) {
        def pumpMasterInstance = PumpMaster.get(id)
        if (!pumpMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'pumpMaster.label', default: 'PumpMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (pumpMasterInstance.version > version) {
                pumpMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'pumpMaster.label', default: 'PumpMaster')] as Object[],
                        "Another user has updated this PumpMaster while you were editing")
                render(view: "edit", model: [pumpMasterInstance: pumpMasterInstance])
                return
            }
        }

        pumpMasterInstance.properties = params
        pumpMasterInstance.lastUpdatedBy = session['activeUser'];
        pumpMasterInstance.lastUpdated = new Date();

        if (!pumpMasterInstance.save(flush: true)) {
            render(view: "edit", model: [pumpMasterInstance: pumpMasterInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'pumpMaster.label', default: 'PumpMaster'), pumpMasterInstance.id])
        redirect(action: "show", id: pumpMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def pumpMasterInstance = PumpMaster.get(id)

        if (!pumpMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'pumpMaster.label', default: 'PumpMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            pumpMasterInstance.isActive = false
            pumpMasterInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'pumpMaster.label', default: 'PumpMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'pumpMaster.label', default: 'PumpMaster'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    //report method for pump master
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


            try {
                sendMail {
                    multipart true
                    to 'ganeshtransport92@gmail.com'
//                    to 'rakeshadak137@gmail.com'
                    subject "Bill From Ganesh Transport Created"
                    html "LR"
                    attachBytes 'bill.pdf','application/pdf',reportDef.contentStream.toByteArray()
                }
            }
            catch (Exception e){
                e.printStackTrace();
            }
        } else {
            render(text: reportDef.contentStream, contentType: reportDef.fileFormat.mimeTyp, encoding: reportDef.parameters.encoding ? reportDef.parameters.encoding : 'UTF-8');
        }
    }

    def getList(){
        def child = [];
        def Data = PumpMaster.findAllByIsActive(true);
        if(Data){
            Data.each {d ->
                child.push([
                        id: d.id,
                        version: d.version,
                        pumpName: d?.pumpName?:"",
                        dieselRate: d?.dieselRate?:0
                ])
            }
        }
        render child as JSON;
    }
}
