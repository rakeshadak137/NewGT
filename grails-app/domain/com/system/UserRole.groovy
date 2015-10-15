package com.system


class UserRole implements Serializable {

    User user
    Role role

    static  constraints = {
        user()
        role()
    }

}
