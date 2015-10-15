import com.master.BranchMaster
import com.master.FinancialYear
import com.system.User

class @artifact.name@ {

    User lastUpdatedBy,createdBy
    Date lastUpdated
    Date dateCreated
    Boolean isActive = true
    FinancialYear financialYear
    BranchMaster branch
    static constraints = {
        createdBy display:false
        lastUpdatedBy display:false
        lastUpdated display:false
        dateCreated display:false
        isActive display:false
        financialYear display:false
        branch display: false
    }
}
