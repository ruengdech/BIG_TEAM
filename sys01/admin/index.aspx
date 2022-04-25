<%@ Page Language="VB" %>

<!DOCTYPE html>
<%
    Dim cls As New MY_CLASS
    Session("URL") = "../admin/index.aspx"
    Try
        If IsNothing(Session("USER_TYPE")) Then
            If Request.QueryString("user_id") <> Nothing Then
                cls.strSql = "SELECT " &
                                "users.ID, users.username, users.pswd, employee2.uid, employee2.name, employee2.lastname, employee2.abr, NEW_USER_MAPPING.USER_TYPE  " &
                            "FROM  " &
                                "(users INNER JOIN employee2 ON users.sales_code = employee2.abr)  " &
                                "LEFT JOIN NEW_USER_MAPPING ON users.ID = NEW_USER_MAPPING.OLD_ID  " &
                            "WHERE (((users.ID)=" & Request.QueryString("user_id") & ") );"
                cls.func_SetDataSet(cls.strSql, "LOGIN")
                If cls.ds.Tables("LOGIN").Rows.Count > 0 Then
                    With cls.ds.Tables("LOGIN").Rows(0)
                        Session("STAFF_ID") = .Item("uid").ToString 'รหัสพนักงานเก็บที่นี่
                        Session("USER_ID") = .Item("ID").ToString
                        Session("USER_NAME") = .Item("username").ToString
                        Session("USER_FNAME") = .Item("name").ToString
                        Session("USER_ABR") = .Item("abr").ToString
                        Session("USER_TYPE") = .Item("USER_TYPE").ToString
                    End With
                Else
                    Response.Redirect("../authentication/login.aspx")
                End If

            Else
                Response.Redirect("../authentication/login.aspx")
            End If
        Else
            'DO NOTHING
        End If
    Catch ex As Exception
        Response.Redirect("../authentication/login.aspx")
    End Try

    %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>ระบบงานติดตั้ง (Admin)</title>
	<link rel="stylesheet" href="../themes/ST_MED.css" />
	<link rel="stylesheet" href="../themes/jquery.mobile.icons.min.css" />
    <link href="../themes/jquery.mobile.structure-1.4.5.css" rel="stylesheet" />
    <script src="../themes/jquery-1.11.1.min.js"></script>
    <script src="../themes/jquery.mobile-1.4.5.min.js"></script>
    <script type="text/javascript" >
        var JOB_DATA = [];
    </script>
    <style>
        #tb_history, .table_job_list {
          font-family: Arial, Helvetica, sans-serif;
          border-collapse: collapse;
          width: 100%;
          text-shadow:none!important;
          /*width:900px; */
        }

        #tb_history td, #tb_history th , .table_job_list th, .table_job_list td {
          border: 1px solid #ddd;
          padding: 8px;
        }

        #tb_history tr:nth-child(even), .table_job_list tr:nth-child(even) {background-color: #f2f2f2;}

        #tb_history tr:hover, .table_job_list tr:hover  {background-color: #ddd;}

        #tb_history th, .table_job_list th {
          padding-top: 12px;
          padding-bottom: 12px;
          text-align: left;
          background-color: #4CAF50;
          color: white;
        }

        .center {
            text-align:center !important;
        }

    .background1 {
        background-color:beige!important;
    }
        
    .background2 {
        background-color:lavender!important;
    }
   </style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<style>
    .fa-star {
        color:#ccc;
        font-size:2.5em;
    }
    /* Hover state of the stars */
    .fa-star:hover{
        color:#FFCC36;
    }

    /* Selected state of the stars */
    .fa-star:active  {
      color:#FF912C;
    }

    /* Selected state of the stars */
    .fa-star-active  {
      color:#FF912C;
      font-size:2.5em;
    }
