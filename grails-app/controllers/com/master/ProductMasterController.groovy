package com.master

import annotation.ParentScreen
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

@ParentScreen(name = "Master", fullName = "Product Master", subUnder = "Master")

class ProductMasterController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [productMasterInstanceList: ProductMaster.findAllByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true), productMasterInstanceTotal: ProductMaster.countByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true)]
    }

    def create() {
        [productMasterInstance: new ProductMaster(params)]
    }

    def save() {
        def productMasterInstance = new ProductMaster(params)

        productMasterInstance.dateCreated=new Date();
        productMasterInstance.financialYear=session['financialYear'];
        productMasterInstance.createdBy=session['activeUser'];
        productMasterInstance.branch = session['branch'];
        productMasterInstance.weight = params.weight as BigDecimal;

        productMasterInstance.rate = params.rate as BigDecimal;

        productMasterInstance.thickNess = params.thickness as BigDecimal;
        productMasterInstance.length = params.length as BigDecimal;
        productMasterInstance.od = params.od as BigDecimal;

        if (!productMasterInstance.save(flush: true)) {
            render(view: "create", model: [productMasterInstance: productMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        print(productMasterInstance.weight);
        flash.message = message(code: 'default.created.message', args: [message(code: 'productMaster.label', default: 'ProductMaster'), productMasterInstance.id])
        redirect(action: "list", id: productMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def productMasterInstance = ProductMaster.get(id)
        if (!productMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productMaster.label', default: 'ProductMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [productMasterInstance: productMasterInstance]
    }

    def edit(Long id) {
        def productMasterInstance = ProductMaster.get(id)
        if (!productMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productMaster.label', default: 'ProductMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        [productMasterInstance: productMasterInstance]
    }

    def update(Long id, Long version) {
        def productMasterInstance = ProductMaster.get(id)
        if (!productMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productMaster.label', default: 'ProductMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        if (version != null) {
            if (productMasterInstance.version > version) {
                productMasterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'productMaster.label', default: 'ProductMaster')] as Object[],
                        "Another user has updated this ProductMaster while you were editing")
                render(view: "edit", model: [productMasterInstance: productMasterInstance],params: [scrid: session['activeScreen'].id])
                return
            }
        }

        productMasterInstance.properties = params
        productMasterInstance.lastUpdatedBy = session['activeUser'];
        productMasterInstance.lastUpdated = new Date();

        productMasterInstance.rate = params.rate as BigDecimal;
        productMasterInstance.weight = params.weight as BigDecimal;
        productMasterInstance.thickNess = params.thickness as BigDecimal;
        productMasterInstance.length = params.length as BigDecimal;
        productMasterInstance.od = params.od as BigDecimal;

        if (!productMasterInstance.save(flush: true)) {
            render(view: "edit", model: [productMasterInstance: productMasterInstance],params: [scrid: session['activeScreen'].id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'productMaster.label', default: 'ProductMaster'), productMasterInstance.id])
        redirect(action: "list", id: productMasterInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def productMasterInstance = ProductMaster.get(id)
        if (!productMasterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productMaster.label', default: 'ProductMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            productMasterInstance.isActive = false;
            productMasterInstance.save();

            flash.message = message(code: 'default.deleted.message', args: [message(code: 'productMaster.label', default: 'ProductMaster'), id])
            redirect(action: "list",params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'productMaster.label', default: 'ProductMaster'), id])
            redirect(action: "list", id: id,params: [scrid: session['activeScreen'].id])
        }
    }

    def getData(){
        def Data = [];
        def child = [];

        if(params.id){
            Data = ProductMaster.findById(params.id as Long);

            if(Data){
                child.push([
                        rate: Data.rate,
                        od: Data.od,
                        thickness: Data.thickNess,
                        weight: Data.weight,
                        length: Data.length
                ]);
            }
        }
        render child as JSON;
    }

    def getList(){
        def child = [];

        def Data = ProductMaster.findAllByIsActive(true);

        if(Data){
            Data.each {d ->
                child.push([
                        id: d.id,
                        version: d.version,
                        code: d.productCode,
                        name: d.productName,
                        customer: d?.customerName?.accountName?:"",
                        category: d?.category?.categoryName?:"",
                        division: d?.division?.divisionName?:""
                ])
            }
        }
        render child as JSON;
    }
}
