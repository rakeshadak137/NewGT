package com.transaction

import com.master.ProductMaster
import com.master.UnitMaster
import org.codehaus.groovy.grails.web.json.JSONObject

class BillAgainstLRDetails {
    LREntry lrEntry
    String lrNo
    ProductMaster product
    BigDecimal qty
    BigDecimal rate
    UnitMaster unit
    String customerPartNo
    BigDecimal wtPiece
    BigDecimal totalWeight
    BigDecimal amount

    static belongsTo = [billAgainstLR:BillAgainstLR]

    static constraints = {
        lrEntry nullable: false
        lrNo nullable: false
        product nullable: false
        qty nullable: false,min: 0.0
        rate nullable: false,min: 0.0
        unit nullable: false
        customerPartNo nullable: true
        wtPiece nullable: false,min: 0.0,scale: 5
        totalWeight nullable: false,min: 0.0,scale: 5
        amount nullable: false,min: 0.0
    }

    static saveChildData(JSONObject st) {

        return new BillAgainstLRDetails(
                lrEntry: LREntry.findById(st.lrId as Long),
                lrNo: st.lrNo,
                product: ProductMaster.findById(st.itemId as Long),
                qty: st.qty as BigDecimal,
                rate: st.rate as BigDecimal,
                unit: UnitMaster.findById(st.unitId as Long),
                customerPartNo: st.customerPartNo,
                wtPiece: st.wtPiece as BigDecimal,
                totalWeight: st.totalWeight as BigDecimal,
                amount: st.amount as BigDecimal
        )
    }
}
