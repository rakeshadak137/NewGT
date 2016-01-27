package com.master

import com.system.User

class CustomerMaster {
    String name
    String address
    String mobileNo

    User lastUpdatedBy, createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    BranchMaster branch

    static constraints = {
        name nullable: false
        address nullable: true
        mobileNo nullable: true

        branch display:false,nullable: false
        createdBy display: false,nullable: false
        lastUpdatedBy display: false,nullable: true
        lastUpdated display: false,nullable: true
        dateCreated display: false,nullable: false
        isActive display: false,nullable: false
        financialYear display: false,nullable: false

        createdBy display: false
        lastUpdatedBy display: false
        lastUpdated display: false
        dateCreated display: false
        isActive display: false
        financialYear display: false
        branch display: false
    }
}
