<%@ page import="com.master.TripRate" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'tripRate.label', default: 'TripRate')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-tripRate" class="content scaffold-show" role="main">
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
                <ol class="property-list tripRate">

                    <g:if test="${tripRateInstance?.location}">
                        <li class="fieldcontain">
                            <span id="location-label" class="property-label"><g:message
                                    code="tripRate.location.label"
                                    default="Location"/></span> :-

                            <span class="property-value" aria-labelledby="location-label"><g:fieldValue
                                    bean="${tripRateInstance}" field="location"/></span>

                        </li>
                    </g:if>

                    <g:if test="${tripRateInstance?.srNo}">
                        <li class="fieldcontain">
                            <span id="srNo-label" class="property-label"><g:message
                                    code="tripRate.srNo.label"
                                    default="Sr No"/></span> :-

                            <span class="property-value" aria-labelledby="srNo-label"><g:fieldValue
                                    bean="${tripRateInstance}" field="srNo"/></span>

                        </li>
                    </g:if>

                    <g:if test="${tripRateInstance?.createdBy}">
                        <li class="fieldcontain">
                            <span id="createdBy-label" class="property-label"><g:message
                                    code="tripRate.createdBy.label"
                                    default="Created By"/></span> :-

                            <span class="property-value" aria-labelledby="createdBy-label">
                                ${tripRateInstance?.createdBy?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${tripRateInstance?.lastUpdatedBy}">
                        <li class="fieldcontain">
                            <span id="lastUpdatedBy-label" class="property-label"><g:message
                                    code="tripRate.lastUpdatedBy.label"
                                    default="Last Updated By"/></span> :-

                            <span class="property-value" aria-labelledby="lastUpdatedBy-label">
                                ${tripRateInstance?.lastUpdatedBy?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${tripRateInstance?.lastUpdated}">
                        <li class="fieldcontain">
                            <span id="lastUpdated-label" class="property-label"><g:message
                                    code="tripRate.lastUpdated.label"
                                    default="Last Updated"/></span> :-

                            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                                    date="${tripRateInstance?.lastUpdated}"/></span>

                        </li>
                    </g:if>

                    <g:if test="${tripRateInstance?.dateCreated}">
                        <li class="fieldcontain">
                            <span id="dateCreated-label" class="property-label"><g:message
                                    code="tripRate.dateCreated.label"
                                    default="Date Created"/></span> :-

                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${tripRateInstance?.dateCreated}"/></span>

                        </li>
                    </g:if>

                    <g:if test="${tripRateInstance?.isActive}">
                        <li class="fieldcontain">
                            <span id="isActive-label" class="property-label"><g:message
                                    code="tripRate.isActive.label"
                                    default="Is Active"/></span> :-

                            <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                    boolean="${tripRateInstance?.isActive}"/></span>

                        </li>
                    </g:if>

                    <g:if test="${tripRateInstance?.financialYear}">
                        <li class="fieldcontain">
                            <span id="financialYear-label" class="property-label"><g:message
                                    code="tripRate.financialYear.label"
                                    default="Financial Year"/></span> :-

                            <span class="property-value" aria-labelledby="financialYear-label">
                                ${tripRateInstance?.financialYear?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${tripRateInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message
                                    code="tripRate.branch.label"
                                    default="Branch"/></span> :-

                            <span class="property-value" aria-labelledby="branch-label">
                                ${tripRateInstance?.branch?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${tripRateInstance?.rate}">
                        <li class="fieldcontain">
                            <span id="rate-label" class="property-label"><g:message
                                    code="tripRate.rate.label"
                                    default="Rate"/></span> :-

                            <span class="property-value" aria-labelledby="rate-label"><g:fieldValue
                                    bean="${tripRateInstance}" field="rate"/></span>

                        </li>
                    </g:if>

                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="id" value="${tripRateInstance?.id}"/>
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${tripRateInstance?.id}"
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
