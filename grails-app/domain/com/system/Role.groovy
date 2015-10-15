package com.system


class Role {
    String authority


    static mapping = {
        cache true
    }

    static constraints = {
        authority blank: false, unique: true
    }
    static hasMany = [roleRight: RoleRights]

    String toString() {
        authority
    }
}
