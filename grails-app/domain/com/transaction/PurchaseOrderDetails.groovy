package com.transaction

import com.master.AccountMaster
import com.master.BillingTypeMaster
import org.codehaus.groovy.grails.web.json.JSONObject

class PurchaseOrderDetails {

    AccountMaster fromCustomer,toCustomer
    BigDecimal freight = 0.00
    BigDecimal loading = 0.00
    BigDecimal unLoading = 0.00
    BigDecimal collection = 0.00
    BigDecimal cartage = 0.00
    BigDecimal cata = 0.00
    BigDecimal bilty = 0.00
    BigDecimal doorDelivery = 0.00
    BigDecimal total = 0.00
    BigDecimal advance = 0.00
    BigDecimal haulting = 0.00
    BigDecimal balance = 0.00
    BigDecimal tripRate = 0.00
    BigDecimal amount = 0.00
    BillingTypeMaster billType

    static belongsTo = [purchaseOrder:PurchaseOrder]

    static constraints = {
        fromCustomer nullable: false
        toCustomer nullable: false
        freight nullable: true
        loading nullable: true
        unLoading nullable: true
        collection nullable: true
        cartage nullable: true
        cata nullable: true
        bilty nullable: true
        doorDelivery nullable: true
        total nullable: true
        advance nullable: true
        haulting nullable: true
        balance nullable: true
        tripRate nullable: true
        amount nullable: true
        billType nullable: true
    }

    static saveChildData(JSONObject st) {

        return new PurchaseOrderDetails(
               fromCustomer: AccountMaster.findById(st?.fromCustomerId as Long),
                toCustomer: AccountMaster.findById(st?.toCustomerId as Long),
                freight: st?.freight ? st?.freight as BigDecimal:0,
                loading: st?.loading ? st?.loading as BigDecimal:0,
                unLoading: st?.unLoading ? st?.unLoading as BigDecimal:0,
                collection: st?.collection ? st?.collection as BigDecimal:0,
                cartage: st?.cartage ? st?.cartage as BigDecimal:0,
                cata: st?.cata ? st.cata as BigDecimal:0,
                bilty: st?.bilty ? st.bilty as BigDecimal:0,
                doorDelivery: st?.doorDelivery ? st.doorDelivery as BigDecimal:0,
                total: st?.total ? st?.total as BigDecimal:0,
                advance: st?.advance ? st.advance as BigDecimal:0,
                haulting: st?.haulting ? st.haulting as BigDecimal:0,
                balance: st?.balance ? st.balance as BigDecimal:0,
                tripRate:st?.tripRate ? st.tripRate as BigDecimal:0,
                amount: st?.amount ? st?.amount as BigDecimal:0,
                billType:st?.billType ? BillingTypeMaster.findById(st?.billType as Long):null
        )
    }
}
