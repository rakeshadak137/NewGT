
<%@ page import="com.transaction.CashVoucher" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-cashVoucher" class="content scaffold-show" role="main">
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
                <ol class="property-list cashVoucher">
                    
                    <g:if test="${cashVoucherInstance?.voucherType}">
                        <li class="fieldcontain">
                            <span id="voucherType-label" class="property-label"><g:message
                                    code="cashVoucher.voucherType.label"
                                    default="Voucher Type"/></span> :-
                        
                            <span class="property-value" aria-labelledby="voucherType-label"><g:fieldValue
                                    bean="${cashVoucherInstance}" field="voucherType"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.vehicleNo}">
                        <li class="fieldcontain">
                            <span id="vehicleNo-label" class="property-label"><g:message
                                    code="cashVoucher.vehicleNo.label"
                                    default="Vehicle No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="vehicleNo-label">
                                ${cashVoucherInstance?.vehicleNo?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.paymentType}">
                        <li class="fieldcontain">
                            <span id="paymentType-label" class="property-label"><g:message
                                    code="cashVoucher.paymentType.label"
                                    default="Payment Type"/></span> :-
                        
                            <span class="property-value" aria-labelledby="paymentType-label"><g:fieldValue
                                    bean="${cashVoucherInstance}" field="paymentType"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.pumpName}">
                        <li class="fieldcontain">
                            <span id="pumpName-label" class="property-label"><g:message
                                    code="cashVoucher.pumpName.label"
                                    default="Pump Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="pumpName-label">
                                ${cashVoucherInstance?.pumpName?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.dieselReceiptNo}">
                        <li class="fieldcontain">
                            <span id="dieselReceiptNo-label" class="property-label"><g:message
                                    code="cashVoucher.dieselReceiptNo.label"
                                    default="Diesel Receipt No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dieselReceiptNo-label"><g:fieldValue
                                    bean="${cashVoucherInstance}" field="dieselReceiptNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.dieselReceiptDate}">
                        <li class="fieldcontain">
                            <span id="dieselReceiptDate-label" class="property-label"><g:message
                                    code="cashVoucher.dieselReceiptDate.label"
                                    default="Diesel Receipt Date"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dieselReceiptDate-label"><g:formatDate
                                    date="${cashVoucherInstance?.dieselReceiptDate}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.bankName}">
                        <li class="fieldcontain">
                            <span id="bankName-label" class="property-label"><g:message
                                    code="cashVoucher.bankName.label"
                                    default="Bank Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="bankName-label">
                                ${cashVoucherInstance?.bankName?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.chequeNo}">
                        <li class="fieldcontain">
                            <span id="chequeNo-label" class="property-label"><g:message
                                    code="cashVoucher.chequeNo.label"
                                    default="Cheque No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="chequeNo-label"><g:fieldValue
                                    bean="${cashVoucherInstance}" field="chequeNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.description}">
                        <li class="fieldcontain">
                            <span id="description-label" class="property-label"><g:message
                                    code="cashVoucher.description.label"
                                    default="Description"/></span> :-
                        
                            <span class="property-value" aria-labelledby="description-label"><g:fieldValue
                                    bean="${cashVoucherInstance}" field="description"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.createdBy}">
                        <li class="fieldcontain">
                            <span id="createdBy-label" class="property-label"><g:message
                                    code="cashVoucher.createdBy.label"
                                    default="Created By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="createdBy-label">
                                ${cashVoucherInstance?.createdBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.lastUpdatedBy}">
                        <li class="fieldcontain">
                            <span id="lastUpdatedBy-label" class="property-label"><g:message
                                    code="cashVoucher.lastUpdatedBy.label"
                                    default="Last Updated By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdatedBy-label">
                                ${cashVoucherInstance?.lastUpdatedBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.lastUpdated}">
                        <li class="fieldcontain">
                            <span id="lastUpdated-label" class="property-label"><g:message
                                    code="cashVoucher.lastUpdated.label"
                                    default="Last Updated"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                                    date="${cashVoucherInstance?.lastUpdated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.dateCreated}">
                        <li class="fieldcontain">
                            <span id="dateCreated-label" class="property-label"><g:message
                                    code="cashVoucher.dateCreated.label"
                                    default="Date Created"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${cashVoucherInstance?.dateCreated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.isActive}">
                        <li class="fieldcontain">
                            <span id="isActive-label" class="property-label"><g:message
                                    code="cashVoucher.isActive.label"
                                    default="Is Active"/></span> :-
                        
                            <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                    boolean="${cashVoucherInstance?.isActive}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.financialYear}">
                        <li class="fieldcontain">
                            <span id="financialYear-label" class="property-label"><g:message
                                    code="cashVoucher.financialYear.label"
                                    default="Financial Year"/></span> :-
                        
                            <span class="property-value" aria-labelledby="financialYear-label">
                                ${cashVoucherInstance?.financialYear?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message
                                    code="cashVoucher.branch.label"
                                    default="Branch"/></span> :-
                        
                            <span class="property-value" aria-labelledby="branch-label">
                                ${cashVoucherInstance?.branch?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.cashVoucherChilds}">
                        <li class="fieldcontain">
                            <span id="cashVoucherChilds-label" class="property-label"><g:message
                                    code="cashVoucher.cashVoucherChilds.label"
                                    default="Cash Voucher Childs"/></span> :-
                        
                            <g:each in="${cashVoucherInstance.cashVoucherChilds}" var="c">
                                <span class="property-value" aria-labelledby="cashVoucherChilds-label">
                                    ${c?.encodeAsHTML()}
                                </span>
                            </g:each>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.dieselAmount}">
                        <li class="fieldcontain">
                            <span id="dieselAmount-label" class="property-label"><g:message
                                    code="cashVoucher.dieselAmount.label"
                                    default="Diesel Amount"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dieselAmount-label"><g:fieldValue
                                    bean="${cashVoucherInstance}" field="dieselAmount"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.dieselLtr}">
                        <li class="fieldcontain">
                            <span id="dieselLtr-label" class="property-label"><g:message
                                    code="cashVoucher.dieselLtr.label"
                                    default="Diesel Ltr"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dieselLtr-label"><g:fieldValue
                                    bean="${cashVoucherInstance}" field="dieselLtr"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.dieselRate}">
                        <li class="fieldcontain">
                            <span id="dieselRate-label" class="property-label"><g:message
                                    code="cashVoucher.dieselRate.label"
                                    default="Diesel Rate"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dieselRate-label"><g:fieldValue
                                    bean="${cashVoucherInstance}" field="dieselRate"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.netAmount}">
                        <li class="fieldcontain">
                            <span id="netAmount-label" class="property-label"><g:message
                                    code="cashVoucher.netAmount.label"
                                    default="Net Amount"/></span> :-
                        
                            <span class="property-value" aria-labelledby="netAmount-label"><g:fieldValue
                                    bean="${cashVoucherInstance}" field="netAmount"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.voucherDate}">
                        <li class="fieldcontain">
                            <span id="voucherDate-label" class="property-label"><g:message
                                    code="cashVoucher.voucherDate.label"
                                    default="Voucher Date"/></span> :-
                        
                            <span class="property-value" aria-labelledby="voucherDate-label"><g:formatDate
                                    date="${cashVoucherInstance?.voucherDate}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${cashVoucherInstance?.voucherNo}">
                        <li class="fieldcontain">
                            <span id="voucherNo-label" class="property-label"><g:message
                                    code="cashVoucher.voucherNo.label"
                                    default="Voucher No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="voucherNo-label"><g:fieldValue
                                    bean="${cashVoucherInstance}" field="voucherNo"/></span>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:hiddenField name="id" value="${cashVoucherInstance?.id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${cashVoucherInstance?.id}" params="${[scrid:session['activeScreen'].id]}"><g:message
                                code="default.button.edit.label" default="Edit"/></g:link>
                        <g:actionSubmit class="btn btn-info btn-small" action="delete"
                                        value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>

                        <a ng-href="/${grailsApplication.config.erpName}/cashVoucher/print_action?id=${cashVoucherInstance?.id}&scrid=${session['activeScreen'].id}" class="btn btn-info btn-small"
                           target="_blank">Print</a>
                    </fieldset>
                </g:form>
            </div>
        </div>
        <g:render template="/shared/viewFooter"/>
    </div>
</div>

</body>
</html>
