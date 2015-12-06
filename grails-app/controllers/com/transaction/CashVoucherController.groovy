package com.transaction

import NumbersToWords.NumToWords
import annotation.ParentScreen
import com.master.BankMaster
import com.master.VehicleMaster
import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

import java.text.DecimalFormat

@ParentScreen(name = "Transaction", subUnder = "Transaction", fullName = "Cash Voucher")
class CashVoucherController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    DecimalFormat df = new DecimalFormat("#.##");

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [cashVoucherInstanceList: CashVoucher.findAllByIsActive(true), cashVoucherInstanceTotal: CashVoucher.countByIsActive(true)]
    }

    def create() {
        [cashVoucherInstance: new CashVoucher(params)]
    }

    def save() {
        def cashVoucherInstance = new CashVoucher(params)

        cashVoucherInstance.dateCreated = new Date();
        cashVoucherInstance.financialYear = session['financialYear'];
        cashVoucherInstance.createdBy = session['activeUser'];
        cashVoucherInstance.branch = session['branch'];
        cashVoucherInstance.lastUpdatedBy = session['activeUser'];
        def lastVoucherNo = CashVoucher?.last()?.voucherNo?:0;
        cashVoucherInstance.voucherNo = lastVoucherNo+1;

        if(params.childJson){

            def data=JSON.parse(params.childJson);
            if(data){
                data.each {d->
                    if(d.bool){
                        cashVoucherInstance.addToCashVoucherChilds(CashVoucherChild.saveChildData(d));
                        def memoNo = InternalMemo.findById(d?.id);
                        memoNo.isCleared = true;
                        memoNo.save();
                    }
                }
            }
        }

        if (!cashVoucherInstance.save(flush: true)) {
            render(view: "create", model: [cashVoucherInstance: cashVoucherInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), cashVoucherInstance.id])
        redirect(action: "show", id: cashVoucherInstance.id,params: [scrid: session['activeScreen'].id])
    }

    def show(Long id) {
        def cashVoucherInstance = CashVoucher.get(id)
        if (!cashVoucherInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        [cashVoucherInstance: cashVoucherInstance]
    }

    def edit(Long id) {
        def cashVoucherInstance = CashVoucher.get(id)
        if (!cashVoucherInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        [cashVoucherInstance: cashVoucherInstance]
    }

    def update(Long id, Long version) {
        def cashVoucherInstance = CashVoucher.get(id)
        if (!cashVoucherInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        def cashData = CashVoucherChild.findAllByCashVoucher(cashVoucherInstance as CashVoucher);
        if(cashData){
            cashData.each {cd->
                def data=[];
                data = InternalMemo.findById(cd?.memoNo?.id);
                if(data){
                    data.isCleared=false;
                    data.save();
                }
            }
        }
        CashVoucher.executeUpdate("delete CashVoucherChild as b where b.cashVoucher.id=:id", [id: cashVoucherInstance.id]);
        cashVoucherInstance.save(flush: true);


        if (version != null) {
            if (cashVoucherInstance.version > version) {
                cashVoucherInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'cashVoucher.label', default: 'CashVoucher')] as Object[],
                        "Another user has updated this CashVoucher while you were editing")
                render(view: "edit", model: [cashVoucherInstance: cashVoucherInstance])
                return
            }
        }

        cashVoucherInstance.properties = params
        cashVoucherInstance.lastUpdatedBy = session['activeUser'];
        cashVoucherInstance.lastUpdated = new Date();

        if(params.childJson){
            def data=JSON.parse(params.childJson);
            if(data){
                data.each {d->
                    if(d?.bool) {
                        cashVoucherInstance.addToCashVoucherChilds(CashVoucherChild.saveChildData(d));
                        def memoNo = InternalMemo.findById(d?.id);
                        memoNo.isCleared = true;
                        memoNo.save();
                    }
                }
            }
        }

        if (!cashVoucherInstance.save(flush: true)) {
            render(view: "edit", model: [cashVoucherInstance: cashVoucherInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), cashVoucherInstance.id])
        redirect(action: "show", id: cashVoucherInstance.id, params: [scrid: session['activeScreen'].id])
    }

    def delete(Long id) {
        def cashVoucherInstance = CashVoucher.get(id)

        if (!cashVoucherInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
            return
        }

        try {
            cashVoucherInstance.isActive = false
            cashVoucherInstance.save();
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), id])
            redirect(action: "list", params: [scrid: session['activeScreen'].id])
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cashVoucher.label', default: 'CashVoucher'), id])
            redirect(action: "show", id: id, params: [scrid: session['activeScreen'].id])
        }
    }
    def findMemos(){
        def result=[];
        if(params.id){
            def data=InternalMemo.findAllByVehicleNoAndIsClearedAndDateCreatedGreaterThan(VehicleMaster.findById(params.id),false,Date.parse("yyyy-MM-dd","2014-11-01"));
            if(data){
                data.each {d->
                    result.push([
                           id:d?.id,
                           memoNo:d?.voucherNo?:"",
                           memoDate:d?.voucherDate?.format("dd-MM-yyyy")?:"",
                           amount:d?.totalTripRate?:0,
                           ltr:d?.dieselLtr?:0,
                           dieselAmt:d?.dieselAmount?:0,
                           advance:d?.advance?:0,
                           balance:d?.balance?:0,
                           bool:false
                    ])
                }
            }
            if(result){
                render result as JSON
            }
            else render '[]'
        }
    }

    def editData(){
        def child = [];
        def data=[];
        if(params.vid){
            data=InternalMemo.findAllByVehicleNo(VehicleMaster.findById(params.vid as Long));
            if(data){
                data.each {d->
                    def cashData = CashVoucherChild.findByMemoNoAndCashVoucher(InternalMemo.findById(d.id as Long),CashVoucher.findById(params.id as Long));

                    if(cashData){
                        child.push(
                                [
                                        id       : cashData?.memoNo?.id,
                                        memoNo   : cashData?.memoNo?.voucherNo ?: "",
                                        memoDate : cashData?.memoNo?.voucherDate?.format("dd-MM-yyyy") ?: "",
                                        amount   : cashData?.memoNo?.totalTripRate ?: 0,
                                        ltr      : cashData?.dieselLtr ?: 0,
                                        dieselAmt: cashData?.dieselAmount ?: 0,
                                        advance  : 0,
                                        balance  : cashData?.balance ?: 0,
                                        bool     : true
                                ]
                        )
                    }
                    else{
                        child.push(
                                [
                                        id:d?.id,
                                        memoNo:d?.voucherNo?:"",
                                        memoDate:d?.voucherDate?.format("dd-MM-yyyy")?:"",
                                        amount:d?.totalTripRate?:0,
                                        ltr:d?.dieselLtr?:0,
                                        dieselAmt:d?.dieselAmount?:0,
                                        advance:d?.advance?:0,
                                        balance:d?.balance?:0,
                                        bool:false
                                ]
                        )
                    }
                }
            }
        }
        render child as JSON;
    }

    def print_action(){
        def reportDetails=[];
        def child=[];
        def memoNo="";
        def mDate="";
        def vNo="";
        def amt="";
        def sNo="";
        def parent;
        NumToWords nm = new NumToWords();
           if(params?.id){
               def data = CashVoucher.findById(params?.id as Long);
               if(data){
                   def childData = CashVoucherChild.findAllByCashVoucher(data as CashVoucher);
                   if(childData){
                       childData.each {c->
                           child.push([
                                   memoNo:c?.memoNo?.voucherNo?:"",
                                   date:c?.memoDate?.format("dd-MM-yyyy"),
                                   vehicleNo:c?.memoNo?.vehicleNo?.state+"-"+c?.memoNo?.vehicleNo?.rto+" "+c?.memoNo?.vehicleNo?.series+" "+c?.memoNo?.vehicleNo?.vehicleNo,
                                   amount:c?.balance?:0
                           ])
                       }
                   }
                   if(data.voucherType=="Diesel Voucher"){
                       memoNo="Memo No";
                       mDate="Date";
                       vNo="Vehicle No";
                       amt="Amount";
                   }
                   if(!child){
                       child.push([
                               memoNo:"",
                               date:"",
                               vehicleNo:"",
                               amount:""
                       ])
                   }
                   parent=[
                           voucherType:data?.voucherType?:"",
                           voucherNo: data?.voucherNo?:"",
                           date:data?.voucherDate?.format("dd-MM-yyyy"),
                           payTo:data?.payTo?:"",
                           total:data?.netAmount?df.format(data?.netAmount):0,
                           totalWords:data?.netAmount?nm.convert(data?.netAmount?.intValue()):0,
                           description:data?.description?:"",
                           paymentType:data?.paymentType?:"",
                           pumpName:data?.pumpName?.pumpName?:"",
                           dieselLtr:data?.dieselLtr?:"",
                           dieselAmt:data?.dieselAmount?:"",
                           slipNo:data?.dieselReceiptNo?:"",
                           slipDate:data?.dieselReceiptDate?.format("dd-MM-yyyy"),
                           bankName:data?.bankName?.bankName?:"",
                           chequeNo:data?.chequeNo?:"",
                           child:child,
                           mNo:memoNo,
                           mDate:mDate,
                           vNo:vNo,
                           amt:amt,
                           sNo:sNo,
                           vehicleNumber:data?.vehicleNumber?:""
                   ]
                   if(parent){
                       reportDetails.push(parent);
                   }
               }
           }
        params._format = "PDF";
        params._file = "../reports/transactionReport/CashVoucher"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'driverMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    // JSON of List Page
    def getList(){
        def child = [];

        def Data = CashVoucher.findAllByIsActive(true);
        if(Data){
            Data.each {d ->
                child.push([
                        id: d.id,
                        version: d.version,
                        voucherNo: d?.voucherNo?:"",
                        voucherDate: d?.voucherDate?.format("dd-MM-yyyy")?:"",
                        voucherType: d?.voucherType?:"",
                        amount: d?.netAmount?:"",
                        bankName: d?.bankName?.bankName?:"",
                        chequeNo: d?.chequeNo?:"",
                        payTo: d?.payTo?:"",
                        vehicleNo: (d?.vehicleNo?.state?:"")+"-"+(d?.vehicleNo?.rto?:"")+" "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:""),
                        description:d?.description?:""
                ])
            }
        }
        if(child){
            render child as JSON
        }
        else{
            render '[]'
        }
        render child as JSON;
    }

    def checkDuplicateChequeNo(){
        if(params?.chequeNo && params?.bankId){
            def result = CashVoucher.findByBankNameAndChequeNo(BankMaster.findById(params?.bankId as long),params?.chequeNo)
            if(result){
                render result?.voucherNo
            }
            else{
                render ''
            }
        }
        else{
            render ''
        }
    }
}

