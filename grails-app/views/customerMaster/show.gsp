<%@ page import="com.master.CustomerMaster" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'customerMaster.label', default: 'CustomerMaster')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-customerMaster" class="content scaffold-show" role="main">
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
                <ol class="property-list customerMaster">

                    <g:if test="${customerMasterInstance?.name}">
                        <li class="fieldcontain">
                            <span id="name-label" class="property-label"><g:message
                                    code="customerMaster.name.label"
                                    default="Name"/></span> :-

                            <span class="property-value" aria-labelledby="name-label"><g:fieldValue
                                    bean="${customerMasterInstance}" field="name"/></span>

                        </li>
                    </g:if>

                    <g:if test="${customerMasterInstance?.address}">
                        <li class="fieldcontain">
                            <span id="address-label" class="property-label"><g:message
                                    code="customerMaster.address.label"
                                    default="Address"/></span> :-

                            <span class="property-value" aria-labelledby="address-label"><g:fieldValue
                                    bean="${customerMasterInstance}" field="address"/></span>

                        </li>
                    </g:if>

                    <g:if test="${customerMasterInstance?.mobileNo}">
                        <li class="fieldcontain">
                            <span id="mobileNo-label" class="property-label"><g:message
                                    code="customerMaster.mobileNo.label"
                                    default="Mobile No"/></span> :-

                            <span class="property-value" aria-labelledby="mobileNo-label"><g:fieldValue
                                    bean="${customerMasterInstance}" field="mobileNo"/></span>

                        </li>
                    </g:if>

                    <g:if test="${customerMasterInstance?.branch}">
                        <li class="fieldcontain">
                            <span id="branch-label" class="property-label"><g:message
                                    code="customerMaster.branch.label"
                                    default="Branch"/></span> :-

                            <span class="property-value" aria-labelledby="branch-label">
                                ${customerMasterInstance?.branch?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${customerMasterInstance?.createdBy}">
                        <li class="fieldcontain">
                            <span id="createdBy-label" class="property-label"><g:message
                                    code="customerMaster.createdBy.label"
                                    default="Created By"/></span> :-

                            <span class="property-value" aria-labelledby="createdBy-label">
                                ${customerMasterInstance?.createdBy?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${customerMasterInstance?.lastUpdatedBy}">
                        <li class="fieldcontain">
                            <span id="lastUpdatedBy-label" class="property-label"><g:message
                                    code="customerMaster.lastUpdatedBy.label"
                                    default="Last Updated By"/></span> :-

                            <span class="property-value" aria-labelledby="lastUpdatedBy-label">
                                ${customerMasterInstance?.lastUpdatedBy?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${customerMasterInstance?.lastUpdated}">
                        <li class="fieldcontain">
                            <span id="lastUpdated-label" class="property-label"><g:message
                                    code="customerMaster.lastUpdated.label"
                                    default="Last Updated"/></span> :-

                            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                                    date="${customerMasterInstance?.lastUpdated}"/></span>

                        </li>
                    </g:if>

                    <g:if test="${customerMasterInstance?.dateCreated}">
                        <li class="fieldcontain">
                            <span id="dateCreated-label" class="property-label"><g:message
                                    code="customerMaster.dateCreated.label"
                                    default="Date Created"/></span> :-

                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${customerMasterInstance?.dateCreated}"/></span>

                        </li>
                    </g:if>

                    <g:if test="${customerMasterInstance?.isActive}">
                        <li class="fieldcontain">
                            <span id="isActive-label" class="property-label"><g:message
                                    code="customerMaster.isActive.label"
                                    default="Is Active"/></span> :-

                            <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                    boolean="${customerMasterInstance?.isActive}"/></span>

                        </li>
                    </g:if>

                    <g:if test="${customerMasterInstance?.financialYear}">
                        <li class="fieldcontain">
                            <span id="financialYear-label" class="property-label"><g:message
                                    code="customerMaster.financialYear.label"
                                    default="Financial Year"/></span> :-

                            <span class="property-value" aria-labelledby="financialYear-label">
                                ${customerMasterInstance?.financialYear?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="id" value="${customerMasterInstance?.id}"/>
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${customerMasterInstance?.id}"
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
