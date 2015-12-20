package com.transaction

import org.codehaus.groovy.grails.web.json.JSONObject

class LRReceivedEntryDetails {
    LREntry lrEntry

    static belongsTo = [parent : LRReceivedEntry]

    static constraints = {
        lrEntry nullable: false
    }

    static saveChildData(JSONObject st) {

        return new LRReceivedEntryDetails(
               lrEntry: LREntry.findById(st.id as Long)
        )
    }
}
