package com.transaction

import annotation.ParentScreen

@ParentScreen(name = "Report", subUnder = "Report", fullName = "Voucher Report")
class CashVoucherReportController {

    def index() {
      render(view:"voucherReport")
    }
}
