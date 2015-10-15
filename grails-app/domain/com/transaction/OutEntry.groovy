package com.transaction

import com.master.AccountMaster
import com.master.BranchMaster
import com.master.FinancialYear
import com.master.GodownMaster
import com.system.User
import org.springframework.beans.PropertyEditorRegistrar
import org.springframework.beans.PropertyEditorRegistry
import org.springframework.beans.propertyeditors.CustomDateEditor

import java.text.SimpleDateFormat

class OutEntry implements PropertyEditorRegistrar{
    String voucherNo
    Date voucherDate
    AccountMaster fromCustomer, toCustomer
    GodownMaster godown
    Date outTime

//    String transportName
//    String driverName
//    String ownerName
//    String address
//    String phoneNo
    String vehicle

//    String dieselReceiptNo
//    Date dieselReceiptDate
//    BigDecimal dieselLtr
//    BigDecimal dieselRate
//    BigDecimal dieselAmount
//    String pumpName

//    BigDecimal freight
//    BigDecimal totalTripRate
//    BigDecimal advance
//    BigDecimal balance

    User lastUpdatedBy, createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    BranchMaster branch

    static hasMany = [outEntryDetails: OutEntryDetails]

    static constraints = {
        voucherNo nullable: false
        voucherDate nullable: false
        fromCustomer nullable: false
        toCustomer nullable: false
        godown nullable: false
        outTime nullable: true

//        transportName nullable: false
//        driverName nullable: false
//        ownerName nullable: true
//        address nullable: true
//        phoneNo nullable: true
        vehicle nullable: false

//        dieselReceiptNo nullable: true
//        dieselReceiptDate nullable: true
//        dieselLtr nullable: true
//        dieselRate nullable: true
//        dieselAmount nullable: true
//        pumpName nullable: true

//        freight nullable: false
//        totalTripRate nullable: false
//        advance nullable: true
//        balance nullable: true

        createdBy display: false
        lastUpdatedBy display: false,nullable: true
        lastUpdated display: false,nullable: true
        dateCreated display: false
        isActive display: false
        financialYear display: false
        branch display: false
    }

    @Override
    void registerCustomEditors(PropertyEditorRegistry registry) {
        registry.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true))
    }
}
