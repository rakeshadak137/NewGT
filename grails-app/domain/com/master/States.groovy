package com.master

import com.system.User

class States {
    String stateName

    BranchMaster branch
    User lastUpdatedBy,createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear

    static constraints = {
        stateName nullable: false

        branch display:false,nullable: false
        createdBy display:false,nullable: false
        lastUpdatedBy display:false,nullable: true
        lastUpdated display:false,nullable: true
        dateCreated display:false,nullable: false
        isActive display:false,nullable: false
        financialYear display:false,nullable: false
    }

    String toString(){
        stateName
    }
}
