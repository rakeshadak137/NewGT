package com.transaction

import org.codehaus.groovy.grails.web.json.JSONObject

class CashVoucherChild {
    InternalMemo memoNo
//    String vehicleNo
//    BigDecimal balanceAmount=0
    BigDecimal dieselLtr=0
    BigDecimal dieselAmount=0
    BigDecimal balance=0
    Date memoDate
    BigDecimal totalAmount=0

    static constraints = {
        memoNo nullable: true
//        vehicleNo nullable: true
        memoDate nullable: true
    }

    static belongsTo = [cashVoucher:CashVoucher]

    static saveChildData(JSONObject st) {

        return new CashVoucherChild(
                memoNo:st?.id?InternalMemo.get(st?.id):null,
                memoDate: st?.memoDate?Date.parse("yyyy-MM-dd",st.memoDate):"",
                dieselLtr:st?.ltr?:0,
                dieselAmount:st?.dieselAmt?:0,
                balance:st?.balance?:0,
                totalAmount: st?.amount?st?.amount:0
        )
    }
}

