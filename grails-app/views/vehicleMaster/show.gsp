
<%@ page import="com.master.VehicleMaster" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'vehicleMaster.label', default: 'VehicleMaster')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-vehicleMaster" class="content scaffold-show" role="main">
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
                <ol class="property-list vehicleMaster">
                    
                    <g:if test="${vehicleMasterInstance?.vehicleNo}">
                        <li class="fieldcontain">
                            <span id="vehicleNo-label" class="property-label"><g:message
                                    code="vehicleMaster.vehicleNo.label"
                                    default="Vehicle No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="vehicleNo-label"><g:fieldValue
                                    bean="${vehicleMasterInstance}" field="vehicleNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${vehicleMasterInstance?.vehicleType}">
                        <li class="fieldcontain">
                            <span id="vehicleType-label" class="property-label"><g:message
                                    code="vehicleMaster.vehicleType.label"
                                    default="Vehicle Type"/></span> :-
                        
                            <span class="property-value" aria-labelledby="vehicleType-label"><g:fieldValue
                                    bean="${vehicleMasterInstance}" field="vehicleType"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${vehicleMasterInstance?.companyName}">
                        <li class="fieldcontain">
                            <span id="companyName-label" class="property-label"><g:message
                                    code="vehicleMaster.companyName.label"
                                    default="Company Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="companyName-label"><g:fieldValue
                                    bean="${vehicleMasterInstance}" field="companyName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${vehicleMasterInstance?.ownerName}">
                        <li class="fieldcontain">
                            <span id="ownerName-label" class="property-label"><g:message
                                    code="vehicleMaster.ownerName.label"
                                    default="Owner Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="ownerName-label"><g:fieldValue
                                    bean="${vehicleMasterInstance}" field="ownerName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${vehicleMasterInstance?.mobileNo}">
                        <li class="fieldcontain">
                            <span id="mobileNo-label" class="property-label"><g:message
                                    code="vehicleMaster.mobileNo.label"
                                    default="Mobile No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="mobileNo-label"><g:fieldValue
                                    bean="${vehicleMasterInstance}" field="mobileNo"/></span>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:hiddenField name="id" value="${vehicleMasterInstance?.id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${vehicleMasterInstance?.id}" params="${[scrid:session['activeScreen'].id]}"><g:message
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
