package com.transaction

import com.master.*
import com.system.User
import org.springframework.beans.PropertyEditorRegistrar
import org.springframework.beans.PropertyEditorRegistry
import org.springframework.beans.propertyeditors.CustomDateEditor

import java.text.SimpleDateFormat

class LREntry implements PropertyEditorRegistrar{
    String lrNo
    Date lrDate
    VehicleMaster vehicleNo
    DriverMaster driverName
    String poNO
    PurchaseOrderDetails poID
    AccountMaster fromCustomer
    AccountMaster toCustomer
    String fromLocation,toLocation,fromAddress,toAddress,fCustomer,tCustomer
    String billPayType
    String particular
    BigDecimal amount = 0.00
    BigDecimal totalAmount = 0.00
    BigDecimal grandTotal = 0.00
    GodownMaster goDown

    BigDecimal freight
    BigDecimal loading
    BigDecimal unloading
    BigDecimal collection
    BigDecimal cartage
    BigDecimal cata
    BigDecimal bilty
    BigDecimal doorDelivery

    Boolean billingTypeTo=false
    int print_status=0
    String lcNo
    String invoiceNo,invoiceAmount

    Boolean received = false;

    User lastUpdatedBy, createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    BranchMaster branch

    static hasMany = [lrEntryDetails:LREntryDetails]

    static constraints = {
        lrNo nullable: false
        lrDate nullable: false
        vehicleNo nullable: false
        driverName nullable: false

        poNO nullable: true
        poID nullable: true

        fromCustomer nullable: true
        toCustomer nullable: true

        fCustomer nullable: true
        tCustomer nullable: true

        fromLocation nullable: false
        toLocation nullable: false

        fromAddress nullable: true
        toAddress nullable: true

        billPayType nullable: false,inList: ['Paid','To Be Billed','To Pay']
        particular nullable: true
        amount nullable: true
        totalAmount nullable: false
        grandTotal nullable: false

        freight nullable: false,min: 0.0
        loading nullable: false,min: 0.0
        unloading nullable: false,min: 0.0
        collection nullable: false,min: 0.0
        cartage nullable: false,min: 0.0
        cata nullable: false,min: 0.0
        bilty nullable: false,min: 0.0
        doorDelivery nullable: false,min: 0.0
        lcNo nullable: true
        invoiceNo nullable: true
        invoiceAmount nullable: true

        createdBy display: false,nullable: false
        lastUpdatedBy display: false,nullable: true
        lastUpdated display: false,nullable: true
        dateCreated display: false,nullable: false
        isActive display: false,nullable: false
        financialYear display: false,nullable: false
        branch display: false,nullable: false
    }

    @Override
    void registerCustomEditors(PropertyEditorRegistry registry) {
        registry.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true))
    }
}
