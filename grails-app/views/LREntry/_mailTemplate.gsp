<%--
  Created by IntelliJ IDEA.
  User: anil
  Date: 13-Aug-14
  Time: 10:44 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
%{--<html>--}%
%{--<head>--}%
    %{--<title>LR Entry</title>--}%
%{--</head>--}%

%{--<body>--}%
%{--<table style="font-style: italic">--}%
    %{--<th>From</th><td>${LREntryInstance?.fromCustomer?.accountName}</td>--}%

    %{--<div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">--}%
    %{--<table class="table table-striped table-bordered table-hover dataTable">--}%
        %{--<tr>--}%
            %{--<th>Invoice No</th>--}%
            %{--<th>Description</th>--}%
            %{--<th>Quantity</th>--}%
            %{--<th>Packing</th>--}%
            %{--<th>Wt. Per Piece</th>--}%
            %{--<th>Total Wt.</th>--}%
            %{--<th>Rate</th>--}%
            %{--<th>Total Amt</th>--}%
        %{--</tr>--}%
        %{--<g:each in="${LREntryInstance?.lrEntryDetails}" var="c">--}%
            %{--<tr>--}%
                %{--<td>${c?.invoiceNo}</td>--}%
                %{--<td>${c?.productName?.productName}</td>--}%
                %{--<td>${c?.qty}</td>--}%
                %{--<td>${c?.invoiceQty}</td>--}%
                %{--<td>${c?.weight}</td>--}%
                %{--<td></td>--}%
                %{--<td>${c?.rate}</td>--}%
                %{--<td>${c?.totalAmount}</td>--}%
            %{--</tr>--}%
        %{--</g:each>--}%
    %{--</table>--}%
    %{--</div>--}%
%{--</table>--}%
%{--</body>--}%
%{--</html>--}%


<html>
<head>
    <title>LR Entry</title>

</head>

<body>
<table border="1" align="center">

    <tr>
        <td>



            %{--<table border="1" align="center">--}%
                %{--<tr>--}%
                    %{--<td>--}%
                        %{--<h3 align="Center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ganesh Transport&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>--}%
                    %{--</td>--}%

                %{--</tr>--}%

                %{--<tr>--}%
                    %{--<td>--}%
                        %{--<h4 align="Center" style="font-style: italic">Transport Contractor</h4>--}%
                    %{--</td>--}%
                %{--</tr>--}%

            %{--</table>--}%

            %{--<hr>--}%
            %{--<p align="center">--}%
                %{--Head off: Northland Commercial Complex, Shop No.3, Plot No.5 Sec.1 Near Vaishnovdevi Mandir, Indrayni nagar, Bhosari, Pune-26--}%
                %{--<br>--}%
                %{--Mob: 9850050582, 9822014897--}%
                %{--<br>--}%
                %{--Branch Off: W-12, MIDC. Waluj, Aurangabad, E-mail:- ganeshtransport92@gmail.com, Mob.: 9881374442--}%
            %{--</p>--}%
            %{--<hr>--}%
            <table border="1" align="center">

                <thead>
                <tr>
                    <td>From:${LREntryInstance?.fromCustomer?.accountName}</td>
                    <td>Vehicle No:${LREntryInstance?.vehicleNo}</td>
                    <td>Date:${LREntryInstance?.dateCreated?.format("dd-MM-yyyy")}</td>
                    <td>LR No.:${LREntryInstance?.lrNo}</td>


                </tr>
                <tr>
                    <td>To:${LREntryInstance?.toCustomer?.accountName}</td>
                    <td>Total:${LREntryInstance?.grandTotal}</td>
                    <td></td>
                    <td></td>

                </tr>
                </thead>
            </table>

            <table align="center" border="1">
                <tr>
                    <th>Invoice No</th>
                    <th>Description</th>
                    <th>Quantity</th>
                    <th>Packing</th>
                    <th>Wt. Per Piece</th>
                    <th>Total Wt.</th>
                    <th>Rate</th>
                    <th>Total Amt</th>
                </tr>
                <g:each in="${LREntryInstance?.lrEntryDetails}" var="c">
                    <tr>
                        <td>${c?.invoiceNo}</td>
                        <td>${c?.productName?.productName}</td>
                        <td>${c?.qty}</td>
                        <td>${c?.invoiceQty}</td>
                        <td>${c?.weight}</td>
                        <td>${c?.qty * c?.weight}</td>
                        <td>${c?.rate}</td>
                        <td>${c?.totalAmount}</td>
                    </tr>
                </g:each>
            </table>
    </tr>
</td><br/>
    <tr>
        <td>

            <table align="center" border="1">

                %{--<g:each in="${LREntryInstance?.lrEntryDetails}" var="c">--}%
                    <tr>
                        <td>Freight:${LREntryInstance?.freight}</td>
                        <td>Loading:${LREntryInstance?.loading}</td>
                        <td>UnLoading:${LREntryInstance?.unloading}</td>
                        <td>Collection:${LREntryInstance?.collection} </td>


                    </tr>
                    <tr>
                        <td>Cartage:${LREntryInstance?.cartage}</td>
                        <td>Cata:${LREntryInstance?.cata}</td>
                        <td>Bilty:${LREntryInstance?.bilty}</td>
                        <td>Door Delivery:${LREntryInstance?.doorDelivery}</td>


                    </tr>
                %{--</g:each>--}%


            </table>
        </td>


    </tr>
    <tr>
        <td>
            %{--<p style="float:right">Trip Rate:</p>--}%
        </td>
    </tr>

    <tr>
        <td>

            <p style="float:right">For GANESH TRANSPORT</p><br/>
            <p style="float:left">Receivers Signature & Stamp</p>
            <p style="float:right;padding-left: 400px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Authorised Signatory</p>

        </td>

    </tr>
</td>
</tr>
</table>
</body>
</html>