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
        def finalData
        def parent = []
        def child = []
        def totalAmount = 0;

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
                child = [];
                def childData = d?.localOutEntryDetails
                totalAmount = totalAmount + d?.totalTripRate?:0;

                if(childData){
                    childData.each {ch ->
                        child.push([
                                invoiceNo : ch?.invoiceNo?:"",
                                materialName : ch?.productCode?.productCode?:"",
                                qty : ch?.quantity?:""
                        ]);
                    }
                }

                if(child){
                    parent.push([
                            child : child,
                            date : d?.localOutEntryDate?.format("dd-MM-yyyy")?:"",
                            vehicleNo : (d?.vehicleNo?.state?:"") +" - "+ (d?.vehicleNo?.rto?:"") +" "+
                                    (d?.vehicleNo?.series?:"") +" "+ (d?.vehicleNo?.vehicleNo?:""),
                            amount : d?.totalTripRate?:"",
                            voucherNo : d?.localOutEntryNo?:""
                    ]);
                }
            }
        }

        finalData = [
                parent : parent,
                fromParty: params.fromParty ? AccountMaster.findById(params.fromParty as Long)?.accountName : "",
                toParty  : params.toParty ? AccountMaster.findById(params.toParty as Long)?.accountName : "",
                fromDate : params.fromDate ? Date.parse("yyyy-MM-dd", params.fromDate)?.format("dd-MM-yyyy") : "",
                toDate   : params.toDate ? Date.parse("yyyy-MM-dd", params.toDate)?.format("dd-MM-yyyy") : "",
                vehicleNo: params.vNo ? VehicleMaster.findById(params.vNo as Long):"",
                totalAmount : totalAmount
        ]

        reportDetails.push(finalData)

        params._format = "PDF";
        params._file = "../reports/transactionReport/AllInOneLocalTripReport.jasper"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }
}
