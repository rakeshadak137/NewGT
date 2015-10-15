class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

//		"/"(view:"/login/auth")
		"/"(controller:'login',action: 'auth')
		"500"(view:'/error')
	}
}
