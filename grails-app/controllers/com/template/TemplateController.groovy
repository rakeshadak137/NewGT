package com.template

import annotation.ParentScreen
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

//import com.master.InstituteType
@ParentScreen(name = "Mail/SMS", fullName = "Create Template", subUnder = "Mail/SMS")
class TemplateController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
//        redirect(action: "list", params: params)
        redirect(action: "create",params: [scrid: session['activeScreen'].id])
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [templateInstanceList: Template.list(params), templateInstanceTotal: Template.count()]
    }

    def create(Integer max) {
//        [templateInstance: new Template(params)]
        params.max = Math.min(max ?: 10, 100)
        [templateInstance: new Template(params), templateInstanceList: Template.list(params), templateInstanceTotal: Template.count()]
    }

    def save() {
        def templateInstance = new Template(params)
        def childs = JSON.parse(params.childJSON);

        templateInstance.dateCreated = new Date();
        templateInstance.financialYear=session['financialYear'];
//        templateInstance.createdBy=session['activeUser'];
//        templateInstance.branch=session['branch'];
//        templateInstance.type = InstituteType.findById(session['activeUser'].instituteType.id);
        childs.each({ c ->
            templateInstance.addToChilds(ChildTemplate.buildFromJSON(c));
        });
        if (!templateInstance.save(flush: true)) {
            render(view: "create", model: [templateInstance: templateInstance],params: [scrid: session['activeScreen'].id])
//            redirect(action: "create")
            create();
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'template.label', default: 'Template'), templateInstance.id])
        redirect(action: "create",params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def templateInstance = Template.get(id)
        if (!templateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'template.label', default: 'Template'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [templateInstance: templateInstance]
    }

    def edit(Long id) {
        def templateInstance = Template.get(id)
        if (!templateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'template.label', default: 'Template'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [templateInstance: templateInstance]
    }

    def update(Long id, Long version) {
        def templateInstance = Template.get(id)
        if (!templateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'template.label', default: 'Template'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (templateInstance.version > version) {
                templateInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'template.label', default: 'Template')] as Object[],
                        "Another user has updated this Template while you were editing")
                render(view: "edit", model: [templateInstance: templateInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        templateInstance.properties = params

        Template.executeUpdate("delete  ChildTemplate as b where b.parent.id=:id", [id: templateInstance.id]);
        templateInstance.save(flush: true);

        def childs = JSON.parse(params.childJSON);
        childs.each { c ->
            templateInstance.addToChilds(ChildTemplate.buildFromJSON(c));
        };

        if (!templateInstance.save(flush: true)) {
            render(view: "edit", model: [templateInstance: templateInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'template.label', default: 'Template'), templateInstance.id])
        redirect(action: "create",params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def templateInstance = Template.get(id)
        if (!templateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'template.label', default: 'Template'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            templateInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'template.label', default: 'Template'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'template.label', default: 'Template'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    def saveOrUpdate() {
        def existdata;
        if (params.subject.id) {
            existdata = Template.findBySubject(TemplateSubject.findById(params.subject.id as Long))
            if (existdata) {
                update(existdata.id, existdata.version);
            } else {
                save();
            }

        } else {
            redirect(action: 'create',params: [scrid: session['activeScreen'].id])
        }
    }

    def childFind() {
        if (params.id) {
//            String tempId = params.id;
//            long tId = Long.parseLong(tempId);
            def resultobj = "";
            def result;
            result = Template.findBySubject(TemplateSubject.findById(params.id))
            if (result) {
                resultobj = [id: result.id,
                        details: result.childs.collect { sub ->
                            [
                                    bool: false,
                                    templateName: sub.name,
                                    description: sub.description
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

    def getTemplate() {
        def result = [];
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
}
