package com.master

import annotation.ParentScreen
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "Vehicle Master", subUnder = "Master")

class VehicleMasterController {
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [vehicleMasterInstanceList: VehicleMaster.findAllByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true), vehicleMasterInstanceTotal: VehicleMaster.countByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true)]
    }

    def create() {
        [vehicleMasterInstance: new VehicleMaster(params)]
    }

    def save() {
        def vehicleMasterInstance = new VehicleMaster(params)

        vehicleMasterInstance.dateCreated=new Date();
        vehicleMasterInstance.financialYear=session['financialYear'];
        vehicleMasterInstance.createdBy=session['activeUser'];
        vehicleMasterInstance.branch=session['branch'];

        if (!vehicleMasterInstance.save(flush: true)) {
            render(view: "create", model: [vehicleMasterInstance: vehicleMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'vehicleMaster.label', default: 'VehicleMaster'), vehicleMasterInstance.id])
        redirect(action: "list", id: vehicleMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def vehicleMasterInstance = VehicleMaster.get(id)
        if (!vehicleMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'vehicleMaster.label', default: 'VehicleMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [vehicleMasterInstance: vehicleMasterInstance]
    }

    def edit(Long id) {
        def vehicleMasterInstance = VehicleMaster.get(id)
        if (!vehicleMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'vehicleMaster.label', default: 'VehicleMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [vehicleMasterInstance: vehicleMasterInstance]
    }

    def update(Long id, Long version) {
        def vehicleMasterInstance = VehicleMaster.get(id)
        if (!vehicleMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'vehicleMaster.label', default: 'VehicleMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (vehicleMasterInstance.version > version) {
                vehicleMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'vehicleMaster.label', default: 'VehicleMaster')] as Object[],
                        "Another user has updated this VehicleMaster while you were editing")
                render(view: "edit", model: [vehicleMasterInstance: vehicleMasterInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        vehicleMasterInstance.properties = params
        vehicleMasterInstance.lastUpdatedBy=session['activeUser'];
        vehicleMasterInstance.lastUpdated=new Date();

        if (!vehicleMasterInstance.save(flush: true)) {
            render(view: "edit", model: [vehicleMasterInstance: vehicleMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'vehicleMaster.label', default: 'VehicleMaster'), vehicleMasterInstance.id])
        redirect(action: "list", id: vehicleMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def vehicleMasterInstance = VehicleMaster.get(id)
        if (!vehicleMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'vehicleMaster.label', default: 'VehicleMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            vehicleMasterInstance.isActive = false;
            vehicleMasterInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'vehicleMaster.label', default: 'VehicleMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'vehicleMaster.label', default: 'VehicleMaster'), id])
            redirect(action: "list", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    def searchDuplicateVehicleNo(){
        def data = VehicleMaster.findByStateAndRtoAndSeriesAndVehicleNo(params.state,params.rto,params.series,params.no);
        if(data){
            render data as JSON
        }
        else render ""
    }

    def showList(){
        def result=[];
        def data=VehicleMaster.findAllByIsActive(true);
        if(data){
            data.each {d->
                result.push([
                     id:d.id,
                     vehicleNo:(d?.state?:"")+" "+(d?.rto?:"")+" "+(d?.series?:"")+" "+(d?.vehicleNo),
                     vehicleType:d?.vehicleType?:"",
                     companyName:d?.companyName?:"",
                     ownerName:d?.ownerName?:"",
                     mobileNo:d?.mobileNo?:""
                ])

            }

        }
        if(result){
            render result as JSON
        }
        else{
            render '[]'
        }
    }
}

