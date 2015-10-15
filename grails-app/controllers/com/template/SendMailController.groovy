package com.template

import annotation.ParentScreen
import com.master.AccountMaster
import com.master.BranchMaster

//import com.adminssion.Admission
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

//import com.master.ClassDivision
//import com.master.Department
//import com.master.InstituteType
//import com.master.YearAndClass
import sendMailService.SendMailService

@ParentScreen(name = "Mail/SMS", fullName = "Occasional Mail/SMS", subUnder = "Mail/SMS")
class SendMailController {
    SendMailService sendMailService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [sendMailInstanceList: SendMail.list(params), sendMailInstanceTotal: SendMail.count()]
    }

    def create() {
        [sendMailInstance: new SendMail(params)]
    }

    def save() {
        def sendMailInstance = new SendMail(params)

        def coSms;
        def coMail;
        def path = "";
        sendMailInstance.lastUpdatedBy = session['activeUser']
//        sendMailInstance.type = InstituteType.findById(session['activeUser'].instituteType.id);
        String extraDesc = params.extraDescription;
//        def deptId=Department.findById(params.dId as Long);
//        def classId=YearAndClass.findById(params.cId);
        def childs = JSON.parse(params.parentData);
        def tempChild = JSON.parse(params.mailData);

        // attachment code
        def fileName = params.attachment.fileItem.fileName
        sendMailInstance.attachment = fileName
        def f = request.getFile('attachment')
        if (!f.empty) {
            flash.message = 'Your attachment has been uploaded'
            new File(grailsApplication.config.images.location.toString()).mkdirs()
            f.transferTo(new File(grailsApplication.config.images.location.toString() + File.separatorChar + f.getOriginalFilename()))
            path = grailsApplication.config.images.location.toString() + File.separatorChar + f.getOriginalFilename()
        }

//check if send mail and send sms checkboxes are selected

        if (params.mailCheck) {
            coMail = sendMailService.mailService(childs, tempChild, extraDesc, path);           //call send sms service
        }

        if (params.smsCheck) {
            coSms = sendMailService.smsService(childs, tempChild, extraDesc);             //Call send mail Service
        }

        if (coMail) {
            coMail.each { t ->
                sendMailInstance.mailTo = t.to
                sendMailInstance.mailBody = extraDesc
                sendMailInstance.mailSubject = t.emailSubject
                flash.message = "Email Sent To Selected Parent"
                sendMailInstance.department = AccountMaster.findById(params.dId as Long);
//                sendMailInstance.classOnly = YearAndClass.findById(params.cId as Long);
                sendMailInstance.attachment = path ?: "No Attachment"
                //grailsApplication.config.grails.mail.username
            }
        } else {
//                    log.error "Problem Sending Email ${e.message}",e
            flash.message = "Confirmation Email not Sent"
        }
        if (coSms) {
            coSms.each { cs ->
                sendMailInstance.mobileNo = cs.mob
                flash.message = "SMS Sent To Selected Parent"
            }
        } else {
//                    log.error "Problem Sending SMS ${e.message}",e
            flash.message = "Confirmation SMS not Sent"
        }


        if (!sendMailInstance.save(flush: true)) {
            render(view: "create", model: [sendMailInstance: sendMailInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'sendMail.label', default: 'SendMail'), sendMailInstance.id])
        redirect(action: "show", id: sendMailInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def sendMailInstance = SendMail.get(id)
        if (!sendMailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sendMail.label', default: 'SendMail'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [sendMailInstance: sendMailInstance]
    }

    def edit(Long id) {
        def sendMailInstance = SendMail.get(id)
        if (!sendMailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sendMail.label', default: 'SendMail'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [sendMailInstance: sendMailInstance]
    }

    def update(Long id, Long version) {
        def sendMailInstance = SendMail.get(id)
        if (!sendMailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sendMail.label', default: 'SendMail'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (sendMailInstance.version > version) {
                sendMailInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'sendMail.label', default: 'SendMail')] as Object[],
                        "Another user has updated this SendMail while you were editing")
                render(view: "edit", model: [sendMailInstance: sendMailInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        sendMailInstance.properties = params

        if (!sendMailInstance.save(flush: true)) {
            render(view: "edit", model: [sendMailInstance: sendMailInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'sendMail.label', default: 'SendMail'), sendMailInstance.id])
        redirect(action: "show", id: sendMailInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def sendMailInstance = SendMail.get(id)
        if (!sendMailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sendMail.label', default: 'SendMail'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            sendMailInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'sendMail.label', default: 'SendMail'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'sendMail.label', default: 'SendMail'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    def studDetails() {
        def bid = BranchMaster.findById(session['branch'].id);
//        def fYear = session['financialYear'];
        if (params) {
//            String cId = params.id;
//            long classId = Long.parseLong(cId);
//            String dId = params.dept;
//            long deptId = Long.parseLong(dId);
            def resultobj = "";
            def result;
            result = AccountMaster.findById(params?.id);
//          result=ClassDivision.findAllByDepartmentAndOrganizationAndBranchAndInstituteAndInstituteType(Department.findById(deptId),
//                    Organization.findById(orgId), Branch.findById(brId), Institute.findById(intiId), InstituteType.findById(typeId))

            if (result) {
                resultobj = [id: result.id,
                        details: result.collect { sub ->
                            [
                                    bool: false,
                                    name: sub?.accountName,
                                    parentName: sub?.address,
                                    mobileNo: sub?.mobileNo,
                                    email: sub?.email
                            ]
                        }];
            }
            if (resultobj) {
                render resultobj as JSON;
            } else {
                render '[]'
            }
        } else {
            render '[]'
        }
    }

    def getDept() {
        def result = [];
        def bid = BranchMaster.findById(session['branch'].id);
        def data = AccountMaster.findAllByBranchAndIsActive(bid,true);
        if (data) {
            data.each { d ->
                result.push([
                        id: d.id,
                        name: d.accountName
                ])
            }
        }
        if (result) {
            render result as JSON
        } else {
            render '[]'
        }

    }

//    def deptList() {
//        if (params.id) {
//            String dId = params.id;
//            long deptId = Long.parseLong(dId);
//            def resultobj = "";
//            def result;
//            def data = [];
//
////            result= ClassDivision.findAllByDepartment(Department.findById(deptId)).collect({
////                [
////                  className:it.classes,
////                  classId:it.sem.id
////                ]
////            });
//            result = ClassDivision.where {
//                eq("department", Department.findById(dId as Long))
//            }.projections {
//                distinct("sem")
//            };
//            if (result) {
//                result.each { d ->
//                    data.push([
//                            id: d.id,
//                            yrClass: d.yearAndClass
//                    ])
//                }
//            }
//            if (data) {
//                render data as JSON
//            } else {
//                render "[]"
//            }
//        } else {
//            render "[]"
//        }
//    }

    def getSubject() {
        def result = [];
//        def iid = session['activeUser'].instituteType.id;
        def data = TemplateSubject.list();
        if (data) {
            data.each { d ->
                result.push([
                        id: d.id,
                        name: d.name
                ])

            }
        }
        if (result) {
            render result as JSON
        } else {
            render '[]'
        }
    }

    def sendSms() {
        try {
            // Construct data
            String data = "";

            data += "username=" + URLEncoder.encode("rakeshadakyogisoft", "ISO-8859-1");
            data += "&password=" + URLEncoder.encode("8605014080", "ISO-8859-1");
            data += "&message=" + URLEncoder.encode("This is a SMS Test", "ISO-8859-1");
            data += "&want_report=1";
            data += "&msisdn=+918087090777";

            // Send data
            URL url = new URL("http://bulksms.vsms.net:5567/eapi/submission/send_sms/2/2.0");


            URLConnection conn = url.openConnection();
            conn.setDoOutput(true);
            OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
            wr.write(data);
            wr.flush();

            // Get the response
            BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = rd.readLine()) != null) {
                // Print the response output...
                System.out.println(line);
            }
            wr.close();
            rd.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    def getList(){
        def child = [];

        def Data = SendMail.list();

        if(Data){
            Data.each {d ->
                child.push([
                        id: d.id,
                        version: d.version,
                        sendTo: d.mailTo,
                        mobile: d.mobileNo,
                        description: d.mailSubject,
                        date: d.dateCreated
                ])
            }
        }
        render child as JSON;
    }
}
