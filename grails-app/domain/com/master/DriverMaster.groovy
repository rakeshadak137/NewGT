package com.master

import com.system.User

class DriverMaster {
    String driverName
    String driverId
    String address
    String mobileNo

    BranchMaster branch
    User lastUpdatedBy,createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear

    static constraints = {
        driverName nullable: false
        driverId nullable: true
        address nullable: true
        mobileNo nullable: true

        branch display:false,nullable: false
        createdBy display:false,nullable: false
        lastUpdatedBy display:false,nullable: true
        lastUpdated display:false,nullable: true
        dateCreated display:false,nullable: false
        isActive display:false,nullable: false
        financialYear display:false,nullable: false

    }

    String toString(){
        driverName
    }
}
