package com.master

import annotation.ParentScreen
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "Account Master", subUnder = "Master")

class AccountMasterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [accountMasterInstanceList: AccountMaster.findAllByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true), accountMasterInstanceTotal: AccountMaster.countByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true)]
    }

    def create() {
        [accountMasterInstance: new AccountMaster(params)]
    }

    def save() {
        def accountMasterInstance = new AccountMaster(params)

        accountMasterInstance.dateCreated = new Date();
        accountMasterInstance.financialYear=session['financialYear'];
        accountMasterInstance.createdBy=session['activeUser'];
        accountMasterInstance.branch=session['branch'];

        if (!accountMasterInstance.save(flush: true)) {
            render(view: "create", model: [accountMasterInstance: accountMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'accountMaster.label', default: 'AccountMaster'), accountMasterInstance.id])
        redirect(action: "list", id: accountMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def accountMasterInstance = AccountMaster.get(id)
        if (!accountMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'accountMaster.label', default: 'AccountMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [accountMasterInstance: accountMasterInstance]
    }

    def edit(Long id) {
        def accountMasterInstance = AccountMaster.get(id)
        if (!accountMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'accountMaster.label', default: 'AccountMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [accountMasterInstance: accountMasterInstance]
    }

    def update(Long id, Long version) {
        def accountMasterInstance = AccountMaster.get(id)
        if (!accountMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'accountMaster.label', default: 'AccountMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (accountMasterInstance.version > version) {
                accountMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'accountMaster.label', default: 'AccountMaster')] as Object[],
                        "Another user has updated this AccountMaster while you were editing")
                render(view: "edit", model: [accountMasterInstance: accountMasterInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        accountMasterInstance.properties = params

        accountMasterInstance.lastUpdatedBy=session['activeUser'];
        accountMasterInstance.lastUpdated=new Date();

        if (!accountMasterInstance.save(flush: true)) {
            render(view: "edit", model: [accountMasterInstance: accountMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'accountMaster.label', default: 'AccountMaster'), accountMasterInstance.id])
        redirect(action: "list", id: accountMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def accountMasterInstance = AccountMaster.get(id)
        if (!accountMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'accountMaster.label', default: 'AccountMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            accountMasterInstance.isActive = false
            accountMasterInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'accountMaster.label', default: 'AccountMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'accountMaster.label', default: 'AccountMaster'), id])
            redirect(action: "list", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    def getList(){
        def child = [];

        def Data = AccountMaster.findAllByIsActive(true);

        if(Data){
            Data.each {d ->
                child.push([
                        id: d.id,
                        version: d.version,
                        accountName: d.accountName,
                        address: d.address,
                        city: d.city.cityName,
                        mobile: d.contactMobile
                ])
            }
        }
        render child as JSON;
    }
}
