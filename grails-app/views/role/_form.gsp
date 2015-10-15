<%@ page import="com.system.Role" %>
<script>
    function RoleController($scope, $http) {
        init();

        function init() {
            $scope.screenList=[];
            $scope.screenModule=[];
            $scope.screenCanList=[];
            $http.post("/${grailsApplication.config.erpName}/role/getFrames?id="+"${roleInstance?.id}")
                    .success(function (data) {
                        debugger;
                        $scope.screenList = data;
                    });
        }

        $scope.allCheck=function(index,bool,pid,mid,sid,level){
            debugger;
            if(level == 1){
                var cl = $scope.screenList[index].module.length;
                for(var i=0;i<cl;i++){
                    $scope.screenList[index].module[i].bool=bool;
                    var ml = $scope.screenList[index].module[i].module.length;
                    for(var y=0;y<ml;y++){
                        $scope.screenList[index].module[i].module[y].bool =bool;
                        var zl = $scope.screenList[index].module[i].module[y].module.length;
                        for(var z=0;z<zl;z++){
                            $scope.screenList[index].module[i].module[y].module[z].bool =bool;
                        }
                    }
                }
            }else if(level == 2){
//                alert("ParentIndex :"+pid+"  ModuleIndex: "+mid+" ScreenIndex: "+sid);
                var can2 = $scope.screenList[pid].module;
                var boosh2=false;
                for(var s in can2){
                    if(can2[s].bool){
                        boosh2 = can2[s].bool;
                    }
                }
                var ml1 = $scope.screenList[pid].module[index].module.length;
                for(var y1=0;y1<ml1;y1++){
                    $scope.screenList[pid].module[index].module[y1].bool =bool;
                    var zl1 = $scope.screenList[pid].module[index].module[y1].module.length;
                    for(var z1=0;z1<zl1;z1++){
                        $scope.screenList[pid].module[index].module[y1].module[z1].bool =bool;
                    }
                }
                $scope.screenList[pid].bool=boosh2;


            }else if(level == 3){
//                alert("ParentIndex :"+pid+"  ModuleIndex: "+mid+" ScreenIndex: "+sid);
                var can3 = $scope.screenList[pid].module[mid].module;
                var boosh3=false;
                for(var s in can3){
                    if(can3[s].bool){
                        boosh3 = can3[s].bool;
                    }
                }
                var zl2 = $scope.screenList[pid].module[mid].module[index].module.length;
                for(var cd=0;cd<zl2;cd++){
                    $scope.screenList[pid].module[mid].module[index].module[cd].bool =bool;
                }
                $scope.screenList[pid].module[mid].bool=boosh3;
                var can31 = $scope.screenList[pid].module;
                var boosh31=false;
                for(var s in can31){
                    if(can31[s].bool){
                        boosh31 = can31[s].bool;
                    }
                }
                $scope.screenList[pid].bool=boosh31;


            }else if(level == 4){
//                alert("ParentIndex :"+pid+"  ModuleIndex: "+mid+" ScreenIndex: "+sid);
                var can4 = $scope.screenList[pid].module[mid].module[sid].module;
                var boosh4=false;
                for(var s in can4){
                    if(can4[s].bool){
                        boosh4 = can4[s].bool;
                    }
                }
                $scope.screenList[pid].module[mid].module[sid].bool=boosh4;
                $scope.screenList[pid].module[mid].bool=boosh4;
                $scope.screenList[pid].bool=boosh4;
                var can41 = $scope.screenList[pid].module[mid].module;
                var boosh41=false;
                for(var s in can41){
                    if(can41[s].bool){
                        boosh41 = can41[s].bool;
                    }
                }
                $scope.screenList[pid].module[mid].bool=boosh41;
                $scope.screenList[pid].bool=boosh41;

            }
        };
    }
</script>
<style type="text/css">

.wfm { width:500px }

.newui{ list-style:none; }

.newli { padding-top:10px }

</style>
<div ng-controller="RoleController">

    <input type="hidden" value="{{screenList}}" name="screenJSON">

<table>


<tr>

    <div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'authority', 'error')} required">
            <td><label for="authority">
                <g:message code="role.authority.label" default="Authority"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:textField name="authority" required="" value="${roleInstance?.authority}"/></td>
        </div>

    </tr>
    

</table>
    <hr>
    %{--{{"akshay"}}--}%

    <ul class="newui" frang-tree>
        <li class="newli" frang-tree-repeat="node in screenList">
            <div><span class="icon"
                       ng-class="{collapsed: node.collapsed, expanded: !node.collapsed}"
                       ng-show="node.module && node.module.length > 0"
                       ng-click="node.collapsed = !node.collapsed"></span>
                <input type="checkbox" ng-model="node.bool" ng-change="allCheck($index,node.bool,node.parentIndex,node.moduleIndex,node.screenIndex,node.level)"><span class="lbl" ></span>
                <span
                        ng-class="{folder: node.module && node.module.length > 0}"
                        ng-bind="node.name"
                        ng-click="action(node)"></span>
            </div>
            <ul ng-if="!node.collapsed && node.module && node.module.length > 0"
                frang-tree-insert-children="node.module"></ul>
        </li>
    </ul>
    %{--End angular tree view --}%


</div>