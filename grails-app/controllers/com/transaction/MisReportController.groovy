package com.transaction

import annotation.ParentScreen
import com.master.AccountMaster
import com.master.VehicleMaster

@ParentScreen(name = "Report", subUnder = "Report", fullName = "MIS Report")

class MisReportController {
    def jasperService

    def index() {
        render(view: "print");
    }

    def print_action(){
        def reportDetails = [];
        def child = [];
        def parent = [];
        def finalData;
        def grandTotalLrAmount = 0;
        def grandTotalFreightAmount = 0;
        def grandTotalDieselAmount = 0;
        def grandTotalCashAdvance = 0;
        def grandTotalDieselPaid = 0;
        def grandTotalCashPaid = 0;
        def grandTotalBalanceAmount = 0;

        def data = InternalMemo.createCriteria().list {
            eq("branch",session['branch'])
            eq("isActive",true)

            if(params.fromDate && params.toDate){
                between("voucherDate",Date.parse("yyyy-MM-dd",params.fromDate),Date.parse("yyyy-MM-dd",params.toDate))
            }else if(params.fromDate){
                ge("voucherDate",Date.parse("yyyy-MM-dd",params.fromDate))
            }else if(params.toDate){
                le("voucherDate",Date.parse("yyyy-MM-dd",params.toDate))
            }
        }

        if(data){
            data.each {d ->
                child = [];
                Boolean memoFlag = true;
                def childData = d?.internalMemoDetails;
                def balance = d?.totalBalance?:0;
                def paidDiesel = 0;
                def paidDieselRate = 0;
                def paidDieselAmount = 0;
                def totalLrAmount = 0;
                def paidCash = 0;
                String paidDate = "";
                String received = "";
                def finalVoucherData = [];
                def lrData = [];

                def voucherData = CashVoucherChild.createCriteria().list {
                    eq("memoNo",d as InternalMemo)

                    projections {
                        property("cashVoucher")
                    }
                }.unique();

                if(voucherData){
                    finalVoucherData = voucherData?.first()?:[];
                }

                if(finalVoucherData) {
                    if (finalVoucherData?.paymentType == "Diesel") {
                        balance = (d?.totalBalance ?: 0) - (finalVoucherData?.dieselAmount ?: 0)
                        paidDiesel = finalVoucherData?.dieselLtr ?: 0;
                        paidDieselRate = finalVoucherData?.dieselRate ?: 0;
                        paidDieselAmount = finalVoucherData?.dieselAmount ?: 0;
                    }

                    if (finalVoucherData?.paymentType == "Cash") {
                        balance = (d?.totalBalance ?: 0) - (finalVoucherData?.netAmount ?: 0)
                        paidCash = finalVoucherData?.netAmount ?: 0;
                    }

                    paidDate = finalVoucherData?.voucherDate?.format("dd-MM-yyyy");

                    if(balance == 0){
                        received = "RECEIVED";
                    }
                }

                if(childData){
                    def lrUniqueData = LREntryDetails.createCriteria().list {
                        inList("id",d?.internalMemoDetails?.lrChild?.id)

                        projections {
                            property("lrEntry")
                        }
                    }.unique();

                    if(lrUniqueData){
                        totalLrAmount = lrUniqueData.inject(0){result, it -> result + it?.grandTotal?:0}
                    }

                    if(lrUniqueData){
                        memoFlag = true;

                        grandTotalLrAmount = grandTotalLrAmount + totalLrAmount;
                        grandTotalFreightAmount = grandTotalFreightAmount + d?.freight ?: 0;
                        grandTotalBalanceAmount = grandTotalBalanceAmount + balance;
                        grandTotalDieselAmount = grandTotalDieselAmount + d?.dieselAmount?:0;
                        grandTotalCashAdvance = grandTotalCashAdvance + d?.advance?:0;
                        grandTotalDieselPaid = grandTotalDieselPaid + paidDieselAmount;
                        grandTotalCashPaid = grandTotalCashPaid  + paidCash;

                        lrUniqueData.each {l ->
                            if (memoFlag) {
                                child.push([
                                        memoDate        : d?.voucherDate?.format("dd-MM-yyyy") ?: "",
                                        fromParty       : l?.fromCustomer?.accountName ?: "",
                                        toParty         : l?.toCustomer?.accountName ?: "",
                                        vehicleNo : (d?.vehicleNo?.state?:"")+" - "+(d?.vehicleNo?.rto?:"")+
                                                " "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:""),
                                        memoNo          : d?.voucherNo ?: "",
                                        lrNo            : l?.lrNo ?: "",
                                        lrAmount        : l?.grandTotal ?: 0,
                                        vehFright       : d?.freight ?: 0,
                                        diesel          : d?.dieselLtr ?: 0,
                                        dieselRate      : d?.dieselRate ?: 0,
                                        dieselAmount    : d?.dieselAmount ?: 0,
                                        cashAdvance     : d?.advance ?: 0,
                                        balance         : balance,
                                        paidDiesel      : paidDiesel,
                                        paidDieselRate  : paidDieselRate,
                                        paidDieselAmount: paidDieselAmount,
                                        paidCash        : paidCash,
                                        paidDate        : paidDate,
                                        received        : received,
                                        totalLrAmount   : totalLrAmount
                                ]);
                            } else {
                                child.push([
                                        memoDate        : "",
                                        fromParty       : l?.fromCustomer?.accountName ?: "",
                                        toParty         : l?.toCustomer?.accountName ?: "",
                                        vehicleNo : (d?.vehicleNo?.state?:"")+" - "+(d?.vehicleNo?.rto?:"")+
                                                " "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:""),
                                        memoNo          : "",
                                        lrNo            : l?.lrNo ?: "",
                                        lrAmount        : l?.grandTotal ?: 0,
                                        vehFright       : "",
                                        diesel          : "",
                                        dieselRate      : "",
                                        dieselAmount    : "",
                                        cashAdvance     : "",
                                        balance         : "",
                                        paidDiesel      : "",
                                        paidDieselRate  : "",
                                        paidDieselAmount: "",
                                        paidCash        : "",
                                        paidDate        : "",
                                        received        : "",
                                        totalLrAmount   : ""
                                ]);
                            }
                            memoFlag = false;
                        }
                    }
                }
                parent.push([details : child])
            }// End of Memo Loop
        }
        finalData = [
                parent : parent,
                grandTotalLrAmount : grandTotalLrAmount,
                grandTotalFreightAmount : grandTotalFreightAmount,
                grandTotalBalanceAmount : grandTotalBalanceAmount,
                grandTotalDieselAmount : grandTotalDieselAmount,
                grandTotalCashAdvance : grandTotalCashAdvance ,
                grandTotalDieselPaid : grandTotalDieselPaid ,
                grandTotalCashPaid : grandTotalCashPaid
        ];

        reportDetails.push(finalData);
        print reportDetails;
        params._format = params.format;
        params._file = "../reports/transactionReport/MisReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'stockReport', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def print_action1(){
        def reportDetails = [];
        def child = [];
        def parent = [];
        def finalData;
        def grandTotalLrAmount = 0;
        def grandTotalFreightAmount = 0;
        def grandTotalDieselAmount = 0;
        def grandTotalCashAdvance = 0;
        def grandTotalDieselPaid = 0;
        def grandTotalCashPaid = 0;
        def grandTotalBalanceAmount = 0;

        def data = InternalMemo.createCriteria().list {
            eq("branch",session['branch'])
            eq("isActive",true)

            if(params.fromDate && params.toDate){
                between("voucherDate",Date.parse("yyyy-MM-dd",params.fromDate),Date.parse("yyyy-MM-dd",params.toDate))
            }else if(params.fromDate){
                ge("voucherDate",Date.parse("yyyy-MM-dd",params.fromDate))
            }else if(params.toDate){
                le("voucherDate",Date.parse("yyyy-MM-dd",params.toDate))
            }
        }

        if(data){
            data.each {d ->
                child = [];
                Boolean memoFlag = true;
                def childData = d?.internalMemoDetails;
                def balance = d?.totalBalance?:0;
                def paidDiesel = 0;
                def paidDieselRate = 0;
                def paidDieselAmount = 0;
                def totalLrAmount = 0;
                def paidCash = 0;
                String paidDate = "";
                String received = "";
                def finalVoucherData = [];
                def lrData = [];

                def voucherData = CashVoucherChild.createCriteria().list {
                    eq("memoNo",d as InternalMemo)

                    projections {
                        property("cashVoucher")
                    }
                }.unique();

                if(voucherData){
                    finalVoucherData = voucherData?.first()?:[];
                }

                if(finalVoucherData) {
                    if (finalVoucherData?.paymentType == "Diesel") {
                        balance = (d?.totalBalance ?: 0) - (finalVoucherData?.dieselAmount ?: 0)
                        paidDiesel = finalVoucherData?.dieselLtr ?: 0;
                        paidDieselRate = finalVoucherData?.dieselRate ?: 0;
                        paidDieselAmount = finalVoucherData?.dieselAmount ?: 0;
                    }

                    if (finalVoucherData?.paymentType == "Cash") {
                        balance = (d?.totalBalance ?: 0) - (finalVoucherData?.netAmount ?: 0)
                        paidCash = finalVoucherData?.netAmount ?: 0;
                    }

                    paidDate = finalVoucherData?.voucherDate?.format("dd-MM-yyyy");

                    if(balance == 0){
                        received = "RECEIVED";
                    }
                }

                if(childData){
                    def lrUniqueData = LREntryDetails.createCriteria().list {
                        inList("id",d?.internalMemoDetails?.lrChild?.id)

                        projections {
                            property("lrEntry")

                            inList("lrEntry",LREntry.createCriteria().list {
                                eq("branch",session['branch'])
                                eq("isActive",true)

                                if(params.fromParty){
                                    eq("fromCustomer",AccountMaster.findById(params.fromParty))
                                }

                                if(params.toParty){
                                    eq("toCustomer",AccountMaster.findById(params.toParty))
                                }
                            })
                        }
                    }.unique();

                    if(lrUniqueData){
                        totalLrAmount = lrUniqueData.inject(0){result, it -> result + it?.grandTotal?:0}
                    }

                    if(lrUniqueData){
                        memoFlag = true;

                        grandTotalLrAmount = grandTotalLrAmount + totalLrAmount;
                        grandTotalFreightAmount = grandTotalFreightAmount + d?.freight ?: 0;
                        grandTotalBalanceAmount = grandTotalBalanceAmount + balance;
                        grandTotalDieselAmount = grandTotalDieselAmount + d?.dieselAmount?:0;
                        grandTotalCashAdvance = grandTotalCashAdvance + d?.advance?:0;
                        grandTotalDieselPaid = grandTotalDieselPaid + paidDieselAmount;
                        grandTotalCashPaid = grandTotalCashPaid  + paidCash;

                        lrUniqueData.each {l ->
                            if (memoFlag) {
                                child.push([
                                        memoDate        : d?.voucherDate?.format("dd-MM-yyyy") ?: "",
                                        fromParty       : l?.fromCustomer?.accountName ?: "",
                                        toParty         : l?.toCustomer?.accountName ?: "",
                                        vehicleNo : (d?.vehicleNo?.state?:"")+" - "+(d?.vehicleNo?.rto?:"")+
                                                " "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:""),
                                        memoNo          : d?.voucherNo ?: "",
                                        lrNo            : l?.lrNo ?: "",
                                        lrAmount        : l?.grandTotal ?: 0,
                                        vehFright       : d?.freight ?: 0,
                                        diesel          : d?.dieselLtr ?: 0,
                                        dieselRate      : d?.dieselRate ?: 0,
                                        dieselAmount    : d?.dieselAmount ?: 0,
                                        cashAdvance     : d?.advance ?: 0,
                                        balance         : balance,
                                        paidDiesel      : paidDiesel,
                                        paidDieselRate  : paidDieselRate,
                                        paidDieselAmount: paidDieselAmount,
                                        paidCash        : paidCash,
                                        paidDate        : paidDate,
                                        received        : received,
                                        totalLrAmount   : totalLrAmount
                                ]);
                            } else {
                                child.push([
                                        memoDate        : "",
                                        fromParty       : l?.fromCustomer?.accountName ?: "",
                                        toParty         : l?.toCustomer?.accountName ?: "",
                                        vehicleNo : (d?.vehicleNo?.state?:"")+" - "+(d?.vehicleNo?.rto?:"")+
                                                " "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:""),
                                        memoNo          : "",
                                        lrNo            : l?.lrNo ?: "",
                                        lrAmount        : l?.grandTotal ?: 0,
                                        vehFright       : "",
                                        diesel          : "",
                                        dieselRate      : "",
                                        dieselAmount    : "",
                                        cashAdvance     : "",
                                        balance         : "",
                                        paidDiesel      : "",
                                        paidDieselRate  : "",
                                        paidDieselAmount: "",
                                        paidCash        : "",
                                        paidDate        : "",
                                        received        : "",
                                        totalLrAmount   : ""
                                ]);
                            }
                            memoFlag = false;
                        }
                        parent.push([details : child])
                    }// Lr Unique Data List Loop
                }
            }// End of Memo Loop
        }
        finalData = [
                parent : parent,
                grandTotalLrAmount : grandTotalLrAmount,
                grandTotalFreightAmount : grandTotalFreightAmount,
                grandTotalBalanceAmount : grandTotalBalanceAmount,
                grandTotalDieselAmount : grandTotalDieselAmount,
                grandTotalCashAdvance : grandTotalCashAdvance ,
                grandTotalDieselPaid : grandTotalDieselPaid ,
                grandTotalCashPaid : grandTotalCashPaid
        ];

        reportDetails.push(finalData);
        print reportDetails;
        params._format = params.format;
        params._file = "../reports/transactionReport/MisReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'stockReport', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def print_action2(){
        def reportDetails = [];
        def child = [];
        def parent = [];
        def finalData;
        def grandTotalLrAmount = 0;
        def grandTotalFreightAmount = 0;
        def grandTotalDieselAmount = 0;
        def grandTotalCashAdvance = 0;
        def grandTotalDieselPaid = 0;
        def grandTotalCashPaid = 0;
        def grandTotalBalanceAmount = 0;

        def data = InternalMemo.createCriteria().list {
            eq("branch",session['branch'])
            eq("isActive",true)

            if(params.vNo) {
                eq("vehicleNo", VehicleMaster.findById(params.vNo as Long))
            }

            if(params.fromDate && params.toDate){
                between("voucherDate",Date.parse("yyyy-MM-dd",params.fromDate),Date.parse("yyyy-MM-dd",params.toDate))
            }else if(params.fromDate){
                ge("voucherDate",Date.parse("yyyy-MM-dd",params.fromDate))
            }else if(params.toDate){
                le("voucherDate",Date.parse("yyyy-MM-dd",params.toDate))
            }
        }

        if(data){
            data.each {d ->
                child = [];
                Boolean memoFlag = true;
                def childData = d?.internalMemoDetails;
                def balance = d?.totalBalance?:0;
                def paidDiesel = 0;
                def paidDieselRate = 0;
                def paidDieselAmount = 0;
                def totalLrAmount = 0;
                def paidCash = 0;
                String paidDate = "";
                String received = "";
                def finalVoucherData = [];
                def lrData = [];

                def voucherData = CashVoucherChild.createCriteria().list {
                    eq("memoNo",d as InternalMemo)

                    projections {
                        property("cashVoucher")
                    }
                }.unique();

                if(voucherData){
                    finalVoucherData = voucherData?.first()?:[];
                }

                if(finalVoucherData) {
                    if (finalVoucherData?.paymentType == "Diesel") {
                        balance = (d?.totalBalance ?: 0) - (finalVoucherData?.dieselAmount ?: 0)
                        paidDiesel = finalVoucherData?.dieselLtr ?: 0;
                        paidDieselRate = finalVoucherData?.dieselRate ?: 0;
                        paidDieselAmount = finalVoucherData?.dieselAmount ?: 0;
                    }

                    if (finalVoucherData?.paymentType == "Cash") {
                        balance = (d?.totalBalance ?: 0) - (finalVoucherData?.netAmount ?: 0)
                        paidCash = finalVoucherData?.netAmount ?: 0;
                    }

                    paidDate = finalVoucherData?.voucherDate?.format("dd-MM-yyyy");

                    if(balance == 0){
                        received = "RECEIVED";
                    }
                }

                if(childData){
                    def lrUniqueData = LREntryDetails.createCriteria().list {
                        inList("id",d?.internalMemoDetails?.lrChild?.id)

                        projections {
                            property("lrEntry")
                        }
                    }.unique();

                    if(lrUniqueData){
                        totalLrAmount = lrUniqueData.inject(0){result, it -> result + it?.grandTotal?:0}
                    }

                    if(lrUniqueData){
                        memoFlag = true;

                        grandTotalLrAmount = grandTotalLrAmount + totalLrAmount;
                        grandTotalFreightAmount = grandTotalFreightAmount + d?.freight ?: 0;
                        grandTotalBalanceAmount = grandTotalBalanceAmount + balance;
                        grandTotalDieselAmount = grandTotalDieselAmount + d?.dieselAmount?:0;
                        grandTotalCashAdvance = grandTotalCashAdvance + d?.advance?:0;
                        grandTotalDieselPaid = grandTotalDieselPaid + paidDieselAmount;
                        grandTotalCashPaid = grandTotalCashPaid  + paidCash;

                        lrUniqueData.each {l ->
                            if (memoFlag) {
                                child.push([
                                        memoDate        : d?.voucherDate?.format("dd-MM-yyyy") ?: "",
                                        fromParty       : l?.fromCustomer?.accountName ?: "",
                                        toParty         : l?.toCustomer?.accountName ?: "",
                                        vehicleNo : (d?.vehicleNo?.state?:"")+" - "+(d?.vehicleNo?.rto?:"")+
                                                " "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:""),
                                        memoNo          : d?.voucherNo ?: "",
                                        lrNo            : l?.lrNo ?: "",
                                        lrAmount        : l?.grandTotal ?: 0,
                                        vehFright       : d?.freight ?: 0,
                                        diesel          : d?.dieselLtr ?: 0,
                                        dieselRate      : d?.dieselRate ?: 0,
                                        dieselAmount    : d?.dieselAmount ?: 0,
                                        cashAdvance     : d?.advance ?: 0,
                                        balance         : balance,
                                        paidDiesel      : paidDiesel,
                                        paidDieselRate  : paidDieselRate,
                                        paidDieselAmount: paidDieselAmount,
                                        paidCash        : paidCash,
                                        paidDate        : paidDate,
                                        received        : received,
                                        totalLrAmount   : totalLrAmount
                                ]);
                            } else {
                                child.push([
                                        memoDate        : "",
                                        fromParty       : l?.fromCustomer?.accountName ?: "",
                                        toParty         : l?.toCustomer?.accountName ?: "",
                                        vehicleNo : (d?.vehicleNo?.state?:"")+" - "+(d?.vehicleNo?.rto?:"")+
                                                " "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:""),
                                        memoNo          : "",
                                        lrNo            : l?.lrNo ?: "",
                                        lrAmount        : l?.grandTotal ?: 0,
                                        vehFright       : "",
                                        diesel          : "",
                                        dieselRate      : "",
                                        dieselAmount    : "",
                                        cashAdvance     : "",
                                        balance         : "",
                                        paidDiesel      : "",
                                        paidDieselRate  : "",
                                        paidDieselAmount: "",
                                        paidCash        : "",
                                        paidDate        : "",
                                        received        : "",
                                        totalLrAmount   : ""
                                ]);
                            }
                            memoFlag = false;
                        }
                        parent.push([details : child])
                    }// Lr Unique Data List Loop
                }
            }// End of Memo Loop
        }
        finalData = [
                parent : parent,
                grandTotalLrAmount : grandTotalLrAmount,
                grandTotalFreightAmount : grandTotalFreightAmount,
                grandTotalBalanceAmount : grandTotalBalanceAmount,
                grandTotalDieselAmount : grandTotalDieselAmount,
                grandTotalCashAdvance : grandTotalCashAdvance ,
                grandTotalDieselPaid : grandTotalDieselPaid ,
                grandTotalCashPaid : grandTotalCashPaid
        ];

        reportDetails.push(finalData);
        print reportDetails;
        params._format = params.format;
        params._file = "../reports/transactionReport/MisReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'stockReport', action: 'generateReport', model: [data: reportDetails], params: params);
    }
}
