<%@ Page Language="VB" AutoEventWireup="false" CodeFile="data_engineer.aspx.vb" Inherits="sys01_dashboard_data_engineer" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title> สรุปข้อมูลช่างซ่อม (Engineer) </title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1" />    
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
    var EN_LIST = [];
    var STAFF_LIST = [];    
</script>
<%
    Dim cls As New MY_CLASS_MSSQL()

    'Search Form Query
    Dim query_en_list As String
    Dim query_staff_list As String

    'Recieve Form Value
    Dim input_en_id, input_year, input_staff_id, input_en_name As String
    input_en_id = Request.Form("req_en_id")
    input_staff_id = Request.Form("req_staff_id")
    input_year = Request.Form("req_year")

    'input_am_name = Request.Form("req_am_name")
    input_en_name = Request.QueryString("req_en_id")

    'EN List
    query_en_list = "  SELECT req_staffid1 , req_staffname1 FROM SYS01_TS_REQUEST"
    cls.strSql = query_en_list
    cls.func_SetDataSet(cls.strSql, "ENList")

    'Staff List
    query_staff_list = "SELECT STAFF_ID , STAFF_NAME, STAFF_LNAME FROM SYS01_MS_STAFF ORDER BY  STAFF_ID"
    cls.strSql = query_staff_list
    cls.func_SetDataSet(cls.strSql, "StaffList")

    If cls.ds.Tables("ENList").Rows.Count > 0 Then
        Dim VALUE_AM As String = ""
        Dim Name As String
        For i As Integer = 0 To cls.ds.Tables("ENList").Rows.Count - 1
            With cls.ds.Tables("ENList").Rows(i)
%>
                    <script>
                        //Keep data to Array Job_Data
                        EN_LIST.push(["<% response.Write(.Item(0).ToString) %>",
                            "<% response.Write(.Item(1).ToString) %>"]);
                    </script>
<%     

                Name = .Item("req_staffname1").ToString
                If input_en_name = Name Then
                    input_en_id = .Item("req_staffid1").ToString
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
                        EN_LIST.push(["<% response.Write(.Item(0).ToString) %>",
                            "<% response.Write(.Item(1).ToString) %>"]);
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
        var x = document.getElementById("req_en_id");
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
    <h3>Saintmed: ระบบงานช่างซ่อม (Engineer)</h3>          
    <hr></hr>

    <!--Show Search --> 

        <form action="data_engineer.aspx" method="post">            
            <div class="row"> 
                 <div class="col">
                   <h6>Engineers Name :</h6>
                    <select class="form-control" id="req_en_id" name="req_en_id" placeholder="เลือก Engineer "> 
                    <option value=""> </option>
                <%
                    Dim cls As New MY_CLASS_MSSQL()
                    Dim query_am_list As String
                    query_am_list = "SELECT req_staffid1 , req_staffname1 FROM SYS01_TS_REQUEST"
                    cls.strSql = query_am_list
                    cls.func_SetDataSet(cls.strSql, "ENList")
                    If cls.ds.Tables("ENList").Rows.Count > 0 Then
                        Dim VALUE As String = ""
                        For i As Integer = 0 To cls.ds.Tables("ENList").Rows.Count - 1
                            With cls.ds.Tables("ENList").Rows(i)
                                VALUE &=
                                "<option value=" & .Item("req_staffid1").ToString & ">" & .Item("req_staffname1").ToString & "</option>"
                            End With
                        Next
                        Response.Write(Left(VALUE, VALUE.Length - 1))
                    End If
                  %>            
                    </select>
                  </div>

                <div class="col" style="color:#FFFCF5;">
                   <h6 style="color:#FFFCF5;">Sales Name</h6>
                    <select class="form-control" id="req_staff_id" name="req_staff_id" placeholder="เลือก Sales Staff " style="color:#FFFCF5;"> 
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
                    <select class="form-control" id="req_year" name="req_year" placeholder="เลือก ปี "> 
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
         'Recieve Form Value
         Dim input_en_id, input_year, input_en_name As String
         input_en_id = Request.Form("req_en_id")
         input_year = Request.Form("req_year")

         input_en_name = Request.Form("req_en_name")
         If (input_en_name = "") = False Then
             Dim query_en_id As String

             query_en_id = "SELECT req_staffid1 FROM SYS01_TS_REQUEST where req_staffname1 LIKE '" + input_en_name + "' GROUP BY req_staffid1"
             cls.strSql = query_en_id
             cls.func_SetDataSet(cls.strSql, "EN_ID")

             If cls.ds.Tables("EN_ID").Rows.Count > 0 Then
                 Dim VALUE As String = ""
                 For i As Integer = 0 To cls.ds.Tables("EN_ID").Rows.Count - 1
                     With cls.ds.Tables("EN_ID").Rows(i)
                         input_en_id = .Item("req_enid").ToString
                     End With
                 Next
                 Response.Write(Left(VALUE, VALUE.Length - 1))
             End If
         End If

         If (input_en_id = "") = False Or (input_year = "") = False Then
             'Searh by Recieve value
             If (input_en_id = "") = False And (input_year = "") = False Then
                 'search by BM ID and Year
                 Dim query_job_data As String
                 query_job_data = "SELECT uid, staff_name, req_installlocation, req_date, req_jobtype1, req_job1, req_staffname1, req_jobdatefinish , req_status From SYS01_TS_REQUEST WHERE year(req_date) = '" + input_year + "' and req_staffid1 = '" + input_en_id + "'"
                 cls.strSql = query_job_data
                 cls.func_SetDataSet(cls.strSql, "JobENRequest")

             ElseIf (input_en_id = "") = False And input_year = "" Then
                 'search by BM ID only
                 Dim query_job_data As String
                 query_job_data = "SELECT uid, staff_name, req_installlocation, req_date, req_jobtype1, req_job1, req_staffname1, req_jobdatefinish , req_status FROM SYS01_TS_REQUEST WHERE req_staffid1 = '" + input_en_id + "'"
                 cls.strSql = query_job_data
                 cls.func_SetDataSet(cls.strSql, "JobENRequest")

             ElseIf (input_year = "") = False And input_en_id = "" Then
                 'search by Year only
                 Dim query_job_data As String
                 query_job_data = "SELECT uid, staff_name, req_installlocation, req_date, req_jobtype1, req_job1, req_staffname1, req_jobdatefinish , req_status From SYS01_TS_REQUEST WHERE year(req_date) = " + input_year
                 cls.strSql = query_job_data
                 cls.func_SetDataSet(cls.strSql, "JobENRequest")
             Else
                 'search by All
                 Dim query_job_data As String
                 query_job_data = "SELECT uid, staff_name, req_installlocation, req_date, req_jobtype1, req_job, req_staffname1, req_jobdatefinish , req_status FROM SYS01_TS_REQUEST"
                 cls.strSql = query_job_data
                 cls.func_SetDataSet(cls.strSql, "JobENRequest")
             End If
