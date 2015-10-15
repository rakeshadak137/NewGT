package com.master

import annotation.ParentScreen
import com.transaction.CashVoucher
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "Driver Master", subUnder = "Master")

class DriverMasterController {

    def jasperService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [driverMasterInstanceList: DriverMaster.findAllByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true), driverMasterInstanceTotal: DriverMaster.countByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true)]
    }

    def create() {
        [driverMasterInstance: new DriverMaster(params)]
    }

    def save() {
        def driverMasterInstance = new DriverMaster(params)

        driverMasterInstance.dateCreated=new Date();
        driverMasterInstance.financialYear=session['financialYear'];
        driverMasterInstance.createdBy=session['activeUser'];
        driverMasterInstance.branch = session['branch'];

        if (!driverMasterInstance.save(flush: true)) {
            render(view: "create", model: [driverMasterInstance: driverMasterInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'driverMaster.label', default: 'DriverMaster'), driverMasterInstance.id])
        redirect(action: "list", id: driverMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def driverMasterInstance = DriverMaster.get(id)
        if (!driverMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'driverMaster.label', default: 'DriverMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [driverMasterInstance: driverMasterInstance]
    }

    def edit(Long id) {
        def driverMasterInstance = DriverMaster.get(id)
        if (!driverMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'driverMaster.label', default: 'DriverMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [driverMasterInstance: driverMasterInstance]
    }

    def update(Long id, Long version) {
        def driverMasterInstance = DriverMaster.get(id)
        if (!driverMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'driverMaster.label', default: 'DriverMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (driverMasterInstance.version > version) {
                driverMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'driverMaster.label', default: 'DriverMaster')] as Object[],
                        "Another user has updated this DriverMaster while you were editing")
                render(view: "edit", model: [driverMasterInstance: driverMasterInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        driverMasterInstance.properties = params

        driverMasterInstance.lastUpdatedBy=session['activeUser'];
        driverMasterInstance.lastUpdated=new Date();

        if (!driverMasterInstance.save(flush: true)) {
            render(view: "edit", model: [driverMasterInstance: driverMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'driverMaster.label', default: 'DriverMaster'), driverMasterInstance.id])
        redirect(action: "list", id: driverMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def driverMasterInstance = DriverMaster.get(id)
        if (!driverMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'driverMaster.label', default: 'DriverMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            driverMasterInstance.isActive = false;
            driverMasterInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'driverMaster.label', default: 'DriverMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'driverMaster.label', default: 'DriverMaster'), id])
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
            def cashInstance;
            def toMailId = "";
            if(params?.id){
                cashInstance=CashVoucher.findById(params?.id);
            }

            try {
                sendMail {
                    multipart true
                    to 'ganeshtransport92@gmail.com'
//                    to 'rakeshadak137@gmail.com'
                    subject "Cash Voucher Created"
                    if(cashInstance) {
                        html "Voucher No: " + (cashInstance?.voucherNo ?: "") + "<BR> Voucher Type: " + (cashInstance?.voucherType?:"") + "<BR> Pay To: " + (cashInstance?.payTo?:"")+ "<BR> Net Amount: " + (cashInstance?.netAmount?:"") + "<BR> Description: " + (cashInstance?.description?:"") + "<BR> Vehicle No: " + ((cashInstance?.vehicleNo?.state ?: "") + "-" + (cashInstance?.vehicleNo?.rto ?: "") + " " + (cashInstance?.vehicleNo?.series ?: "") + " " + (cashInstance?.vehicleNo?.vehicleNo ?: ""))+ "<BR> Pump Name: " + (cashInstance?.pumpName?.pumpName?:"")+ "<BR> Slip No: " + (cashInstance?.dieselReceiptNo?:"")+ "<BR> Diesel Ltr: " + (cashInstance?.dieselLtr?:"")
                    }
                    attachBytes 'voucher.pdf','application/pdf',reportDef.contentStream.toByteArray()
                }
            }
            catch (Exception e){
                e.printStackTrace();
            }

        } else {
            render(text: reportDef.contentStream, contentType: reportDef.fileFormat.mimeTyp, encoding: reportDef.parameters.encoding ? reportDef.parameters.encoding : 'UTF-8');
        }
    }
}
