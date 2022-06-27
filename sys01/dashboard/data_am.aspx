 <%@ Page Language="VB" AutoEventWireup="false" CodeFile="data_am.aspx.vb" Inherits="sys01_dashboard_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title> สรุปข้อมูลฝ่าย AM</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- <link href="../css1/bootstrap.min.css" rel="stylesheet" />
    <script src="../js1/jquery-3.3.1.min.js"></script>
    <script src="../js1/popper.min.js"></script>
    <script src="../js1/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />
    -->
    <!-- datatable -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/css/bootstrap.min.css" >
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap5.min.css">
</head>
<style>
    .layout {
    padding-left:30px;
    padding-right:30px;
    padding-top:10PX;
    }
    body{
        background-color:#FFFCF5;
    }
    .table-responsive {
        padding-left:30px;
        padding-right:30px;
    }

    th, td {
      text-align: center;
      padding: 8px;
    }
    th{
        background-color:deepskyblue;
        color: white;
    }


    tr:nth-child(even) {
      background-color:#B7D0E1;
    }
    tr:nth-child(odd) {
      background-color: ghostwhite;
    }

</style>

<script type="text/javascript" >
    var JOB_DATA = [];
    var AM_LIST = [];
    var STAFF_LIST = [];    
</script>
<%
    Dim cls As New MY_CLASS_MSSQL()
    'Search Form Query
    Dim query_am_list As String
    Dim query_staff_list As String

    'Recieve Form Value
    Dim input_am_id, input_year, input_staff_id, input_am_name As String
    input_am_id = Request.QueryString("req_am_id")
    input_staff_id = Request.Form("req_staff_id")

    'input_am_name = Request.Form("req_am_name")
    input_am_name = Request.QueryString("req_am_name")

    'AM List
    query_am_list = "SELECT STAFF_ID , STAFF_NAME, STAFF_LNAME FROM  SYS01_MS_STAFF WHERE  (STAFF_TYPE LIKE '%AREAMANAGER%') ORDER BY STAFF_ID"
    cls.strSql = query_am_list
    cls.func_SetDataSet(cls.strSql, "AMList")

    'Staff List
    query_staff_list = "SELECT STAFF_ID , STAFF_NAME, STAFF_LNAME FROM SYS01_MS_STAFF ORDER BY  STAFF_ID"
    cls.strSql = query_staff_list
    cls.func_SetDataSet(cls.strSql, "StaffList")

    If cls.ds.Tables("AMList").Rows.Count > 0 Then
        Dim VALUE_AM As String = ""
        Dim Name As String
        For i As Integer = 0 To cls.ds.Tables("AMList").Rows.Count - 1
            With cls.ds.Tables("AMList").Rows(i)
%>
                    <script>
                        //Keep data to Array Job_Data
                        AM_LIST.push(["<% response.Write(.Item(0).ToString) %>",
                            "<% response.Write(.Item(1).ToString) %>",
                            "<% response.Write(.Item(2).ToString) %>"]);
                    </script>
<%     

                Name = .Item("STAFF_NAME").ToString & " " & .Item("STAFF_LNAME").ToString
                If input_am_name = Name Then
                    input_am_id = .Item("STAFF_ID").ToString
                End If

                'VALUE_AM &= i.ToString() &
                '.Item("STAFF_ID").ToString & "**" & .Item("STAFF_NAME").ToString & " " &
                '.Item("STAFF_LNAME").ToString & "||"
            End With
        Next
        'Response.Write(Left(VALUE_AM, VALUE_AM.Length - 1))
    End If

    If cls.ds.Tables("StaffList").Rows.Count > 0 Then
        Dim VALUE As String = ""
        For i As Integer = 0 To cls.ds.Tables("StaffList").Rows.Count - 1
            With cls.ds.Tables("StaffList").Rows(i)
%>
                    <script>
                        //Keep data to Array Job_Data
                        AM_LIST.push(["<% response.Write(.Item(0).ToString) %>",
                            "<% response.Write(.Item(1).ToString) %>",
                            "<% response.Write(.Item(2).ToString) %>"]);
                    </script>
