package com.transaction

import com.master.BranchMaster
import com.master.FinancialYear
import com.master.PumpMaster
import com.master.VehicleMaster
import com.system.User
import org.springframework.beans.PropertyEditorRegistrar
import org.springframework.beans.PropertyEditorRegistry
import org.springframework.beans.propertyeditors.CustomDateEditor

import java.text.SimpleDateFormat

class InternalMemo implements PropertyEditorRegistrar{
    VehicleMaster vehicleNo // For Searching Only
    Date fromDate, toDate // For Searching Only

    String voucherNo
    Date voucherDate

    String transportName
    String driverName
    String ownerName
    String address
    String phoneNo

    String dieselReceiptNo
    Date dieselReceiptDate
    BigDecimal dieselLtr
    BigDecimal dieselRate
    BigDecimal dieselAmount
    PumpMaster pumpName

    String vehicleNumber
    BigDecimal freight
    BigDecimal totalTripRate
    BigDecimal advance
    BigDecimal balance
    int print_status=0
    boolean isCleared=false

    User lastUpdatedBy,createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    BranchMaster branch

    static hasMany = [internalMemoDetails:InternalMemoDetails]

    static constraints = {
        vehicleNo nullable: false
        fromDate nullable: false
        toDate nullable: false
        voucherNo nullable: false
        voucherDate nullable: false

        transportName nullable: false
        driverName nullable: true
        ownerName nullable: true
        address nullable: true
        phoneNo nullable: true

        dieselReceiptNo nullable: true
        dieselReceiptDate nullable: true
        dieselLtr nullable: true
        dieselRate nullable: true
        dieselAmount nullable: true
        pumpName nullable: true

        vehicleNumber nullable: false
        freight nullable: false
        totalTripRate nullable: false
        advance nullable: false
        balance nullable: false

        createdBy display: false
        lastUpdatedBy display: false,nullable: true
        lastUpdated display: false
        dateCreated display: false
        isActive display: false
        financialYear display: false
        branch display: false
    }

    @Override
    void registerCustomEditors(PropertyEditorRegistry registry) {
        registry.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true))
    }
}
