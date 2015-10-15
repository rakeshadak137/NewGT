package com.master

class FinancialYear {
    String year

    static constraints = {
        year nullable: false

    }

    String toString() {
        year
    }
}
