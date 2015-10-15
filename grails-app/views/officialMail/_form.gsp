<%@ page import="com.system.User; com.master.BranchMaster; com.master.AccountMaster;com.template.OfficialMail" %>
<script>
    function verify() {
        if (!document.getElementById("subject").value) {
            alert("Please Enter Subject")
            return false
        }
        else if (!document.getElementById("description").value) {
            alert("Please Enter description")
            return false
        }
        else {
            return true
        }

    }
</script>
<table>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: officialMailInstance, field: 'assignBy', 'error')} required">
            <td><label for="assignBy">
                <g:message code="officialMail.assignBy.label" default="Assign By"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td>
                <g:select id="assignBy" name="assignBy.id"
                          from="${User.findAllByEnable(true)}"
                          optionKey="id" required="" value="${officialMailInstance?.assignBy?.id}" class="many-to-one"/>
            </td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: officialMailInstance, field: 'publishDate', 'error')} required">
            <td><label for="publishDate">
                <g:message code="officialMail.publishDate.label" default="Publish Date"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><input type="date" name="publishDate"
                       value="${officialMailInstance?.publishDate?.format('yyyy-MM-dd') ?: Date.newInstance().format('yyyy-MM-dd')}"
                       required=""/></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: officialMailInstance, field: 'publishEndDate', 'error')} ">
            <td><label for="publishEndDate">
                <g:message code="officialMail.publishEndDate.label" default="Publish End Date"/>

            </label></td>
            <td><input type="date" name="publishEndDate"
                       value="${officialMailInstance?.publishEndDate?.format('yyyy-MM-dd') ?: Date.newInstance().format('yyyy-MM-dd')}"
                       required=""/></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: officialMailInstance, field: 'assignTo', 'error')} required">
            <td><label for="assignTo">
                <g:message code="officialMail.assignTo.label" default="Assign To"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:select id="assignTo" name="assignTo.id"
                          from="${AccountMaster.findAllByBranchAndIsActive(BranchMaster.findById(session['branch'].id),true)}"
                          optionKey="id" required="" value="${officialMailInstance?.assignTo?.id}"
                          class="many-to-one"/></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: officialMailInstance, field: 'subject', 'error')} ">
            <td><label for="subject">
                <g:message code="officialMail.subject.label" default="Subject"/>

            </label></td>
            <td><g:textField name="subject" value="${officialMailInstance?.subject}" id="subject"/></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: officialMailInstance, field: 'description', 'error')} ">
            <td><label for="description">
                <g:message code="officialMail.description.label" default="Description"/>

            </label></td>
            <td><g:textArea name="description" value="${officialMailInstance?.description}"
                            style="width: 510px; height: 110px" id="description"/></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: officialMailInstance, field: 'attachment', 'error')} ">
            <td><label for="attachment">
                <g:message code="officialMail.attachment.label" default="Attachment"/>

            </label></td>
            <td>
                %{--<input type="file" name="attachment" ng-model="attachment"/>--}%
                <input type="file" name="attachment" ng-model="attachment" ng-change="moreAttachment()"/>
            </td>
        </div>

    </tr>

</table>