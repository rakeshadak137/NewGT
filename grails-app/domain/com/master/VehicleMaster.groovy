package com.master

import com.system.User

class VehicleMaster {
    String vehicleNo
    String vehicleType
    String companyName
    String ownerName
    String mobileNo
    String state
    String rto
    String series

    BranchMaster branch
    User lastUpdatedBy,createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear

    static constraints = {
        vehicleNo nullable: false
        vehicleType nullable: true
        companyName nullable: true
        ownerName nullable: true
        mobileNo nullable: true
        state nullable: true
        rto nullable: true
        series nullable: true

        branch display:false,nullable: false
        createdBy display:false,nullable: false
        lastUpdatedBy display:false,nullable: true
        lastUpdated display:false,nullable: true
        dateCreated display:false,nullable: false
        isActive display:false,nullable: false
        financialYear display:false,nullable: false
    }

    String toString(){
        vehicleNo
    }
}
