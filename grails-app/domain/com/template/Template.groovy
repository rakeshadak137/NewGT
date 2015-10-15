package com.template

import com.system.Auditable

class Template extends Auditable {
    TemplateSubject subject

    static hasMany = [childs:ChildTemplate]
    static constraints = {
        subject()
    }
}
