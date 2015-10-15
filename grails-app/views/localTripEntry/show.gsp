
<%@ page import="com.transaction.LocalTripEntry" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'localTripEntry.label', default: 'LocalTripEntry')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-localTripEntry" class="content scaffold-show" role="main">
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
                <ol class="property-list localTripEntry">
                    
                    <g:if test="${localTripEntryInstance?.localOutEntryNo}">
                        <li class="fieldcontain">
                            <span id="localOutEntryNo-label" class="property-label"><g:message
                                    code="localTripEntry.localOutEntryNo.label"
                                    default="Local Out Entry No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="localOutEntryNo-label"><g:fieldValue
                                    bean="${localTripEntryInstance}" field="localOutEntryNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.localOutEntryDate}">
                        <li class="fieldcontain">
                            <span id="localOutEntryDate-label" class="property-label"><g:message
                                    code="localTripEntry.localOutEntryDate.label"
                                    default="Local Out Entry Date"/></span> :-
                        
                            <span class="property-value" aria-labelledby="localOutEntryDate-label"><g:formatDate
                                    date="${localTripEntryInstance?.localOutEntryDate}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.fromCustomer}">
                        <li class="fieldcontain">
                            <span id="fromCustomer-label" class="property-label"><g:message
                                    code="localTripEntry.fromCustomer.label"
                                    default="From Customer"/></span> :-
                        
                            <span class="property-value" aria-labelledby="fromCustomer-label">
                                ${localTripEntryInstance?.fromCustomer?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.toCustomer}">
                        <li class="fieldcontain">
                            <span id="toCustomer-label" class="property-label"><g:message
                                    code="localTripEntry.toCustomer.label"
                                    default="To Customer"/></span> :-
                        
                            <span class="property-value" aria-labelledby="toCustomer-label">
                                ${localTripEntryInstance?.toCustomer?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.godown}">
                        <li class="fieldcontain">
                            <span id="godown-label" class="property-label"><g:message
                                    code="localTripEntry.godown.label"
                                    default="Godown"/></span> :-
                        
                            <span class="property-value" aria-labelledby="godown-label">
                                ${localTripEntryInstance?.godown?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.localOutTime}">
                        <li class="fieldcontain">
                            <span id="localOutTime-label" class="property-label"><g:message
                                    code="localTripEntry.localOutTime.label"
                                    default="Local Out Time"/></span> :-
                        
                            <span class="property-value" aria-labelledby="localOutTime-label">
                            %{--<g:formatDate date="${localTripEntryInstance?.localOutTime}"/></span>--}%
                            <g:fieldValue  bean="${localTripEntryInstance}" field="localOutTime"/></span>
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.poNo}">
                        <li class="fieldcontain">
                            <span id="poNo-label" class="property-label"><g:message
                                    code="localTripEntry.poNo.label"
                                    default="Po No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="poNo-label">
                                ${localTripEntryInstance?.poNo?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.transportName}">
                        <li class="fieldcontain">
                            <span id="transportName-label" class="property-label"><g:message
                                    code="localTripEntry.transportName.label"
                                    default="Transport Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="transportName-label"><g:fieldValue
                                    bean="${localTripEntryInstance}" field="transportName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.driverName}">
                        <li class="fieldcontain">
                            <span id="driverName-label" class="property-label"><g:message
                                    code="localTripEntry.driverName.label"
                                    default="Driver Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="driverName-label">
                            <g:fieldValue  bean="${localTripEntryInstance}" field="driverName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.ownerName}">
                        <li class="fieldcontain">
                            <span id="ownerName-label" class="property-label"><g:message
                                    code="localTripEntry.ownerName.label"
                                    default="Owner Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="ownerName-label"><g:fieldValue
                                    bean="${localTripEntryInstance}" field="ownerName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.address}">
                        <li class="fieldcontain">
                            <span id="address-label" class="property-label"><g:message
                                    code="localTripEntry.address.label"
                                    default="Address"/></span> :-
                        
                            <span class="property-value" aria-labelledby="address-label"><g:fieldValue
                                    bean="${localTripEntryInstance}" field="address"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.phoneNo}">
                        <li class="fieldcontain">
                            <span id="phoneNo-label" class="property-label"><g:message
                                    code="localTripEntry.phoneNo.label"
                                    default="Phone No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="phoneNo-label"><g:fieldValue
                                    bean="${localTripEntryInstance}" field="phoneNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.vehicleNo}">
                        <li class="fieldcontain">
                            <span id="vehicleNo-label" class="property-label"><g:message
                                    code="localTripEntry.vehicleNo.label"
                                    default="Vehicle No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="vehicleNo-label">
                                ${localTripEntryInstance?.vehicleNo?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.vehicleManual}">
                        <li class="fieldcontain">
                            <span id="vehicleManual-label" class="property-label"><g:message
                                    code="localTripEntry.vehicleManual.label"
                                    default="Vehicle Manual"/></span> :-
                        
                            <span class="property-value" aria-labelledby="vehicleManual-label"><g:fieldValue
                                    bean="${localTripEntryInstance}" field="vehicleManual"/></span>
                            
                        </li>
                    </g:if>
                    
                    %{--<g:if test="${localTripEntryInstance?.dieselReceiptNo}">--}%
                        %{--<li class="fieldcontain">--}%
                            %{--<span id="dieselReceiptNo-label" class="property-label"><g:message--}%
                                    %{--code="localTripEntry.dieselReceiptNo.label"--}%
                                    %{--default="Diesel Receipt No"/></span> :---}%
                        %{----}%
                            %{--<span class="property-value" aria-labelledby="dieselReceiptNo-label"><g:fieldValue--}%
                                    %{--bean="${localTripEntryInstance}" field="dieselReceiptNo"/></span>--}%
                            %{----}%
                        %{--</li>--}%
                    %{--</g:if>--}%
                    
                    %{--<g:if test="${localTripEntryInstance?.dieselReceiptDate}">--}%
                        %{--<li class="fieldcontain">--}%
                            %{--<span id="dieselReceiptDate-label" class="property-label"><g:message--}%
                                    %{--code="localTripEntry.dieselReceiptDate.label"--}%
                                    %{--default="Diesel Receipt Date"/></span> :---}%
                        %{----}%
                            %{--<span class="property-value" aria-labelledby="dieselReceiptDate-label"><g:formatDate--}%
                                    %{--date="${localTripEntryInstance?.dieselReceiptDate}"/></span>--}%
                            %{----}%
                        %{--</li>--}%
                    %{--</g:if>--}%
                    
                    %{--<g:if test="${localTripEntryInstance?.dieselLtr}">--}%
                        %{--<li class="fieldcontain">--}%
                            %{--<span id="dieselLtr-label" class="property-label"><g:message--}%
                                    %{--code="localTripEntry.dieselLtr.label"--}%
                                    %{--default="Diesel Ltr"/></span> :---}%
                        %{----}%
                            %{--<span class="property-value" aria-labelledby="dieselLtr-label"><g:fieldValue--}%
                                    %{--bean="${localTripEntryInstance}" field="dieselLtr"/></span>--}%
                            %{----}%
                        %{--</li>--}%
                    %{--</g:if>--}%
                    
                    %{--<g:if test="${localTripEntryInstance?.dieselRate}">--}%
                        %{--<li class="fieldcontain">--}%
                            %{--<span id="dieselRate-label" class="property-label"><g:message--}%
                                    %{--code="localTripEntry.dieselRate.label"--}%
                                    %{--default="Diesel Rate"/></span> :---}%
                        %{----}%
                            %{--<span class="property-value" aria-labelledby="dieselRate-label"><g:fieldValue--}%
                                    %{--bean="${localTripEntryInstance}" field="dieselRate"/></span>--}%
                            %{----}%
                        %{--</li>--}%
                    %{--</g:if>--}%
                    
                    %{--<g:if test="${localTripEntryInstance?.dieselAmount}">--}%
                        %{--<li class="fieldcontain">--}%
                            %{--<span id="dieselAmount-label" class="property-label"><g:message--}%
                                    %{--code="localTripEntry.dieselAmount.label"--}%
                                    %{--default="Diesel Amount"/></span> :---}%
                        %{----}%
                            %{--<span class="property-value" aria-labelledby="dieselAmount-label"><g:fieldValue--}%
                                    %{--bean="${localTripEntryInstance}" field="dieselAmount"/></span>--}%
                            %{----}%
                        %{--</li>--}%
                    %{--</g:if>--}%
                    
                    %{--<g:if test="${localTripEntryInstance?.pumpName}">--}%
                        %{--<li class="fieldcontain">--}%
                            %{--<span id="pumpName-label" class="property-label"><g:message--}%
                                    %{--code="localTripEntry.pumpName.label"--}%
                                    %{--default="Pump Name"/></span> :---}%
                        %{----}%
                            %{--<span class="property-value" aria-labelledby="pumpName-label"><g:fieldValue--}%
                                    %{--bean="${localTripEntryInstance}" field="pumpName"/></span>--}%
                            %{----}%
                        %{--</li>--}%
                    %{--</g:if>--}%
                    %{----}%
                    %{--<g:if test="${localTripEntryInstance?.freight}">--}%
                        %{--<li class="fieldcontain">--}%
                            %{--<span id="freight-label" class="property-label"><g:message--}%
                                    %{--code="localTripEntry.freight.label"--}%
                                    %{--default="Freight"/></span> :---}%
                        %{----}%
                            %{--<span class="property-value" aria-labelledby="freight-label"><g:fieldValue--}%
                                    %{--bean="${localTripEntryInstance}" field="freight"/></span>--}%
                            %{----}%
                        %{--</li>--}%
                    %{--</g:if>--}%
                    
                    <g:if test="${localTripEntryInstance?.totalTripRate}">
                        <li class="fieldcontain">
                            <span id="totalTripRate-label" class="property-label"><g:message
                                    code="localTripEntry.totalTripRate.label"
                                    default="Total Trip Rate"/></span> :-
                        
                            <span class="property-value" aria-labelledby="totalTripRate-label"><g:fieldValue
                                    bean="${localTripEntryInstance}" field="totalTripRate"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.advance}">
                        <li class="fieldcontain">
                            <span id="advance-label" class="property-label"><g:message
                                    code="localTripEntry.advance.label"
                                    default="Advance"/></span> :-
                        
                            <span class="property-value" aria-labelledby="advance-label"><g:fieldValue
                                    bean="${localTripEntryInstance}" field="advance"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.balance}">
                        <li class="fieldcontain">
                            <span id="balance-label" class="property-label"><g:message
                                    code="localTripEntry.balance.label"
                                    default="Balance"/></span> :-
                        
                            <span class="property-value" aria-labelledby="balance-label"><g:fieldValue
                                    bean="${localTripEntryInstance}" field="balance"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${localTripEntryInstance?.createdBy}">
                        <li class="fieldcontain">
                            <span id="createdBy-label" class="property-label"><g:message
                                    code="localTripEntry.createdBy.label"
                                    default="Created By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="createdBy-label">
                                ${localTripEntryInstance?.createdBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    %{--<g:if test="${localTripEntryInstance?.lastUpdatedBy}">--}%
                        %{--<li class="fieldcontain">--}%
                            %{--<span id="lastUpdatedBy-label" class="property-label"><g:message--}%
                                    %{--code="localTripEntry.lastUpdatedBy.label"--}%
                                    %{--default="Last Updated By"/></span> :---}%
                        %{----}%
                            %{--<span class="property-value" aria-labelledby="lastUpdatedBy-label">--}%
                                %{--${localTripEntryInstance?.lastUpdatedBy?.encodeAsHTML()}</span>--}%
                            %{----}%
                        %{--</li>--}%
                    %{--</g:if>--}%
                    
                    %{--<g:if test="${localTripEntryInstance?.lastUpdated}">--}%
                        %{--<li class="fieldcontain">--}%
                            %{--<span id="lastUpdated-label" class="property-label"><g:message--}%
                                    %{--code="localTripEntry.lastUpdated.label"--}%
                                    %{--default="Last Updated"/></span> :---}%
                        %{----}%
                            %{--<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate--}%
                                    %{--date="${localTripEntryInstance?.lastUpdated}"/></span>--}%
                            %{----}%
                        %{--</li>--}%
                    %{--</g:if>--}%
                    
                    <g:if test="${localTripEntryInstance?.dateCreated}">
                        <li class="fieldcontain">
                            <span id="dateCreated-label" class="property-label"><g:message
                                    code="localTripEntry.dateCreated.label"
                                    default="Date Created"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${localTripEntryInstance?.dateCreated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    %{--<g:if test="${localTripEntryInstance?.isActive}">--}%
                        %{--<li class="fieldcontain">--}%
                            %{--<span id="isActive-label" class="property-label"><g:message--}%
                                    %{--code="localTripEntry.isActive.label"--}%
                                    %{--default="Is Active"/></span> :---}%
                        %{----}%
                            %{--<span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean--}%
                                    %{--boolean="${localTripEntryInstance?.isActive}"/></span>--}%
                            %{----}%
                        %{--</li>--}%
                    %{--</g:if>--}%
                    
                    <g:if test="${localTripEntryInstance?.financialYear}">
                        <li class="fieldcontain">
                            <span id="financialYear-label" class="property-label"><g:message
                                    code="localTripEntry.financialYear.label"
                                    default="Financial Year"/></span> :-
                        
                            <span class="property-value" aria-labelledby="financialYear-label">
                                ${localTripEntryInstance?.financialYear?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    %{--<g:if test="${localTripEntryInstance?.branch}">--}%
                        %{--<li class="fieldcontain">--}%
                            %{--<span id="branch-label" class="property-label"><g:message--}%
                                    %{--code="localTripEntry.branch.label"--}%
                                    %{--default="Branch"/></span> :---}%
                        %{----}%
                            %{--<span class="property-value" aria-labelledby="branch-label">--}%
                                %{--${localTripEntryInstance?.branch?.encodeAsHTML()}</span>--}%
                            %{----}%
                        %{--</li>--}%
                    %{--</g:if>--}%
                    
                    <g:if test="${localTripEntryInstance?.localOutEntryDetails}">
                        <li class="fieldcontain">
                            <span id="localOutEntryDetails-label" class="property-label"><g:message
                                    code="localTripEntry.localOutEntryDetails.label"
                                    default="Local Out Entry Details"/></span> :-
                        
                            <g:each in="${localTripEntryInstance.localOutEntryDetails}" var="l">
                                <span class="property-value" aria-labelledby="localOutEntryDetails-label">
                                    ${l?.encodeAsHTML()}
                                </span>
                            </g:each>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="id" value="${localTripEntryInstance?.id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${localTripEntryInstance?.id}" params="${[scrid:session['activeScreen'].id]}"><g:message
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
