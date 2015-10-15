package com.template

class ChildTemplate  {
    String name
    String description

    static belongsTo = [parent:Template]

    static constraints = {
        name blank: false
        description blank: false
    }

    static buildFromJSON(org.codehaus.groovy.grails.web.json.JSONObject tempDet) {
        return new ChildTemplate(
                name: tempDet.templateName,
                description: tempDet.description
        );
    }
}
