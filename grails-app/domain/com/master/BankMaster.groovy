package com.master

import com.system.User

class BankMaster {

    String bankName
    String accountNo
    String address
    User lastUpdatedBy, createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    BranchMaster branch
    static constraints = {
        bankName nullable: false
        accountNo nullable: true
        address nullable: true
        createdBy display: false
        lastUpdatedBy display: false
        lastUpdated display: false
        dateCreated display: false
        isActive display: false
        financialYear display: false
        branch display: false
    }

    String toString(){
        bankName
    }
}
