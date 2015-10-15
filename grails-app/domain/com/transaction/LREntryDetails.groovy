package com.transaction

import com.master.ProductMaster
import com.master.UnitMaster
import org.codehaus.groovy.grails.web.json.JSONObject

class LREntryDetails {
    ProductMaster productName
    String invoiceNo
    BigDecimal qty = 0
    UnitMaster unit
    BigDecimal invoiceQty = 0
    UnitMaster invoiceUnit
    BigDecimal rate = 0.00
    BigDecimal weight = 0.00
    BigDecimal totalAmount

    static belongsTo = [lrEntry:LREntry]

    static constraints = {
        productName nullable: false
        invoiceNo nullable: false
        qty nullable: false
        unit nullable: false
        invoiceQty nullable: false
        invoiceUnit nullable: false
        rate nullable: false
        weight nullable: false,scale: 5
        totalAmount nullable: false

    }

    static saveChildData(JSONObject st) {

        return new LREntryDetails(
                productName: ProductMaster.findById(st.productId as Long),
                invoiceNo: st.invoiceNo,
                qty: st.qty as BigDecimal,
                unit: UnitMaster.findById(st.unitId as Long),
                invoiceQty: st.invoiceQty as BigDecimal,
                invoiceUnit: UnitMaster.findById(st.invoiceUnitId as Long),
                rate: st.rate as BigDecimal,
                weight: st.weight as BigDecimal,
                totalAmount: st.tAmount as BigDecimal
        )
    }
}
