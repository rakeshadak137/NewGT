
<%@ page import="com.master.ProductMaster" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'productMaster.label', default: 'ProductMaster')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-productMaster" class="content scaffold-show" role="main">
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
                <ol class="property-list productMaster">
                    
                    <g:if test="${productMasterInstance?.productName}">
                        <li class="fieldcontain">
                            <span id="productName-label" class="property-label"><g:message
                                    code="productMaster.productName.label"
                                    default="Product Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="productName-label"><g:fieldValue
                                    bean="${productMasterInstance}" field="productName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.productCode}">
                        <li class="fieldcontain">
                            <span id="productCode-label" class="property-label"><g:message
                                    code="productMaster.productCode.label"
                                    default="Product Code"/></span> :-
                        
                            <span class="property-value" aria-labelledby="productCode-label"><g:fieldValue
                                    bean="${productMasterInstance}" field="productCode"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.customerName}">
                        <li class="fieldcontain">
                            <span id="customerName-label" class="property-label"><g:message
                                    code="productMaster.customerName.label"
                                    default="Customer Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="customerName-label">
                                ${productMasterInstance?.customerName?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.category}">
                        <li class="fieldcontain">
                            <span id="category-label" class="property-label"><g:message
                                    code="productMaster.category.label"
                                    default="Category"/></span> :-
                        
                            <span class="property-value" aria-labelledby="category-label">
                                ${productMasterInstance?.category?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.division}">
                        <li class="fieldcontain">
                            <span id="division-label" class="property-label"><g:message
                                    code="productMaster.division.label"
                                    default="Division"/></span> :-
                        
                            <span class="property-value" aria-labelledby="division-label">
                                ${productMasterInstance?.division?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.billingType}">
                        <li class="fieldcontain">
                            <span id="billingType-label" class="property-label"><g:message
                                    code="productMaster.billingType.label"
                                    default="Billing Type"/></span> :-
                        
                            <span class="property-value" aria-labelledby="billingType-label">
                                ${productMasterInstance?.billingType?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.unit}">
                        <li class="fieldcontain">
                            <span id="unit-label" class="property-label"><g:message
                                    code="productMaster.unit.label"
                                    default="Unit"/></span> :-
                        
                            <span class="property-value" aria-labelledby="unit-label">
                                ${productMasterInstance?.unit?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.rate}">
                        <li class="fieldcontain">
                            <span id="rate-label" class="property-label"><g:message
                                    code="productMaster.rate.label"
                                    default="Rate"/></span> :-
                        
                            <span class="property-value" aria-labelledby="rate-label"><g:fieldValue
                                    bean="${productMasterInstance}" field="rate"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.weightLn}">
                        <li class="fieldcontain">
                            <span id="weightLn-label" class="property-label"><g:message
                                    code="productMaster.weightLn.label"
                                    default="Weight Ln"/></span> :-
                        
                            <span class="property-value" aria-labelledby="weightLn-label"><g:fieldValue
                                    bean="${productMasterInstance}" field="weightLn"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.weight}">
                        <li class="fieldcontain">
                            <span id="weight-label" class="property-label"><g:message
                                    code="productMaster.weight.label"
                                    default="Weight"/></span> :-
                        
                            <span class="property-value" aria-labelledby="weight-label"><g:fieldValue
                                    bean="${productMasterInstance}" field="weight"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.od}">
                        <li class="fieldcontain">
                            <span id="od-label" class="property-label"><g:message
                                    code="productMaster.od.label"
                                    default="Od"/></span> :-
                        
                            <span class="property-value" aria-labelledby="od-label"><g:fieldValue
                                    bean="${productMasterInstance}" field="od"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.thickNess}">
                        <li class="fieldcontain">
                            <span id="thickNess-label" class="property-label"><g:message
                                    code="productMaster.thickNess.label"
                                    default="Thick Ness"/></span> :-
                        
                            <span class="property-value" aria-labelledby="thickNess-label"><g:fieldValue
                                    bean="${productMasterInstance}" field="thickNess"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.length}">
                        <li class="fieldcontain">
                            <span id="length-label" class="property-label"><g:message
                                    code="productMaster.length.label"
                                    default="Length"/></span> :-
                        
                            <span class="property-value" aria-labelledby="length-label"><g:fieldValue
                                    bean="${productMasterInstance}" field="length"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.createdBy}">
                        <li class="fieldcontain">
                            <span id="createdBy-label" class="property-label"><g:message
                                    code="productMaster.createdBy.label"
                                    default="Created By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="createdBy-label">
                                ${productMasterInstance?.createdBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.lastUpdatedBy}">
                        <li class="fieldcontain">
                            <span id="lastUpdatedBy-label" class="property-label"><g:message
                                    code="productMaster.lastUpdatedBy.label"
                                    default="Last Updated By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdatedBy-label">
                                ${productMasterInstance?.lastUpdatedBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.lastUpdated}">
                        <li class="fieldcontain">
                            <span id="lastUpdated-label" class="property-label"><g:message
                                    code="productMaster.lastUpdated.label"
                                    default="Last Updated"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                                    date="${productMasterInstance?.lastUpdated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.dateCreated}">
                        <li class="fieldcontain">
                            <span id="dateCreated-label" class="property-label"><g:message
                                    code="productMaster.dateCreated.label"
                                    default="Date Created"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${productMasterInstance?.dateCreated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.isActive}">
                        <li class="fieldcontain">
                            <span id="isActive-label" class="property-label"><g:message
                                    code="productMaster.isActive.label"
                                    default="Is Active"/></span> :-
                        
                            <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                    boolean="${productMasterInstance?.isActive}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.financialYear}">
                        <li class="fieldcontain">
                            <span id="financialYear-label" class="property-label"><g:message
                                    code="productMaster.financialYear.label"
                                    default="Financial Year"/></span> :-
                        
                            <span class="property-value" aria-labelledby="financialYear-label">
                                ${productMasterInstance?.financialYear?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${productMasterInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message
                                    code="productMaster.branch.label"
                                    default="Branch"/></span> :-
                        
                            <span class="property-value" aria-labelledby="branch-label">
                                ${productMasterInstance?.branch?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:hiddenField name="id" value="${productMasterInstance?.id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${productMasterInstance?.id}" params="${[scrid:session['activeScreen'].id]}"><g:message
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
