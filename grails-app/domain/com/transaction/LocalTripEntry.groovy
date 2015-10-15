package com.transaction

import com.master.*
import com.system.User

class LocalTripEntry {

    String localOutEntryNo
    Date localOutEntryDate
    AccountMaster fromCustomer, toCustomer
    GodownMaster godown
    Date localOutTime
    PurchaseOrder poNo

    String transportName
    String driverName
    String ownerName
    String address
    String phoneNo
    VehicleMaster vehicleNo
    String vehicleManual

//    String dieselReceiptNo
//    Date dieselReceiptDate
//    BigDecimal dieselLtr
//    BigDecimal dieselRate
//    BigDecimal dieselAmount
//    String pumpName

//    BigDecimal freight
    BigDecimal totalTripRate
    BigDecimal advance
    BigDecimal balance

    User lastUpdatedBy, createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    BranchMaster branch
    static constraints = {

        localOutEntryNo nullable: false
        localOutEntryDate nullable: false
        localOutTime nullable: true
        fromCustomer nullable: false
        toCustomer nullable: false
        godown nullable: false
        localOutTime nullable: true
        poNo nullable: true

        transportName nullable: true
        driverName nullable: true
        ownerName nullable: true
        address nullable: true
        phoneNo nullable: true
        vehicleNo nullable: true
        vehicleManual nullable: true

//        dieselReceiptNo nullable: true
//        dieselReceiptDate nullable: true
//        dieselLtr nullable: true
//        dieselRate nullable: true
//        dieselAmount nullable: true
//        pumpName nullable: true

//        freight nullable: true
        totalTripRate nullable: false
        advance nullable: true
        balance nullable: true

        createdBy display: false
        lastUpdatedBy display: false
        lastUpdated display: false
        dateCreated display: false
        isActive display: false
        financialYear display: false
        branch display: false
    }

    static hasMany = [localOutEntryDetails:LocalOutEntryDetails]
}
