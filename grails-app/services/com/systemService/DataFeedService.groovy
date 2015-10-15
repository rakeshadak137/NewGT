package com.systemService

import com.master.BranchMaster
import com.master.FinancialYear
import com.system.Role
import com.system.Screen
import com.system.User
import com.system.UserRole

class DataFeedService {

    def insertData(){

        def br=BranchMaster.first();
        if(!br){
            BranchMaster branch = new BranchMaster(branchName:"Pune",branchAddress:"Bhosari",isActive: true)
            branch.save();
        }

        def us=User.first();
        if(!us){
            User user=new User(username: "admin",password: "admin",admin: true,client: false, enable: true,branch: BranchMaster.findById(1));
            user.save();
        }

        def fy=FinancialYear.first();
        if(!fy){
            FinancialYear fyear=new FinancialYear(year:"2014-15")
            fyear.save();
        }

        def role = Role.first();
        if(!role){
            Role r = new Role(authority: "Administrator")

            def screen = Screen.findAllByFilterAndParentScreenIsNotNull(null);

            screen.each {s ->
                r.addToRoleRight(screen: Screen.findById(s.id as Long),module: Screen.findById(s.parentScreen.parentScreen.id as Long),subModule: Screen.findById(s.parentScreen.id as Long),canAdd: true,canDelete: true,canPrint: true,canUpdate: true,canView: true)
            }
            r.save();
        }

        def userRole = UserRole.first();
        if(!userRole){
            UserRole uRole = new UserRole(user: User.findById(1),role: Role.findById(1))
            uRole.save();
        }
    }
}
