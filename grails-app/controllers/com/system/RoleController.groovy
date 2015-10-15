package com.system

import annotation.ParentScreen
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Utilities", fullName = "Role Rights",subUnder = "Utilities")
class RoleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [roleInstanceList: Role.list(), roleInstanceTotal: Role.count()]
    }

    def create() {
        [roleInstance: new Role(params)]
    }

    def save() {
        def roleInstance = new Role(params)

//        roleInstance.dateCreated = new Date();
//        roleInstance.financialYear = session['financialYear'];
//        roleInstance.createdBy = session['activeUser'];
//        roleInstance.branch = session['branch'];
        def screenChild = JSON.parse(params.screenJSON);
        screenChild.each { s ->
            if(s.bool){
                s.module.each{s1->
                    if(s1.bool){
                        s1.module.each{s2->
                            if(s2.bool){
                                roleInstance.addToRoleRight(module: Screen.findById(s.moduleid),subModule:Screen.findById(s1.moduleid),screen:Screen.findById(s2.moduleid),
                                        canAdd:s2.module[0].bool,canUpdate: s2.module[1].bool,canDelete: s2.module[2].bool,canView: s2.module[3].bool,canPrint: s2.module[4].bool );
                            }
                        }
                    }
                }
            }
        }


        if (!roleInstance.save(flush: true)) {
            render(view: "create", model: [roleInstance: roleInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'role.label', default: 'Role'), roleInstance.id])
        redirect(action: "show", id: roleInstance.id, params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def roleInstance = Role.get(id)
        if (!roleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        [roleInstance: roleInstance]
    }

    def edit(Long id) {
        def roleInstance = Role.get(id)
        if (!roleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        [roleInstance: roleInstance]
    }

    def update(Long id, Long version) {
        def roleInstance = Role.get(id)
        if (!roleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (roleInstance.version > version) {
                roleInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'role.label', default: 'Role')] as Object[],
                        "Another user has updated this Role while you were editing")
                render(view: "edit", model: [roleInstance: roleInstance])
                return
            }
        }

        roleInstance.properties = params
//        roleInstance.lastUpdatedBy = session['activeUser'];
//        roleInstance.lastUpdated = new Date();
        Role.executeUpdate("delete RoleRights as r where r.rights.id=:id",[id:roleInstance.id]);
        roleInstance.save();
        def screenChild = JSON.parse(params.screenJSON);
        screenChild.each { s ->
            if(s.bool){
                s.module.each{s1->
                    if(s1.bool){
                        s1.module.each{s2->
                            if(s2.bool){
                                roleInstance.addToRoleRight(module: Screen.findById(s.moduleid),subModule:Screen.findById(s1.moduleid),screen:Screen.findById(s2.moduleid),
                                        canAdd:s2.module[0].bool,canUpdate: s2.module[1].bool,canDelete: s2.module[2].bool,canView: s2.module[3].bool,canPrint: s2.module[4].bool );
                            }
                        }
                    }
                }
            }
        }
        if (!roleInstance.save(flush: true)) {
            render(view: "edit", model: [roleInstance: roleInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'role.label', default: 'Role'), roleInstance.id])
        redirect(action: "create", id: roleInstance.id, params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def roleInstance = Role.get(id)

        if (!roleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            roleInstance.delete();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'role.label', default: 'Role'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'role.label', default: 'Role'), id])
            redirect(action: "create", id: id, params: [scrid: session['activeScreen'].id])
        }
    }


    def getFrames(){
        def can=[];
        def result=[];
        def modules=[];
        def rights=[];
        boolean  boolObject = false;
        int parentCounter=-1;
        int moduleCounter=-1;
        int screenCounter=-1;
            def data= Screen.findAllByControllerAndNameIsNotNull(null);
            if(data){
                data.each {d->
                    def roleModule = RoleRights.findByModuleAndRights(Screen.findById(d.id),Role.findById(params.id))
                    parentCounter++;
                    moduleCounter=-1;
                    modules=[];
                    def data1 = Screen.findAllByParentScreen(Screen.findById(d.id));
                    if(data1){
                        data1.each {d1->
                            def roleSubModule =  RoleRights.findBySubModuleAndRights(Screen.findById(d1.id),Role.findById(params.id))
                            moduleCounter++;
                            screenCounter=-1;
                            can=[];
                            def datascr  = Screen.findAllByParentScreen(Screen.findById(d1.id));
                            if(datascr){
                                datascr.each {ds->
                                    def roleScreen =  RoleRights.findByScreenAndRights(Screen.findById(ds.id),Role.findById(params.id));
                                    def dd= ds.id;
                                    screenCounter++;
                                    rights=[];
                                    rights.push([
                                            name:"Add",
                                            bool: roleScreen?.canAdd?:false,
                                            moduleid:'',
                                            parentid:dd,
                                            level:4,
                                            collapsed:true,
                                            parentIndex:parentCounter,
                                            moduleIndex:moduleCounter,
                                            screenIndex:screenCounter
                                    ]);
                                    rights.push([
                                            name:"Update",
                                            bool: roleScreen?.canUpdate?:false,
                                            moduleid: '',
                                            parentid:dd,
                                            level:4,
                                            collapsed:true,
                                            parentIndex:parentCounter,
                                            moduleIndex:moduleCounter,
                                            screenIndex:screenCounter
                                    ]); rights.push([
                                            name:"Delete",
                                            bool: roleScreen?.canDelete?:false,
                                            moduleid:'',
                                            parentid:dd,
                                            level:4,
                                            collapsed:true,
                                            parentIndex:parentCounter,
                                            moduleIndex:moduleCounter,
                                            screenIndex:screenCounter
                                    ]); rights.push([
                                            name:"View",
                                            bool: roleScreen?.canView?:false,
                                            moduleid:"",
                                            parentid:dd,
                                            level:4,
                                            collapsed:true,
                                            parentIndex:parentCounter,
                                            moduleIndex:moduleCounter,
                                            screenIndex:screenCounter
                                    ]); rights.push([
                                            name:"Print",
                                            bool: roleScreen?.canPrint?:false,
                                            moduleid:'',
                                            parentid:dd,
                                            level:4,
                                            collapsed:true,
                                            parentIndex:parentCounter,
                                            moduleIndex:moduleCounter,
                                            screenIndex:screenCounter
                                    ]);
                                    can.push([
                                            bool:roleScreen?true:false,
                                            name: ds.domainName,
                                            moduleid: ds.id,
                                            parentid:d1.id,
                                            module:rights,
                                            collapsed:true,
                                            level:3,
                                            parentIndex:parentCounter,
                                            moduleIndex:moduleCounter,
                                            screenIndex:''
                                    ])
                                }
                            }
                            modules.push([
                                    bool:roleSubModule?true:false,
                                    moduleid:d1.id,
                                    name:d1.filter,
                                    parentid:d.id,
                                    module:can,
                                    collapsed:true,
                                    level:2,
                                    parentIndex:parentCounter,
                                    moduleIndex:'',
                                    screenIndex:''
                            ])
                        }
                        result.push([
                                moduleid:d.id,
                                name:d.name,
                                parentid:'',
                                bool:roleModule?true:false,
                                module:modules,
                                collapsed:true,
                                level:1,
                                parentIndex:'',
                                moduleIndex:'',
                                screenIndex:''
                        ])
                    }
                }
            }
        if(result){
            print result;
            render result as JSON;
        }else{
            render '[]'
        }

    }
}
