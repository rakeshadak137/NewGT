<%@ page import="com.master.CategoryMaster" %>

<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: categoryMasterInstance, field: 'categoryName', 'error')} ">
            <td><label for="categoryName">
                <g:message code="categoryMaster.categoryName.label" default="Category Name"/>
                
            </label></td>
            <td><g:textField name="categoryName" id="categoryName" autofocus="" value="${categoryMasterInstance?.categoryName}"/></td>
        </div>

    </tr>
    
</table>