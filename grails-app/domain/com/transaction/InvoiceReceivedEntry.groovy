package com.transaction

import com.master.BranchMaster
import com.master.FinancialYear
import com.master.GodownMaster
import com.system.User

class InvoiceReceivedEntry {
    Date receiveDate
    GodownMaster goDown
    Integer srNo=0

    User lastUpdatedBy, createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    BranchMaster branch

    static hasMany = [child : InvoiceReceivedEntryDetails]

    static constraints = {
        receiveDate nullable: false
        goDown nullable: false

        createdBy display: false
        lastUpdatedBy display: false,nullable: true
        lastUpdated display: false,nullable: true
        dateCreated display: false
        isActive display: false
        financialYear display: false
        branch display: false
    }
}
