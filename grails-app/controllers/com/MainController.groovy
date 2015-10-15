package com

class MainController {

    def index() {
//        def isLogin = params.isLogin;
//
//        if (isLogin) {
//            if (springSecurityService.isLoggedIn()) {
//                render([sucess: true] as JSON)
//            } else {
//                render(view: "/index")
//            }
//        } else {
        render(view: "/index")
//        }
    }

    def getSubMenu() {
        print("hello main")
        println('Log 4');

        if (session['menuId']) {

            def d = []
            def result = [];
            def uid = session['activeUser'].id;
            def userRights = UserRole.findByUser(User.findById(uid));
            def findModule = RoleRights.findByRightsAndModule(Role.findById(userRights.role.id), Screen.findById(session['menuId']));
            if (findModule) {
                def submodule = Screen.findAllByParentScreen(Screen.findById(session['menuId']));
                if (submodule) {
                    submodule.each { sub ->
                        def data = RoleRights.findAllBySubModuleAndRights(Screen.findById(sub.id), Role.findById(findModule.rights.id));
                        if (data.sort { it.screen.id }) {
                            result = [];
                            data.each { da ->
                                result.push([
                                        domainName: da?.screen?.domainName,
                                        id: da?.screen?.id,
                                        controller: da?.screen?.controller ?: "",
                                        filter: da?.screen?.filter ?: ''
                                ])
                            }
                            d.push([
                                    subMenu: sub.filter,
                                    childs: result,
                                    id: sub.id
                            ])
                        }
                    }
                }
            }
            session["activeSubModule"] = d
            if (d) {
                render(template: '/shared/sideMenu', model: [searchresults: d]);
            }
        }
    }
}
