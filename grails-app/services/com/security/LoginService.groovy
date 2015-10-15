package com.security

import com.system.Role
import com.system.RoleRights
import com.system.User
import com.system.UserRole

class LoginService {

    def screenRole(Long id) {

        def userScreenRights = []
        def userRights = UserRole.findByUser(User.findById(id));
        // findAll ByRole
        def roleRights = RoleRights.findAllByRights(Role.findById(userRights.role.id));

        roleRights.each { ro ->
            userScreenRights.push(
                    [canView: ro.canView, screenId: ro.screen.id, canAdd: ro.canAdd, canEdit: ro.canUpdate, canDelete: ro.canDelete, canPrint: ro.canPrint,moduleId:ro.module.id,subModuleId:ro.subModule.id]
            )
        }
        return userScreenRights;
    }


}
