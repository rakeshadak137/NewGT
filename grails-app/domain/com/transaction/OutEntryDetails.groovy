package com.transaction

import com.master.ProductMaster
import com.master.UnitMaster
import org.codehaus.groovy.grails.web.json.JSONObject

class OutEntryDetails {
    String lrNo
    Date lrDate
    String invoiceNo
    BigDecimal invoiceQty
    UnitMaster invoiceUnit
    ProductMaster productName

    static belongsTo = [outEntry: OutEntry]

    static constraints = {
        lrNo nullable: false
        lrDate nullable: false
        invoiceNo nullable: false
        invoiceQty nullable: false
        invoiceUnit nullable: false
        productName nullable: false
    }

    static saveChildData(JSONObject st) {

        return new OutEntryDetails(
                lrNo: st.lrNo,
                lrDate: Date.parse("yyyy-MM-dd",st.lrDate),
                invoiceNo: st.invoiceNo,
                invoiceQty: st.invoiceQty as BigDecimal,
                invoiceUnit: st?.invoiceUnitId ? UnitMaster.findById(st.invoiceUnitId as Long):"",
                productName: st?.productId ? ProductMaster.findById(st.productId as long):""
        )
    }
}
