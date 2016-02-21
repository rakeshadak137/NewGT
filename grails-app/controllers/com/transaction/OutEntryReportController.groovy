package com.transaction

import annotation.ParentScreen
import com.master.AccountMaster

@ParentScreen(name = "Report", subUnder = "Report", fullName = "Out Entry Report")
class OutEntryReportController {

    def index() {
        render(view: "print");
    }

    def allInOtEntryReport(){
        def reportDetails = [];
        def finalData;
        def parent = [];
        def child = [];

        def Data = OutEntry.createCriteria().list {
            eq("branch",session['branch'])
            eq("isActive",true)

            if(params.fromDate && params.toDate){
                between("voucherDate",Date.parse("yyyy-MM-dd",params.fromDate),Date.parse("yyyy-MM-dd",params.toDate))
            }else if(params.fromDate){
                ge("voucherDate",Date.parse("yyyy-MM-dd",params.fromDate))
            }else if(params.toDate){
                le("voucherDate",Date.parse("yyyy-MM-dd",params.toDate))
            }

            if(params.vNo){
                eq('vehicle',params.vNo)
            }
        }.sort{it.voucherDate}

        def childData = OutEntryDetails.createCriteria().list {
            if(params.fromParty){
                eq("fromParty",AccountMaster.findById(params.fromParty as Long))
            }

            if(params.toParty){
                eq("toParty",AccountMaster.findById(params.toParty as Long))
            }

            if(Data) {
                inList("outEntry", Data)
            }
        }

        if(Data){
            Data.each {d ->
                child = [];

                if(childData){
                    childData.each {ch ->
                        child.push([
                                fromCustomer : ch?.fromParty?.accountName?:"",
                                toCustomer : ch?.toParty?.accountName?:"",
                                lrNo : ch?.lrNo,
                                lrDate : ch?.lrDate?.format("dd-MM-yyyy")?:"",
                                qty : ch?.invoiceQty?:"",
                                parameter : ch?.parameter?.name?:""
                        ]);
                    }
                }

                if(child){
                    parent.push([
                            child : child,
                            voucherNo : d?.voucherNo?:"",
                            voucherDate : d?.voucherDate?.format("dd-MM-yyyy")?:"",
                            vehicleNo : d?.vehicle?:"",
                            godown : d?.godown?.godownName?:""
                    ]);
                }
            }
        }

        finalData = [
                parent : parent,
                fromParty: params.fromParty ? AccountMaster.findById(params.fromParty as Long)?.accountName : "",
                toParty  : params.toParty ? AccountMaster.findById(params.toParty as Long)?.accountName : "",
                fromDate : params.fromDate ? Date.parse("yyyy-MM-dd", params.fromDate)?.format("dd-MM-yyyy") : "",
                toDate   : params.toDate ? Date.parse("yyyy-MM-dd", params.toDate)?.format("dd-MM-yyyy") : ""
        ]

        reportDetails.push(finalData)

        params._format = "PDF";
        params._file = "../reports/transactionReport/AllInOneOutEntryReport.jasper"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }
}
