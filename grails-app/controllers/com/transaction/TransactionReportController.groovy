package com.transaction

import annotation.ParentScreen
import com.master.*
import grails.converters.JSON

import java.text.DecimalFormat

@ParentScreen(name = "Report", subUnder = "Report", fullName = "LR Report")
class TransactionReportController {
    def jasperService

    def index() {
        render(view: "lrReport");
    }

    def accountList() {
        def result = [];
        result = AccountMaster.findAllByIsActive(true);
        render result as JSON;
    }

    def itemList() {
        def result = [];
        result = ProductMaster.findAllByIsActive(true);
        render result as JSON;
    }

    def vehicleList() {
        def result = [];
        result = VehicleMaster.findAllByIsActive(true);
        render result as JSON;
    }

    def memoList() {
        def result = [];
        def child = [];
        result = InternalMemo.createCriteria().list {
            eq("branch", session['branch'])
            eq("isActive", true)
        }
        child.push(result);

        render result as JSON;
    }

    def LR() {
        def reportDetails = [];
        Boolean printRate = false;
        if (params.masterPrint) printRate = true

        def serviceTaxNo = ""
        def panNo = ""
        def serviceTaxString = ""

        DecimalFormat df = new DecimalFormat("#.#####")

        if (params.id) {
            def Data = LREntry.findById(params.id as Long);
            def parent;
            def child = [];

            if (Data) {
                def childData = LREntryDetails.findAllByLrEntry(Data as LREntry);
                def custId = Data?.fromCustomer?.id

                if ((custId == 1006) || (custId == 1011) || (custId == 1021) || (custId == 1023) || (custId == 1055) || (custId == 1101)) {
                    serviceTaxNo = ""
                    serviceTaxString = ""
                    panNo = "ALOPK7594C"
                } else {
                    serviceTaxNo = "AQIPK4895RST001"
                    serviceTaxString = "Service Tax No:"
                    panNo = "AQIPK4895R"
                }

                if (childData) {
                    childData.each { c ->

                        if (Data.billPayType == "Paid" || Data.billPayType == "To Pay" || printRate) {
                            child.push([
                                    invoiceNo  : c?.invoiceNo ?: "",
                                    description: (c?.productName?.productCode ?: "") + " - " + (c?.productName?.productName ?: ""),
                                    qty        : c?.qty ?: "",
                                    packing    : c?.invoiceQty ?: "",
                                    weight     : df.format(c?.weight),
                                    totalWeight: df.format(c?.qty * c?.weight),
                                    rate       : c?.rate ?: "",
                                    amount     : c?.totalAmount
                            ]);
                        } else {
                            child.push([
                                    invoiceNo  : c?.invoiceNo ?: "",
                                    description: (c?.productName?.productCode ?: "") + " - " + (c?.productName?.productName ?: ""),
                                    qty        : c?.qty ?: "",
                                    packing    : c?.invoiceQty ?: "",
                                    weight     : "",
                                    totalWeight: "",
                                    rate       : "",
                                    amount     : ""
                            ]);
                        }
                    }
                }

                if (child) {
                    if (Data.billPayType == "Paid" || Data.billPayType == "To Pay" || printRate) {
                        parent = [
                                details         : child,
                                fromLocation    : Data?.fromLocation ?: "",
                                toLocation      : Data?.toLocation ?: "",
                                lrDate          : Data?.lrDate?.format("yyyy-MM-dd") ?: "",
                                vehicleNo       : (Data?.vehicleNo?.state ?: "") + " " + (Data?.vehicleNo?.rto ?: "") + " " + (Data?.vehicleNo?.series ?: "") + " " + (Data?.vehicleNo?.vehicleNo ?: ""),
                                lrNo            : Data?.lrNo ?: "",
                                fromCustomerName: Data?.fromCustomer?.accountName ?: "",
                                toCustomerName  : Data?.toCustomer?.accountName ?: "",
                                fromAddress     : Data?.fromCustomer?.address ?: "",
                                toAddress       : Data?.toCustomer?.address ?: "",
                                billPayType     : Data?.billPayType ?: "",
                                freight         : Data?.freight ?: 0.00,
                                loading         : Data?.loading ?: 0.00,
                                unloading       : Data?.unloading ?: 0.00,
                                collection      : Data?.collection ?: 0.00,
                                cartage         : Data?.cartage ?: 0.00,
                                cata            : Data?.cata ?: 0.00,
                                bilty           : Data?.bilty ?: 0.00,
                                doorDelivery    : Data?.doorDelivery ?: 0.00,
                                grandTotal      : Data?.grandTotal ?: 0.00,
                                lcNo            : Data?.lcNo ?: "",
                                invoiceNo       : Data?.invoiceNo ?: "",
                                invoiceAmount   : Data?.invoiceAmount ?: "",
                                serviceTaxNo    : serviceTaxNo ?: "",
                                serviceTaxString: serviceTaxString,
                                panNo           : panNo ?: ""
                        ]
                    } else {
                        parent = [
                                details         : child,
                                fromLocation    : Data?.fromLocation,
                                toLocation      : Data?.toLocation,
                                lrDate          : Data?.lrDate?.format("yyyy-MM-dd"),
                                vehicleNo       : (Data?.vehicleNo?.state ?: "") + " " + (Data?.vehicleNo?.rto ?: "") + " " + (Data?.vehicleNo?.series ?: "") + " " + (Data?.vehicleNo?.vehicleNo ?: ""),
                                lrNo            : Data?.lrNo,
                                lrTime          : Data?.dateCreated?.format("hh:mm:ss a"),
                                fromCustomerName: Data?.fromCustomer?.accountName,
                                toCustomerName  : Data?.toCustomer?.accountName,
                                fromAddress     : Data?.fromCustomer?.address,
                                toAddress       : Data?.toCustomer?.address,
                                billPayType     : Data?.billPayType,
                                freight         : 0.00,
                                loading         : 0.00,
                                unloading       : 0.00,
                                collection      : 0.00,
                                cartage         : 0.00,
                                cata            : 0.00,
                                bilty           : 0.00,
                                doorDelivery    : 0.00,
                                grandTotal      : "",
                                lcNo            : Data?.lcNo ?: "",
                                invoiceNo       : Data?.invoiceNo ?: "",
                                invoiceAmount   : Data?.invoiceAmount ?: "",
                                serviceTaxNo    : serviceTaxNo ?: "",
                                serviceTaxString: serviceTaxString,
                                panNo           : panNo ?: ""
                        ]
                    }
                }
            }
            if (parent) {
                reportDetails.push(parent);
            }
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/LR_report.jasper"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"

        chain(controller: 'transactionReport', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def datewiseLRreport() {
        def reportDetails = [];
        def childData = [];
        def vehicleNo = "";
        if (params.fdate && params.tdate) {
            def data = LREntry.findAllByLrDateBetween(Date.parse("yyyy-MM-dd", params.fdate), Date.parse("yyyy-MM-dd", params.tdate))
            if (data) {
                def child = [];
                data.each { d ->
                    vehicleNo = "";
                    vehicleNo = (d?.vehicleNo?.state ?: "") + "-" + (d?.vehicleNo?.rto ?: "") + "-" + (d?.vehicleNo?.series ?: "") + " " + (d?.vehicleNo?.vehicleNo ?: "")
                    childData = [];
                    childData = LREntryDetails.findAllByLrEntry(d as LREntry);
                    if (childData) {
                        childData.each { c ->
                            child.push([
                                    lrNo       : c?.lrEntry?.lrNo ?: "",
                                    lrDate     : c?.lrEntry?.lrDate?.format("dd-MM-yyyy") ?: "",
                                    productName: c?.productName ?: "",
                                    partyName  : c?.lrEntry?.fromCustomer?.accountName ?: "",
                                    fromAddress: c?.lrEntry?.fromCustomer?.address ?: "",
                                    toPartyName: c?.lrEntry?.toCustomer?.accountName ?: "",
                                    toAddress  : c?.lrEntry?.toCustomer?.accountName ?: "",
                                    invoiceNo  : c?.invoiceNo ?: "",
                                    invoiceQty : c?.invoiceQty ?: "",
                                    invoiceUnit: c?.unit?.unitName ?: "",
                                    unit       : c?.productName?.unit?.unitName ?: "",
                                    qty        : c?.qty ?: "",
                                    weight     : c?.weight ?: "",
                                    vehicleNo  : vehicleNo
                            ])
                        }
                    }
                }
                if (child) {
                    reportDetails.push([
                            details : child,
                            fromDate: Date.parse("yyyy-MM-dd", params.fdate)?.format("dd-MM-yyyy"),
                            toDate  : Date.parse("yyyy-MM-dd", params.tdate)?.format("dd-MM-yyyy")
                    ])
                }
            }
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/lrDatewise"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def partywiseLRreport() {
        def data = [];
        def childData = [];
        def child = [];
        def reportDetails = [];
        def vehicleNo = "";
        if (params.fdate && params.tdate && ((params.item) || (params.party) || (params.toParty))) {
            if (params.fdate && params.tdate && params.item && !(params.party) && !(params.toParty)) {

                data = LREntry.findAllByLrDateBetween(Date.parse("yyyy-MM-dd", params.fdate), Date.parse("yyyy-MM-dd", params.tdate));

                if (data) {
                    childData = [];
                    data.each { d ->
                        vehicleNo = "";
                        vehicleNo = (d?.vehicleNo?.state ?: "") + "-" + (d?.vehicleNo?.rto ?: "") + "-" + (d?.vehicleNo?.series ?: "") + " " + (d?.vehicleNo?.vehicleNo ?: "")
                        childData = LREntryDetails.findAllByLrEntryAndProductName(d as LREntry, ProductMaster.findById(params.item))
                        if (childData) {
                            childData.each { c ->
                                child.push([
                                        lrNo       : c?.lrEntry?.lrNo ?: "",
                                        lrDate     : c?.lrEntry?.lrDate?.format("dd-MM-yyyy") ?: "",
                                        productName: c?.productName ?: "",
                                        partyName  : c?.lrEntry?.fromCustomer?.accountName ?: "",
                                        fromAddress: c?.lrEntry?.fromCustomer?.address ?: "",
                                        toAddress  : c?.lrEntry?.toCustomer?.address ?: "",
                                        toPartyName: c?.lrEntry?.toCustomer?.accountName ?: "",
                                        invoiceNo  : c?.invoiceNo ?: "",
                                        invoiceQty : c?.invoiceQty ?: "",
                                        invoiceUnit: c?.unit?.unitName ?: "",
                                        unit       : c?.productName?.unit?.unitName ?: "",
                                        qty        : c?.qty ?: "",
                                        weight     : c?.weight ?: "",
                                        vehicleNo  : vehicleNo
                                ])
                            }
                        }
                    }
                }
            } else if (params.fdate && params.tdate && params.party && params.toParty && !(params.item)) {
                data = LREntry.findAllByLrDateBetweenAndFromCustomerAndToCustomer(Date.parse("yyyy-MM-dd", params.fdate), Date.parse("yyyy-MM-dd", params.tdate), AccountMaster.findById(params.party), AccountMaster.findById(params.toParty));
                if (data) {
//                    data.each {
                    data.each { d ->
                        childData = [];
                        vehicleNo = "";
                        vehicleNo = (d?.vehicleNo?.state ?: "") + "-" + (d?.vehicleNo?.rto ?: "") + "-" + (d?.vehicleNo?.series ?: "") + " " + (d?.vehicleNo?.vehicleNo ?: "")
                        childData = LREntryDetails.findAllByLrEntry(d as LREntry);
                        if (childData) {
                            childData.each { c ->
                                child.push([
                                        lrNo       : c?.lrEntry?.lrNo ?: "",
                                        lrDate     : c?.lrEntry?.lrDate?.format("dd-MM-yyyy") ?: "",
                                        productName: c?.productName ?: "",
                                        partyName  : c?.lrEntry?.fromCustomer?.accountName ?: "",
                                        fromAddress: c?.lrEntry?.fromCustomer?.address ?: "",
                                        toPartyName: c?.lrEntry?.toCustomer?.accountName ?: "",
                                        toAddress  : c?.lrEntry?.toCustomer?.accountName ?: "",
                                        invoiceNo  : c?.invoiceNo ?: "",
                                        invoiceQty : c?.invoiceQty ?: "",
                                        invoiceUnit: c?.unit?.unitName ?: "",
                                        unit       : c?.productName?.unit?.unitName ?: "",
                                        qty        : c?.qty ?: "",
                                        weight     : c?.weight ?: "",
                                        vehicleNo  : vehicleNo
                                ])
                            }
                        }
                    }
//                    }
                }
            } else if (params.fdate && params.tdate && params.party && params.item) {
                data = LREntry.findAllByLrDateBetweenAndFromCustomerAndToCustomer(Date.parse("yyyy-MM-dd", params.fdate), Date.parse("yyyy-MM-dd", params.tdate), AccountMaster.findById(params.party), AccountMaster.findById(params.toParty));
                if (data) {
                    childData = [];
                    data.each { d ->
                        vehicleNo = "";
                        vehicleNo = (d?.vehicleNo?.state ?: "") + "-" + (d?.vehicleNo?.rto ?: "") + "-" + (d?.vehicleNo?.series ?: "") + " " + (d?.vehicleNo?.vehicleNo ?: "")
                        childData = LREntryDetails.findAllByLrEntryAndProductName(d as LREntry, ProductMaster.findById(params.item));
                        if (childData) {
                            childData.each { c ->
                                child.push([
                                        lrNo       : c?.lrEntry?.lrNo ?: "",
                                        lrDate     : c?.lrEntry?.lrDate?.format("dd-MM-yyyy") ?: "",
                                        productName: c?.productName ?: "",
                                        partyName  : c?.lrEntry?.fromCustomer?.accountName ?: "",
                                        fromAddress: c?.lrEntry?.fromCustomer?.address ?: "",
                                        toPartyName: c?.lrEntry?.toCustomer?.accountName ?: "",
                                        toAddress  : c?.lrEntry?.toCustomer?.accountName ?: "",
                                        invoiceNo  : c?.invoiceNo ?: "",
                                        invoiceQty : c?.invoiceQty ?: "",
                                        invoiceUnit: c?.unit?.unitName ?: "",
                                        unit       : c?.productName?.unit?.unitName ?: "",
                                        qty        : c?.qty ?: "",
                                        weight     : c?.weight ?: "",
                                        vehicleNo  : vehicleNo
                                ])
                            }
                        }
                    }
                }
            }

        }
        if (child) {
            reportDetails.push([
                    details : child,
                    fromDate: Date.parse("yyyy-MM-dd", params.fdate)?.format("dd-MM-yyyy"),
                    toDate  : Date.parse("yyyy-MM-dd", params.tdate)?.format("dd-MM-yyyy")
            ])
        }

        params._format = "PDF";
        params._file = "../reports/transactionReport/lrDatewise"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def vehiclewiseLRreport() {
        def reportDetails = [];
        def childData = [];
        def child = [];
        def vehicleNo = "";
        if (params.fdate && params.tdate && params.vehicle) {
            def data = LREntry.findAllByLrDateBetweenAndVehicleNo(Date.parse("yyyy-MM-dd", params.fdate), Date.parse("yyyy-MM-dd", params.tdate), VehicleMaster.findById(params.vehicle));
            if (data) {
                data.each { d ->
                    vehicleNo = "";
                    vehicleNo = (d?.vehicleNo?.state ?: "") + "-" + (d?.vehicleNo?.rto ?: "") + "-" + (d?.vehicleNo?.series ?: "") + " " + (d?.vehicleNo?.vehicleNo ?: "")
                    childData = LREntryDetails.findAllByLrEntry(d as LREntry);
                    if (childData) {
                        childData.each { c ->
                            child.push([
                                    lrNo       : c?.lrEntry?.lrNo ?: "",
                                    lrDate     : c?.lrEntry?.lrDate?.format("dd-MM-yyyy") ?: "",
                                    productName: c?.productName ?: "",
                                    partyName  : c?.lrEntry?.fromCustomer?.accountName ?: "",
                                    fromAddress: c?.lrEntry?.fromCustomer?.address ?: "",
                                    toPartyName: c?.lrEntry?.toCustomer?.accountName ?: "",
                                    toAddress  : c?.lrEntry?.toCustomer?.accountName ?: "",
                                    invoiceNo  : c?.invoiceNo ?: "",
                                    invoiceQty : c?.invoiceQty ?: "",
                                    invoiceUnit: c?.unit?.unitName ?: "",
                                    unit       : c?.productName?.unit?.unitName ?: "",
                                    qty        : c?.qty ?: "",
                                    weight     : c?.weight ?: "",
                                    vehicleNo  : vehicleNo
                            ])
                        }
                    }
                }
            }
            if (child) {
                reportDetails.push([
                        details : child,
                        fromDate: Date.parse("yyyy-MM-dd", params.fdate)?.format("dd-MM-yyyy"),
                        toDate  : Date.parse("yyyy-MM-dd", params.tdate)?.format("dd-MM-yyyy")
                ])
            }
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/lrDatewise"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def dateWiseVoucherReport() {
        def reportDetails = [];
        if (params.fdate && params.tdate) {
            def data = CashVoucher.findAllByVoucherDateBetween(Date.parse("yyyy-MM-dd", params.fdate), Date.parse("yyyy-MM-dd", params.tdate))
            if (data) {
                def child = [];
                data.each { d ->
                    child.push([
                            voucherNo   : d?.voucherNo ?: "",
                            date        : d?.voucherDate?.format("dd-MM-yyyy") ?: "",
                            paidTo      : d?.payTo ?: "",
                            amount      : d?.netAmount ?: "",
                            bankName    : d?.bankName?.bankName ?: "",
                            chequeNo    : d?.chequeNo ?: "",
                            vehicleNo   : d?.vehicleNo?.vehicleNo ?: (d?.vehicleNumber ?: ""),
                            description : d?.description ?: "",
                            pumpName    : d?.pumpName?.pumpName ?: "",
                            dieselAmount: d?.dieselAmount ?: ""
                    ])
                }
                if (child) {
                    reportDetails.push([
                            details : child,
                            fromDate: Date.parse("yyyy-MM-dd", params.fdate)?.format("dd-MM-yyyy"),
                            toDate  : Date.parse("yyyy-MM-dd", params.tdate)?.format("dd-MM-yyyy")
                    ])
                }
            }
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/datewiseCashVoucher"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def bankwiseVoucherReport() {
        def reportDetails = [];
        if (params.fdate && params.tdate && params.bank) {
            def data = CashVoucher.findAllByVoucherDateBetweenAndBankName(Date.parse("yyyy-MM-dd", params.fdate), Date.parse("yyyy-MM-dd", params.tdate), BankMaster.findById(params.bank as long))
            if (data) {
                def child = [];
                data.each { d ->
                    child.push([
                            voucherNo   : d?.voucherNo ?: "",
                            date        : d?.voucherDate?.format("dd-MM-yyyy") ?: "",
                            paidTo      : d?.payTo ?: "",
                            amount      : d?.netAmount ?: "",
                            bankName    : d?.bankName?.bankName ?: "",
                            chequeNo    : d?.chequeNo ?: "",
                            vehicleNo   : d?.vehicleNo?.vehicleNo ?: (d?.vehicleNumber ?: ""),
                            description : d?.description ?: "",
                            pumpName    : d?.pumpName?.pumpName ?: "",
                            dieselAmount: d?.dieselAmount ?: ""
                    ])
                }
                if (child) {
                    reportDetails.push([
                            details : child,
                            fromDate: Date.parse("yyyy-MM-dd", params.fdate)?.format("dd-MM-yyyy"),
                            toDate  : Date.parse("yyyy-MM-dd", params.tdate)?.format("dd-MM-yyyy")
                    ])
                }
            }
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/datewiseCashVoucher"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def chequewiseVoucherReport() {
        def reportDetails = [];
        if (params.cheque) {
            def data = CashVoucher.findAllByChequeNo(params.cheque)
            if (data) {
                def child = [];
                data.each { d ->
                    child.push([
                            voucherNo   : d?.voucherNo ?: "",
                            date        : d?.voucherDate?.format("dd-MM-yyyy") ?: "",
                            paidTo      : d?.payTo ?: "",
                            amount      : d?.netAmount ?: "",
                            bankName    : d?.bankName?.bankName ?: "",
                            chequeNo    : d?.chequeNo ?: "",
                            vehicleNo   : d?.vehicleNo?.vehicleNo ?: (d?.vehicleNumber ?: ""),
                            description : d?.description ?: "",
                            pumpName    : d?.pumpName?.pumpName ?: "",
                            dieselAmount: d?.dieselAmount ?: ""
                    ])
                }
                if (child) {
                    reportDetails.push([
                            details: child,
//                            fromDate:Date.parse("yyyy-MM-dd",params.fdate)?.format("dd-MM-yyyy"),
//                            toDate:Date.parse("yyyy-MM-dd",params.tdate)?.format("dd-MM-yyyy")
                    ])
                }
            }
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/datewiseCashVoucher"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def partywiseVoucherReport() {
        def reportDetails = [];
        if (params.party) {
            def data = CashVoucher.findAllByPayTo(params.party)
            if (data) {
                def child = [];
                data.each { d ->
                    child.push([
                            voucherNo   : d?.voucherNo ?: "",
                            date        : d?.voucherDate?.format("dd-MM-yyyy") ?: "",
                            paidTo      : d?.payTo ?: "",
                            amount      : d?.netAmount ?: "",
                            bankName    : d?.bankName?.bankName ?: "",
                            chequeNo    : d?.chequeNo ?: "",
                            vehicleNo   : d?.vehicleNo?.vehicleNo ?: (d?.vehicleNumber ?: ""),
                            description : d?.description ?: "",
                            pumpName    : d?.pumpName?.pumpName ?: "",
                            dieselAmount: d?.dieselAmount ?: ""
                    ])
                }
                if (child) {
                    reportDetails.push([
                            details: child
                    ])
                }
            }
        }
        params._format = "PDF";
        params._file = "../reports/transactionReport/datewiseCashVoucher"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def chequeList() {
        def result = [];
        result = CashVoucher.findAllByIsActiveAndChequeNoIsNotNull(true);
        render result as JSON;
    }
    def generateReport = {
        def reportModel = this.getProperties().containsKey('chainModel') ? chainModel : null
        def report = jasperService.buildReportDefinition(params, request.getLocale(), reportModel)
        generateResponse(report)
    }

    def generateResponse = { reportDef ->
        if (!reportDef.fileFormat.inline && !reportDef.parameters._inline) {
            //response.setHeader("Content-disposition", "attachment; filename=\"${reportDef.parameters._name ?: reportDef.name}.${reportDef.fileFormat.extension}\"");
            response.contentType = reportDef.fileFormat.mimeTyp
            response.characterEncoding = "UTF-8"
            response.outputStream << reportDef.contentStream.toByteArray()
            def lrInstance = [];
            def toMailId = "";
            lrInstance = LREntry.findById(params?.id)
            toMailId = lrInstance?.fromCustomer?.email ?: "rakesh.adak12@gmail.com";


            try {
                sendMail {
                    multipart true
                    to 'ganeshtransportpuneoffice@gmail.com'
//                    to 'rakeshadak137@gmail.com'
                    subject "Report From Ganesh Transport Created"
                    html "LR"
                    attachBytes 'lr.pdf', 'application/pdf', reportDef.contentStream.toByteArray()
                    if (lrInstance) {
                        html g.render(template: '/LREntry/mailTemplate', model: [LREntryInstance: lrInstance])
                    }
                }
            }
            catch (Exception e) {
                e.printStackTrace();
            }
            if (lrInstance.print_status == 0) {
                try {
                    sendMail {
                        multipart true
                        to toMailId
//                        to 'rakeshadak137@gmail.com'
                        subject "Report From Ganesh Transport Created"
                        html "LR"
                        attachBytes 'lr.pdf', 'application/pdf', reportDef.contentStream.toByteArray()
                    }

                    if (lrInstance) {
                        lrInstance.print_status = lrInstance.print_status + 1;
                        lrInstance.save(flush: true);

                    }
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
            }

        } else {
            render(text: reportDef.contentStream, contentType: reportDef.fileFormat.mimeTyp, encoding: reportDef.parameters.encoding ? reportDef.parameters.encoding : 'UTF-8');
        }
    }

    def billIssuedReport() {
        def reportDetails = [];
        def parent;
        def child = [];

        def data = BillAgainstLR.createCriteria().list {
            eq("branch", session['branch'])
            eq("isActive", true)

            if (params.fromParty) {
                eq("fromCompany", AccountMaster.findById(params.fromParty as Long))
            }

            if (params.toParty) {
                eq("toCompany", AccountMaster.findById(params.toParty as Long))
            }

            if (params.fromDate && params.toDate) {
                between("billDate", Date.parse("yyyy-MM-dd", params.fromDate), Date.parse("yyyy-MM-dd", params.toDate))
            } else if (params.fromDate) {
                ge("billDate", Date.parse("yyyy-MM-dd", params.fromDate))
            } else if (params.toDate) {
                le("billDate", Date.parse("yyyy-MM-dd", params.toDate))
            }
        }

        if (data) {
            data.each { d ->
                def childData = d?.billAgainstLRDetails;

                if (childData) {
                    childData.each { c ->
                        child.push([
                                lrNo            : c?.lrEntry?.lrNo ?: "",
                                lrDate          : c?.lrEntry?.lrDate?.format("dd-MM-yyyy") ?: "",
                                fromParty       : d?.fromCompany?.accountName ?: "",
                                fromPartyAddress: d?.fromCompany?.address ?: "",
                                toParty         : d?.toCompany?.accountName ?: "",
                                toPartyAddress  : d?.toCompany?.address ?: "",
                                billNo          : d?.billNo ?: "",
                                billDate        : d?.billDate?.format("dd-MM-yyyy") ?: ""
                        ]);
                    }
                }
            }
        }

        parent = [
                details  : child,
                fromParty: params.fromParty ? AccountMaster.findById(params.fromParty as Long)?.accountName : "",
                toParty  : params.toParty ? AccountMaster.findById(params.toParty as Long)?.accountName : "",
                fromDate : params.fromDate ? Date.parse("yyyy-MM-dd", params.fromDate)?.format("dd-MM-yyyy") : "",
                toDate   : params.toDate ? Date.parse("yyyy-MM-dd", params.toDate)?.format("dd-MM-yyyy") : ""
        ];

        reportDetails.push(parent);

        params._format = "PDF";
        params._file = "../reports/transactionReport/issued_pending_BillReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def billPendingReport() {
        def reportDetails = [];
        def parent;
        def child = [];

        def data = BillAgainstLRDetails.createCriteria().list {
            inList("billAgainstLR", BillAgainstLR.createCriteria().list {
                eq("branch", session['branch'])
                eq("isActive", true)

                if (params.fromParty) {
                    eq("fromCompany", AccountMaster.findById(params.fromParty as Long))
                }

                if (params.toParty) {
                    eq("toCompany", AccountMaster.findById(params.toParty as Long))
                }
            })
            projections {
                property("lrEntry.id")
            }
        }.unique();

        if (data) {
            def lrData = LREntry.createCriteria().list {
                eq("branch", session['branch'])
                eq("isActive", true)

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

                not {
                    'in'("id", data)
                }
            }
            if (lrData) {
                lrData.each { c ->
                    child.push([
                            lrNo            : c?.lrNo ?: "",
                            lrDate          : c?.lrDate?.format("dd-MM-yyyy") ?: "",
                            fromParty       : c?.fromCustomer?.accountName ?: "",
                            fromPartyAddress: c?.fromCustomer?.address ?: "",
                            toParty         : c?.toCustomer?.accountName ?: "",
                            toPartyAddress  : c?.toCustomer?.address ?: "",
                            billNo          : "",
                            billDate        : ""
                    ]);
                }
            }
        }

        parent = [
                details  : child,
                fromParty: params.fromParty ? AccountMaster.findById(params.fromParty as Long)?.accountName : "",
                toParty  : params.toParty ? AccountMaster.findById(params.toParty as Long)?.accountName : "",
                fromDate : params.fromDate ? Date.parse("yyyy-MM-dd", params.fromDate)?.format("dd-MM-yyyy") : "",
                toDate   : params.toDate ? Date.parse("yyyy-MM-dd", params.toDate)?.format("dd-MM-yyyy") : ""
        ];

        reportDetails.push(parent);

        params._format = "PDF";
        params._file = "../reports/transactionReport/issued_pending_BillReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def LRReceivedReport() {
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

        def parentData = LRReceivedEntry.createCriteria().list {
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
            eq("received", true)

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

        if (lrData) {
            data = LRReceivedEntryDetails.createCriteria().list {
                inList("lrEntry", lrData)

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
                        lrNo : d?.lrEntry?.lrNo?:"",
                        lrDate : d?.lrEntry?.lrDate?.format("dd-MM-yyyy")?:"",
                        vehicleNo : (d?.lrEntry?.vehicleNo?.state?:"")+" - "+(d?.lrEntry?.vehicleNo?.rto?:"")+
                                " "+(d?.lrEntry?.vehicleNo?.series?:"")+" "+(d?.lrEntry?.vehicleNo?.vehicleNo?:""),
                        goDown : d?.parent?.goDown?.godownName?:"",
                        fromParty       : d?.lrEntry?.fromCustomer?.accountName ?: "",
                        fromPartyAddress: d?.lrEntry?.fromCustomer?.address ?: "",
                        toParty         : d?.lrEntry?.toCustomer?.accountName ?: "",
                        toPartyAddress  : d?.lrEntry?.toCustomer?.address ?: "",
                ]);
            }
        }

        parent = [
                child : child,
                reportName : "LRReceivedReport_subreport1.jasper",
                fromParty: params.fromParty ? AccountMaster.findById(params.fromParty as Long)?.accountName : "",
                toParty  : params.toParty ? AccountMaster.findById(params.toParty as Long)?.accountName : "",
                fromDate : params.fromDate ? Date.parse("yyyy-MM-dd", params.fromDate)?.format("dd-MM-yyyy") : "",
                toDate   : params.toDate ? Date.parse("yyyy-MM-dd", params.toDate)?.format("dd-MM-yyyy") : "",
                vehicleNo: vehicleNo,
                goDown : ""
        ];

        reportDetails.push(parent);

        params._format = "PDF";
        params._file = "../reports/transactionReport/LRReceivedReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def LRReceivedGodownwiseReport() {
        def reportDetails = [];
        def parent;
        def child = [];
        def data = [];

        def parentData = LRReceivedEntry.createCriteria().list {
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

        data = LRReceivedEntryDetails.createCriteria().list {
            if(parentData) {
                inList("parent", parentData)
            }
        }

        if(!parentData) {
            data = [];
        }

        if (data) {
            data.each {d ->
                child.push([
                        receveNo : d?.parent?.srNo?:"",
                        receiveDate : d?.parent?.receiveDate?.format("dd-MM-yyyy")?:"",
                        lrNo : d?.lrEntry?.lrNo?:"",
                        lrDate : d?.lrEntry?.lrDate?.format("dd-MM-yyyy")?:"",
                        vehicleNo : (d?.lrEntry?.vehicleNo?.state?:"")+" - "+(d?.lrEntry?.vehicleNo?.rto?:"")+
                                " "+(d?.lrEntry?.vehicleNo?.series?:"")+" "+(d?.lrEntry?.vehicleNo?.vehicleNo?:""),
                        goDown : d?.parent?.goDown?.godownName?:"",
                        fromParty       : d?.lrEntry?.fromCustomer?.accountName ?: "",
                        fromPartyAddress: d?.lrEntry?.fromCustomer?.address ?: "",
                        toParty         : d?.lrEntry?.toCustomer?.accountName ?: "",
                        toPartyAddress  : d?.lrEntry?.toCustomer?.address ?: "",
                ]);
            }
        }

        parent = [
                child : child,
                reportName : "LRReceivedReport_subreport1.jasper",
                fromParty: params.fromParty ? AccountMaster.findById(params.fromParty as Long)?.accountName : "",
                toParty  : params.toParty ? AccountMaster.findById(params.toParty as Long)?.accountName : "",
                fromDate : params.fromDate ? Date.parse("yyyy-MM-dd", params.fromDate)?.format("dd-MM-yyyy") : "",
                toDate   : params.toDate ? Date.parse("yyyy-MM-dd", params.toDate)?.format("dd-MM-yyyy") : "",
                vehicleNo: "",
                goDown : params.goDown?GodownMaster.findById(params.goDown as Long):""
        ];

        reportDetails.push(parent);

        params._format = "PDF";
        params._file = "../reports/transactionReport/LRReceivedReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }

    def lrNotReceivedReport(){
        def reportDetails = [];
        def parent;
        def child = [];

        def data = LREntry.createCriteria().list {
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

        if (data) {
            data.each {d ->
                child.push([
                        lrNo : d?.lrNo?:"",
                        lrDate : d?.lrDate?.format("dd-MM-yyyy")?:"",
                        vehicleNo :(d?.vehicleNo?.state?:"")+" - "+(d?.vehicleNo?.rto?:"")+
                                " "+(d?.vehicleNo?.series?:"")+" "+(d?.vehicleNo?.vehicleNo?:""),
                        goDown : d?.goDown?.godownName?:"",
                        fromParty       : d?.fromCustomer?.accountName ?: "",
                        fromPartyAddress: d?.fromCustomer?.address ?: "",
                        toParty         : d?.toCustomer?.accountName ?: "",
                        toPartyAddress  : d?.toCustomer?.address ?: "",
                ]);
            }
        }

        parent = [
                child : child,
                reportName : "LRReceivedReport_subreport2.jasper",
                fromParty: params.fromParty ? AccountMaster.findById(params.fromParty as Long)?.accountName : "",
                toParty  : params.toParty ? AccountMaster.findById(params.toParty as Long)?.accountName : "",
                fromDate : params.fromDate ? Date.parse("yyyy-MM-dd", params.fromDate)?.format("dd-MM-yyyy") : "",
                toDate   : params.toDate ? Date.parse("yyyy-MM-dd", params.toDate)?.format("dd-MM-yyyy") : "",
                vehicleNo: params.vNo?VehicleMaster.findById(params.vNo as Long):"",
                goDown : params.goDown?GodownMaster.findById(params.goDown as Long):""
        ];

        reportDetails.push(parent);

        params._format = "PDF";
        params._file = "../reports/transactionReport/LRReceivedReport"
        params.SUBREPORT_DIR = "${servletContext.getRealPath('/reports/transactionReport')}/"
        params.IMAGE_DIR = "${servletContext.getRealPath('/images')}/"
        chain(controller: 'unitMaster', action: 'generateReport', model: [data: reportDetails], params: params);
    }
}
