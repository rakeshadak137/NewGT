package com.system

import org.codehaus.groovy.grails.web.json.JSONObject

class RoleRights {

    Screen screen,module,subModule
    boolean canAdd, canUpdate, canDelete, canView, canPrint


    static constraints = {

        screen nullable: true
        module nullable: true
        subModule nullable: true
        canAdd()
        canDelete()
        canPrint()
        canUpdate()
        canView()
    }

    static belongsTo = [rights: Role]

    static saveRights(JSONObject screen) {

        return new RoleRights(

                screen: Screen.get(screen.screenId as Integer),
                module: Screen.get(screen.screenId as Integer),
                subModule: Screen.get(screen.screenId as Integer),
                canAdd: screen.canAdd,
                canUpdate: screen.canUpdate,
                canDelete: screen.canDelete,
                canView: screen.canView,
                canPrint: screen.canPrint,
        )

    }
}
