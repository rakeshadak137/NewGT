package com.template

import com.system.Auditable

class TemplateSubject extends Auditable {
    String name

    static constraints = {
        name blank: false,nullable: false,unique: true
    }
    String toString(){
        name
    }
}
