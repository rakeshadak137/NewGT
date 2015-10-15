
<%@ page import="com.master.UnitMaster" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'unitMaster.label', default: 'UnitMaster')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-unitMaster" class="content scaffold-show" role="main">
            <div class="table-header">
                <g:message code="default.show.label" args="[entityName]"/>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px" params="${[scrid:session['activeScreen'].id]}"
                        action="list"><i
                        class="icon-ok bigger-50"></i> List</g:link>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px" params="${[scrid:session['activeScreen'].id]}"
                        action="create">
                    <i class="icon-pencil bigger-50"></i>New
                </g:link>

            </div>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div style="margin-left: 50px; margin-right: 50px;" class="widget-main padding-8">
                <ol class="property-list unitMaster">
                    
                    <g:if test="${unitMasterInstance?.unitName}">
                        <li class="fieldcontain">
                            <span id="unitName-label" class="property-label"><g:message
                                    code="unitMaster.unitName.label"
                                    default="Unit Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="unitName-label"><g:fieldValue
                                    bean="${unitMasterInstance}" field="unitName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${unitMasterInstance?.unitType}">
                        <li class="fieldcontain">
                            <span id="unitType-label" class="property-label"><g:message
                                    code="unitMaster.unitType.label"
                                    default="Unit Type"/></span> :-
                        
                            <span class="property-value" aria-labelledby="unitType-label"><g:fieldValue
                                    bean="${unitMasterInstance}" field="unitType"/></span>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="id" value="${unitMasterInstance?.id}"/>
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${unitMasterInstance?.id}" params="${[scrid:session['activeScreen'].id]}"><g:message
                                code="default.button.edit.label" default="Edit"/></g:link>
                        <g:actionSubmit class="btn btn-info btn-small" action="delete"
                                        value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                    </fieldset>
                </g:form>
            </div>
        </div>
        <g:render template="/shared/viewFooter"/>
    </div>
</div>

</body>
</html>
