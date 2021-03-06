
<%@ page import="com.system.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-user" class="content scaffold-show" role="main">
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
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div style="margin-left: 50px; margin-right: 50px;" class="widget-main padding-8">
                <ol class="property-list user">
                    
                    <g:if test="${userInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message
                                    code="user.branch.label"
                                    default="Branch"/></span> :-
                        
                            <span class="property-value" aria-labelledby="branch-label">
                                ${userInstance?.branch?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${userInstance?.username}">
                        <li class="fieldcontain">
                            <span id="username-label" class="property-label"><g:message
                                    code="user.username.label"
                                    default="Username"/></span> :-
                        
                            <span class="property-value" aria-labelledby="username-label"><g:fieldValue
                                    bean="${userInstance}" field="username"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${userInstance?.password}">
                        <li class="fieldcontain">
                            <span id="password-label" class="property-label"><g:message
                                    code="user.password.label"
                                    default="Password"/></span> :-
                        
                            <span class="property-value" aria-labelledby="password-label"><g:fieldValue
                                    bean="${userInstance}" field="password"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${userInstance?.admin}">
                        <li class="fieldcontain">
                            <span id="admin-label" class="property-label"><g:message
                                    code="user.admin.label"
                                    default="Admin"/></span> :-
                        
                            <span class="property-value" aria-labelledby="admin-label"><g:formatBoolean
                                    boolean="${userInstance?.admin}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${userInstance?.client}">
                        <li class="fieldcontain">
                            <span id="client-label" class="property-label"><g:message
                                    code="user.client.label"
                                    default="Client"/></span> :-
                        
                            <span class="property-value" aria-labelledby="client-label"><g:formatBoolean
                                    boolean="${userInstance?.client}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${userInstance?.enable}">
                        <li class="fieldcontain">
                            <span id="enable-label" class="property-label"><g:message
                                    code="user.enable.label"
                                    default="Enable"/></span> :-
                        
                            <span class="property-value" aria-labelledby="enable-label"><g:formatBoolean
                                    boolean="${userInstance?.enable}"/></span>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="id" value="${userInstance?.id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${userInstance?.id}"><g:message
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
