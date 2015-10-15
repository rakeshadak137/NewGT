<div class="table-header">
    <g:message code="default.list.label" args="[entityName]"/>
    %{--<g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"--}%
            %{--action="create">--}%
        %{--<i class="icon-pencil bigger-50"></i>New--}%
    %{--</g:link>--}%
</div>
%{--<g:if test="${flash.message}">--}%
    %{--<div class="message" role="status">${flash.message}</div>--}%
%{--</g:if>--}%

<div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">
    %{--<div class="row-fluid">--}%
        %{--<div class="span6">--}%
            %{--<div id="sample-table-2_length" class="dataTables_length">--}%
                %{--<label>Display <select name="sample-table-2_length" size="1" aria-controls="sample-table-2">--}%
                    %{--<option value="10" selected="selected">10</option><option value="25">25</option>--}%
                    %{--<option value="50">50</option><option value="100">100</option>--}%
                %{--</select></label>--}%
            %{--</div>--}%
        %{--</div>--}%

        %{--<div class="span6">--}%
            %{--<div class="dataTables_filter" id="sample-table-2_filter">--}%
                %{--<label>Search: <input type="text" aria-controls="sample-table-2" style="width: inherit"></label>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-2"
           aria-describedby="sample-table-2_info">

        <thead>
        <tr>
            <th>Action</th>

            <th><g:message code="template.subject.label"
                           default="Subject"/></th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${templateInstanceList}" status="i" var="templateInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <g:form><td style="width: 50px;">
                    <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                    <g:hiddenField name="id" value="${templateInstance?.id}"/>
                    <g:hiddenField name="version" value="${templateInstance?.version}"/>
                    %{--<g:link action="edit" id="${templateInstance?.id}">--}%
                        %{--<i class="icon-pencil bigger-130"></i>--}%
                    %{--</g:link>   &nbsp;&nbsp;&nbsp;&nbsp;--}%
                    <g:actionSubmitImage value="delete" action="delete"
                                         src="${resource(dir: 'assets/avatars',file: 'delete1.png')}"
                                         onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>

                </td></g:form>

                <td>${fieldValue(bean: templateInstance, field: "subject")}
                </td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
    <g:paginate total="${templateInstanceTotal}"/>
    </div>
</div>