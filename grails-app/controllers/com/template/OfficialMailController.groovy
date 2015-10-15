package com.template

import annotation.ParentScreen
import com.master.AccountMaster
import grails.converters.JSON

//import com.employee.Appointment
//import com.employee.StaffDepartment
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Mail/SMS", fullName = "Official Mail/SMS ", subUnder = "Mail/SMS")
class OfficialMailController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [officialMailInstanceList: OfficialMail.list(params), officialMailInstanceTotal: OfficialMail.count()]
    }

    def create() {
        [officialMailInstance: new OfficialMail(params)]
    }

    def save() {

        def path = ""
        def officialMailInstance = new OfficialMail()
        bindData(officialMailInstance, params, [exclude: ['publishDate', 'publishEndDate']])
        String datepo = params.publishDate;
        String dateref = params.publishEndDate;

        //parse date into mysql database date format
        if (datepo) {
            officialMailInstance.publishDate = Date.parse("yyyy-MM-dd", datepo);
        }

        if (dateref) {
            officialMailInstance.publishEndDate = Date.parse("yyyy-MM-dd", dateref);
        }
        def fileName = params?.attachment?.fileItem?.fileName ?: ""
        officialMailInstance.attachment = fileName
        def f = request.getFile('attachment')
        if (!f.empty) {
            flash.message = 'Your attachment has been uploaded'
            new File(grailsApplication.config.officialMail.location.toString()).mkdirs()
            f.transferTo(new File(grailsApplication.config.officialMail.location.toString() + File.separatorChar + f.getOriginalFilename()))
            path = grailsApplication.config.officialMail.location.toString() + File.separatorChar + f.getOriginalFilename()
        }

        def data = AccountMaster.list();
        int count = 0;
        def recipient = "";
        if (data) {
            data.each { c ->
                if (c?.email) {
                    try {
                        sendMail {
                            multipart true
                            to c.email
                            subject params?.subject ? params?.subject : ""
                            body params?.description ? params?.description : ""
                            if (path) {
                                attachBytes path, 'image/jpg', new File(path).readBytes()
                            }
                            // println("mail succesfully send")
                        }
                        println("mail succesfully send")
                        officialMailInstance.attachment = path ?: "No Attachment"
                        //flash.message = 'Mail succesfully send'
                    } catch (Exception e) {
                        print(e)
                        flash.message = 'During sending mail error is occured'
                    }
                }
            }
        }

        if (!officialMailInstance.save(flush: true)) {
            render(view: "create", model: [officialMailInstance: officialMailInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'officialMail.label', default: 'OfficialMail'), officialMailInstance.id])
        redirect(action: "show", id: officialMailInstance.id, params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def officialMailInstance = OfficialMail.get(id)
        if (!officialMailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'officialMail.label', default: 'OfficialMail'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        [officialMailInstance: officialMailInstance]
    }

    def edit(Long id) {
        def officialMailInstance = OfficialMail.get(id)
        if (!officialMailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'officialMail.label', default: 'OfficialMail'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        [officialMailInstance: officialMailInstance]
        redirect(action: "list", params: params)
    }

    def update(Long id, Long version) {
        def officialMailInstance = OfficialMail.get(id)
        if (!officialMailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'officialMail.label', default: 'OfficialMail'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (officialMailInstance.version > version) {
                officialMailInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'officialMail.label', default: 'OfficialMail')] as Object[],
                        "Another user has updated this OfficialMail while you were editing")
                render(view: "edit", model: [officialMailInstance: officialMailInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        officialMailInstance.properties = params

        if (!officialMailInstance.save(flush: true)) {
            render(view: "edit", model: [officialMailInstance: officialMailInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'officialMail.label', default: 'OfficialMail'), officialMailInstance.id])
        redirect(action: "show", id: officialMailInstance.id, params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def officialMailInstance = OfficialMail.get(id)
        if (!officialMailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'officialMail.label', default: 'OfficialMail'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            officialMailInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'officialMail.label', default: 'OfficialMail'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'officialMail.label', default: 'OfficialMail'), id])
            redirect(action: "show", id: id, params: [scrid: session['activeScreen'].id])
        }
    }

    def getList(){
        def child = [];

        def Data = OfficialMail.list();

        if(Data){
            Data.each {d ->
                child.push([
                        id: d.id,
                        version: d.version,
                        assignBy: d.assignBy.username,
                        publishDate: d.publishDate,
                        publishEndDate: d.publishEndDate,
                        assignTo: d.assignTo.accountName,
                        subject: d.subject
                ])
            }
        }
        render child as JSON;
    }
}
