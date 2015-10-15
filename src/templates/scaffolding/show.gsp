<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-${domainClass.propertyName}" class="content scaffold-show" role="main">
            <div class="table-header">
                <g:message code="default.show.label" args="[entityName]"/>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        action="list"><i
                        class="icon-ok bigger-50"></i> List</g:link>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        action="create">
                    <i class="icon-pencil bigger-50"></i>New
                </g:link>

            </div>
            <g:if test="\${flash.message}">
                <div class="message" role="status">\${flash.message}</div>
            </g:if>
            <div style="margin-left: 50px; margin-right: 50px;" class="widget-main padding-8">
                <ol class="property-list ${domainClass.propertyName}">
                    <% excludedProps = Event.allEvents.toList() << 'id' << 'version'
                    allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
                    props = domainClass.properties.findAll {
                        allowedNames.contains(it.name) && !excludedProps.contains(it.name)
                    }
                    Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                    props.each { p -> %>
                    <g:if test="\${${propertyName}?.${p.name}}">
                        <li class="fieldcontain">
                            <span id="${p.name}-label" class="property-label"><g:message
                                    code="${domainClass.propertyName}.${p.name}.label"
                                    default="${p.naturalName}"/></span> :-
                        <% if (p.isEnum()) { %>
                            <span class="property-value" aria-labelledby="${p.name}-label"><g:fieldValue
                                    bean="\${${propertyName}}" field="${p.name}"/></span>
                            <% } else if (p.oneToMany || p.manyToMany) { %>
                            <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
                                <span class="property-value" aria-labelledby="${p.name}-label">
                                    \${${p.name[0]}?.encodeAsHTML()}
                                </span>
                            </g:each>
                            <% } else if (p.manyToOne || p.oneToOne) { %>
                            <span class="property-value" aria-labelledby="${p.name}-label">
                                \${${propertyName}?.${p.name}?.encodeAsHTML()}</span>
                            <% } else if (p.type == Boolean || p.type == boolean) { %>
                            <span class="property-value" aria-labelledby="${p.name}-label"><g:formatBoolean
                                    boolean="\${${propertyName}?.${p.name}}"/></span>
                            <%
                                } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
                            <span class="property-value" aria-labelledby="${p.name}-label"><g:formatDate
                                    date="\${${propertyName}?.${p.name}}"/></span>
                            <% } else if (!p.type.isArray()) { %>
                            <span class="property-value" aria-labelledby="${p.name}-label"><g:fieldValue
                                    bean="\${${propertyName}}" field="${p.name}"/></span>
                            <% } %>
                        </li>
                    </g:if>
                    <% } %>
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="id" value="\${${propertyName}?.id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="\${${propertyName}?.id}"><g:message
                                code="default.button.edit.label" default="Edit"/></g:link>
                        <g:actionSubmit class="btn btn-info btn-small" action="delete"
                                        value="\${message(code: 'default.button.delete.label', default: 'Delete')}"
                                        onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                    </fieldset>
                </g:form>
            </div>
        </div>
        <g:render template="/shared/viewFooter"/>
    </div>
</div>

</body>
</html>