</style> 
<%
    Response.Write("<SCRIPT>")
    Response.Write("STAFF_ID = '" & Session("STAFF_ID") & "';")
    Response.Write("STAFF_NAME = '" & Session("USER_FNAME") & "';")
    Response.Write("</SCRIPT>")

%> 
</head>
<body>

<div data-role="page" id="page_main" data-theme="b">
		<div data-role="header" data-position="inline">
			<h2>ระบบขอรับบริการงานช่าง</h2>
		</div>
		<div data-role="content" data-theme="a">
                <div data-role="navbar">
                  <ul>
                    <li><a href="index.aspx" data-ajax="true">HOME</a></li>
                    <li><a href="#" data-ajax="true">รอ Assign</a></li>
                    <li><a href="#page_approve" data-transition="flow" data-ajax="true">รอ Approve</a></li>
                    <li><a href="#page_search" data-transition="flow" data-ajax="true">รายการทั้งหมด</a></li>
                    <li><a href="../log_out.aspx" rel="external" >log out</a></li>
                  </ul>
                </div><%--<div data-role="navbar">--%>
                <div id="wait_assign">
                    <h2>รายการรอ Assign ช่าง</h2>
                    <input id="myInput" style="width:94%; padding: 12px 12px 12px 12px; font-size:14pt" type="text" placeholder="Search.." /><br />
                    <div style="overflow-x:auto;">
                        <table id="tb_assign" class="table_job_list" >
                            <thead>
                                <tr class="tr_main"><th style="width:50px">เลขที่</th><th>วันที่แจ้ง / แจ้งโดย</th><th>วันที่ต้องการงาน</th><th>หัวข้อที่แจ้ง</th><th>สถานที่ติดตั้ง</th><th>AM / BM</th><th>สถานะ</th></tr>
                            </thead>
                            </table>
                    </div>			
                </div><%--<div id="history">--%>    
                
		</div>
</div>

<div data-role="page" id="page_approve" data-theme="b">
		<div data-role="header" data-position="inline">
			<h2>ระบบขอรับบริการงานช่าง</h2>
		</div>
		<div data-role="content" data-theme="a">
                <div data-role="navbar">
                  <ul>
                    <li><a href="index.aspx" data-ajax="true">HOME</a></li>
                    <li><a href="#page_main" data-ajax="true">รอ Assign</a></li>
                    <li><a href="#" data-transition="flow" data-ajax="true">รอ Approve</a></li>
                    <li><a href="#page_search" data-transition="flow" data-ajax="true">รายการทั้งหมด</a></li>
                    <li><a href="../log_out.aspx" rel="external" >log out</a></li>
                  </ul>
                </div><%--<div data-role="navbar">--%>
                <div id="history">
                    <h2>รายการอนุมัติแผนปฏิบัติงาน</h2>
                    <input id="myInput2" style="width:94%; padding: 12px 12px 12px 12px; font-size:14pt" type="text" placeholder="Search.." /><br />
                    <div style="overflow-x:auto;">
                        <table id="tb_approve"  class="table_job_list">
                            <thead>
                                <tr class="tr_main"><th style="width:50px">เลขที่</th><th>วันที่แจ้ง / แจ้งโดย</th><th>วันที่ต้องการงาน</th><th>หัวข้อที่แจ้ง</th><th>สถานที่ติดตั้ง</th><th>AM / BM</th><th>ทีมช่าง</th><th>สถานะ</th></tr>
                            </thead>
                        </table>
                    </div>			
                </div><%--<div id="history">--%>     
		</div>
</div>

