
<%@ page import="com.master.BankMaster" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'bankMaster.label', default: 'BankMaster')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>
    <div class="row-fluid" style="margin-left:30px; width:95%; margin-top: 15px;">
        %{--<div class="row-fluid" style="margin-left:30px; width:95%">--}%
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%

        <div id="list-bankMaster" class="content scaffold-list" role="main">
            <div class="table-header">
                <g:message code="default.list.label" args="[entityName]"/>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        params="${[scrid: session['activeScreen'].id]}" action="create">
                    <i class="icon-pencil bigger-50"></i>New
                </g:link>
            </div>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">
                <div class="row-fluid">
                    <div class="span6">
                        <div id="sample-table-2_length" class="dataTables_length">
                            <label>Display <select name="sample-table-2_length" size="1" aria-controls="sample-table-2">
                                <option value="10" selected="selected">10</option><option value="25">25</option>
                                <option value="50">50</option><option value="100">100</option>
                            </select> records</label>
                        </div>
                    </div>

                    <div class="span6">
                        <div class="dataTables_filter" id="sample-table-2_filter">
                            <label>Search: <input type="text" aria-controls="sample-table-2"></label>
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-2"
                       aria-describedby="sample-table-2_info">

                    <thead>
                    <tr>
                        <th>Action</th>
                        
                        <g:sortableColumn property="bankName" title="${message(code: 'bankMaster.bankName.label', default: 'Bank Name')}"/>
                        
                        <g:sortableColumn property="accountNo" title="${message(code: 'bankMaster.accountNo.label', default: 'Account No')}"/>
                        
                        <g:sortableColumn property="address" title="${message(code: 'bankMaster.address.label', default: 'Address')}"/>
                        
                        <th><g:message code="bankMaster.createdBy.label"
                                       default="Created By"/></th>
                        
                        <th><g:message code="bankMaster.lastUpdatedBy.label"
                                       default="Last Updated By"/></th>
                        
                        <g:sortableColumn property="lastUpdated" title="${message(code: 'bankMaster.lastUpdated.label', default: 'Last Updated')}"/>
                        
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${bankMasterInstanceList}" status="i" var="bankMasterInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <g:form><td style="width: 50px;">

                                <g:hiddenField name="id" value="${bankMasterInstance?.id}"/>
                                <g:hiddenField name="version" value="${bankMasterInstance?.version}"/>
                                <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                                <g:link action="edit" id="${bankMasterInstance?.id}" params="${[scrid: session['activeScreen'].id]}">
                                    <i class="icon-pencil bigger-130"></i>
                                </g:link>   &nbsp;&nbsp;&nbsp;&nbsp;
                                <g:actionSubmitImage value="delete" action="delete"
                                                     src="${resource(dir: 'assets/avatars',file: 'delete1.png')}"
                                                     onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>

                            </td></g:form>
                            
                            <td>${fieldValue(bean: bankMasterInstance, field: "bankName")}
                            </td>
                            
                            <td>${fieldValue(bean: bankMasterInstance, field: "accountNo")}</td>
                            
                            <td>${fieldValue(bean: bankMasterInstance, field: "address")}</td>
                            
                            <td>${fieldValue(bean: bankMasterInstance, field: "createdBy")}</td>
                            
                            <td>${fieldValue(bean: bankMasterInstance, field: "lastUpdatedBy")}</td>
                            
                            <td><g:formatDate date="${bankMasterInstance.lastUpdated}"/></td>
                            
                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination">
                    <g:paginate total="${bankMasterInstanceTotal}"/>
                </div>
            </div>
        </div>

    </div>
</div>
%{--</div>--}%
</body>
</html>
