
<%@ page import="com.transaction.PurchaseOrder" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'purchaseOrder.label', default: 'PurchaseOrder')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-purchaseOrder" class="content scaffold-show" role="main">
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
                <ol class="property-list purchaseOrder">
                    
                    <g:if test="${purchaseOrderInstance?.poNo}">
                        <li class="fieldcontain">
                            <span id="poNo-label" class="property-label"><g:message
                                    code="purchaseOrder.poNo.label"
                                    default="Po No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="poNo-label"><g:fieldValue
                                    bean="${purchaseOrderInstance}" field="poNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${purchaseOrderInstance?.poDate}">
                        <li class="fieldcontain">
                            <span id="poDate-label" class="property-label"><g:message
                                    code="purchaseOrder.poDate.label"
                                    default="Po Date"/></span> :-
                        
                            <span class="property-value" aria-labelledby="poDate-label"><g:formatDate
                                    date="${purchaseOrderInstance?.poDate}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${purchaseOrderInstance?.customer}">
                        <li class="fieldcontain">
                            <span id="customer-label" class="property-label"><g:message
                                    code="purchaseOrder.customer.label"
                                    default="Customer"/></span> :-
                        
                            <span class="property-value" aria-labelledby="customer-label">
                                ${purchaseOrderInstance?.customer?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${purchaseOrderInstance?.poType}">
                        <li class="fieldcontain">
                            <span id="poType-label" class="property-label"><g:message
                                    code="purchaseOrder.poType.label"
                                    default="Po Type"/></span> :-
                        
                            <span class="property-value" aria-labelledby="poType-label"><g:fieldValue
                                    bean="${purchaseOrderInstance}" field="poType"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${purchaseOrderInstance?.createdBy}">
                        <li class="fieldcontain">
                            <span id="createdBy-label" class="property-label"><g:message
                                    code="purchaseOrder.createdBy.label"
                                    default="Created By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="createdBy-label">
                                ${purchaseOrderInstance?.createdBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${purchaseOrderInstance?.lastUpdatedBy}">
                        <li class="fieldcontain">
                            <span id="lastUpdatedBy-label" class="property-label"><g:message
                                    code="purchaseOrder.lastUpdatedBy.label"
                                    default="Last Updated By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdatedBy-label">
                                ${purchaseOrderInstance?.lastUpdatedBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${purchaseOrderInstance?.lastUpdated}">
                        <li class="fieldcontain">
                            <span id="lastUpdated-label" class="property-label"><g:message
                                    code="purchaseOrder.lastUpdated.label"
                                    default="Last Updated"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                                    date="${purchaseOrderInstance?.lastUpdated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${purchaseOrderInstance?.dateCreated}">
                        <li class="fieldcontain">
                            <span id="dateCreated-label" class="property-label"><g:message
                                    code="purchaseOrder.dateCreated.label"
                                    default="Date Created"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${purchaseOrderInstance?.dateCreated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${purchaseOrderInstance?.isActive}">
                        <li class="fieldcontain">
                            <span id="isActive-label" class="property-label"><g:message
                                    code="purchaseOrder.isActive.label"
                                    default="Is Active"/></span> :-
                        
                            <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                    boolean="${purchaseOrderInstance?.isActive}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${purchaseOrderInstance?.financialYear}">
                        <li class="fieldcontain">
                            <span id="financialYear-label" class="property-label"><g:message
                                    code="purchaseOrder.financialYear.label"
                                    default="Financial Year"/></span> :-
                        
                            <span class="property-value" aria-labelledby="financialYear-label">
                                ${purchaseOrderInstance?.financialYear?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${purchaseOrderInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message
                                    code="purchaseOrder.branch.label"
                                    default="Branch"/></span> :-
                        
                            <span class="property-value" aria-labelledby="branch-label">
                                ${purchaseOrderInstance?.branch?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${purchaseOrderInstance?.purchaseOrderDetails}">
                        <li class="fieldcontain">
                            <span id="purchaseOrderDetails-label" class="property-label"><g:message
                                    code="purchaseOrder.purchaseOrderDetails.label"
                                    default="Purchase Order Details"/></span> :-
                        
                            <g:each in="${purchaseOrderInstance.purchaseOrderDetails}" var="p">
                                <span class="property-value" aria-labelledby="purchaseOrderDetails-label">
                                    ${p?.encodeAsHTML()}
                                </span>
                            </g:each>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:hiddenField name="id" value="${purchaseOrderInstance?.id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${purchaseOrderInstance?.id}" params="${[scrid:session['activeScreen'].id]}"><g:message
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
