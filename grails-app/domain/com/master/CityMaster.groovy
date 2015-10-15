package com.master

import com.system.User

class CityMaster {
    String cityName
    String pinCode

    BranchMaster branch
    User lastUpdatedBy,createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear

    static constraints = {
        cityName nullable: false
        pinCode nullable: true

        branch display:false,nullable: false
        createdBy display:false,nullable: false
        lastUpdatedBy display:false,nullable: true
        lastUpdated display:false,nullable: true
        dateCreated display:false,nullable: false
        isActive display:false,nullable: false
        financialYear display:false,nullable: false
    }

    String toString(){
        cityName
    }
}
