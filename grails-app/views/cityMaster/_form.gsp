<%@ page import="com.master.CityMaster" %>

<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: cityMasterInstance, field: 'cityName', 'error')} ">
            <td><label for="cityName">
                <g:message code="cityMaster.cityName.label" default="City Name"/>
                
            </label></td>
            <td><g:textField name="cityName" id="cityName" autofocus="" value="${cityMasterInstance?.cityName}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: cityMasterInstance, field: 'pinCode', 'error')} ">
            <td><label for="pinCode">
                <g:message code="cityMaster.pinCode.label" default="Pin Code"/>
                
            </label></td>
            <td><g:textField name="pinCode" value="${cityMasterInstance?.pinCode}"/></td>
        </div>

    </tr>
    
</table>