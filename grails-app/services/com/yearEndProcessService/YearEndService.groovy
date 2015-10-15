package com.yearEndProcessService

/**
 * Created with IntelliJ IDEA.
 * User: Rajpal
 * Date: 4/18/14
 * Time: 6:30 PM
 * To change this template use File | Settings | File Templates.
 */
class YearEndService {

    public String getNextFinancialYear(String year) {
        String[] s1 = year.split("-");
        int y = Integer.parseInt(s1[1]);
        String s2 = s1[1] + "-" + (y + 1)

        return s2;
    }

    public String getPreviousFinancialYear(String year) {
        String[] s1 = year.split("-");
        int y = Integer.parseInt(s1[0]);
        String s2 = (y - 1) + "-" + s1[0]

        return s2;
    }
}