%>                
        <!--Show data table -->
         <h2 style = " padding-top:16px; padding-left:30px; padding-right:30px;" > ข้อมูลงานที่ขอรับบริการ</h2>
         <!-- Data Table -->
         <div Class="table-responsive ">
            <Table Class="table table-hover table-striped table-bordered mydatatable" id="mydatatable" style="text-align:center">
              <thead>
             <tr>
             <th style = "background-color:dodgerblue;" > No.</th>
                <th style = "background-color:dodgerblue;" > JOB_ID</th>
                <th style = "background-color:dodgerblue;" > SALE NAME</th>
                <th style = "background-color:dodgerblue;" > Location</th>
                <th style = "background-color:dodgerblue;" > Req Date</th>
                <th style = "background-color:dodgerblue;" > Type</th>
                <th style = "background-color:dodgerblue;" > Topic</th>
                <th style = "background-color:dodgerblue;" > Engineer Name</th>
                <th style = "background-color:dodgerblue;" > Finished Date</th>
                <th style = "background-color:dodgerblue;" > Status</th>
                </tr>
               </thead>  
               <tbody>
             <% 
                 If cls.ds.Tables("JobENRequest").Rows.Count > 0 Then
                     Dim VALUE As String = ""
                     For i As Integer = 0 To cls.ds.Tables("JobENRequest").Rows.Count - 1
                         With cls.ds.Tables("JobENRequest").Rows(i)

                             VALUE &=
                               "<tr>" &
                               "<td>" & i + 1.ToString() & "</td>" &
                               "<td>" & .Item("uid").ToString & "</td>" &
                               "<td>" & .Item("staff_name").ToString & "</td>" &
                               "<td>" & .Item("req_installlocation").ToString & "</td>" &
                               "<td>" & .Item("req_date").ToString & "</td>" &
                               "<td>" & .Item("req_jobtype1").ToString & "</td>" &
                               "<td>" & .Item("req_job1").ToString & "</td>" &
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
    Else
        'search all | search blank
        Dim query_job_data As String
        query_job_data = "SELECT uid, staff_name, req_installlocation, req_date, req_jobtype1, req_job1, req_bmname, req_staffname1, req_jobdatefinish , req_status FROM SYS01_TS_REQUEST"
        cls.strSql = query_job_data
        cls.func_SetDataSet(cls.strSql, "JobENRequest")
            %>      
        <!--Show data table -->
         <h2 style=" padding-top:16px; padding-left:30px; padding-right:30px;">ข้อมูลงานที่ขอรับบริการ</h2>
         <!-- Data Table -->
         <div class="table-responsive ">
            <table class="table table-hover table-striped table-bordered mydatatable" id="mydatatable" style="text-align:center;">
              <thead>
                <tr>
                <th style="background-color:dodgerblue;">No.</th>
                <th style="background-color:dodgerblue;">JOB_ID</th>
                <th style="background-color:dodgerblue;">SALE NAME</th>
                <th style="background-color:dodgerblue;">Location</th>
                <th style="background-color:dodgerblue;">Req Date</th>
                <th style="background-color:dodgerblue;">Type</th>
                <th style="background-color:dodgerblue;">Topic</th>
                <th style="background-color:dodgerblue;">Engineer Name</th>
                <th style="background-color:dodgerblue;">Finished Date</th>
                <th style="background-color:dodgerblue;">Status</th>
                </tr>
               </thead>  
               <tbody>  
                 <% 
                     If cls.ds.Tables("JobENRequest").Rows.Count > 0 Then
                         Dim VALUE As String = ""
                         For i As Integer = 0 To cls.ds.Tables("JobENRequest").Rows.Count - 1
                             With cls.ds.Tables("JobENRequest").Rows(i)

                                 VALUE &=
                                   "<tr>" &
                                   "<td>" & i + 1.ToString() & "</td>" &
                                   "<td>" & .Item("uid").ToString & "</td>" &
                                   "<td>" & .Item("staff_name").ToString & "</td>" &
                                   "<td>" & .Item("req_installlocation").ToString & "</td>" &
                                   "<td>" & .Item("req_date").ToString & "</td>" &
                                   "<td>" & .Item("req_jobtype1").ToString & "</td>" &
                                   "<td>" & .Item("req_job1").ToString & "</td>" &
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

