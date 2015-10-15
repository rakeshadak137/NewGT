import com.master.FinancialYear
import com.security.LoginService
import com.system.Role
import com.system.RoleRights
import com.system.Screen
import com.system.User
import com.system.UserRole

//import com.security.LoginService
/*

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import org.springframework.security.authentication.AccountExpiredException
import org.springframework.security.authentication.CredentialsExpiredException
import org.springframework.security.authentication.DisabledException
import org.springframework.security.authentication.LockedException
import org.springframework.security.core.context.SecurityContextHolder as SCH
import org.springframework.security.web.WebAttributes
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
*/
//changes to commit
//changes to commit
//changes to commit
//changes to commit
class LoginController {
    LoginService loginService

    def index = {
        render "LoginController"
    }
    def auth = {


        String view = 'auth'
        String postUrl = "validateUser"

        render view: view, model: [targetUrl: request.requestURI - ".dispatch"]
    }

    def validateUser = {

        //  def config = SpringSecurityUtils.securityConfig
//        if (springSecurityService.isLoggedIn()) {
//            redirect uri: config.successHandler.defaultTargetUrl
//            return
//        }
        //  def targetUrl = params.targetUrl;
        def currentUser = User.findByUsernameAndPassword(params.j_username, params.j_password);
        def currentYear  = FinancialYear.findByYear(params.year)

        if (currentUser && currentUser.enable) {
            session['activeUser'] = currentUser;
            session['financialYear'] = currentYear;
            session['branch'] = currentUser.branch;
            session['screenRole'] = loginService.screenRole(currentUser.id);
            def roleData  = UserRole.findByUser(currentUser as User);
            def result=[];
            def module= Screen.findAllByControllerAndNameIsNotNull(null);
            if(module){
                module.each {m->
                    if(RoleRights.findByModuleAndRights(m as Screen,roleData.role as Role)) {
                        result.push([
                                id  : m.id,
                                name: m.name
                        ])
                    }
                }
                session['screenModule']=result;
            }
            redirect controller: 'main', action: 'index'

        } else {

            redirect(controller: "login", action: "auth");
        }
        //   String view = 'auth'
        // String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"

        //if (targetUrl) {

//            session['activeUser'] = User.getAll().first();
        // } else {
        //     render view: view , model: [targetUrl: targetUrl]
        // }
    }
}

/*

	*/
/**
 * Dependency injection for the authenticationTrustResolver.
 *//*

	def authenticationTrustResolver

	*/
/**
 * Dependency injection for the springSecurityService.
 *//*

	def springSecurityService

	*/
/**
 * Default action; redirects to 'defaultTargetUrl' if logged in, /login/auth otherwise.
 *//*

	def index = {
		if (springSecurityService.isLoggedIn()) {
			redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
		}
		else {
			redirect action: 'auth', params: params
		}
	}

	*/
/**
 * Show the login page.
 *//*

	def auth = {

		def config = SpringSecurityUtils.securityConfig

		if (springSecurityService.isLoggedIn()) {
			redirect uri: config.successHandler.defaultTargetUrl
			return
		}

		String view = 'auth'
		String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
		render view: view, model: [postUrl: postUrl,
		                           rememberMeParameter: config.rememberMe.parameter]
	}

	*/
/**
 * The redirect action for Ajax requests.
 *//*

	def authAjax = {
		response.setHeader 'Location', SpringSecurityUtils.securityConfig.auth.ajaxLoginFormUrl
		response.sendError HttpServletResponse.SC_UNAUTHORIZED
	}

	*/
/**
 * Show denied page.
 */

//	def denied = {
////		if (springSecurityService.isLoggedIn() &&
////				authenticationTrustResolver.isRememberMe(SCH.context?.authentication)) {
//			// have cookie but the page is guarded with IS_AUTHENTICATED_FULLY
////			redirect action: 'full', params: params
//
//	}

/**
 * Login page for users with a remember-me cookie but accessing a IS_AUTHENTICATED_FULLY page.
 *//*

	def full = {
		def config = SpringSecurityUtils.securityConfig
		render view: 'auth', params: params,
			model: [hasCookie: authenticationTrustResolver.isRememberMe(SCH.context?.authentication),
			        postUrl: "${request.contextPath}${config.apf.filterProcessesUrl}"]
	}

	*/
/**
 * Callback after a failed login. Redirects to the auth page with a warning message.
 *//*

	def authfail = {

		def username = session[UsernamePasswordAuthenticationFilter.SPRING_SECURITY_LAST_USERNAME_KEY]
		String msg = ''
		def exception = session[WebAttributes.AUTHENTICATION_EXCEPTION]
		if (exception) {
			if (exception instanceof AccountExpiredException) {
				msg = g.message(code: "springSecurity.errors.login.expired")
			}
			else if (exception instanceof CredentialsExpiredException) {
				msg = g.message(code: "springSecurity.errors.login.passwordExpired")
			}
			else if (exception instanceof DisabledException) {
				msg = g.message(code: "springSecurity.errors.login.disabled")
			}
			else if (exception instanceof LockedException) {
				msg = g.message(code: "springSecurity.errors.login.locked")
			}
			else {
				msg = g.message(code: "springSecurity.errors.login.fail")
			}
		}

		if (springSecurityService.isAjax(request)) {
			render([error: msg] as JSON)
		}
		else {
			flash.message = msg
			redirect action: 'auth', params: params
		}
	}

	*/
/**
 * The Ajax success redirect url.
 *//*

	def ajaxSuccess = {
		render([success: true, username: springSecurityService.authentication.name] as JSON)
	}

	*/
/**
 * The Ajax denied redirect url.
 *//*

	def ajaxDenied = {
		render([error: 'access denied'] as JSON)
	}
}
*/
