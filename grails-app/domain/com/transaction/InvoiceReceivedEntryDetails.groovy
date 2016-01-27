package com.transaction

import org.codehaus.groovy.grails.web.json.JSONObject

class InvoiceReceivedEntryDetails {
    LREntryDetails lrEntryDetails

    static belongsTo = [parent : InvoiceReceivedEntry]

    static constraints = {
        lrEntryDetails nullable: false
    }

    static saveChildData(JSONObject st) {

        return new InvoiceReceivedEntryDetails(
                lrEntryDetails: LREntryDetails.findById(st.id as Long)
        )
    }
}
