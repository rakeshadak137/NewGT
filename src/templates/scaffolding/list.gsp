<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>
    <div class="row-fluid" style="margin-left:30px; width:95%; margin-top: 15px;">
        %{--<div class="row-fluid" style="margin-left:30px; width:95%">--}%
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%

        <div id="list-${domainClass.propertyName}" class="content scaffold-list" role="main">
            <div class="table-header">
                <g:message code="default.list.label" args="[entityName]"/>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        action="create">
                    <i class="icon-pencil bigger-50"></i>New
                </g:link>
            </div>
            <g:if test="\${flash.message}">
                <div class="message" role="status">\${flash.message}</div>
            </g:if>
            <div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">
                <div class="row-fluid">
                    <div class="span6">
                        <div id="sample-table-2_length" class="dataTables_length">
                            <label>Display <select name="sample-table-2_length" size="1" aria-controls="sample-table-2">
                                <option value="10" selected="selected">10</option><option value="25">25</option>
                                <option value="50">50</option><option value="100">100</option>
                            </select> records</label>
                        </div>
                    </div>

                    <div class="span6">
                        <div class="dataTables_filter" id="sample-table-2_filter">
                            <label>Search: <input type="text" aria-controls="sample-table-2"></label>
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-2"
                       aria-describedby="sample-table-2_info">

                    <thead>
                    <tr>
                        <th>Action</th>
                        <% excludedProps = Event.allEvents.toList() << 'id' << 'version'
                        allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
                        props = domainClass.properties.findAll {
                            allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type)
                        }
                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                        props.eachWithIndex { p, i ->
                            if (i < 6) {
                                if (p.isAssociation()) { %>
                        <th><g:message code="${domainClass.propertyName}.${p.name}.label"
                                       default="${p.naturalName}"/></th>
                        <% } else { %>
                        <g:sortableColumn property="${p.name}" title="\${message(code: '${domainClass.propertyName}.${
                                p.name}.label', default: '${p.naturalName}')}"/>
                        <% }
                        }
                        } %>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
                        <tr class="\${(i % 2) == 0 ? 'even' : 'odd'}">
                            <g:form><td style="width: 50px;">

                                <g:hiddenField name="id" value="\${${propertyName}?.id}"/>
                                <g:hiddenField name="version" value="\${${propertyName}?.version}"/>
                                <g:link action="edit" id="\${${propertyName}?.id}">
                                    <i class="icon-pencil bigger-130"></i>
                                </g:link>   &nbsp;&nbsp;&nbsp;&nbsp;
                                <g:actionSubmitImage value="delete" action="delete"
                                                     src="\${resource(dir: 'assets/avatars',file: 'delete1.png')}"
                                                     onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>

                            </td></g:form>
                            <% props.eachWithIndex { p, i ->
                                if (i == 0) { %>
                            <td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}
                            </td>
                            <% } else if (i < 6) {
                                if (p.type == Boolean || p.type == boolean) { %>
                            <td><g:formatBoolean boolean="\${${propertyName}.${p.name}}"/></td>
                            <%
                                } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
                            <td><g:formatDate date="\${${propertyName}.${p.name}}"/></td>
                            <% } else { %>
                            <td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                            <% }
                            }
                            } %>
                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination">
                    <g:paginate total="\${${propertyName}Total}"/>
                </div>
            </div>
        </div>

    </div>
</div>
%{--</div>--}%
</body>
</html>