<div data-role="page" id="page_search" data-theme="b">
		<div data-role="header" data-position="inline">
			<h2>ระบบขอรับบริการงานช่าง</h2>
		</div>
		<div data-role="content" data-theme="a">
                <div data-role="navbar">
                  <ul>
                    <li><a href="index.aspx" data-ajax="true">HOME</a></li>
                    <li><a href="#page_main" data-ajax="true">รอ Assign</a></li>
                    <li><a href="#page_approve" data-transition="flow" data-ajax="true">รอ Approve</a></li>
                    <li><a href="#" data-transition="flow" data-ajax="true">รายการทั้งหมด</a></li>
                    <li><a href="../log_out.aspx" rel="external" >log out</a></li>
                  </ul>
                </div><%--<div data-role="navbar">--%>
                <div>
                    <h2>ข้อมูลขอรับบริการทั้งหมด</h2>
                    <input id="myInput3" style="width:94%; padding: 12px 12px 12px 12px; font-size:14pt" type="text" placeholder="Search.." /><br />
                    <div style="overflow-x:auto;">
                        <table id="tb_history"  class="table_job_list">
                            <thead>
                                <tr class="tr_main"><th style="width:50px">เลขที่</th><th>วันที่แจ้ง / แจ้งโดย</th><th>วันที่ต้องการงาน</th><th>หัวข้อที่แจ้ง</th><th>สถานที่ติดตั้ง</th><th>AM / BM</th><th>ทีมช่าง</th><th>สถานะ</th></tr>
                            </thead>
                        </table>
                    </div>			
                </div><%--<div id="history">--%>     
		</div>
</div>

