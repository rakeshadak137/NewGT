package com.transaction

import com.master.*
import com.system.User

class CashVoucher {
   Integer voucherNo
   Date voucherDate
   String voucherType
   VehicleMaster vehicleNo
   BigDecimal netAmount=0
   String paymentType
   String payTo
   String vehicleNumber
    CustomerMaster customerName

    //for diesel voucher
    PumpMaster pumpName
    String dieselReceiptNo
    Date dieselReceiptDate
    BigDecimal dieselLtr=0
    BigDecimal dieselRate=0
    BigDecimal dieselAmount=0

    //for bank Voucher
    BankMaster bankName
    String chequeNo
    String description

    User lastUpdatedBy, createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    BranchMaster branch
    static constraints = {
        voucherType nullable: false
        vehicleNo nullable: true
        paymentType nullable: true
        pumpName nullable: true
        dieselReceiptNo nullable: true
        dieselReceiptDate nullable: true
        bankName nullable: true
        chequeNo nullable: true
        description nullable: true
        payTo nullable: true
        vehicleNumber nullable: true
        customerName nullable: true

        createdBy display: false
        lastUpdatedBy display: false
        lastUpdated display: false
        dateCreated display: false
        isActive display: false
        financialYear display: false
        branch display: false
    }

    static hasMany = [cashVoucherChilds:CashVoucherChild]
}
