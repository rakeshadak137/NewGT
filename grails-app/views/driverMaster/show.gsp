
<%@ page import="com.master.DriverMaster" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'driverMaster.label', default: 'DriverMaster')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-driverMaster" class="content scaffold-show" role="main">
            <div class="table-header">
                <g:message code="default.show.label" args="[entityName]"/>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        action="list" params="${[scrid:session['activeScreen'].id]}"><i
                        class="icon-ok bigger-50"></i> List</g:link>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        action="create" params="${[scrid:session['activeScreen'].id]}">
                    <i class="icon-pencil bigger-50"></i>New
                </g:link>

            </div>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div style="margin-left: 50px; margin-right: 50px;" class="widget-main padding-8">
                <ol class="property-list driverMaster">
                    
                    <g:if test="${driverMasterInstance?.driverName}">
                        <li class="fieldcontain">
                            <span id="driverName-label" class="property-label"><g:message
                                    code="driverMaster.driverName.label"
                                    default="Driver Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="driverName-label"><g:fieldValue
                                    bean="${driverMasterInstance}" field="driverName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${driverMasterInstance?.driverId}">
                        <li class="fieldcontain">
                            <span id="driverId-label" class="property-label"><g:message
                                    code="driverMaster.driverId.label"
                                    default="Driver Id"/></span> :-
                        
                            <span class="property-value" aria-labelledby="driverId-label"><g:fieldValue
                                    bean="${driverMasterInstance}" field="driverId"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${driverMasterInstance?.address}">
                        <li class="fieldcontain">
                            <span id="address-label" class="property-label"><g:message
                                    code="driverMaster.address.label"
                                    default="Address"/></span> :-
                        
                            <span class="property-value" aria-labelledby="address-label"><g:fieldValue
                                    bean="${driverMasterInstance}" field="address"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${driverMasterInstance?.mobileNo}">
                        <li class="fieldcontain">
                            <span id="mobileNo-label" class="property-label"><g:message
                                    code="driverMaster.mobileNo.label"
                                    default="Mobile No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="mobileNo-label"><g:fieldValue
                                    bean="${driverMasterInstance}" field="mobileNo"/></span>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="id" value="${driverMasterInstance?.id}"/>
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${driverMasterInstance?.id}" params="${[scrid:session['activeScreen'].id]}"><g:message
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