<%     
                    'VALUE &= i.ToString() &
                    '.Item("STAFF_ID").ToString & ">> " & .Item("STAFF_NAME").ToString & " " &
                    '.Item("STAFF_LNAME").ToString & "||"
                End With
            Next
            'Response.Write(Left(VALUE, VALUE.Length - 1))
        End If
        %>
<script>
    function myFunction1() {
        var x = document.getElementById("req_am_id");
        x.value = x.value.toUpperCase();
        var y = document.getElementById("req_staff_id");
        y.value = y.value.toUpperCase();
    }  

</script>   

<body>
    <form class="layout" id="form1" runat="server">
    <!-- Fixed navbar -->
    <nav class="navbar navbar-expand-md fixed-top navbar-dark" style="background-color:#0080d6; color:black">
        <a class="navbar-brand" href="data_dashboard.aspx"  style="padding-left:20px;"><b>Saintmed</b></a>
        <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbar" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
        </button>
        <div id = "navbar" class="navbar-collapse collapse" style="padding-left:20px; color:black"">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active"><a class="nav-link" href="data_am.aspx">AM Data</a></li>
                <li class="nav-item"><a class="nav-link" href="data_bm.aspx">BM Data</a></li>
                <li class="nav-item"><a class="nav-link" href="data_engineer.aspx">Engineer Data</a></li>                
             </ul>
        </div>
        </nav>
    <!-- End navbar -->
        
       <!-- <div data-role="header" data-position="inline">
               <div class="container-fluid text-white text-center">
                   <div class="row">
                       <div class="col-md-6">
                          <img src="../../img/SM_LOGO.gif" width="300px" />
                       </div>
                       <div class="col-md-6">
                          <h4>Saintmed: ระบบงานติดตั้ง (Dashboard AM)  </h4>
                       </div>
                    </div>
               </div>
		    </div> <!--End header 
        <div> -->      
    
    <!-- AM Name Repeater List-->
    <br /><br /><br />
    <h3>Saintmed: ระบบงานติดตั้ง (AM)</h3>   
    <!-- Print ค่าที่รับมาจาก Dashboard -->
    <p> <%  'Response.Write(input_am_name) %></p>
    <hr></hr>

    <!--Show Search --> 

        <form action="data_am.aspx" method="post">            
            <div class="row"> 
                 <div class="col">
                   <h6>AM Name :</h6>
                    <select class="form-control" id="req_am_id" name="req_am_id_form" placeholder="เลือก AM "> 
                    <option value=""> </option>
                <%
                    Dim cls As New MY_CLASS_MSSQL()
                    Dim query_am_list As String
                    query_am_list = "SELECT STAFF_ID , STAFF_NAME, STAFF_LNAME FROM  SYS01_MS_STAFF WHERE  (STAFF_TYPE LIKE '%AREAMANAGER%') ORDER BY  STAFF_ID"
                    cls.strSql = query_am_list
                    cls.func_SetDataSet(cls.strSql, "AMList")

                    If cls.ds.Tables("AMList").Rows.Count > 0 Then
                        Dim VALUE As String = ""
                        For i As Integer = 0 To cls.ds.Tables("AMList").Rows.Count - 1
                            With cls.ds.Tables("AMList").Rows(i)
                                VALUE &=
                                "<option value=" & .Item("STAFF_ID").ToString & ">" & .Item("STAFF_NAME").ToString & " " & .Item("STAFF_LNAME").ToString & "</option>"
                            End With
                        Next
                        Response.Write(Left(VALUE, VALUE.Length - 1))
                    End If
                  %>            
                    </select>
                  </div>

                <div class="col" style="color:#FFFCF5;">
                   <h6 style="color:#FFFCF5;">Sales Name</h6>
                    <select class="form-control" id="req_staff_id" name="req_staff_id_form" placeholder="เลือก Sales Staff " style="color:#FFFCF5;"> 
                    <option value="" style="color:#FFFCF5;"></option>
                <%
                    'Dim cls2 As New MY_CLASS_MSSQL()
                    Dim query_sales_list As String
                    query_sales_list = "SELECT STAFF_ID , STAFF_NAME, STAFF_LNAME FROM SYS01_MS_STAFF ORDER BY  STAFF_ID"
                    cls.strSql = query_sales_list
                    cls.func_SetDataSet(cls.strSql, "StaffList")
                    If cls.ds.Tables("StaffList").Rows.Count > 0 Then
                        Dim VALUE2 As String = ""

                    End If
                  %>            
                    </select>
                  </div>
                

                <div class="col">
                   <h6>Request Year:</h6>
                    <select class="form-control" id="req_year" name="req_year_form" placeholder="เลือก ปี "> 
                    <option value="">  </option>
                    <option value="2021"> 2021 </option>
                    <option value="2022"> 2022 </option>
                    <option value="2021"> 2023 </option>
                    <option value="2022"> 2024 </option>
                    <option value="2021"> 2025 </option>
                    <option value="2022"> 2026 </option>                            
                    </select>
                  </div>
            </div> 
            <center>
             <div class="row">
                   <div class="col">
                        <input class="btn btn-primary" id="button1" type="submit" value=" ค้นหา " /> 
                   </div>       
            </div> 
            </center>  
            <hr />
    </form>
    
 <%
     Try
         '*** Read Session ***'
         Dim Ses_req_group, Ses_req_year, Ses_first_AMlist As String
         Ses_req_group = Session("Group")
         Ses_req_year = Session("Year")
         'Show value recive from session
         'Response.Write("Group = " & Session("Group") & "<br>")
         'Response.Write("Year = " & Session("Year") & "<br><br>")

         'Recieve Form Value and Session
         Dim input_am_id, input_year As String
         input_am_id = Request.QueryString("req_am_id")

         '**Cut string**'
         Dim am_id As String
         If input_am_id <> "" Then
             Dim arr_am_id() As String
             arr_am_id = input_am_id.Split("|")
             am_id = arr_am_id(1)
             'MsgBox(">>" + am_id)
             'For count = 0 To arr_am_id.Length - 1
             'MsgBox(arr_am_id(count))
             'Next
         End If


         '** If have the value from first page and have sestion (group) and (years) **'
         If am_id <> "" Then
             'search by AM ID and Session Group and Sesstion Year
             'MsgBox("Keep In Session 1 >>" + am_id + " | " + Ses_req_year + " | " + Ses_req_group)
             Dim query_job_data As String
             query_job_data = "SELECT uid, staff_name, req_installlocation, req_installdate, req_jobtype1, req_job1, req_amname, req_staffname1, req_jobdatefinish , req_status FROM SYS01_TS_REQUEST WHERE req_amid = " + am_id + "and year(req_installdate) = " + Ses_req_year + "and  req_group = " + Ses_req_group
             cls.strSql = query_job_data
             cls.func_SetDataSet(cls.strSql, "JobAMRequest")

             '*** Create Session ***'
             Session.Timeout = 20
             Session("FirstAM_ID") = am_id
             am_id = ""
             Response.Redirect("../dashboard/data_am.aspx")
         ElseIf am_id = "" Then
             'MsgBox("Condition 2 ")
             '*** Read Session ***'
             Ses_req_group = Session("Group")
             Ses_req_year = Session("Year")
             Ses_first_AMlist = Session("FirstAM_ID")

             input_am_id = Request.Form("req_am_id_form")
             input_year = Request.Form("req_year_form")

             If Ses_first_AMlist <> "" Then
                 'search by AM ID and Session Group and Sesstion Year
                 'MsgBox("Condition 5 >>" + Ses_first_AMlist + " | " + Ses_req_year + " | " + Ses_req_group)
                 Dim query_job_data As String
                 query_job_data = "SELECT uid, staff_name, req_installlocation, req_installdate, req_jobtype1, req_job1, req_amname, req_staffname1, req_jobdatefinish , req_status FROM SYS01_TS_REQUEST WHERE req_amid = " + Ses_first_AMlist + "and year(req_installdate) = " + Ses_req_year + "and  req_group = " + Ses_req_group + "and req_status != 'INACTIVE'"
                 cls.strSql = query_job_data
                 cls.func_SetDataSet(cls.strSql, "JobAMRequest")
                 Session("FirstAM_ID") = ""

             ElseIf input_am_id <> "" Or input_year <> "" Then
                 'MsgBox("Condition 6 >>" + input_am_id + " | " + input_year)

                 'Searh by Recieve value
                 If input_am_id <> "" And input_year <> "" Then
                     'search by AM ID and Year and Session Group
                     'MsgBox("Condition 2.1.1 - Search by AM ID and Year>>" + input_am_id + " | " + input_year + " | " + Ses_req_group)
                     Dim query_job_data As String
                     query_job_data = "SELECT uid, staff_name, req_installlocation, req_installdate , req_jobtype1, req_job1, req_amname, req_staffname1, req_jobdatefinish , req_status From SYS01_TS_REQUEST WHERE year(req_installdate) = " + input_year + "and req_amid = " + input_am_id + "and  req_group = " + Ses_req_group + "and req_status != 'INACTIVE'"
                     cls.strSql = query_job_data
                     cls.func_SetDataSet(cls.strSql, "JobAMRequest")

                 ElseIf input_am_id <> "" And input_year = "" Then
                     'search by AM ID only and Session Group
                     'MsgBox("Condition 2.1.2 - Search by AM ID only >>" + input_am_id + " | " + Ses_req_group)
                     Dim query_job_data As String
                     query_job_data = "SELECT uid, staff_name, req_installlocation, req_installdate, req_jobtype1, req_job1, req_amname, req_staffname1, req_jobdatefinish , req_status FROM SYS01_TS_REQUEST WHERE req_amid = " + input_am_id + "and  req_group = " + Ses_req_group + "and req_status != 'INACTIVE'"
                     cls.strSql = query_job_data
                     cls.func_SetDataSet(cls.strSql, "JobAMRequest")

                 ElseIf input_year <> "" And input_am_id = "" Then
                     'search by Year only and Session Group
                     'MsgBox("Condition 2.1.3- Search Year only >>" + input_year + " | " + Ses_req_group)
                     Dim query_job_data As String
                     query_job_data = "SELECT uid, staff_name, req_installlocation, req_installdate , req_jobtype1, req_job1, req_amname, req_staffname1, req_jobdatefinish , req_status From SYS01_TS_REQUEST WHERE year(req_installdate) = " + input_year + "and  req_group = " + Ses_req_group + "and req_status != 'INACTIVE'"
                     cls.strSql = query_job_data
                     cls.func_SetDataSet(cls.strSql, "JobAMRequest")
                 End If


                 If cls.ds.Tables("JobAMRequest").Rows.Count > 0 Then
                     Dim VALUE As String = ""
                     For i As Integer = 0 To cls.ds.Tables("JobAMRequest").Rows.Count - 1
                         With cls.ds.Tables("JobAMRequest").Rows(i)
