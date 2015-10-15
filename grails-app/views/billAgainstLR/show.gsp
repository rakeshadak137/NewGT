
<%@ page import="com.transaction.BillAgainstLR" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'billAgainstLR.label', default: 'BillAgainstLR')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-billAgainstLR" class="content scaffold-show" role="main">
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
                <ol class="property-list billAgainstLR">
                    
                    <g:if test="${billAgainstLRInstance?.billNo}">
                        <li class="fieldcontain">
                            <span id="billNo-label" class="property-label"><g:message
                                    code="billAgainstLR.billNo.label"
                                    default="Bill No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="billNo-label"><g:fieldValue
                                    bean="${billAgainstLRInstance}" field="billNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.billDate}">
                        <li class="fieldcontain">
                            <span id="billDate-label" class="property-label"><g:message
                                    code="billAgainstLR.billDate.label"
                                    default="Bill Date"/></span> :-
                        
                            <span class="property-value" aria-labelledby="billDate-label"><g:formatDate
                                    date="${billAgainstLRInstance?.billDate}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.company}">
                        <li class="fieldcontain">
                            <span id="company-label" class="property-label"><g:message
                                    code="billAgainstLR.company.label"
                                    default="Company"/></span> :-
                        
                            <span class="property-value" aria-labelledby="company-label">
                                ${billAgainstLRInstance?.company?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.fromCompany}">
                        <li class="fieldcontain">
                            <span id="fromCompany-label" class="property-label"><g:message
                                    code="billAgainstLR.fromCompany.label"
                                    default="From Company"/></span> :-
                        
                            <span class="property-value" aria-labelledby="fromCompany-label">
                                ${billAgainstLRInstance?.fromCompany?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.toCompany}">
                        <li class="fieldcontain">
                            <span id="toCompany-label" class="property-label"><g:message
                                    code="billAgainstLR.toCompany.label"
                                    default="To Company"/></span> :-
                        
                            <span class="property-value" aria-labelledby="toCompany-label">
                                ${billAgainstLRInstance?.toCompany?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.vehicleNo}">
                        <li class="fieldcontain">
                            <span id="vehicleNo-label" class="property-label"><g:message
                                    code="billAgainstLR.vehicleNo.label"
                                    default="Vehicle No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="vehicleNo-label"><g:fieldValue
                                    bean="${billAgainstLRInstance}" field="vehicleNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.poNo}">
                        <li class="fieldcontain">
                            <span id="poNo-label" class="property-label"><g:message
                                    code="billAgainstLR.poNo.label"
                                    default="Po No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="poNo-label"><g:fieldValue
                                    bean="${billAgainstLRInstance}" field="poNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.poDate}">
                        <li class="fieldcontain">
                            <span id="poDate-label" class="property-label"><g:message
                                    code="billAgainstLR.poDate.label"
                                    default="Po Date"/></span> :-
                        
                            <span class="property-value" aria-labelledby="poDate-label"><g:formatDate
                                    date="${billAgainstLRInstance?.poDate}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.totalAmount}">
                        <li class="fieldcontain">
                            <span id="totalAmount-label" class="property-label"><g:message
                                    code="billAgainstLR.totalAmount.label"
                                    default="Total Amount"/></span> :-
                        
                            <span class="property-value" aria-labelledby="totalAmount-label"><g:fieldValue
                                    bean="${billAgainstLRInstance}" field="totalAmount"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.createdBy}">
                        <li class="fieldcontain">
                            <span id="createdBy-label" class="property-label"><g:message
                                    code="billAgainstLR.createdBy.label"
                                    default="Created By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="createdBy-label">
                                ${billAgainstLRInstance?.createdBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.lastUpdatedBy}">
                        <li class="fieldcontain">
                            <span id="lastUpdatedBy-label" class="property-label"><g:message
                                    code="billAgainstLR.lastUpdatedBy.label"
                                    default="Last Updated By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdatedBy-label">
                                ${billAgainstLRInstance?.lastUpdatedBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.lastUpdated}">
                        <li class="fieldcontain">
                            <span id="lastUpdated-label" class="property-label"><g:message
                                    code="billAgainstLR.lastUpdated.label"
                                    default="Last Updated"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                                    date="${billAgainstLRInstance?.lastUpdated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.dateCreated}">
                        <li class="fieldcontain">
                            <span id="dateCreated-label" class="property-label"><g:message
                                    code="billAgainstLR.dateCreated.label"
                                    default="Date Created"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${billAgainstLRInstance?.dateCreated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.isActive}">
                        <li class="fieldcontain">
                            <span id="isActive-label" class="property-label"><g:message
                                    code="billAgainstLR.isActive.label"
                                    default="Is Active"/></span> :-
                        
                            <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                    boolean="${billAgainstLRInstance?.isActive}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.financialYear}">
                        <li class="fieldcontain">
                            <span id="financialYear-label" class="property-label"><g:message
                                    code="billAgainstLR.financialYear.label"
                                    default="Financial Year"/></span> :-
                        
                            <span class="property-value" aria-labelledby="financialYear-label">
                                ${billAgainstLRInstance?.financialYear?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${billAgainstLRInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message
                                    code="billAgainstLR.branch.label"
                                    default="Branch"/></span> :-
                        
                            <span class="property-value" aria-labelledby="branch-label">
                                ${billAgainstLRInstance?.branch?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:hiddenField name="id" value="${billAgainstLRInstance?.id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${billAgainstLRInstance?.id}"><g:message
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
