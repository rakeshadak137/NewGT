package com.transaction

import com.master.AccountMaster
import com.master.BranchMaster
import com.master.FinancialYear
import com.system.User
import org.springframework.beans.PropertyEditorRegistrar
import org.springframework.beans.PropertyEditorRegistry
import org.springframework.beans.propertyeditors.CustomDateEditor

import java.text.SimpleDateFormat

class BillAgainstLR implements PropertyEditorRegistrar{
    String billNo
    Date billDate
    Date fromDate
    Date toDate
    AccountMaster company, fromCompany, toCompany
    String vehicleNo
    String poNo
    Date poDate
    BigDecimal totalAmount

    User lastUpdatedBy, createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    BranchMaster branch

    static hasMany = [billAgainstLRDetails:BillAgainstLRDetails]

    static constraints = {
        billNo nullable: false
        billDate nullable: false
        fromDate nullable: false
        toDate nullable: false
        company nullable: false
        fromCompany nullable: false
        toCompany nullable: false
        vehicleNo nullable: true
        poNo nullable: true
        poDate nullable: true
        totalAmount nullable: false, min: 0.0

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
