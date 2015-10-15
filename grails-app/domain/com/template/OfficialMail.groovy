package com.template

//import com.employee.Appointment
//import com.employee.StaffDepartment
import com.master.AccountMaster
import com.system.User

class OfficialMail {

    User assignBy
    Date publishDate, publishEndDate
    AccountMaster assignTo
    String subject, description
    String attachment

    static constraints = {
        assignBy nullable: false
        publishDate nullable: false
        publishEndDate nullable: true
        assignTo nullable: false
        subject nullable: false
        description nullable: true
        attachment nullable: true
    }
}
