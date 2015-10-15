
<%@ page import="com.master.BankMaster" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'bankMaster.label', default: 'BankMaster')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-bankMaster" class="content scaffold-show" role="main">
            <div class="table-header">
                <g:message code="default.show.label" args="[entityName]"/>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        params="${[scrid: session['activeScreen'].id]}" action="list"><i
                        class="icon-ok bigger-50"></i> List</g:link>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        params="${[scrid: session['activeScreen'].id]}" action="create">
                    <i class="icon-pencil bigger-50"></i>New
                </g:link>

            </div>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div style="margin-left: 50px; margin-right: 50px;" class="widget-main padding-8">
                <ol class="property-list bankMaster">
                    
                    <g:if test="${bankMasterInstance?.bankName}">
                        <li class="fieldcontain">
                            <span id="bankName-label" class="property-label"><g:message
                                    code="bankMaster.bankName.label"
                                    default="Bank Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="bankName-label"><g:fieldValue
                                    bean="${bankMasterInstance}" field="bankName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${bankMasterInstance?.accountNo}">
                        <li class="fieldcontain">
                            <span id="accountNo-label" class="property-label"><g:message
                                    code="bankMaster.accountNo.label"
                                    default="Account No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="accountNo-label"><g:fieldValue
                                    bean="${bankMasterInstance}" field="accountNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${bankMasterInstance?.address}">
                        <li class="fieldcontain">
                            <span id="address-label" class="property-label"><g:message
                                    code="bankMaster.address.label"
                                    default="Address"/></span> :-
                        
                            <span class="property-value" aria-labelledby="address-label"><g:fieldValue
                                    bean="${bankMasterInstance}" field="address"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${bankMasterInstance?.createdBy}">
                        <li class="fieldcontain">
                            <span id="createdBy-label" class="property-label"><g:message
                                    code="bankMaster.createdBy.label"
                                    default="Created By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="createdBy-label">
                                ${bankMasterInstance?.createdBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${bankMasterInstance?.lastUpdatedBy}">
                        <li class="fieldcontain">
                            <span id="lastUpdatedBy-label" class="property-label"><g:message
                                    code="bankMaster.lastUpdatedBy.label"
                                    default="Last Updated By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdatedBy-label">
                                ${bankMasterInstance?.lastUpdatedBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${bankMasterInstance?.lastUpdated}">
                        <li class="fieldcontain">
                            <span id="lastUpdated-label" class="property-label"><g:message
                                    code="bankMaster.lastUpdated.label"
                                    default="Last Updated"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                                    date="${bankMasterInstance?.lastUpdated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${bankMasterInstance?.dateCreated}">
                        <li class="fieldcontain">
                            <span id="dateCreated-label" class="property-label"><g:message
                                    code="bankMaster.dateCreated.label"
                                    default="Date Created"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${bankMasterInstance?.dateCreated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${bankMasterInstance?.isActive}">
                        <li class="fieldcontain">
                            <span id="isActive-label" class="property-label"><g:message
                                    code="bankMaster.isActive.label"
                                    default="Is Active"/></span> :-
                        
                            <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                    boolean="${bankMasterInstance?.isActive}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${bankMasterInstance?.financialYear}">
                        <li class="fieldcontain">
                            <span id="financialYear-label" class="property-label"><g:message
                                    code="bankMaster.financialYear.label"
                                    default="Financial Year"/></span> :-
                        
                            <span class="property-value" aria-labelledby="financialYear-label">
                                ${bankMasterInstance?.financialYear?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${bankMasterInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message
                                    code="bankMaster.branch.label"
                                    default="Branch"/></span> :-
                        
                            <span class="property-value" aria-labelledby="branch-label">
                                ${bankMasterInstance?.branch?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="id" value="${bankMasterInstance?.id}"/>
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${bankMasterInstance?.id}"><g:message
                                code="default.button.edit.label" default="Edit" params="${[scrid: session['activeScreen'].id]}" /></g:link>
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
