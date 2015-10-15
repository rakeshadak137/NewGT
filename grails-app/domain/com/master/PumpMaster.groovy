package com.master

import com.system.User

class PumpMaster {
    String pumpName
    BigDecimal dieselRate

    User lastUpdatedBy, createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    BranchMaster branch
    static constraints = {
        pumpName nullable: false
        dieselRate nullable: false

        branch display:false,nullable: false
        createdBy display: false,nullable: false
        lastUpdatedBy display: false,nullable: true
        lastUpdated display: false,nullable: true
        dateCreated display: false,nullable: false
        isActive display: false,nullable: false
        financialYear display: false,nullable: false
    }
}
