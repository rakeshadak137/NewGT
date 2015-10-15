package com.system

class Auditable {

    User lastUpdatedBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    String financialYear

    static constraints = {

        lastUpdatedBy nullable: true, display: false
        lastUpdated nullable: true
        dateCreated nullable: true
        isActive display: false
        financialYear nullable: false, display: false
    }

    static mapping = {
        tablePerHierarchy(false)
    }
}
