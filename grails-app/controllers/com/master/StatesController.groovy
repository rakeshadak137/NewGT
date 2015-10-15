package com.master

import annotation.ParentScreen
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "State Master", subUnder = "Master")

class StatesController {
    def jasperService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [statesInstanceList: States.findAllByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true), statesInstanceTotal: States.countByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true)]
    }

    def create() {
        [statesInstance: new States(params)]
    }

    def save() {
        def statesInstance = new States(params)

        statesInstance.dateCreated=new Date();
        statesInstance.financialYear=session['financialYear'];
        statesInstance.createdBy=session['activeUser'];
        statesInstance.branch = session['branch'];

        if (!statesInstance.save(flush: true)) {
            render(view: "create", model: [statesInstance: statesInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'states.label', default: 'States'), statesInstance.id])
        redirect(action: "list", id: statesInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def statesInstance = States.get(id)
        if (!statesInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'states.label', default: 'States'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [statesInstance: statesInstance]
    }

    def edit(Long id) {
        def statesInstance = States.get(id)
        if (!statesInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'states.label', default: 'States'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [statesInstance: statesInstance]
    }

    def update(Long id, Long version) {
        def statesInstance = States.get(id)
        if (!statesInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'states.label', default: 'States'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (statesInstance.version > version) {
                statesInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'states.label', default: 'States')] as Object[],
                        "Another user has updated this States while you were editing")
                render(view: "edit", model: [statesInstance: statesInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        statesInstance.properties = params
        statesInstance.lastUpdatedBy=session['activeUser'];
        statesInstance.lastUpdated=new Date();

        if (!statesInstance.save(flush: true)) {
            render(view: "edit", model: [statesInstance: statesInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'states.label', default: 'States'), statesInstance.id])
        redirect(action: "list", id: statesInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def statesInstance = States.get(id)
        if (!statesInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'states.label', default: 'States'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            statesInstance.isActive = false;
            statesInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'states.label', default: 'States'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'states.label', default: 'States'), id])
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


//            try {
//                sendMail {
//                    multipart true
//                    to 'ganeshtransport92@gmail.com'
////                    to 'rakeshadak137@gmail.com'
//                    subject "Out Entry From Ganesh Transport Created"
//                    html "LR"
//                    attachBytes 'OutEntry.pdf','application/pdf',reportDef.contentStream.toByteArray()
//                }
//            }
//            catch (Exception e){
//                e.printStackTrace();
//            }
        } else {
            render(text: reportDef.contentStream, contentType: reportDef.fileFormat.mimeTyp, encoding: reportDef.parameters.encoding ? reportDef.parameters.encoding : 'UTF-8');
        }
    }
}
