<%@ page import="com.transaction.InvoiceReceivedEntry" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'invoiceReceivedEntry.label', default: 'InvoiceReceivedEntry')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-invoiceReceivedEntry" class="content scaffold-show" role="main">
            <div class="table-header">
                <g:message code="default.show.label" args="[entityName]"/>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        action="list" params="${[scrid: session['activeScreen'].id]}"><i
                        class="icon-ok bigger-50"></i> List</g:link>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        action="create" params="${[scrid: session['activeScreen'].id]}">
                    <i class="icon-pencil bigger-50"></i>New
                </g:link>

            </div>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div style="margin-left: 50px; margin-right: 50px;" class="widget-main padding-8">
                <ol class="property-list invoiceReceivedEntry">

                    <g:if test="${invoiceReceivedEntryInstance?.receiveDate}">
                        <li class="fieldcontain">
                            <span id="receiveDate-label" class="property-label"><g:message
                                    code="invoiceReceivedEntry.receiveDate.label"
                                    default="Receive Date"/></span> :-

                            <span class="property-value" aria-labelledby="receiveDate-label"><g:formatDate
                                    date="${invoiceReceivedEntryInstance?.receiveDate}"/></span>

                        </li>
                    </g:if>

                    <g:if test="${invoiceReceivedEntryInstance?.goDown}">
                        <li class="fieldcontain">
                            <span id="goDown-label" class="property-label"><g:message
                                    code="invoiceReceivedEntry.goDown.label"
                                    default="Go Down"/></span> :-

                            <span class="property-value" aria-labelledby="goDown-label">
                                ${invoiceReceivedEntryInstance?.goDown?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${invoiceReceivedEntryInstance?.createdBy}">
                        <li class="fieldcontain">
                            <span id="createdBy-label" class="property-label"><g:message
                                    code="invoiceReceivedEntry.createdBy.label"
                                    default="Created By"/></span> :-

                            <span class="property-value" aria-labelledby="createdBy-label">
                                ${invoiceReceivedEntryInstance?.createdBy?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${invoiceReceivedEntryInstance?.lastUpdatedBy}">
                        <li class="fieldcontain">
                            <span id="lastUpdatedBy-label" class="property-label"><g:message
                                    code="invoiceReceivedEntry.lastUpdatedBy.label"
                                    default="Last Updated By"/></span> :-

                            <span class="property-value" aria-labelledby="lastUpdatedBy-label">
                                ${invoiceReceivedEntryInstance?.lastUpdatedBy?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${invoiceReceivedEntryInstance?.lastUpdated}">
                        <li class="fieldcontain">
                            <span id="lastUpdated-label" class="property-label"><g:message
                                    code="invoiceReceivedEntry.lastUpdated.label"
                                    default="Last Updated"/></span> :-

                            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                                    date="${invoiceReceivedEntryInstance?.lastUpdated}"/></span>

                        </li>
                    </g:if>

                    <g:if test="${invoiceReceivedEntryInstance?.dateCreated}">
                        <li class="fieldcontain">
                            <span id="dateCreated-label" class="property-label"><g:message
                                    code="invoiceReceivedEntry.dateCreated.label"
                                    default="Date Created"/></span> :-

                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${invoiceReceivedEntryInstance?.dateCreated}"/></span>

                        </li>
                    </g:if>

                    <g:if test="${invoiceReceivedEntryInstance?.isActive}">
                        <li class="fieldcontain">
                            <span id="isActive-label" class="property-label"><g:message
                                    code="invoiceReceivedEntry.isActive.label"
                                    default="Is Active"/></span> :-

                            <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                    boolean="${invoiceReceivedEntryInstance?.isActive}"/></span>

                        </li>
                    </g:if>

                    <g:if test="${invoiceReceivedEntryInstance?.financialYear}">
                        <li class="fieldcontain">
                            <span id="financialYear-label" class="property-label"><g:message
                                    code="invoiceReceivedEntry.financialYear.label"
                                    default="Financial Year"/></span> :-

                            <span class="property-value" aria-labelledby="financialYear-label">
                                ${invoiceReceivedEntryInstance?.financialYear?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${invoiceReceivedEntryInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message
                                    code="invoiceReceivedEntry.branch.label"
                                    default="Branch"/></span> :-

                            <span class="property-value" aria-labelledby="branch-label">
                                ${invoiceReceivedEntryInstance?.branch?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${invoiceReceivedEntryInstance?.child}">
                        <li class="fieldcontain">
                            <span id="child-label" class="property-label"><g:message
                                    code="invoiceReceivedEntry.child.label"
                                    default="Child"/></span> :-

                            <g:each in="${invoiceReceivedEntryInstance.child}" var="c">
                                <span class="property-value" aria-labelledby="child-label">
                                    ${c?.encodeAsHTML()}
                                </span>
                            </g:each>

                        </li>
                    </g:if>

                    <g:if test="${invoiceReceivedEntryInstance?.srNo}">
                        <li class="fieldcontain">
                            <span id="srNo-label" class="property-label"><g:message
                                    code="invoiceReceivedEntry.srNo.label"
                                    default="Sr No"/></span> :-

                            <span class="property-value" aria-labelledby="srNo-label"><g:fieldValue
                                    bean="${invoiceReceivedEntryInstance}" field="srNo"/></span>

                        </li>
                    </g:if>

                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="id" value="${invoiceReceivedEntryInstance?.id}"/>
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${invoiceReceivedEntryInstance?.id}"
                                params="${[scrid: session['activeScreen'].id]}"><g:message
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
