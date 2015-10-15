import grails.converters.JSON

class BootStrap {
    def screenDataFeedService
    def dataFeedService
    def init = { servletContext ->
        screenDataFeedService.screen();
        dataFeedService.insertData();

        JSON.registerObjectMarshaller(Date){
            return it?.format("yyyy-MM-dd");
        }
    }
    def destroy = {
    }
}
