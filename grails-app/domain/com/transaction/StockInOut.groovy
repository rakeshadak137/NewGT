package com.transaction

import com.master.*
import com.system.User

class StockInOut {
    String lrNo
    Date lrDate
    VehicleMaster vehicle
    GodownMaster godown
    DivisionMaster divisionName
    ProductMaster productName

    String invoiceNo
    AccountMaster fromCustomer, toCustomer
    BigDecimal invoiceQty
    String status
    Date inDate
    Date outDate
    UnitMaster invoiceUnit

    User lastUpdatedBy, createdBy
    FinancialYear financialYear
    BranchMaster branch

    static constraints = {
        lrNo nullable: false
        lrDate nullable: false
        vehicle nullable: true
        godown nullable: false
        divisionName nullable: true
        productName nullable: true

        invoiceNo nullable: false
        invoiceUnit nullable: false
        fromCustomer nullable: false
        toCustomer nullable: false
        invoiceQty nullable: false
        status  nullable: false, inList: ['IN','OUT']
        inDate nullable: false
        outDate nullable: true

        createdBy display: false
        lastUpdatedBy display: false
        financialYear display: false
        branch display: false
    }
}
