package com.template

import com.master.AccountMaster
import com.system.Auditable
import org.springframework.beans.PropertyEditorRegistrar

//import com.master.Department
//import com.master.YearAndClass
import org.springframework.beans.PropertyEditorRegistry
import org.springframework.beans.propertyeditors.CustomDateEditor

import java.text.SimpleDateFormat

class SendMail extends Auditable implements PropertyEditorRegistrar{

    AccountMaster department
//    YearAndClass classOnly

    String mailTo
    String mailSubject
    String mailBody
    String mobileNo

    String attachment

    static constraints = {
        department nullable: true
//        classOnly nullable: true

        mailTo nullable: true
        mailSubject nullable: true
        mailBody nullable: true
        mobileNo nullable: true

        attachment nullable: true
    }
    @Override
    void registerCustomEditors(PropertyEditorRegistry registry) {
        registry.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true))
    }
}
