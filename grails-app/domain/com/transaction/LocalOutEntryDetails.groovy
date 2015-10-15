package com.transaction
import com.master.ProductMaster
import com.master.UnitMaster
import org.codehaus.groovy.grails.web.json.JSONObject

class LocalOutEntryDetails {

    ProductMaster productCode
    String invoiceNo
    String productName
    BigDecimal quantity
    UnitMaster unit

    static constraints = {

        productCode nullable: true
        productName nullable: true
        quantity nullable: true
        unit nullable: true
        invoiceNo nullable: true

    }

    static belongsTo = [localTripEntry:LocalTripEntry]

    static saveChildData(JSONObject st) {

        return new LocalOutEntryDetails(
                productCode:st?.productId ? ProductMaster.get(st.productId as Long):"",
                productName: st?.manualProductName ? st?.manualProductName :"",
                quantity: st?.qty ? st.qty as BigDecimal :0.00,
                unit: st?.unitName ? UnitMaster.get(st.unitName as Long): 0.00,
                invoiceNo: st?.invoiceNo?:""
        )
    }
}
