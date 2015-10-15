package com.transaction

import annotation.ParentScreen

@ParentScreen(name = "Report", subUnder = "Report", fullName = "Stock Report")
class StockReportController {
    def jasperService
    def index() {
        render(view: "print");
    }
    def stockOutDatewise(){

        def reportDetails=[]
        def child=[]
        def parent
        if(params.fdate && params.tdate){
            def data=OutEntry.findAllByVoucherDateBetween(Date.parse("yyyy-MM-dd",params.fdate),Date.parse("yyyy-MM-dd",params.tdate))
            if(data){
                data.each {d->
                    def data2=OutEntryDetails.findAllByOutEntry(d as OutEntry)
                    if(data2){
                        data2.each {d2->
                            def prodName=LREntryDetails.findByLrEntryAndInvoiceNo(LREntry.findByLrNo(d2.lrNo),d2.invoiceNo)
//                            def prodName=LREntryDetails.findByLrEntryAndInvoiceNo(LREntry.findByLrNoAndFinancialYear(d2.lrNo,FinancialYear.findById(session['financialYear'].id)),d2.invoiceNo)
                            child.push([
                                    vehicleNo:d?.vehicle?:"",
                                    inv:d2?.invoiceNo?:"",
                                    fromTo:(d?.fromCustomer?.accountName)+" To "+(d?.toCustomer?.accountName),
                                    partNo:prodName?.productName?.productCode?:"",
                                    desc:prodName?.productName?.productName?:"",
                                    qty:d2?.invoiceQty?:""
                            ])
                        }

                    }
                }
                if(child){
                    parent=[
                            details:child,
                            fromDate:Date.parse("yyyy-MM-dd",params.fdate).format("dd-MM-yyyy"),
                            toDate:Date.parse("yyyy-MM-dd",params.tdate).format("dd-MM-yyyy")
                    ]
                }
                if(parent){
                    reportDetails.push(parent);
                }
            }
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/datewiseoutentry"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"

        chain(controller: 'transactionReport', action: 'generateReport', model: [data: reportDetails], params: params);
    }
}
