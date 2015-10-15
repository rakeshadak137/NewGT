package filter


class ScreenFilters {
    def screenService
    def filters = {
        all(controller: '*', action: '*') {
            before = {
                //if (!request.xhr) {
                String scrid = params['scrid'];
                session['activeScreen'] = scrid ? screenService.getScreenById(scrid) : null
                //  session['financialYear'] = "12-13"
                session['menuId'] = params?.sid
            }
        }
    }
}
