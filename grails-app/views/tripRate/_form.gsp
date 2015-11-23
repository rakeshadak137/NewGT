<%@ page import="com.master.TripRate" %>

<script>
    function TripRateController($scope, $http) {
        init();

        function init() {
            $scope.rate = 0;

            <g:if test="${tripRateInstance?.id}">
                $scope.rate = ${tripRateInstance?.rate}
            </g:if>
        }

        $scope.isNumber = function (a) {
            return isNumberKey(a);
        };
    }
</script>

<div ng-controller="TripRateController">
    <table>

        <tr>

            <div class="fieldcontain ${hasErrors(bean: tripRateInstance, field: 'location', 'error')} ">
                <td><label for="location">
                    <g:message code="tripRate.location.label" default="Location"/>

                </label></td>
                <td><g:textField name="location" value="${tripRateInstance?.location}" required=""/></td>
            </div>

        </tr>

        <tr>

            <div class="fieldcontain ${hasErrors(bean: tripRateInstance, field: 'srNo', 'error')} ">
                <td><label for="srNo">
                    <g:message code="tripRate.srNo.label" default="Sr No"/>

                </label></td>
                <td><g:textField name="srNo" value="${tripRateInstance?.srNo}" required=""/></td>
            </div>

        </tr>

        <tr>

            <div class="fieldcontain ${hasErrors(bean: tripRateInstance, field: 'rate', 'error')} required">
                <td><label for="rate">
                    <g:message code="tripRate.rate.label" default="Rate"/>
                    <span class="required-indicator">*</span>
                </label></td>
                <td><input type="text" ng-model="rate" name="rate"
                           value="${fieldValue(bean: tripRateInstance, field: 'rate')}"
                           ng-change="rate=isNumber(rate)"/></td>
            </div>

        </tr>

    </table>
</div>