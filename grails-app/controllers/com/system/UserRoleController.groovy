package com.system

import annotation.ParentScreen
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Utilities", fullName = "User Role",subUnder = "Utilities")
class UserRoleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userRoleInstanceList: UserRole.list(), userRoleInstanceTotal: UserRole.count()]
    }

    def create() {
        [userRoleInstance: new UserRole(params)]
    }

    def save() {
        def userRoleInstance = new UserRole(params)


        if (!userRoleInstance.save(flush: true)) {
            render(view: "create", model: [userRoleInstance: userRoleInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'userRole.label', default: 'UserRole'), userRoleInstance.id])
        redirect(action: "list", id: userRoleInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def userRoleInstance = UserRole.get(id)
        if (!userRoleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userRole.label', default: 'UserRole'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [userRoleInstance: userRoleInstance]
    }

    def edit(Long id) {
        def userRoleInstance = UserRole.get(id)
        if (!userRoleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userRole.label', default: 'UserRole'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [userRoleInstance: userRoleInstance]
    }

    def update(Long id, Long version) {
        def userRoleInstance = UserRole.get(id)
        if (!userRoleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userRole.label', default: 'UserRole'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (userRoleInstance.version > version) {
                userRoleInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'userRole.label', default: 'UserRole')] as Object[],
                        "Another user has updated this UserRole while you were editing")
                render(view: "edit", model: [userRoleInstance: userRoleInstance])
                return
            }
        }

        userRoleInstance.properties = params

        if (!userRoleInstance.save(flush: true)) {
            render(view: "edit", model: [userRoleInstance: userRoleInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'userRole.label', default: 'UserRole'), userRoleInstance.id])
        redirect(action: "list", id: userRoleInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def userRoleInstance = UserRole.get(id)

        if (!userRoleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userRole.label', default: 'UserRole'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            userRoleInstance.delete()
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'userRole.label', default: 'UserRole'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'userRole.label', default: 'UserRole'), id])
            redirect(action: "show", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    def getList(){
        def child = [];

        def Data = UserRole.list();

        if(Data){
            Data.each {d ->
                child.push([
                        id: d.id,
                        version: d.version,
                        user: d.user.username,
                        role: d.role.authority
                ])
            }
        }
        render child as JSON;
    }
}
