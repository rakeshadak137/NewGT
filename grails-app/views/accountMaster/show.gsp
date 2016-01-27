<%@ page import="com.master.AccountMaster" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'accountMaster.label', default: 'AccountMaster')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
<g:render template="/shared/viewHeader"/>

<div class="span12" style="width: 95%;margin-top: 15px;">
%{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


<div id="show-accountMaster" class="content scaffold-show" role="main">
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
<ol class="property-list accountMaster">

<g:if test="${accountMasterInstance?.accountName}">
    <li class="fieldcontain">
        <span id="accountName-label" class="property-label"><g:message
                code="accountMaster.accountName.label"
                default="Account Name"/></span> :-

        <span class="property-value" aria-labelledby="accountName-label"><g:fieldValue
                bean="${accountMasterInstance}" field="accountName"/></span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.address}">
    <li class="fieldcontain">
        <span id="address-label" class="property-label"><g:message
                code="accountMaster.address.label"
                default="Address"/></span> :-

        <span class="property-value" aria-labelledby="address-label"><g:fieldValue
                bean="${accountMasterInstance}" field="address"/></span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.state}">
    <li class="fieldcontain">
        <span id="state-label" class="property-label"><g:message
                code="accountMaster.state.label"
                default="State"/></span> :-

        <span class="property-value" aria-labelledby="state-label">
            ${accountMasterInstance?.state?.encodeAsHTML()}</span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.phoneNo}">
    <li class="fieldcontain">
        <span id="phoneNo-label" class="property-label"><g:message
                code="accountMaster.phoneNo.label"
                default="Phone No"/></span> :-

        <span class="property-value" aria-labelledby="phoneNo-label"><g:fieldValue
                bean="${accountMasterInstance}" field="phoneNo"/></span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.mobileNo}">
    <li class="fieldcontain">
        <span id="mobileNo-label" class="property-label"><g:message
                code="accountMaster.mobileNo.label"
                default="Mobile No"/></span> :-

        <span class="property-value" aria-labelledby="mobileNo-label"><g:fieldValue
                bean="${accountMasterInstance}" field="mobileNo"/></span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.pinCode}">
    <li class="fieldcontain">
        <span id="pinCode-label" class="property-label"><g:message
                code="accountMaster.pinCode.label"
                default="Pin Code"/></span> :-

        <span class="property-value" aria-labelledby="pinCode-label"><g:fieldValue
                bean="${accountMasterInstance}" field="pinCode"/></span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.email}">
    <li class="fieldcontain">
        <span id="email-label" class="property-label"><g:message
                code="accountMaster.email.label"
                default="Email"/></span> :-

        <span class="property-value" aria-labelledby="email-label"><g:fieldValue
                bean="${accountMasterInstance}" field="email"/></span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.contactPerson}">
    <li class="fieldcontain">
        <span id="contactPerson-label" class="property-label"><g:message
                code="accountMaster.contactPerson.label"
                default="Contact Person"/></span> :-

        <span class="property-value" aria-labelledby="contactPerson-label"><g:fieldValue
                bean="${accountMasterInstance}" field="contactPerson"/></span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.contactMobile}">
    <li class="fieldcontain">
        <span id="contactMobile-label" class="property-label"><g:message
                code="accountMaster.contactMobile.label"
                default="Contact Mobile"/></span> :-

        <span class="property-value" aria-labelledby="contactMobile-label"><g:fieldValue
                bean="${accountMasterInstance}" field="contactMobile"/></span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.tinNo}">
    <li class="fieldcontain">
        <span id="tinNo-label" class="property-label"><g:message
                code="accountMaster.tinNo.label"
                default="Tin No"/></span> :-

        <span class="property-value" aria-labelledby="tinNo-label"><g:fieldValue
                bean="${accountMasterInstance}" field="tinNo"/></span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.cstNo}">
    <li class="fieldcontain">
        <span id="cstNo-label" class="property-label"><g:message
                code="accountMaster.cstNo.label"
                default="Cst No"/></span> :-

        <span class="property-value" aria-labelledby="cstNo-label"><g:fieldValue
                bean="${accountMasterInstance}" field="cstNo"/></span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.lastUpdatedBy}">
    <li class="fieldcontain">
        <span id="lastUpdatedBy-label" class="property-label"><g:message
                code="accountMaster.lastUpdatedBy.label"
                default="Last Updated By"/></span> :-

        <span class="property-value" aria-labelledby="lastUpdatedBy-label">
            ${accountMasterInstance?.lastUpdatedBy?.encodeAsHTML()}</span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.lastUpdated}">
    <li class="fieldcontain">
        <span id="lastUpdated-label" class="property-label"><g:message
                code="accountMaster.lastUpdated.label"
                default="Last Updated"/></span> :-

        <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate
                date="${accountMasterInstance?.lastUpdated}"/></span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.dateCreated}">
    <li class="fieldcontain">
        <span id="dateCreated-label" class="property-label"><g:message
                code="accountMaster.dateCreated.label"
                default="Date Created"/></span> :-

        <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                date="${accountMasterInstance?.dateCreated}"/></span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.isActive}">
    <li class="fieldcontain">
        <span id="isActive-label" class="property-label"><g:message
                code="accountMaster.isActive.label"
                default="Is Active"/></span> :-

        <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                boolean="${accountMasterInstance?.isActive}"/></span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.financialYear}">
    <li class="fieldcontain">
        <span id="financialYear-label" class="property-label"><g:message
                code="accountMaster.financialYear.label"
                default="Financial Year"/></span> :-

        <span class="property-value" aria-labelledby="financialYear-label">
            ${accountMasterInstance?.financialYear?.encodeAsHTML()}</span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.city}">
    <li class="fieldcontain">
        <span id="city-label" class="property-label"><g:message
                code="accountMaster.city.label"
                default="City"/></span> :-

        <span class="property-value" aria-labelledby="city-label">
            ${accountMasterInstance?.city?.encodeAsHTML()}</span>

    </li>
</g:if>

<g:if test="${accountMasterInstance?.contactEmail}">
    <li class="fieldcontain">
        <span id="contactEmail-label" class="property-label"><g:message
                code="accountMaster.contactEmail.label"
                default="Contact Email"/></span> :-

        <span class="property-value" aria-labelledby="contactEmail-label"><g:fieldValue
                bean="${accountMasterInstance}" field="contactEmail"/></span>

    </li>
</g:if>

</ol>
<g:form>
    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
        <g:hiddenField name="id" value="${accountMasterInstance?.id}"/>
        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
        <g:link class="btn btn-info btn-small" action="edit" id="${accountMasterInstance?.id}"
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
