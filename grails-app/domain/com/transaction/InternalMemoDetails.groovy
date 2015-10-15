package com.transaction

import com.master.AccountMaster
import com.master.UnitMaster
import org.codehaus.groovy.grails.web.json.JSONObject

class InternalMemoDetails {
    String lrNo
    Date lrDate
    AccountMaster fromCustomer, toCustomer
    LREntryDetails lrChild
    String invoiceNo
    BigDecimal qty
    UnitMaster unit

    static belongsTo = [internalMemo:InternalMemo]

    static constraints = {
        lrNo nullable: false
        lrDate nullable: false
        lrChild nullable: false
        invoiceNo nullable: false
        fromCustomer nullable: false
        toCustomer nullable: false
        qty nullable: false
        unit nullable: false
    }

    static saveChildData(JSONObject st) {

        return new InternalMemoDetails(
                lrNo: st.lrNo,
                lrDate: st.lrDate,
                fromCustomer: AccountMaster.findById(st.fromCustomerId as Long),
                toCustomer: AccountMaster.findById(st.toCustomerId as Long),
                lrChild: LREntryDetails.findById(st.lrChild as Long),
                invoiceNo: st.invoiceNo,
                qty: st.totalQty as BigDecimal,
                unit: UnitMaster.findById(st.unitId as Long)
        )
    }
}
