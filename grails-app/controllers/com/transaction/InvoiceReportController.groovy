package com.transaction

import annotation.ParentScreen
import com.master.AccountMaster
import com.master.GodownMaster
import com.master.VehicleMaster

@ParentScreen(name = "Report", subUnder = "Report", fullName = "Invoice Report")
class InvoiceReportController {

    def index() {
        render(view: "print");
    }

    def invoiceReceivedReport(){
        def reportDetails = [];
        def parent;
        def child = [];
        def data = [];
        def vData = [];
        String vehicleNo = "";

        if(params.vNo){
            vData = VehicleMaster.findById(params.vNo as Long);

            if(vData){
                vehicleNo = (vData?.state?:"") +" - "+ (vData?.rto?:"") +" "+ (vData?.series?:"") +" "+ (vData?.vehicleNo?:"")
            }
        }

        def parentData = InvoiceReceivedEntry.createCriteria().list {
            eq("branch", session['branch'])
            eq("isActive", true)

            if (params.fromDate && params.toDate) {
                between("receiveDate", Date.parse("yyyy-MM-dd", params.fromDate), Date.parse("yyyy-MM-dd", params.toDate))
            } else if (params.fromDate) {
                ge("receiveDate", Date.parse("yyyy-MM-dd", params.fromDate))
            } else if (params.toDate) {
                le("receiveDate", Date.parse("yyyy-MM-dd", params.toDate))
            }
        }

        def lrData = LREntry.createCriteria().list {
            eq("branch", session['branch'])
            eq("isActive", true)

            if (params.fromParty) {
                eq("fromCustomer", AccountMaster.findById(params.fromParty as Long))
            }

            if (params.toParty) {
                eq("toCustomer", AccountMaster.findById(params.toParty as Long))
            }

            if (params.vNo) {
                eq("vehicleNo", VehicleMaster.findById(params.vNo as Long))
            }
        }

        def lrChildData = LREntryDetails.createCriteria().list {
            eq("received",true)

            if(lrData) {
                inList("lrEntry", lrData)
            }
        }

        if (lrChildData) {
            data = InvoiceReceivedEntryDetails.createCriteria().list {
                inList("lrEntryDetails", lrChildData)

                if(parentData) {
                    inList("parent", parentData)
                }
            }
        }

        if((!parentData) && (params.fromDate) && (params.toDate)){
            data = [];
        }

        if (data) {
            data.each {d ->
                child.push([
                        receveNo : d?.parent?.srNo?:"",
                        receiveDate : d?.parent?.receiveDate?.format("dd-MM-yyyy")?:"",
                        invocieNo : d?.lrEntryDetails?.invoiceNo?:"",
                        vehicleNo : (d?.lrEntryDetails?.lrEntry?.vehicleNo?.state?:"")+" - "+(d?.lrEntryDetails?.lrEntry?.vehicleNo?.rto?:"")+
                                " "+(d?.lrEntryDetails?.lrEntry?.vehicleNo?.series?:"")+" "+(d?.lrEntryDetails?.lrEntry?.vehicleNo?.vehicleNo?:""),
                        goDown : d?.parent?.goDown?.godownName?:"",
                        fromParty       : d?.lrEntryDetails?.lrEntry?.fromCustomer?.accountName ?: "",
                        fromPartyAddress: d?.lrEntryDetails?.lrEntry?.fromCustomer?.address ?: "",
                        toParty         : d?.lrEntryDetails?.lrEntry?.toCustomer?.accountName ?: "",
                        toPartyAddress  : d?.lrEntryDetails?.lrEntry?.toCustomer?.address ?: "",
                ]);
            }
        }

        parent = [
                child : child,
                titleName : "INVOICE RECEIVED REPORT",
                reportName : "InvoiceReceivedReport_subreport1.jasper",
                fromParty: params.fromParty ? AccountMaster.findById(params.fromParty as Long)?.accountName : "",
                toParty  : params.toParty ? AccountMaster.findById(params.toParty as Long)?.accountName : "",
                fromDate : params.fromDate ? Date.parse("yyyy-MM-dd", params.fromDate)?.format("dd-MM-yyyy") : "",
                toDate   : params.toDate ? Date.parse("yyyy-MM-dd", params.toDate)?.format("dd-MM-yyyy") : "",
                vehicleNo: vehicleNo,
                goDown : ""
        ];

        reportDetails.push(parent);

        params._format = "PDF";
        params._file = "../reports/transactionReport/InvoiceReceivedReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def invoiceReceivedGodownwiseReport(){
        def reportDetails = [];
        def parent;
        def child = [];
        def data = [];
        def vData = [];
        String vehicleNo = "";

        if(params.vNo){
            vData = VehicleMaster.findById(params.vNo as Long);

            if(vData){
                vehicleNo = (vData?.state?:"") +" - "+ (vData?.rto?:"") +" "+ (vData?.series?:"") +" "+ (vData?.vehicleNo?:"")
            }
        }

        def parentData = InvoiceReceivedEntry.createCriteria().list {
            eq("branch", session['branch'])
            eq("isActive", true)

            if(params.goDown){
                eq("goDown",GodownMaster.findById(params.goDown as Long))
            }

            if (params.fromDate && params.toDate) {
                between("receiveDate", Date.parse("yyyy-MM-dd", params.fromDate), Date.parse("yyyy-MM-dd", params.toDate))
            } else if (params.fromDate) {
                ge("receiveDate", Date.parse("yyyy-MM-dd", params.fromDate))
            } else if (params.toDate) {
                le("receiveDate", Date.parse("yyyy-MM-dd", params.toDate))
            }
        }

        data = InvoiceReceivedEntryDetails.createCriteria().list {
            if(parentData) {
                inList("parent", parentData)
            }
        }

        if(!parentData) {
            data = [];
        }

        if((!parentData) && (params.fromDate) && (params.toDate)){
            data = [];
        }

        if (data) {
            data.each {d ->
                child.push([
                        receveNo : d?.parent?.srNo?:"",
                        receiveDate : d?.parent?.receiveDate?.format("dd-MM-yyyy")?:"",
                        invocieNo : d?.lrEntryDetails?.invoiceNo?:"",
                        vehicleNo : (d?.lrEntryDetails?.lrEntry?.vehicleNo?.state?:"")+" - "+(d?.lrEntryDetails?.lrEntry?.vehicleNo?.rto?:"")+
                                " "+(d?.lrEntryDetails?.lrEntry?.vehicleNo?.series?:"")+" "+(d?.lrEntryDetails?.lrEntry?.vehicleNo?.vehicleNo?:""),
                        goDown : d?.parent?.goDown?.godownName?:"",
                        fromParty       : d?.lrEntryDetails?.lrEntry?.fromCustomer?.accountName ?: "",
                        fromPartyAddress: d?.lrEntryDetails?.lrEntry?.fromCustomer?.address ?: "",
                        toParty         : d?.lrEntryDetails?.lrEntry?.toCustomer?.accountName ?: "",
                        toPartyAddress  : d?.lrEntryDetails?.lrEntry?.toCustomer?.address ?: "",
                ]);
            }
        }

        parent = [
                child : child,
                titleName : "INVOICE RECEIVED REPORT",
                reportName : "InvoiceReceivedReport_subreport1.jasper",
                fromParty: params.fromParty ? AccountMaster.findById(params.fromParty as Long)?.accountName : "",
                toParty  : params.toParty ? AccountMaster.findById(params.toParty as Long)?.accountName : "",
                fromDate : params.fromDate ? Date.parse("yyyy-MM-dd", params.fromDate)?.format("dd-MM-yyyy") : "",
                toDate   : params.toDate ? Date.parse("yyyy-MM-dd", params.toDate)?.format("dd-MM-yyyy") : "",
                vehicleNo: vehicleNo,
                goDown : params.goDown?GodownMaster.findById(params.goDown as Long):""
        ];

        reportDetails.push(parent);

        params._format = "PDF";
        params._file = "../reports/transactionReport/InvoiceReceivedReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def invoiceNotReceivedReport(){
        def reportDetails = [];
        def parent;
        def child = [];

        def lrData = LREntry.createCriteria().list {
            eq("branch", session['branch'])
            eq("isActive", true)
            eq("received", false)

            if (params.fromParty) {
                eq("fromCustomer", AccountMaster.findById(params.fromParty as Long))
            }

            if (params.toParty) {
                eq("toCustomer", AccountMaster.findById(params.toParty as Long))
            }

            if (params.fromDate && params.toDate) {
                between("lrDate", Date.parse("yyyy-MM-dd", params.fromDate), Date.parse("yyyy-MM-dd", params.toDate))
            } else if (params.fromDate) {
                ge("lrDate", Date.parse("yyyy-MM-dd", params.fromDate))
            } else if (params.toDate) {
                le("lrDate", Date.parse("yyyy-MM-dd", params.toDate))
            }
        }

        def lrChildData = LREntryDetails.createCriteria().list {
            eq("received",false)

            if(lrData) {
                inList("lrEntry", lrData)
            }
        }

        if (lrChildData) {
            lrChildData.each {d ->
                child.push([
                        invocieNo : d?.invoiceNo?:"",
                        vehicleNo : (d?.lrEntry?.vehicleNo?.state?:"")+" - "+(d?.lrEntry?.vehicleNo?.rto?:"")+
                                " "+(d?.lrEntry?.vehicleNo?.series?:"")+" "+(d?.lrEntry?.vehicleNo?.vehicleNo?:""),
                        goDown : d?.lrEntry?.goDown?.godownName?:"",
                        fromParty       : d?.lrEntry?.fromCustomer?.accountName ?: "",
                        fromPartyAddress: d?.lrEntry?.fromCustomer?.address ?: "",
                        toParty         : d?.lrEntry?.toCustomer?.accountName ?: "",
                        toPartyAddress  : d?.lrEntry?.toCustomer?.address ?: "",
                ]);
            }
        }

        parent = [
                child : child,
                titleName : "INVOICE NOT RECEIVED REPORT",
                reportName : "InvoiceReceivedReport_subreport2.jasper",
                fromParty: params.fromParty ? AccountMaster.findById(params.fromParty as Long)?.accountName : "",
                toParty  : params.toParty ? AccountMaster.findById(params.toParty as Long)?.accountName : "",
                fromDate : params.fromDate ? Date.parse("yyyy-MM-dd", params.fromDate)?.format("dd-MM-yyyy") : "",
                toDate   : params.toDate ? Date.parse("yyyy-MM-dd", params.toDate)?.format("dd-MM-yyyy") : "",
                vehicleNo: "",
                goDown : params.goDown?GodownMaster.findById(params.goDown as Long):""
        ];

        reportDetails.push(parent);

        params._format = "PDF";
        params._file = "../reports/transactionReport/InvoiceReceivedReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }
}
