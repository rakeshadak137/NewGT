package com.system

class Screen {

    String name, controller, filter, domainName
    Screen parentScreen

    static constraints = {
        name nullable: true
        controller nullable: true
        parentScreen nullable: true
        filter nullable: true
        domainName nullable: true
    }

    static getScreenById(userScreenRights, parentScreenId) {

        def screens = [];
        if (userScreenRights.size == 0) return;
        try {
            def screenId = userScreenRights.collect({ p -> p.screenId });
            StringBuilder sb = new StringBuilder();
            boolean needSep = false
            screenId.each { p ->
                if (needSep) sb.append(',');
                sb.append(p)
                needSep = true;
            }

            //String hql =
            screens = Screen.findAll("from Screen s where s.parentScreen.id=" + parentScreenId + " and s.id in (" + sb + ")");
        } catch (Exception e) {
            println e
        }
        return screens;
    }
}
