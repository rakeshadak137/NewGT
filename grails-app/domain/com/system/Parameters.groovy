package com.system

import com.master.BranchMaster
import com.master.FinancialYear

class Parameters {


    String lrPrefix,lrPostfix
    Integer lastLRNo,lastSMAutoBillNo,lastOthersBillNo
    String sMAutoBillNoPrefix,sMAutoBillNoPostfix
    String othersBillNoPrefix,othersBillNoPostfix

    User lastUpdatedBy, createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    BranchMaster branch
    static constraints = {

        lrPrefix nullable: true
        lrPostfix nullable: true
        lastLRNo nullable: true
        lastSMAutoBillNo nullable: true
        lastOthersBillNo nullable: true
        sMAutoBillNoPrefix nullable: true
        sMAutoBillNoPostfix nullable: true
        othersBillNoPrefix nullable: true
        othersBillNoPostfix nullable: true

        createdBy display: false
        lastUpdatedBy display: false
        lastUpdated display: false
        dateCreated display: false
        isActive display: false
        financialYear display: false
        branch display: false
    }
}