<div data-role="page" id="page_edit" data-theme="a">
    
		<div data-role="header" data-position="inline">
			<h2>ระบบ บริการติดตั้ง/ซ่อมบำรุงเครื่องมือแพทย์</h2>
		</div>
		<div data-role="content" data-theme="a">            
                <div class="ui-body-d ui-content ui-corner-all">
                    <div class="ui-bar ui-bar-a">
                        <h3 id="head_edit">ASSIGN JOB</h3>                        
                    </div>
                    <div class="ui-body ui-body-a">                        
                        <div class="ui-grid-b ui-responsive background1">
                        <h2>ข้อมูลผู้ส่งเรื่อง</h2>
                            <div class="ui-block-a" >
                                    <label for="txt_staffId">รหัสพนักงาน :</label>
                                    <input type="text" name="txt_staffId" id="txt_staffId" value="" />
                            </div>
                            <div class="ui-block-b" >
                                    <label for="txt_name">ชื่อ:</label>
                                    <input type="text" name="txt_name" id="txt_name" value="" />
                            </div>
                            <div class="ui-block-c" >                    
                                    <label for="txt_lname">นามสกุล:</label>
                                    <input type="text" name="txt_lname" id="txt_lname" value="" />
                            </div>
                        </div><!-- <div class="ui-grid-b ui-responsive"> -->
                        <div class="ui-grid-a ui-responsive background1">
                            <div class="ui-block-a" >
                                    <label for="txt_mobile">Mobile :</label>
                                    <input type="text" name="txt_mobile" id="txt_mobile" value="" />
                            </div>
                            <div class="ui-block-b" >
                                    <label for="txt_email">Email: </label>
                                    <input type="email" name="txt_email" id="txt_email" value="" />
                            </div>
                            
                            <div class="ui-block-a" >
                                <div class="ui-field-contain">
                                    <label for="sel_am">AM :</label>
                                    <select name="sel_am" id="sel_am" data-native-menu="false">
                                        <option value="0" selected="selected">เลือก AM</option>
                                    </select>
                                </div>
                            </div>
                            <div class="ui-block-b" >
                                <div class="ui-field-contain">
                                    <label for="sel_bm">BM :</label>
                                    <select name="sel_bm" id="sel_bm" data-native-menu="false">
                                        <option value="0" selected="selected">เลือก BM</option>
                                    </select>
                                </div>
                            </div>

                            <h2>สถานที่ติดตั้ง</h2>
                            <div class="ui-block-a" >
                                <label for="txt_location">โรงพยาบาล โรงแรม อื่นๆ :</label>
                                <input type="text" name="txt_location" id="txt_location" value="" />
                            </div>
                            <div class="ui-block-b" >
                                <label for="txt_dept">แผนก :</label>
                                <input type="text" name="txt_dept" id="txt_dept" value="" />
                            </div>
                            <div class="ui-block-a" >
                                <label for="txt_contact">ชื่อผู้ติดต่อ :</label>
                                <input type="text" name="txt_contact" id="txt_contact" value="" />
                            </div>
                            <div class="ui-block-b" >
                                <label for="txt_contactTel">เบอร์โทรผู้ติดต่อ :</label>
                                <input type="text" name="txt_contactTel" id="txt_contactTel" value="" />
                            </div>

                            <h2>รายละเอียดงาน</h2>
                            <div class="ui-block-a" >
                                <label for="txt_id">เลขที่ใบงาน :</label>
                                <input type="text" name="txt_id" id="txt_id" value="" readonly="readonly" />
                            </div>
                            <div class="ui-block-b" >
                                <label for="txt_job_date">วันที่ของาน :</label>
                                <input type="text" name="txt_job_date" id="txt_job_date" value="" readonly="readonly" />
                            </div>

                            <div class="ui-block-a" >
                                <label for="txt_date">วันเวลาที่ต้องการ [เดือน/วัน/ปี]:</label>
                                <input type="date" name="txt_date" id="txt_date" value="" />
                                <input type="time" name="txt_time" id="txt_time" />
                            </div>
                            <div class="ui-block-b" >
                                <label for="txt_contract">เลขที่สัญญา :</label>
                                <input type="text" name="txt_contract" id="txt_contract" value="" />
                            </div>

                            
                            <div class="ui-block-a" >
                                <label for="sel_pm">รอบ PM (ครั้ง/ปี) :</label>
                                <select name="sel_pm" id="sel_pm" data-native-menu="false">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                </select>
                            </div>
                            <div class="ui-block-b" >
                                <label for="sel_warantee">ระยะเวลารับประกัน (ปี) :</label>
                                <select name="sel_warantee" id="sel_warantee" data-native-menu="false">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                </select>
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_job1">ประเภทของงาน (1) :</label>
                                <select name="sel_job1" id="sel_job1" data-native-menu="false">
                                    <option value="" selected="selected">เลือกประเภทของงาน</option>
                                    <option value="ติดตั้งเครื่องมือแพทย์">ติดตั้งเครื่องมือแพทย์</option>
                                    <option value="Demo">Demo</option>
                                    <option value="ย้ายเครื่องมือแพทย์">ย้ายเครื่องมือแพทย์</option>
                                    <option value="แสดงสินค้า">แสดงสินค้า</option>
                                    <option value="สำรองเครื่อง">สำรองเครื่อง</option>
                                    <option value="ตรวจเช็คระบบ">ตรวจเช็คระบบ</option>
                                    <option value="Preventive Maintainance">Preventive Maintainance</option>
                                    <option value="อื่นๆ">อื่นๆ</option>
                                </select>
                            </div>
                            <div class="ui-block-b" >
                                <label for="txt_job1">รายการแจ้งใช้บริการ (1) :</label>
                                <input type="text" name="txt_job1" id="txt_job1" value="" />
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_job2">ประเภทของงาน (2) :</label>
                                <select name="sel_job2" id="sel_job2" data-native-menu="false">
                                    <option value="" selected="selected">เลือกประเภทของงาน</option>
                                    <option value="ติดตั้งเครื่องมือแพทย์">ติดตั้งเครื่องมือแพทย์</option>
                                    <option value="Demo">Demo</option>
                                    <option value="ย้ายเครื่องมือแพทย์">ย้ายเครื่องมือแพทย์</option>
                                    <option value="แสดงสินค้า">แสดงสินค้า</option>
                                    <option value="สำรองเครื่อง">สำรองเครื่อง</option>
                                    <option value="ตรวจเช็คระบบ">ตรวจเช็คระบบ</option>
                                    <option value="Preventive Maintainance">Preventive Maintainance</option>
                                    <option value="อื่นๆ">อื่นๆ</option>
                                </select>
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_job2">รายการแจ้งใช้บริการ (2) :</label>
                                <input type="text" name="txt_job2" id="txt_job2" value="" />
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_job3">ประเภทของงาน (3) :</label>
                                <select name="sel_job3" id="sel_job3" data-native-menu="false">
                                    <option value="" selected="selected">เลือกประเภทของงาน</option>
                                    <option value="ติดตั้งเครื่องมือแพทย์">ติดตั้งเครื่องมือแพทย์</option>
                                    <option value="Demo">Demo</option>
                                    <option value="ย้ายเครื่องมือแพทย์">ย้ายเครื่องมือแพทย์</option>
                                    <option value="แสดงสินค้า">แสดงสินค้า</option>
                                    <option value="สำรองเครื่อง">สำรองเครื่อง</option>
                                    <option value="ตรวจเช็คระบบ">ตรวจเช็คระบบ</option>
                                    <option value="Preventive Maintainance">Preventive Maintainance</option>
                                    <option value="อื่นๆ">อื่นๆ</option>
                                </select>
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_job2">รายการแจ้งใช้บริการ (3) :</label>
                                <input type="text" name="txt_job3" id="txt_job3" value="" />
                            </div>

                        </div><!-- <div class="ui-grid-a ui-responsive"> -->
                        <div class="ui-grid-solo ui-responsive background2">
                            
                            <h2>ข้อมูลมอบหมายงาน</h2>
                            <div class="ui-block-a">
                                <label for="sel_staff">จำนวนช่าง :</label>
                                <select name="sel_staff" id="sel_staff" data-native-menu="false">
                                    <option value="0" selected="selected">ระบุจำนวนช่าง</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                </select>
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_assign_date">วันเวลาที่ Assign งาน:</label>
                                <input type="text" name="txt_assign_date" id="txt_assign_date" value="" />
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_staff1">ช่างที่มอบหมาย 1 :</label>
                                <select name="sel_staff1" id="sel_staff1" data-native-menu="false">
                                    <option value="0" selected="selected">เลือกช่างคนที่ 1</option>
                                </select>
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_staff2">ช่างที่มอบหมาย 2 :</label>
                                <select name="sel_staff2" id="sel_staff2" data-native-menu="false">
                                    <option value="0" selected="selected">เลือกช่างคนที่ 2</option>
                                </select>
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_staff3">ช่างที่มอบหมาย 3 :</label>
                                <select name="sel_staff3" id="sel_staff3" data-native-menu="false">
                                    <option value="0" selected="selected">เลือกช่างคนที่ 3</option>
                                </select>
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_staff4">ช่างที่มอบหมาย 4 :</label>
                                <select name="selsel_staff4_staff1" id="sel_staff4" data-native-menu="false">
                                    <option value="0" selected="selected">เลือกช่างคนที่ 4</option>
                                </select>
                            </div>
                            <div class="ui-block-a">
                                <label for="txt_job_status">สถานะของงาน</label>
                                <input type="text" name="txt_job_status" id="txt_job_status" readonly="readonly" />
                            </div>
                            <div class="ui-block-a">
                                <label for="txt_assignid">พนักงานผู้มอบหมายงาน</label>
                                <input type="text" name="txt_assignid" placeholder="รหัสพนักงานของท่าน" id="txt_assignid"  />
                                <input type="text" name="txt_assignname" id="txt_assignname" readonly="readonly" />
                            </div>
                        </div><!-- <div class="ui-grid-a ui-responsive"> -->

                        <div class="ui-grid-a ui-responsive" id="div_plan">
                            <h2>ข้อมูลแผนปฏิบัติงาน</h2>
                            <div class="ui-block-a">
                                <label for="txt_plan_start">วันที่เริ่มงาน [เดือน/วัน/ปี]:</label>
                                <input type="date" name="txt_plan_start" id="txt_plan_start" />
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_date_end">วันที่ดำเนินการเสร็จ [เดือน/วัน/ปี]:</label>
                                <input type="date" name="txt_plan_end" id="txt_plan_end" />
                            </div>
                            <div class="ui-block-a">
                                <label for="txt_planid">รหัสพนักงานผู้วางแผน</label>
                                <input type="text" name="txt_planid" placeholder="รหัสพนักงานของท่าน" id="txt_planid"  />
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_planname">ชื่อพนักงานผู้วางแผน</label>
                                <input type="text" name="txt_planname" id="txt_planname" readonly="readonly" />
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_plan_result">ผลการอนุมัติแผน:</label>
                                <select name="sel_plan_result" id="sel_plan_result" data-native-menu="false">
                                    <option value="" selected="selected">เลือกผลการอนุมัติ</option>
                                    <option value="APPROVE">อนุมัติตามแผน</option>
                                    <option value="EDIT">แก้ไขแผน</option>
                                </select>
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_plan_comment">Comment แผนปฏิบัติงาน</label>
                                <textarea cols="40" rows="4" name="txt_plan_comment" id="txt_plan_comment"></textarea>
                            </div>
                            <div class="ui-block-a">
                                <label for="txt_plan_approveid">รหัสพนักงานผู้อนุมัติแผน</label>
                                <input type="text" name="txt_plan_approveid" placeholder="รหัสพนักงานของท่าน" id="txt_plan_approveid"  />
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_plan_approveid">ชื่อพนักงานผู้อนุมัติแผน</label>
                                <input type="text" name="txt_plan_approvename" id="txt_plan_approvename" readonly="readonly" />
                            </div>
                        </div><!--<div class="ui-grid-a ui-responsive">-->

                        <div class="ui-grid-a ui-responsive" id="div_engineer">
                            <h2>ข้อมูลการปฏิบัติงานจริง</h2>
                            <div class="ui-block-a">
                                <label for="txt_date_start">วันเวลาที่เริ่มงาน [เดือน/วัน/ปี]:</label>
                                <input type="date" name="txt_date_start" id="txt_date_start" value="" />
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_date_end">วันเวลาที่ดำเนินการเสร็จ [เดือน/วัน/ปี]:</label>
                                <input type="date" name="txt_date_end" id="txt_date_end" value="" />
                            </div>
                            <div class="ui-block-a">
                                <label for="p_assigned_attached">รูปประกอบ</label>
                                <div id="p_assigned_attached"></div>
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_job_detail">รายละเอียดการปฏิบัติงาน</label>
                                <input type="date" name="txt_job_detail" id="txt_job_detail" value="" />
                            </div>
                            <div class="ui-block-a">
                                <label for="p_job_state_engineer">สถานะงานจากช่าง</label>
                                <div id="p_job_state_engineer"></div>
                            </div>
                        </div><!--<div class="ui-grid-a ui-responsive">-->
                        <button class="ui-btn" id ="bt_submit">บันทึกข้อมูล</button>
                        <button class="ui-btn ui-btn-active ui-btn-c" id ="bt_delete">ลบข้อมูล</button>
                    </div><%--<div class="ui-body ui-body-a">--%>
                </div><%--<div id="request" class="ui-body-d ui-content ui-corner-all">--%>
            
            <input type="button" onclick="history.back();" value="Back"/>
 		</div>
    
</div>

<div data-role="page" id="page_detail" data-theme="a">
    
		<div data-role="header" data-position="inline">
			<h2>ระบบ บริการติดตั้ง/ซ่อมบำรุงเครื่องมือแพทย์</h2>
		</div>
		<div data-role="content" data-theme="a">
            <div id="div_detail"></div>
            <input type="button" onclick="history.back();" value="Back"/>
 		</div>
    
</div>


</body>
</html>
<script src="../../JS/sys01.admin.js"></script>