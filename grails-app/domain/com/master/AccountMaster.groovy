package com.master

import com.system.User

class AccountMaster {

    String accountName
    String address
    States state
    CityMaster city
    String phoneNo
    String mobileNo
    String pinCode,email
    String contactPerson,contactMobile,contactEmail
    String tinNo,cstNo
    BillingTypeMaster billType

    BranchMaster branch
    User lastUpdatedBy,createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    static constraints = {

        accountName nullable: false
        address nullable: false
        state nullable: false
        phoneNo nullable: true
        mobileNo nullable: true
        pinCode nullable: true
        email nullable: true
        contactPerson nullable: true
        contactMobile nullable: true
        contactMobile nullable: true
        tinNo nullable: true
        cstNo nullable: true
        billType nullable: true

        branch display:false,nullable: false
        createdBy display: false,nullable: false
        lastUpdatedBy display: false,nullable: true
        lastUpdated display: false,nullable: true
        dateCreated display: false,nullable: false
        isActive display: false,nullable: false
        financialYear display: false,nullable: false
    }

    String toString(){
        accountName
    }
}
