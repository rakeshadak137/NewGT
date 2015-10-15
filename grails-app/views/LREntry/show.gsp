
<%@ page import="com.transaction.LREntry" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'LREntry.label', default: 'LREntry')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
    <script>
        function lrController($http,$scope){
            init();
            function init(){
                $scope.showField = "${session['activeUser'].admin}";
            }
        }
    </script>
</head>

<body>
<div ng-controller="lrController">
<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-LREntry" class="content scaffold-show" role="main">
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
                <ol class="property-list LREntry">
                    
                    <g:if test="${LREntryInstance?.lrNo}">
                        <li class="fieldcontain">
                            <span id="lrNo-label" class="property-label"><g:message
                                    code="LREntry.lrNo.label"
                                    default="Lr No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lrNo-label"><g:fieldValue
                                    bean="${LREntryInstance}" field="lrNo"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.lrDate}">
                        <li class="fieldcontain">
                            <span id="lrDate-label" class="property-label"><g:message
                                    code="LREntry.lrDate.label"
                                    default="Lr Date"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lrDate-label"><g:formatDate
                                    date="${LREntryInstance?.lrDate}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.vehicleNo}">
                        <li class="fieldcontain">
                            <span id="vehicleNo-label" class="property-label"><g:message
                                    code="LREntry.vehicleNo.label"
                                    default="Vehicle No"/></span> :-
                        
                            <span class="property-value" aria-labelledby="vehicleNo-label">
                                ${LREntryInstance?.vehicleNo?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.driverName}">
                        <li class="fieldcontain">
                            <span id="driverName-label" class="property-label"><g:message
                                    code="LREntry.driverName.label"
                                    default="Driver Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="driverName-label">
                                ${LREntryInstance?.driverName?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.poNO}">
                        <li class="fieldcontain">
                            <span id="poNO-label" class="property-label"><g:message
                                    code="LREntry.poNO.label"
                                    default="Po NO"/></span> :-
                        
                            <span class="property-value" aria-labelledby="poNO-label"><g:fieldValue
                                    bean="${LREntryInstance}" field="poNO"/></span>
                            
                        </li>
                    </g:if>
                    
                    %{--<g:if test="${LREntryInstance?.billType}">--}%
                        %{--<li class="fieldcontain">--}%
                            %{--<span id="billType-label" class="property-label"><g:message--}%
                                    %{--code="LREntry.billType.label"--}%
                                    %{--default="Bill Type"/></span> :---}%
                        %{----}%
                            %{--<span class="property-value" aria-labelledby="billType-label">--}%
                                %{--${LREntryInstance?.billType?.encodeAsHTML()}</span>--}%
                            %{----}%
                        %{--</li>--}%
                    %{--</g:if>--}%
                    
                    <g:if test="${LREntryInstance?.fromCustomer}">
                        <li class="fieldcontain">
                            <span id="fromCustomer-label" class="property-label"><g:message
                                    code="LREntry.fromCustomer.label"
                                    default="From Customer"/></span> :-
                        
                            <span class="property-value" aria-labelledby="fromCustomer-label">
                                ${LREntryInstance?.fromCustomer?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.toCustomer}">
                        <li class="fieldcontain">
                            <span id="toCustomer-label" class="property-label"><g:message
                                    code="LREntry.toCustomer.label"
                                    default="To Customer"/></span> :-
                        
                            <span class="property-value" aria-labelledby="toCustomer-label">
                                ${LREntryInstance?.toCustomer?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.fromLocation}">
                        <li class="fieldcontain">
                            <span id="fromLocation-label" class="property-label"><g:message
                                    code="LREntry.fromLocation.label"
                                    default="From Location"/></span> :-
                        
                            <span class="property-value" aria-labelledby="fromLocation-label"><g:fieldValue
                                    bean="${LREntryInstance}" field="fromLocation"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.toLocation}">
                        <li class="fieldcontain">
                            <span id="toLocation-label" class="property-label"><g:message
                                    code="LREntry.toLocation.label"
                                    default="To Location"/></span> :-
                        
                            <span class="property-value" aria-labelledby="toLocation-label"><g:fieldValue
                                    bean="${LREntryInstance}" field="toLocation"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.billPayType}">
                        <li class="fieldcontain">
                            <span id="billPayType-label" class="property-label"><g:message
                                    code="LREntry.billPayType.label"
                                    default="Bill Pay Type"/></span> :-
                        
                            <span class="property-value" aria-labelledby="billPayType-label"><g:fieldValue
                                    bean="${LREntryInstance}" field="billPayType"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.particular}">
                        <li class="fieldcontain">
                            <span id="particular-label" class="property-label"><g:message
                                    code="LREntry.particular.label"
                                    default="Particular"/></span> :-
                        
                            <span class="property-value" aria-labelledby="particular-label"><g:fieldValue
                                    bean="${LREntryInstance}" field="particular"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.amount}">
                        <li class="fieldcontain">
                            <span id="amount-label" class="property-label"><g:message
                                    code="LREntry.amount.label"
                                    default="Amount"/></span> :-
                        
                            <span class="property-value" aria-labelledby="amount-label"><g:fieldValue
                                    bean="${LREntryInstance}" field="amount"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.totalAmount}">
                        <li class="fieldcontain">
                            <span id="totalAmount-label" class="property-label"><g:message
                                    code="LREntry.totalAmount.label"
                                    default="Total Amount"/></span> :-
                        
                            <span class="property-value" aria-labelledby="totalAmount-label"><g:fieldValue
                                    bean="${LREntryInstance}" field="totalAmount"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.createdBy}">
                        <li class="fieldcontain">
                            <span id="createdBy-label" class="property-label"><g:message
                                    code="LREntry.createdBy.label"
                                    default="Created By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="createdBy-label">
                                ${LREntryInstance?.createdBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.lastUpdatedBy}">
                        <li class="fieldcontain">
                            <span id="lastUpdatedBy-label" class="property-label"><g:message
                                    code="LREntry.lastUpdatedBy.label"
                                    default="Last Updated By"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdatedBy-label">
                                ${LREntryInstance?.lastUpdatedBy?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.lastUpdated}">
                        <li class="fieldcontain">
                            <span id="lastUpdated-label" class="property-label"><g:message
                                    code="LREntry.lastUpdated.label"
                                    default="Last Updated"/></span> :-
                        
                            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                                    date="${LREntryInstance?.lastUpdated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.dateCreated}">
                        <li class="fieldcontain">
                            <span id="dateCreated-label" class="property-label"><g:message
                                    code="LREntry.dateCreated.label"
                                    default="Date Created"/></span> :-
                        
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${LREntryInstance?.dateCreated}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.isActive}">
                        <li class="fieldcontain">
                            <span id="isActive-label" class="property-label"><g:message
                                    code="LREntry.isActive.label"
                                    default="Is Active"/></span> :-
                        
                            <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                    boolean="${LREntryInstance?.isActive}"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.financialYear}">
                        <li class="fieldcontain">
                            <span id="financialYear-label" class="property-label"><g:message
                                    code="LREntry.financialYear.label"
                                    default="Financial Year"/></span> :-
                        
                            <span class="property-value" aria-labelledby="financialYear-label">
                                ${LREntryInstance?.financialYear?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message
                                    code="LREntry.branch.label"
                                    default="Branch"/></span> :-
                        
                            <span class="property-value" aria-labelledby="branch-label">
                                ${LREntryInstance?.branch?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.goDown}">
                        <li class="fieldcontain">
                            <span id="goDown-label" class="property-label"><g:message
                                    code="LREntry.goDown.label"
                                    default="Go Down"/></span> :-
                        
                            <span class="property-value" aria-labelledby="goDown-label">
                                ${LREntryInstance?.goDown?.encodeAsHTML()}</span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${LREntryInstance?.lrEntryDetails}">
                        <li class="fieldcontain">
                            <span id="lrEntryDetails-label" class="property-label"><g:message
                                    code="LREntry.lrEntryDetails.label"
                                    default="Lr Entry Details"/></span> :-
                        
                            <g:each in="${LREntryInstance.lrEntryDetails}" var="l">
                                <span class="property-value" aria-labelledby="lrEntryDetails-label">
                                    ${l?.encodeAsHTML()}
                                </span>
                            </g:each>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:hiddenField name="id" value="${LREntryInstance?.id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${LREntryInstance?.id}" params="${[scrid:session['activeScreen'].id]}"><g:message
                                code="default.button.edit.label" default="Edit"/></g:link>
                        <g:actionSubmit class="btn btn-info btn-small" action="delete"
                                        value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>

                        <a ng-href="/${grailsApplication.config.erpName}/TransactionReport/LR?id=${LREntryInstance?.id}&scrid=${session['activeScreen'].id}&whiteCopy={{whiteCopy}}" class="btn btn-info btn-small"
                               target="_blank">Print</a>

                        <td ng-show="showField"><a ng-href="/${grailsApplication.config.erpName}/TransactionReport/LR?id=${LREntryInstance?.id}&scrid=${session['activeScreen'].id}&masterPrint=true" class="btn btn-info btn-small"
                                                   target="_blank">Master Print</a></td>

                        <a ng-href="/${grailsApplication.config.erpName}/LREntry/sendPartyMail?id=${LREntryInstance?.id}&scrid=${session['activeScreen'].id}"
                           class="btn btn-info btn-small">Send Mail</a>

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
