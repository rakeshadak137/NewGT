package com.master

import annotation.ParentScreen
import com.transaction.InternalMemo
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "City Master", subUnder = "Master")

class CityMasterController {
    def jasperService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [cityMasterInstanceList: CityMaster.findAllByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true), cityMasterInstanceTotal: CityMaster.countByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true)]
    }

    def create() {
        [cityMasterInstance: new CityMaster(params)]
    }

    def save() {
        def cityMasterInstance = new CityMaster(params)

        cityMasterInstance.dateCreated=new Date();
        cityMasterInstance.financialYear=session['financialYear'];
        cityMasterInstance.createdBy=session['activeUser'];
        cityMasterInstance.branch = session['branch'];

        if (!cityMasterInstance.save(flush: true)) {
            render(view: "create", model: [cityMasterInstance: cityMasterInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'cityMaster.label', default: 'CityMaster'), cityMasterInstance.id])
        redirect(action: "list", id: cityMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def cityMasterInstance = CityMaster.get(id)
        if (!cityMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cityMaster.label', default: 'CityMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [cityMasterInstance: cityMasterInstance]
    }

    def edit(Long id) {
        def cityMasterInstance = CityMaster.get(id)
        if (!cityMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cityMaster.label', default: 'CityMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [cityMasterInstance: cityMasterInstance]
    }

    def update(Long id, Long version) {
        def cityMasterInstance = CityMaster.get(id)
        if (!cityMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cityMaster.label', default: 'CityMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (cityMasterInstance.version > version) {
                cityMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'cityMaster.label', default: 'CityMaster')] as Object[],
                        "Another user has updated this CityMaster while you were editing")
                render(view: "edit", model: [cityMasterInstance: cityMasterInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        cityMasterInstance.properties = params

        cityMasterInstance.lastUpdatedBy=session['activeUser'];
        cityMasterInstance.lastUpdated=new Date();

        if (!cityMasterInstance.save(flush: true)) {
            render(view: "edit", model: [cityMasterInstance: cityMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cityMaster.label', default: 'CityMaster'), cityMasterInstance.id])
        redirect(action: "list", id: cityMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def cityMasterInstance = CityMaster.get(id)
        if (!cityMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cityMaster.label', default: 'CityMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            cityMasterInstance.isActive = false;
            cityMasterInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cityMaster.label', default: 'CityMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cityMaster.label', default: 'CityMaster'), id])
            redirect(action: "list", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    //report method for internal memo
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

           if(reportDef?.reportData[0]?.voucherNo){
               def memoData = InternalMemo.findByVoucherNo(reportDef.reportData[0].voucherNo);
               if(memoData && !(session['activeUser'].admin)){
                   memoData.print_status = memoData.print_status+1;
                   memoData.save(flush: true);
               }
           }

            try {
                sendMail {
                    multipart true
                    to 'ganeshtransport92@gmail.com','snehal.kamble1441@gmail.com'
//                    to 'rakeshadak137@gmail.com'
//                    reportDef.reportData[0].voucherNo,reportDef.reportData[0].outTime,reportDef.reportData[0].vehicleNo.vehicleNo,reportDef.reportData[0].advance,reportDef.reportData[0].balance
                    subject "Internal Memo Created "+" Voucher No:"+reportDef.reportData[0].voucherNo+" Time:"+reportDef.reportData[0].outTime+" Vehicle No:"+reportDef.reportData[0].vehicleNo+" Advance:"+reportDef.reportData[0].advance+" Balance:"+reportDef.reportData[0].balance
                    html "Voucher No:"+reportDef.reportData[0].voucherNo+"<BR>Time:"+reportDef.reportData[0].outTime+"<BR>Vehicle No:"+reportDef.reportData[0].vehicleNo+"<BR>Advance:"+reportDef.reportData[0].advance+"<BR>Balance:"+reportDef.reportData[0].balance
                    attachBytes 'report.pdf','application/pdf',reportDef.contentStream.toByteArray()
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
