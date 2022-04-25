<%@ Page Language="VB" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<meta charset="utf-8" />
    <script src="../sys01/themes/jquery-1.11.1.min.js"></script>
    <link href="../sys01/themes/jquery-ui.css" rel="stylesheet" />

    <title>CSI MONITOR</title>
    <style>
        .customers_main {
          font-family: Arial, Helvetica, sans-serif;
          border-collapse: collapse;
          width: 100%;
        }

        .customers_main td, .customers_main th {
          border: 1px solid #ddd;
          padding: 10px;
        }

        /*.customers tr:nth-child(even){background-color: #f2f2f2;}*/
        .customers_main tr{background-color: white;}

        

        .customers_main th {
          padding-top: 12px;
          padding-bottom: 12px;
          text-align: left;
          background-color: #4CAF50;
          color: white;
        }

        
        .customers {
          font-family: Arial, Helvetica, sans-serif;
          border-collapse: collapse;
          width: 100%;
        }

        .customers td, .customers th {
          border: 1px solid #ddd;
          padding: 10px;
        }

        /*.customers tr:nth-child(even){background-color: #f2f2f2;}*/
        .customers tr{background-color: white;}

        .customers tr:hover {background-color: #fd79a8;}

        .customers th {
          padding-top: 12px;
          padding-bottom: 12px;
          text-align: left;
          background-color: #4CAF50;
          color: white;
        }
        
         select, input {
            padding: 5px 5px 5px 5px; font-size:12pt;
        }
    </style>
        <script>
            /*Linkage dataset .net to javascript*/
            var MASTER_ITEM1 = [];//new Array(20, 200); //สร้าง ITEM            
            var STAFF_NAME = "";
    </script>
</head>
    <%



'0    uid 
'1    req_job1 
'2    req_installlocation 
'3    req_installdept 
'4    req_jobdatefinish 
'5    req_staffname1 
'6    req_staffname2 
'7    req_staffname3 
'8    req_staffname4 
'9    C_DATE 
'10    CSI_1_1 
'11   CSI_1_2 
'12   CSI_1_3 
'13   CSI_2_1 
'14   CSI_2_2 
'15   CSI_2_3 
'16   CSI_3_1 
'17   CSI_3_2 
'18   CSI_3_3 
'19   CSI_4_1 
'20   CSI_4_2 
'21   CSI_4_3 
'22   CSI_4_4 
'23   CSI_5_1 
'24   CSI_5_2 
'25   CSI1 
'26   CSI2 
'27   CSI3 
'28   CSI4 
'29   CSI5 
'30   CSI_AVG 
'31   CS_SUGGESTION


   %>
<body>
    <div style="width:100%; align-content:center">    
    <table style="width:98%" class="customers_main">
        <tr>
            <th colspan="2">Account Receipt Update</th>
        </tr>
        <tr>
            <td style="width:60%;vertical-align:top">
                <input id="myInput" style="width:94%; padding: 12px 12px 12px 12px; font-size:14pt" type="text" placeholder="Search.." /><br />
                <table id="tb_order_list" style="width:100%" class="customers">
                    <tr>
                        <th>#</th>
                        <th>Hospital</th>
                        <th>TOPIC</th>
                        <th>ENGINEER</th>
                        <th><a href="avg1.aspx" target="_blank">AVG(1)</a></th>
                        <th><a href="avg1.aspx" target="_blank">AVG(2)</a></th>
                        <th><a href="avg1.aspx" target="_blank">AVG(3)</a></th>
                        <th><a href="avg1.aspx" target="_blank">AVG(4)</a></th>
                        <th><a href="avg1.aspx" target="_blank">AVG(5)</a></th>
                        <th>AVG (All)</th>
                    </tr>
                    <tbody id="myTable">
                           <% 

                               Dim cls As New MY_CLASS_MSSQL
                               cls.strSql = "SELECT SYS01_TS_REQUEST.uid, SYS01_TS_REQUEST.req_job1, SYS01_TS_REQUEST.req_installlocation, SYS01_TS_REQUEST.req_installdept, SYS01_TS_REQUEST.req_jobdatefinish, SYS01_TS_REQUEST.req_staffname1, SYS01_TS_REQUEST.req_staffname2, SYS01_TS_REQUEST.req_staffname3, SYS01_TS_REQUEST.req_staffname4, SYS04_TS_CSIRESULT.C_DATE, SYS04_TS_CSIRESULT.CSI_1_1, SYS04_TS_CSIRESULT.CSI_1_2, SYS04_TS_CSIRESULT.CSI_1_3, SYS04_TS_CSIRESULT.CSI_2_1, SYS04_TS_CSIRESULT.CSI_2_2, SYS04_TS_CSIRESULT.CSI_2_3, SYS04_TS_CSIRESULT.CSI_3_1, SYS04_TS_CSIRESULT.CSI_3_2, SYS04_TS_CSIRESULT.CSI_3_3, SYS04_TS_CSIRESULT.CSI_4_1, SYS04_TS_CSIRESULT.CSI_4_2, SYS04_TS_CSIRESULT.CSI_4_3, SYS04_TS_CSIRESULT.CSI_4_4, SYS04_TS_CSIRESULT.CSI_5_1, SYS04_TS_CSIRESULT.CSI_5_2, SYS04_TS_CSIRESULT.CSI1, SYS04_TS_CSIRESULT.CSI2, SYS04_TS_CSIRESULT.CSI3, SYS04_TS_CSIRESULT.CSI4, SYS04_TS_CSIRESULT.CSI5, SYS04_TS_CSIRESULT.CSI_AVG, SYS04_TS_CSIRESULT.CS_SUGGESTION FROM SYS04_TS_CSIRESULT INNER JOIN SYS01_TS_REQUEST ON SYS04_TS_CSIRESULT.C_REFERENCE = SYS01_TS_REQUEST.uid ORDER BY SYS01_TS_REQUEST.uid DESC"

                               cls.strSql = "SELECT " &
                                               "SYS01_TS_REQUEST.uid, SYS01_TS_REQUEST.req_job1, SYS01_TS_REQUEST.req_installlocation, SYS01_TS_REQUEST.req_installdept" &
                                               ", SYS01_TS_REQUEST.req_jobdatefinish, SYS01_TS_REQUEST.req_staffname1, SYS01_TS_REQUEST.req_staffname2" &
                                               ", SYS01_TS_REQUEST.req_staffname3, SYS01_TS_REQUEST.req_staffname4, SYS04_TS_CSIRESULT.C_DATE, SYS04_TS_CSIRESULT.CSI_1_1, SYS04_TS_CSIRESULT.CSI_1_2" &
                                               ", SYS04_TS_CSIRESULT.CSI_1_3, SYS04_TS_CSIRESULT.CSI_2_1, SYS04_TS_CSIRESULT.CSI_2_2, SYS04_TS_CSIRESULT.CSI_2_3" &
                                               ", SYS04_TS_CSIRESULT.CSI_3_1, SYS04_TS_CSIRESULT.CSI_3_2, SYS04_TS_CSIRESULT.CSI_3_3, SYS04_TS_CSIRESULT.CSI_4_1" &
                                               ", SYS04_TS_CSIRESULT.CSI_4_2, SYS04_TS_CSIRESULT.CSI_4_3, SYS04_TS_CSIRESULT.CSI_4_4, SYS04_TS_CSIRESULT.CSI_5_1" &
                                               ", SYS04_TS_CSIRESULT.CSI_5_2, SYS04_TS_CSIRESULT.CSI1, SYS04_TS_CSIRESULT.CSI2, SYS04_TS_CSIRESULT.CSI3" &
                                               ", SYS04_TS_CSIRESULT.CSI4, SYS04_TS_CSIRESULT.CSI5, SYS04_TS_CSIRESULT.CSI_AVG, SYS04_TS_CSIRESULT.CS_SUGGESTION " &
                                       "FROM " &
                                               "SYS04_TS_CSIRESULT " &
                                                   "INNER JOIN SYS01_TS_REQUEST ON SYS04_TS_CSIRESULT.C_REFERENCE = SYS01_TS_REQUEST.uid " &
                                       "ORDER BY SYS01_TS_REQUEST.uid DESC"
                               cls.func_SetDataSet(cls.strSql, "ORDER")

                               If cls.ds.Tables("ORDER").Rows.Count > 0 Then
                                   Dim bg_color As String = "style='background-color:#fab1a0'"
                                   For i As Integer = 0 To cls.ds.Tables("ORDER").Rows.Count - 1
                                       With cls.ds.Tables("ORDER").Rows(i)

                                           Response.Write("<tr>")
                                           Response.Write("<td>#<b>" & .Item("uid").ToString & "</b><br /><span style='font-size:0.9em'> (" & CDate(.Item("req_jobdatefinish")).ToString("yyyy-MM-dd") & ")</span></td>")
                                           Response.Write("<td>" & .Item("req_job1").ToString() & "</td>")

                                           Response.Write("<td>")
                                           Response.Write("Hospital: " & .Item("req_installlocation").ToString)
                                           Response.Write("<br/>Location: " & .Item("req_installdept").ToString)
                                           Response.Write("</td>")


                                           Response.Write("<td>")
                                           Response.Write("S1: " & .Item("req_staffname1").ToString)
                                           If .Item("req_staffname2").ToString.Length > 5 Then Response.Write("<br/>S2: " & .Item("req_staffname2").ToString)
                                           If .Item("req_staffname3").ToString.Length > 5 Then Response.Write("<br/>S3: " & .Item("req_staffname3").ToString)
                                           If .Item("req_staffname4").ToString.Length > 5 Then Response.Write("<br/>S4: " & .Item("req_staffname4").ToString)
                                           Response.Write("<br/>Location: " & .Item("req_installdept").ToString)
                                           Response.Write("</td>")

                                           Response.Write("<td>" & CDec(.Item("csi1").ToString).ToString("#0.00") & "</td>")
                                           Response.Write("<td>" & CDec(.Item("csi2").ToString).ToString("#0.00") & "</td>")
                                           Response.Write("<td>" & CDec(.Item("csi3").ToString).ToString("#0.00") & "</td>")
                                           Response.Write("<td>" & CDec(.Item("csi4").ToString).ToString("#0.00") & "</td>")
                                           Response.Write("<td>" & CDec(.Item("csi5").ToString).ToString("#0.00") & "</td>")
                                           Response.Write("<td style='text-align:center;color:blue;cursor: pointer;' onclick = ""show_detail('" & .Item("uid").ToString & "'," & i & ")"" >" & CDec(.Item("CSI_AVG").ToString).ToString("#0.00") & "</td>")

                                           Response.Write("</tr>")
                                           %>
                                           <script>
                                               MASTER_ITEM1.push(["<%response.Write(.Item(0).ToString)%>", "<%response.Write(.Item(1).ToString)%>", "<%response.Write(.Item(2).ToString)%>", "<%response.Write(.Item(3).ToString)%>", "<%response.Write(.Item(4).ToString)%>", "<%response.Write(.Item(5).ToString)%>", "<%response.Write(.Item(6).ToString)%>", "<%response.Write(.Item(7).ToString)%>", "<%response.Write(.Item(8).ToString)%>", "<%response.Write(.Item(9).ToString)%>", "<%response.Write(.Item(10).ToString)%>", "<%response.Write(.Item(11).ToString)%>", "<%response.Write(.Item(12).ToString)%>", "<%response.Write(.Item(13).ToString)%>", "<%response.Write(.Item(14).ToString)%>", "<%response.Write(.Item(15).ToString)%>", "<%response.Write(.Item(16).ToString)%>", "<%response.Write(.Item(17).ToString)%>", "<%response.Write(.Item(18).ToString)%>", "<%response.Write(.Item(19).ToString)%>", "<%response.Write(.Item(20).ToString)%>", "<%response.Write(.Item(21).ToString)%>", "<%response.Write(.Item(22).ToString)%>", "<%response.Write(.Item(23).ToString)%>", "<%response.Write(.Item(24).ToString)%>", "<%response.Write(.Item(25).ToString)%>", "<%response.Write(.Item(26).ToString)%>", "<%response.Write(.Item(27).ToString)%>", "<%response.Write(.Item(28).ToString)%>", "<%response.Write(.Item(29).ToString)%>", "<%response.Write(.Item(30).ToString)%>", "<%response.Write(.Item(31).ToString)%>"]);
                                           </script>
                            <%
                                        End With
                                    Next

                                End If %>
                        </tbody>
                </table>
            </td>
            <td style="width:40%;vertical-align: top;">
               
                <table width="100%">
                    <tr>
                        <th colspan="2" style="background-color:#6c5ce7;text-align:center ">รายละเอียดการประเมิน</th>
                    </tr>
                    <tr>
                        <th>รหัสงาน</th>
                        <td><span id="_id"></span></td>
                    </tr>
                    <tr>
                        <th>ชื่องาน</th>
                        <td><span id="_title"></span></td>
                    </tr>
                    <tr>
                        <th>ลูกค้า</th>
                        <td><span id="_hospital"></span></td>
                    </tr>
                    <tr>
                        <th>ผู้ปฏิบัติงาน</th>
                        <td><span id="_staff"></span></td>
                    </tr>
                    <tr>
                        <th>วันที่ปิดงาน</th>
                        <td><span id="_fdate"></span></td>
                    </tr>
                    <tr>
                        <th>วันที่ประเมิน</th>
                        <td><span id="_cdate"></span></td>
                    </tr>
                    <tr>
                        <th>คะแนนเฉลี่ย</th>
                        <td><span id="_score"></span></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            คะแนนรายข้อ
                            <table width="100%" style="text-align:center!important;">
                                <tr>
                                    <th style="background-color:brown;text-align:center;">NO</th>
                                    <th style="background-color:brown;text-align:center;">(1)</th>
                                    <th style="background-color:brown;text-align:center;">(2)</th>
                                    <th style="background-color:brown;text-align:center;">(3)</th>
                                    <th style="background-color:brown;text-align:center;">(4)</th>
                                    <th style="background-color:brown;text-align:center;">(AVG)</th>
                                </tr>
                                <tr>
                                    <th>1.</th>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_11"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_12"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_13"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_14"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_1"></span></td>
                                </tr>
                                <tr>
                                    <th>2.</th>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_21"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_22"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_23"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_24"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_2"></span></td>
                                </tr>
                                <tr>
                                    <th>3.</th>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_31"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_32"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_33"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_34"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_3"></span></td>
                                </tr>
                                <tr>
                                    <th>4.</th>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_41"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_42"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_43"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_44"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_4"></span></td>
                                </tr>
                                <tr>
                                    <th>5.</th>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_51"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_52"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_53"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_54"></span></td>
                                    <td style="text-align:right; padding-right: 3px;"><span id="_5"></span></td>
                                </tr>   
                            </table>
                        </td>
                    </tr>                
            </td>
        </tr>
    </table>
    </div>
</body>    
</html>


<script>

    var getUrlParameter = function getUrlParameter(sParam) {
        var sPageURL = window.location.search.substring(1),
            sURLVariables = sPageURL.split('&'),
            sParameterName,
            i;

        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');

            if (sParameterName[0] === sParam) {
                return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
            }
        }
    };

    $(document).ready(function () {

        $("#myInput").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#tb_order_list tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
            $(".tr_main").show();
        });

        try {
            var xx = getUrlParameter('j');
            if (xx.length > 0) {
                for (i = 0; i < MASTER_ITEM1.length - 1; i++) {
                    if (xx == MASTER_ITEM1[i][0]) {
                        show_detail(xx, i);
                        break;
                    }
                }
                
            }
        }
        catch (err) {
            document.getElementById("demo").innerHTML = err.message;
        }

    });

    function show_detail(order_no, row_index) {
        $("#_id").html(MASTER_ITEM1[row_index][0]);
        $("#_title").html(MASTER_ITEM1[row_index][1]);
        $("#_hospital").html(MASTER_ITEM1[row_index][2] + "<br />" + MASTER_ITEM1[row_index][3]);
        $("#_fdate").html(MASTER_ITEM1[row_index][4]);

        var staffs = MASTER_ITEM1[row_index][5];
        if (MASTER_ITEM1[row_index][6].length > 3) { staffs += "<br />" + MASTER_ITEM1[row_index][6]; }
        if (MASTER_ITEM1[row_index][7].length > 3) { staffs += "<br />" + MASTER_ITEM1[row_index][7]; }
        if (MASTER_ITEM1[row_index][8].length > 3) { staffs += "<br />" + MASTER_ITEM1[row_index][8]; }

        $("#_staff").html(staffs);
        $("#_cdate").html(MASTER_ITEM1[row_index][9]);
        $("#_11").html(parseFloat(MASTER_ITEM1[row_index][10]).toFixed(2));
        $("#_12").html(parseFloat(MASTER_ITEM1[row_index][11]).toFixed(2));
        $("#_13").html(parseFloat(MASTER_ITEM1[row_index][12]).toFixed(2));
        $("#_21").html(parseFloat(MASTER_ITEM1[row_index][13]).toFixed(2));
        $("#_22").html(parseFloat(MASTER_ITEM1[row_index][14]).toFixed(2));
        $("#_23").html(parseFloat(MASTER_ITEM1[row_index][15]).toFixed(2));
        $("#_31").html(parseFloat(MASTER_ITEM1[row_index][16]).toFixed(2));
        $("#_32").html(parseFloat(MASTER_ITEM1[row_index][17]).toFixed(2));
        $("#_33").html(parseFloat(MASTER_ITEM1[row_index][18]).toFixed(2));
        $("#_41").html(parseFloat(MASTER_ITEM1[row_index][19]).toFixed(2));
        $("#_42").html(parseFloat(MASTER_ITEM1[row_index][20]).toFixed(2));
        $("#_43").html(parseFloat(MASTER_ITEM1[row_index][21]).toFixed(2));
        $("#_44").html(parseFloat(MASTER_ITEM1[row_index][22]).toFixed(2));
        $("#_51").html(parseFloat(MASTER_ITEM1[row_index][23]).toFixed(2));
        $("#_52").html(parseFloat(MASTER_ITEM1[row_index][24]).toFixed(2));
        $("#_1").html(parseFloat(MASTER_ITEM1[row_index][25]).toFixed(2));
        $("#_2").html(parseFloat(MASTER_ITEM1[row_index][26]).toFixed(2));
        $("#_3").html(parseFloat(MASTER_ITEM1[row_index][27]).toFixed(2));
        $("#_4").html(parseFloat(MASTER_ITEM1[row_index][28]).toFixed(2));
        $("#_5").html(parseFloat(MASTER_ITEM1[row_index][29]).toFixed(2));
        $("#_score").html(parseFloat(MASTER_ITEM1[row_index][30]).toFixed(2));
    }


  
</script>