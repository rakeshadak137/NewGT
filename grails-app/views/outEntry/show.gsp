
<%@ page import="com.transaction.OutEntry" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'outEntry.label', default: 'OutEntry')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
    <script>
        function OutController($http,$scope){
            init();
            function init(){
            }
        }
    </script>
</head>

<body>
<div ng-controller="OutController">
<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-outEntry" class="content scaffold-show" role="main">
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
                <ol class="property-list outEntry">
                    
                    <g:if test="${outEntryInstance?.voucherNo}">
                        <li class="fieldcontain">
                            <span id="voucherNo-label" class="property-label"><g:message
                                    code="outEntry.voucherNo.label"
                                    default="Voucher No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="voucherNo-label"><g:fieldValue
                                    bean="${outEntryInstance}" field="voucherNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${outEntryInstance?.voucherDate}">
                        <li class="fieldcontain">
                            <span id="voucherDate-label" class="property-label"><g:message
                                    code="outEntry.voucherDate.label"
                                    default="Voucher Date"/></span> :-
                        
                            <span class="property-value" aria-labelledby="voucherDate-label"><g:formatDate
                                    date="${outEntryInstance?.voucherDate}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${outEntryInstance?.fromCustomer}">
                        <li class="fieldcontain">
                            <span id="fromCustomer-label" class="property-label"><g:message
                                    code="outEntry.fromCustomer.label"
                                    default="From Customer"/></span> :-
                        
                            <span class="property-value" aria-labelledby="fromCustomer-label">
                                ${outEntryInstance?.fromCustomer?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${outEntryInstance?.toCustomer}">
                        <li class="fieldcontain">
                            <span id="toCustomer-label" class="property-label"><g:message
                                    code="outEntry.toCustomer.label"
                                    default="To Customer"/></span> :-
                        
                            <span class="property-value" aria-labelledby="toCustomer-label">
                                ${outEntryInstance?.toCustomer?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${outEntryInstance?.vehicle}">
                        <li class="fieldcontain">
                            <span id="vehicle-label" class="property-label"><g:message
                                    code="outEntry.vehicle.label"
                                    default="Vehicle"/></span> :-
                        
                            <span class="property-value" aria-labelledby="vehicle-label">
                                ${outEntryInstance?.vehicle?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${outEntryInstance?.createdBy}">
                        <li class="fieldcontain">
                            <span id="createdBy-label" class="property-label"><g:message
                                    code="outEntry.createdBy.label"
                                    default="Created By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="createdBy-label">
                                ${outEntryInstance?.createdBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${outEntryInstance?.lastUpdatedBy}">
                        <li class="fieldcontain">
                            <span id="lastUpdatedBy-label" class="property-label"><g:message
                                    code="outEntry.lastUpdatedBy.label"
                                    default="Last Updated By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdatedBy-label">
                                ${outEntryInstance?.lastUpdatedBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${outEntryInstance?.lastUpdated}">
                        <li class="fieldcontain">
                            <span id="lastUpdated-label" class="property-label"><g:message
                                    code="outEntry.lastUpdated.label"
                                    default="Last Updated"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                                    date="${outEntryInstance?.lastUpdated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${outEntryInstance?.dateCreated}">
                        <li class="fieldcontain">
                            <span id="dateCreated-label" class="property-label"><g:message
                                    code="outEntry.dateCreated.label"
                                    default="Date Created"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${outEntryInstance?.dateCreated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${outEntryInstance?.isActive}">
                        <li class="fieldcontain">
                            <span id="isActive-label" class="property-label"><g:message
                                    code="outEntry.isActive.label"
                                    default="Is Active"/></span> :-
                        
                            <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                    boolean="${outEntryInstance?.isActive}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${outEntryInstance?.financialYear}">
                        <li class="fieldcontain">
                            <span id="financialYear-label" class="property-label"><g:message
                                    code="outEntry.financialYear.label"
                                    default="Financial Year"/></span> :-
                        
                            <span class="property-value" aria-labelledby="financialYear-label">
                                ${outEntryInstance?.financialYear?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${outEntryInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message
                                    code="outEntry.branch.label"
                                    default="Branch"/></span> :-
                        
                            <span class="property-value" aria-labelledby="branch-label">
                                ${outEntryInstance?.branch?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${outEntryInstance?.outEntryDetails}">
                        <li class="fieldcontain">
                            <span id="outEntryDetails-label" class="property-label"><g:message
                                    code="outEntry.outEntryDetails.label"
                                    default="Out Entry Details"/></span> :-
                        
                            <g:each in="${outEntryInstance.outEntryDetails}" var="o">
                                <span class="property-value" aria-labelledby="outEntryDetails-label">
                                    ${o?.invoiceNo?:""}
                                </span>
                            </g:each>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="id" value="${outEntryInstance?.id}"/>
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${outEntryInstance?.id}" params="${[scrid:session['activeScreen'].id]}"><g:message
                                code="default.button.edit.label" default="Edit"/></g:link>
                        <g:actionSubmit class="btn btn-info btn-small" action="delete"
                                        value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>

                        <a ng-href="/${grailsApplication.config.erpName}/outEntry/print_action?id=${outEntryInstance?.id}" class="btn btn-info btn-small" target="_blank">Print</a>

                        <a ng-href="/${grailsApplication.config.erpName}/outEntry/print_action2?id=${outEntryInstance?.id}" class="btn btn-info btn-small" target="_blank">Print Remaining Stock</a>

                        <a ng-href="/${grailsApplication.config.erpName}/outEntry/print_action3?id=${outEntryInstance?.id}" class="btn btn-info btn-small" target="_blank">Godown Remaining Stock</a>

                    </fieldset>
                </g:form>
            </div>
        </div>
        <g:render template="/shared/viewFooter"/>
    </div>
</div>
</div>
</body>
</html>
