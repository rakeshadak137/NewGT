
<%@ page import="com.transaction.InternalMemo" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'internalMemo.label', default: 'InternalMemo')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-internalMemo" class="content scaffold-show" role="main">
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
                <ol class="property-list internalMemo">
                    
                    <g:if test="${internalMemoInstance?.vehicleNo}">
                        <li class="fieldcontain">
                            <span id="vehicleNo-label" class="property-label"><g:message
                                    code="internalMemo.vehicleNo.label"
                                    default="Vehicle NO"/></span> :-
                        
                            <span class="property-value" aria-labelledby="vehicleNo-label">
                                ${internalMemoInstance?.vehicleNo?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.fromDate}">
                        <li class="fieldcontain">
                            <span id="fromDate-label" class="property-label"><g:message
                                    code="internalMemo.fromDate.label"
                                    default="From Date"/></span> :-
                        
                            <span class="property-value" aria-labelledby="fromDate-label"><g:formatDate
                                    date="${internalMemoInstance?.fromDate}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.toDate}">
                        <li class="fieldcontain">
                            <span id="toDate-label" class="property-label"><g:message
                                    code="internalMemo.toDate.label"
                                    default="To Date"/></span> :-
                        
                            <span class="property-value" aria-labelledby="toDate-label"><g:formatDate
                                    date="${internalMemoInstance?.toDate}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.voucherNo}">
                        <li class="fieldcontain">
                            <span id="voucherNo-label" class="property-label"><g:message
                                    code="internalMemo.voucherNo.label"
                                    default="Voucher No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="voucherNo-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="voucherNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.voucherDate}">
                        <li class="fieldcontain">
                            <span id="voucherDate-label" class="property-label"><g:message
                                    code="internalMemo.voucherDate.label"
                                    default="Voucher Date"/></span> :-
                        
                            <span class="property-value" aria-labelledby="voucherDate-label"><g:formatDate
                                    date="${internalMemoInstance?.voucherDate}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.transportName}">
                        <li class="fieldcontain">
                            <span id="transportName-label" class="property-label"><g:message
                                    code="internalMemo.transportName.label"
                                    default="Transport Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="transportName-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="transportName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.driverName}">
                        <li class="fieldcontain">
                            <span id="driverName-label" class="property-label"><g:message
                                    code="internalMemo.driverName.label"
                                    default="Driver Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="driverName-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="driverName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.ownerName}">
                        <li class="fieldcontain">
                            <span id="ownerName-label" class="property-label"><g:message
                                    code="internalMemo.ownerName.label"
                                    default="Owner Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="ownerName-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="ownerName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.address}">
                        <li class="fieldcontain">
                            <span id="address-label" class="property-label"><g:message
                                    code="internalMemo.address.label"
                                    default="Address"/></span> :-
                        
                            <span class="property-value" aria-labelledby="address-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="address"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.phoneNo}">
                        <li class="fieldcontain">
                            <span id="phoneNo-label" class="property-label"><g:message
                                    code="internalMemo.phoneNo.label"
                                    default="Phone No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="phoneNo-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="phoneNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.dieselReceiptNo}">
                        <li class="fieldcontain">
                            <span id="dieselReceiptNo-label" class="property-label"><g:message
                                    code="internalMemo.dieselReceiptNo.label"
                                    default="Diesel Receipt No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dieselReceiptNo-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="dieselReceiptNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.dieselReceiptDate}">
                        <li class="fieldcontain">
                            <span id="dieselReceiptDate-label" class="property-label"><g:message
                                    code="internalMemo.dieselReceiptDate.label"
                                    default="Diesel Receipt Date"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dieselReceiptDate-label"><g:formatDate
                                    date="${internalMemoInstance?.dieselReceiptDate}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.dieselLtr}">
                        <li class="fieldcontain">
                            <span id="dieselLtr-label" class="property-label"><g:message
                                    code="internalMemo.dieselLtr.label"
                                    default="Diesel Ltr"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dieselLtr-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="dieselLtr"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.dieselRate}">
                        <li class="fieldcontain">
                            <span id="dieselRate-label" class="property-label"><g:message
                                    code="internalMemo.dieselRate.label"
                                    default="Diesel Rate"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dieselRate-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="dieselRate"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.dieselAmount}">
                        <li class="fieldcontain">
                            <span id="dieselAmount-label" class="property-label"><g:message
                                    code="internalMemo.dieselAmount.label"
                                    default="Diesel Amount"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dieselAmount-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="dieselAmount"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.pumpName}">
                        <li class="fieldcontain">
                            <span id="pumpName-label" class="property-label"><g:message
                                    code="internalMemo.pumpName.label"
                                    default="Pump Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="pumpName-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="pumpName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.freight}">
                        <li class="fieldcontain">
                            <span id="freight-label" class="property-label"><g:message
                                    code="internalMemo.freight.label"
                                    default="Freight"/></span> :-
                        
                            <span class="property-value" aria-labelledby="freight-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="freight"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.totalTripRate}">
                        <li class="fieldcontain">
                            <span id="totalTripRate-label" class="property-label"><g:message
                                    code="internalMemo.totalTripRate.label"
                                    default="Total Trip Rate"/></span> :-
                        
                            <span class="property-value" aria-labelledby="totalTripRate-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="totalTripRate"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.advance}">
                        <li class="fieldcontain">
                            <span id="advance-label" class="property-label"><g:message
                                    code="internalMemo.advance.label"
                                    default="Advance"/></span> :-
                        
                            <span class="property-value" aria-labelledby="advance-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="advance"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.balance}">
                        <li class="fieldcontain">
                            <span id="balance-label" class="property-label"><g:message
                                    code="internalMemo.balance.label"
                                    default="Balance"/></span> :-
                        
                            <span class="property-value" aria-labelledby="balance-label"><g:fieldValue
                                    bean="${internalMemoInstance}" field="balance"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.createdBy}">
                        <li class="fieldcontain">
                            <span id="createdBy-label" class="property-label"><g:message
                                    code="internalMemo.createdBy.label"
                                    default="Created By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="createdBy-label">
                                ${internalMemoInstance?.createdBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.lastUpdatedBy}">
                        <li class="fieldcontain">
                            <span id="lastUpdatedBy-label" class="property-label"><g:message
                                    code="internalMemo.lastUpdatedBy.label"
                                    default="Last Updated By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdatedBy-label">
                                ${internalMemoInstance?.lastUpdatedBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.lastUpdated}">
                        <li class="fieldcontain">
                            <span id="lastUpdated-label" class="property-label"><g:message
                                    code="internalMemo.lastUpdated.label"
                                    default="Last Updated"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                                    date="${internalMemoInstance?.lastUpdated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.dateCreated}">
                        <li class="fieldcontain">
                            <span id="dateCreated-label" class="property-label"><g:message
                                    code="internalMemo.dateCreated.label"
                                    default="Date Created"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${internalMemoInstance?.dateCreated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.isActive}">
                        <li class="fieldcontain">
                            <span id="isActive-label" class="property-label"><g:message
                                    code="internalMemo.isActive.label"
                                    default="Is Active"/></span> :-
                        
                            <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                    boolean="${internalMemoInstance?.isActive}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.financialYear}">
                        <li class="fieldcontain">
                            <span id="financialYear-label" class="property-label"><g:message
                                    code="internalMemo.financialYear.label"
                                    default="Financial Year"/></span> :-
                        
                            <span class="property-value" aria-labelledby="financialYear-label">
                                ${internalMemoInstance?.financialYear?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message
                                    code="internalMemo.branch.label"
                                    default="Branch"/></span> :-
                        
                            <span class="property-value" aria-labelledby="branch-label">
                                ${internalMemoInstance?.branch?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${internalMemoInstance?.internalMemoDetails}">
                        <li class="fieldcontain">
                            <span id="internalMemoDetails-label" class="property-label"><g:message
                                    code="internalMemo.internalMemoDetails.label"
                                    default="Internal Memo Details"/></span> :-
                        
                            <g:each in="${internalMemoInstance.internalMemoDetails}" var="i">
                                <span class="property-value" aria-labelledby="internalMemoDetails-label">
                                    ${i?.encodeAsHTML()}
                                </span>
                            </g:each>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="id" value="${internalMemoInstance?.id}"/>
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${internalMemoInstance?.id}" params="${[scrid:session['activeScreen'].id]}"><g:message
                                code="default.button.edit.label" default="Edit"/></g:link>
                        <g:actionSubmit class="btn btn-info btn-small" action="delete"
                                        value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>

                        <a ng-href="/${grailsApplication.config.erpName}/InternalMemo/print_action?id=${internalMemoInstance?.id}&scrid=${session['activeScreen'].id}" class="btn btn-info btn-small"
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
