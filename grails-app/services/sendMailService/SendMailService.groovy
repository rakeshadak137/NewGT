package sendMailService

class SendMailService {

    def mailService(def childs,def tempChild,def extraDesc,def path){

        boolean flag=false;
        def returnData=[];
        if(childs && tempChild){

            String emailSubject=childs?.templateName[0];
            childs.each {sub->
                tempChild.each {tc->
                    if(tc.bool){
                        try
                        {
                            sendMail {
                                multipart true
                                to tc.email
                                subject "Mail from School"
                                html extraDesc
//                              attachBytes './web-app/images/grails_logo.jpg','image/jpg', new File('./web-app/images/grails_logo.jpg').readBytes()
                                if(path)
                                {
                                    attachBytes path,'image/jpg', new File(path).readBytes()
                                }


                            }
                            flag=true;
                            if(flag)
                            {
                                returnData.push([
                                        to: tc?.email?:"",
                                        emailSubject:emailSubject?:"",
                                        status:flag
                                ])
                            }
                        }catch(Exception e){
                                return false
                        }
                    }

                }
            }
        }
        return returnData;
    }

    def smsService(childs,tempChild,extraDesc){

    def returnData=[];
        String sendNumbers="";
        int count=0;
        boolean  flag=false;
        if(childs && tempChild){

            childs.each{ch->
                tempChild.each{tc->
                    if(tc.bool){
                                  count=count+1;
                                  if(count==1){
                                                sendNumbers=tc.mobileNo
                                              }
                                  else if(count!=1){
                                                       sendNumbers=sendNumbers+","+tc.mobileNo
                                                   }
                        returnData.push([
                                          mob:tc?.mobileNo?:""
                                       ])
                }
                }

            }
//            sms Gateway API Code Starts Here
            try {
                // Construct data
                String data = "";

                data += "username=" + URLEncoder.encode("anilaaher", "ISO-8859-1");   // anilaaher
                data += "&password=" + URLEncoder.encode("8605014080", "ISO-8859-1");
                data += "&message=" + URLEncoder.encode(extraDesc, "ISO-8859-1");
                data += "&want_report=1";
                data += "&msisdn=" + sendNumbers;

                // Send data
                URL url = new URL("http://bulksms.vsms.net:5567/eapi/submission/send_sms/2/2.0");


                URLConnection conn = url.openConnection();
                conn.setDoOutput(true);
                OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
                wr.write(data);
                wr.flush();

                // Get the response
                BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String line;
                while ((line = rd.readLine()) != null) {
                    // Print the response output...
                    System.out.println(line);
                }
                wr.close();
                rd.close();


            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return returnData
    }
}