%>
                    <script>
                        //Keep data to Array Job_Data
                        JOB_DATA.push(["<% response.Write((i + 1).ToString()) %>",
                            "<% response.Write(.Item(0).ToString) %>",
                            "<% response.Write(.Item(1).ToString) %>",
                            "<% response.Write(.Item(2).ToString) %>",
                            "<% response.Write(.Item(3).ToString) %>" , 
                            "<% response.Write(.Item(4).ToString) %>" ,
                            "<% response.Write(.Item(5).ToString) %>" ,
                            "<% response.Write(.Item(6).ToString) %>" ,
                            "<% response.Write(.Item(7).ToString) %>",
                            "<% response.Write(.Item(8).ToString) %>",
                            "<% response.Write(.Item(9).ToString) %>"]);
                    </script>
<%                         
                    'VALUE &= i.ToString() &
                    '.Item("uid").ToString & "|" & .Item("staff_name").ToString & "|" &
                    '.Item("req_installlocation").ToString & "|" & .Item("req_installdate").ToString & "|" &
                    '.Item("req_jobtype1").ToString & "|" & .Item("req_job1").ToString & "|" &
                    '.Item("req_staffname1").ToString & "|" & .Item("req_jobdatefinish").ToString & "|" &
                    '.Item("req_status").ToString & "^"
                End With
            Next
            'Response.Write(Left(VALUE, VALUE.Length - 1))
        End If
    Else
        'search by All and Session Group
        'MsgBox("Condition Search ALL >>" + Ses_req_group)
        Dim query_job_data As String
        query_job_data = "SELECT uid, staff_name, req_installlocation, req_installdate , req_jobtype1, req_job1, req_amname, req_staffname1, req_jobdatefinish , req_status FROM SYS01_TS_REQUEST WHERE req_group = " + Ses_req_group + "and req_status != 'INACTIVE'"
        cls.strSql = query_job_data
        cls.func_SetDataSet(cls.strSql, "JobAMRequest")
    End If
 %>      
        <!--Show data table -->
         <h2 style=" padding-top:16px; padding-left:30px; padding-right:30px;">ข้อมูลงานที่ขอรับบริการ</h2>
         <!-- Data Table -->
         <div class="table-responsive ">
            <table class="table table-hover table-striped table-bordered mydatatable" id="mydatatable" style="text-align:center">
              <thead>
                <tr>
                <th style="background-color:dodgerblue;">No.</th>
                <th style="background-color:dodgerblue;">JOB_ID</th>
                <th style="background-color:dodgerblue;">SALE NAME</th>
                <th style="background-color:dodgerblue;">Location</th>
                <th style="background-color:dodgerblue;">Installation Date</th>
                <th style="background-color:dodgerblue;">Type</th>
                <th style="background-color:dodgerblue;">Topic</th>
                <th style="background-color:dodgerblue;">AM Name</th>
                <th style="background-color:dodgerblue;">Engineer</th>
                <th style="background-color:dodgerblue;">Finished Date</th>
                <th style="background-color:dodgerblue;">Status</th>
                </tr>
               </thead>  
               <tbody>  
                 <% 
                     If cls.ds.Tables("JobAMRequest").Rows.Count > 0 Then
                         Dim VALUE As String = ""
                         For i As Integer = 0 To cls.ds.Tables("JobAMRequest").Rows.Count - 1
                             With cls.ds.Tables("JobAMRequest").Rows(i)

                                 VALUE &=
                                   "<tr>" &
                                   "<td>" & i + 1.ToString() & "</td>" &
                                   "<td>" & .Item("uid").ToString & "</td>" &
                                   "<td>" & .Item("staff_name").ToString & "</td>" &
                                   "<td>" & .Item("req_installlocation").ToString & "</td>" &
                                   "<td>" & .Item("req_installdate").ToString & "</td>" &
                                   "<td>" & .Item("req_jobtype1").ToString & "</td>" &
                                   "<td>" & .Item("req_job1").ToString & "</td>" &
                                   "<td>" & .Item("req_amname").ToString & "</td>" &
                                   "<td>" & .Item("req_staffname1").ToString & "</td>" &
                                   "<td>" & .Item("req_jobdatefinish").ToString & "</td>" &
                                   "<td>" & .Item("req_status").ToString & "</td>" &
                                   "</tr>"

                             End With
                         Next
                         Response.Write(Left(VALUE, VALUE.Length - 1))
                  %>                   
               </tbody>
           </table>
        </div> <!-- End class table resp -->
<%
            End If
        End If

    Catch ex As Exception
        Response.Write("Can't show data")
        Response.Write(ex.ToString)
    End Try
     %> 
           
        
        <!-- <script src="../../JS/sys01.dashboard.js"></script> -->
        <!-- data table script -->
         <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
         <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
         <script src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap5.min.js" ></script>

         <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
         <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" ></script>
         
        <script>
         $(document).ready(function () {
             $('.mydatatable').DataTable({
                 //searching: false,
             });
         });
        </script>
         <br /><br /><br />
    </form>
</body>
</html>
