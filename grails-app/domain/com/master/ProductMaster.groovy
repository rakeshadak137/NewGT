package com.master

import com.system.User

class ProductMaster {


    String productCode
    String productName
    AccountMaster customerName
    String customerPartNo
    CategoryMaster category
    DivisionMaster division
    BillingTypeMaster billingType
    UnitMaster unit
    BigDecimal rate = 0
    String weightLn
    BigDecimal weight = 0
    BigDecimal od = 0
    BigDecimal thickNess = 0
    BigDecimal length = 0

    BranchMaster branch
    User lastUpdatedBy,createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear



    static constraints = {
        productName nullable: false
        productCode nullable: false
        customerName nullable: false
        customerPartNo nullable: true
        category nullable: true
        division nullable: false
        billingType nullable: true
        unit nullable: false
        rate ()
        weightLn nullable: true
        weight scale: 5
        od ()
        thickNess ()
        length ()

        createdBy display: false,nullable: false
        lastUpdatedBy display: false,nullable: true
        lastUpdated display: false,nullable: true
        dateCreated display: false,nullable: false
        isActive display: false,nullable: false
        financialYear display: false,nullable: false
        branch display:false,nullable: false
    }

    String toString(){
        productName
    }
}
