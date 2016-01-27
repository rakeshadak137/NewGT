package com.transaction

import annotation.ParentScreen
import com.master.AccountMaster
import com.master.VehicleMaster

@ParentScreen(name = "Report", subUnder = "Report", fullName = "Local Trip Report")
class LocalTripReportController {

    def index() {
        render(view: "print");
    }

    def allInOneLocalTripReport(){
        def reportDetails = []
        def parent
        def child = []

        def Data = LocalTripEntry.createCriteria().list {
            eq("branch",session['branch'])
            eq("isActive",true)

            if(params.fromParty){
                eq("fromCustomer",AccountMaster.findById(params.fromParty as Long))
            }

            if(params.toParty){
                eq("toCustomer",AccountMaster.findById(params.toParty as Long))
            }

            if(params.vNo){
                eq("vehicleNo",VehicleMaster.findById(params.vNo as Long))
            }

            if(params.fromDate && params.toDate){
                between("localOutEntryDate",Date.parse("yyyy-MM-dd",params.fromDate),Date.parse("yyyy-MM-dd",params.toDate))
            }else if(params.fromDate){
                ge("localOutEntryDate",Date.parse("yyyy-MM-dd",params.fromDate))
            }else if(params.toDate){
                le("localOutEntryDate",Date.parse("yyyy-MM-dd",params.toDate))
            }
        }.sort {it.localOutEntryDate}

        if(Data){
            Data.each {d ->
                def childData = d?.localOutEntryDetails

                if(childData){
                    childData.each {ch ->
                        child.push([
                                date : d?.localOutEntryDate?.format("dd-MM-yyyy")?:"",
                                vehicleNo : (d?.vehicleNo?.state?:"") +" - "+ (d?.vehicleNo?.rto?:"") +" "+ (d?.vehicleNo?.series?:"") +" "+ (d?.vehicleNo?.vehicleNo?:""),
                                invoiceNo : ch?.invoiceNo?:"",
                                materialName : ch?.productCode?.productCode?:"",
                                qty : ch?.quantity?:"",
                                amount : ""
                        ]);
                    }
                }
            }
        }

        parent = [
                child : child,
                fromParty: params.fromParty ? AccountMaster.findById(params.fromParty as Long)?.accountName : "",
                toParty  : params.toParty ? AccountMaster.findById(params.toParty as Long)?.accountName : "",
                fromDate : params.fromDate ? Date.parse("yyyy-MM-dd", params.fromDate)?.format("dd-MM-yyyy") : "",
                toDate   : params.toDate ? Date.parse("yyyy-MM-dd", params.toDate)?.format("dd-MM-yyyy") : "",
                vehicleNo: params.vNo ? VehicleMaster.findById(params.vNo as Long):""
        ]

        reportDetails.push(parent)

        params._format = "PDF";
        params._file = "../reports/transactionReport/InvoiceReceivedReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }
}
