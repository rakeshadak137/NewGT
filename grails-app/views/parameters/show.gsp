
<%@ page import="com.system.Parameters" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'parameters.label', default: 'Parameters')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-parameters" class="content scaffold-show" role="main">
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
                <ol class="property-list parameters">
                    
                    <g:if test="${parametersInstance?.lrPrefix}">
                        <li class="fieldcontain">
                            <span id="lrPrefix-label" class="property-label"><g:message
                                    code="parameters.lrPrefix.label"
                                    default="Lr Prefix"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lrPrefix-label"><g:fieldValue
                                    bean="${parametersInstance}" field="lrPrefix"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.lrPostfix}">
                        <li class="fieldcontain">
                            <span id="lrPostfix-label" class="property-label"><g:message
                                    code="parameters.lrPostfix.label"
                                    default="Lr Postfix"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lrPostfix-label"><g:fieldValue
                                    bean="${parametersInstance}" field="lrPostfix"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.lastLRNo}">
                        <li class="fieldcontain">
                            <span id="lastLRNo-label" class="property-label"><g:message
                                    code="parameters.lastLRNo.label"
                                    default="Last LRN o"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastLRNo-label"><g:fieldValue
                                    bean="${parametersInstance}" field="lastLRNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.lastSMAutoBillNo}">
                        <li class="fieldcontain">
                            <span id="lastSMAutoBillNo-label" class="property-label"><g:message
                                    code="parameters.lastSMAutoBillNo.label"
                                    default="Last SMA uto Bill No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastSMAutoBillNo-label"><g:fieldValue
                                    bean="${parametersInstance}" field="lastSMAutoBillNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.lastOthersBillNo}">
                        <li class="fieldcontain">
                            <span id="lastOthersBillNo-label" class="property-label"><g:message
                                    code="parameters.lastOthersBillNo.label"
                                    default="Last Others Bill No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastOthersBillNo-label"><g:fieldValue
                                    bean="${parametersInstance}" field="lastOthersBillNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.sMAutoBillNoPrefix}">
                        <li class="fieldcontain">
                            <span id="sMAutoBillNoPrefix-label" class="property-label"><g:message
                                    code="parameters.sMAutoBillNoPrefix.label"
                                    default="SMA uto Bill No Prefix"/></span> :-
                        
                            <span class="property-value" aria-labelledby="sMAutoBillNoPrefix-label"><g:fieldValue
                                    bean="${parametersInstance}" field="sMAutoBillNoPrefix"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.sMAutoBillNoPostfix}">
                        <li class="fieldcontain">
                            <span id="sMAutoBillNoPostfix-label" class="property-label"><g:message
                                    code="parameters.sMAutoBillNoPostfix.label"
                                    default="SMA uto Bill No Postfix"/></span> :-
                        
                            <span class="property-value" aria-labelledby="sMAutoBillNoPostfix-label"><g:fieldValue
                                    bean="${parametersInstance}" field="sMAutoBillNoPostfix"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.othersBillNoPrefix}">
                        <li class="fieldcontain">
                            <span id="othersBillNoPrefix-label" class="property-label"><g:message
                                    code="parameters.othersBillNoPrefix.label"
                                    default="Others Bill No Prefix"/></span> :-
                        
                            <span class="property-value" aria-labelledby="othersBillNoPrefix-label"><g:fieldValue
                                    bean="${parametersInstance}" field="othersBillNoPrefix"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.othersBillNoPostfix}">
                        <li class="fieldcontain">
                            <span id="othersBillNoPostfix-label" class="property-label"><g:message
                                    code="parameters.othersBillNoPostfix.label"
                                    default="Others Bill No Postfix"/></span> :-
                        
                            <span class="property-value" aria-labelledby="othersBillNoPostfix-label"><g:fieldValue
                                    bean="${parametersInstance}" field="othersBillNoPostfix"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.createdBy}">
                        <li class="fieldcontain">
                            <span id="createdBy-label" class="property-label"><g:message
                                    code="parameters.createdBy.label"
                                    default="Created By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="createdBy-label">
                                ${parametersInstance?.createdBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.lastUpdatedBy}">
                        <li class="fieldcontain">
                            <span id="lastUpdatedBy-label" class="property-label"><g:message
                                    code="parameters.lastUpdatedBy.label"
                                    default="Last Updated By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdatedBy-label">
                                ${parametersInstance?.lastUpdatedBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.lastUpdated}">
                        <li class="fieldcontain">
                            <span id="lastUpdated-label" class="property-label"><g:message
                                    code="parameters.lastUpdated.label"
                                    default="Last Updated"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                                    date="${parametersInstance?.lastUpdated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.dateCreated}">
                        <li class="fieldcontain">
                            <span id="dateCreated-label" class="property-label"><g:message
                                    code="parameters.dateCreated.label"
                                    default="Date Created"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${parametersInstance?.dateCreated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.isActive}">
                        <li class="fieldcontain">
                            <span id="isActive-label" class="property-label"><g:message
                                    code="parameters.isActive.label"
                                    default="Is Active"/></span> :-
                        
                            <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                    boolean="${parametersInstance?.isActive}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.financialYear}">
                        <li class="fieldcontain">
                            <span id="financialYear-label" class="property-label"><g:message
                                    code="parameters.financialYear.label"
                                    default="Financial Year"/></span> :-
                        
                            <span class="property-value" aria-labelledby="financialYear-label">
                                ${parametersInstance?.financialYear?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${parametersInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message
                                    code="parameters.branch.label"
                                    default="Branch"/></span> :-
                        
                            <span class="property-value" aria-labelledby="branch-label">
                                ${parametersInstance?.branch?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="id" value="${parametersInstance?.id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${parametersInstance?.id}"><g:message
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
