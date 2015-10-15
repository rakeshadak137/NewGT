package com.transaction

import com.master.AccountMaster
import com.master.BranchMaster
import com.master.FinancialYear
import com.system.User
import org.springframework.beans.PropertyEditorRegistrar
import org.springframework.beans.PropertyEditorRegistry
import org.springframework.beans.propertyeditors.CustomDateEditor

import java.text.SimpleDateFormat

class PurchaseOrder implements PropertyEditorRegistrar{

    String poNo
    Date poDate
    AccountMaster customer
    String poType


    User lastUpdatedBy, createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    BranchMaster branch

    static hasMany = [purchaseOrderDetails:PurchaseOrderDetails]

    static constraints = {
        poNo nullable: false
        poDate nullable: false
        customer nullable: false
        poType inList: ['Original','Dummy'],nullable: false

        createdBy display: false,nullable: false
        lastUpdatedBy display: false,nullable: true
        lastUpdated display: false,nullable: true
        dateCreated display: false,nullable: false
        isActive display: false,nullable: false
        financialYear display: false,nullable: false
        branch display: false,nullable: false
    }

    @Override
    void registerCustomEditors(PropertyEditorRegistry registry) {
        registry.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true))
    }
}
