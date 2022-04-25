<%@ Page Language="VB" %>

<!DOCTYPE html>
<%
    Dim cls As New MY_CLASS
    Session("URL") = "../engineer/index.aspx"
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
                        Session("STAFF_ID") = .Item("uid").ToString
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
	<title>jQuery Mobile: Theme Download</title>
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

    .background1 {
        background-color:beige!important;
    }
        
    .background2 {
        background-color:lavender!important;
    }
        
    .background3 {
        background-color:skyblue !important;
    }
        
    .background4 {
        background-color:lightgoldenrodyellow !important;
    }

</style>  
<%
    Response.Write("<SCRIPT>")
    Response.Write("STAFF_ID = '" & Session("STAFF_ID") & "';")
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
                    <li><a href="#page_main" data-ajax="true">รอ บันทึกแผน</a></li>
                    <li><a href="#page_approved" onclick="get_request('WAITFORCLOSE');" data-transition="flow" data-ajax="true">รอ บันทึกเริ่ม/ปิดงาน</a></li>
                    <li><a href="#page_closed" onclick="get_request('CLOSED');" data-transition="flow" data-ajax="true">งานที่ปิดแล้ว</a></li>
                    <li><a href="../log_out.aspx" rel="external" >log out</a></li>
                  </ul>
                </div><%--<div data-role="navbar">--%>
                <div id="wait_assign">
                    <h2>งาน ASSIGN รอบันทึกแผนงาน</h2>
                    <input id="myInput" style="width:94%; padding: 12px 12px 12px 12px; font-size:14pt" type="text" placeholder="Search.." /><br />
                    <div style="overflow-x:auto;">
                        <table id="tb_plan" class="table_job_list" >
                            <thead>
                                <tr class="tr_main"><th style="width:50px">เลขที่</th><th>วันที่แจ้ง / แจ้งโดย</th><th>หัวข้อที่แจ้ง</th><th>สถานที่ติดตั้ง</th><th>AM / BM</th><th>สถานะ</th></tr>
                            </thead>
                            </table>
                    </div>			
                </div><%--<div id="history">--%>    
                
		</div>
</div>

<div data-role="page" id="page_approved" data-theme="b">
		<div data-role="header" data-position="inline">
			<h2>ระบบขอรับบริการงานช่าง</h2>
		</div>
		<div data-role="content" data-theme="a">
                <div data-role="navbar">
                  <ul>
                    <li><a href="index.aspx" data-ajax="true">HOME</a></li>
                    <li><a href="#page_main" onclick="get_request('WAITFORPLAN');" data-ajax="true">รอ บันทึกแผน</a></li>
                    <li><a href="#page_approved" data-transition="flow" data-ajax="true">รอ บันทึกเริ่ม/ปิดงาน</a></li>
                    <li><a href="#page_closed" onclick="get_request('CLOSED');" data-transition="flow" data-ajax="true">งานที่ปิดแล้ว</a></li>
                    <li><a href="../log_out.aspx" rel="external" >log out</a></li>
                  </ul>
                </div><%--<div data-role="navbar">--%>
                <div id="history">
                    <h2>รายการรอเริ่มงาน/ปิดงาน</h2>
                    <input id="myInput2" style="width:94%; padding: 12px 12px 12px 12px; font-size:14pt" type="text" placeholder="Search.." /><br />
                    <div style="overflow-x:auto;">
                        <table id="tb_approve"  class="table_job_list">
                            <thead>
                                <tr class="tr_main"><th style="width:50px">เลขที่</th><th>วันที่แจ้ง / แจ้งโดย</th><th>หัวข้อที่แจ้ง</th><th>สถานที่ติดตั้ง</th><th>AM / BM</th><th>สถานะ</th></tr>
                            </thead>
                        </table>
                    </div>			
                </div><%--<div id="history">--%>     
		</div>
</div>

<div data-role="page" id="page_closed" data-theme="b">
		<div data-role="header" data-position="inline">
			<h2>ระบบขอรับบริการงานช่าง</h2>
		</div>
		<div data-role="content" data-theme="a">
                <div data-role="navbar">
                  <ul>
                    <li><a href="index.aspx" data-ajax="true">HOME</a></li>
                    <li><a href="#page_main" onclick="get_request('WAITFORPLAN');" data-ajax="true">รอ บันทึกแผน</a></li>
                    <li><a href="#page_approved" onclick="get_request('WAITFORCLOSE');" data-transition="flow" data-ajax="true">รอ บันทึกเริ่ม/ปิดงาน</a></li>
                    <li><a href="#page_closed" data-transition="flow" data-ajax="true">งานที่ปิดแล้ว</a></li>
                    <li><a href="../log_out.aspx" rel="external" >log out</a></li>
                  </ul>
                </div><%--<div data-role="navbar">--%>
                <div>
                    <h2>ข้อมูลขอรับบริการทั้งหมด</h2>
                    <input id="myInput3" style="width:94%; padding: 12px 12px 12px 12px; font-size:14pt" type="text" placeholder="Search.." /><br />
                    <div style="overflow-x:auto;">
                        <table id="tb_closed"  class="table_job_list">
                            <thead>
                                <tr class="tr_main"><th style="width:50px">เลขที่</th><th>วันที่แจ้ง / แจ้งโดย</th><th>หัวข้อที่แจ้ง</th><th>สถานที่ติดตั้ง</th><th>AM / BM</th><th>สถานะ</th></tr>
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
		<div data-role="content" data-theme="a" id="div_edit">
                <div class="ui-body-d ui-content ui-corner-all">
                    <div class="ui-bar ui-bar-a">
                        <h3 id="head_edit">Heading</h3>                        
                    </div>
                    <div class="ui-body ui-body-a">
                        <div class="ui-grid-b ui-responsive background1" >
                        <h2>ข้อมูลผู้ส่งเรื่อง</h2>
                            <div class="ui-block-a " >
                                    <label for="txt_staffId">รหัสพนักงาน :</label>
                                    <input type="text" name="txt_staffId" id="txt_staffId" value="" readonly="readonly" class="background1" />
                            </div>
                            <div class="ui-block-b" >
                                    <label for="txt_name">ชื่อ:</label>
                                    <input type="text" name="txt_name" id="txt_name" value="" readonly="readonly" class="background1" />
                            </div>
                            <div class="ui-block-c" >                    
                                    <label for="txt_lname">นามสกุล:</label>
                                    <input type="text" name="txt_lname" id="txt_lname" value="" readonly="readonly"  class="background1"/>
                            </div>
                        </div><!-- <div class="ui-grid-b ui-responsive"> -->
                        <div class="ui-grid-a ui-responsive background1">
                            <div class="ui-block-a" >
                                    <label for="txt_mobile">Mobile :</label>
                                    <input type="text" name="txt_mobile" id="txt_mobile" value="" readonly="readonly" class="background1" />
                            </div>
                            <div class="ui-block-b" >
                                    <label for="txt_email">Email: </label>
                                    <input type="email" name="txt_email" id="txt_email" value="" readonly="readonly" class="background1" />
                            </div>
                            
                            <div class="ui-block-a background1" >
                                <div class="ui-field-contain">
                                    <label for="sel_am">AM :</label>
                                    <input type="text" name="sel_am" id="sel_am" value="" readonly="readonly" class="background1" />
                                </div>
                            </div>
                            <div class="ui-block-b" >
                                <div class="ui-field-contain">
                                    <label for="sel_bm">BM :</label>
                                    <input type="text" name="sel_bm" id="sel_bm" value="" readonly="readonly"  class="background1"/>
                                </div>
                            </div>

                            <h2>สถานที่ติดตั้ง</h2>
                            <div class="ui-block-a" >
                                <label for="txt_location">โรงพยาบาล โรงแรม อื่นๆ :</label>
                                <input type="text" name="txt_location" id="txt_location" value="" readonly="readonly"  class="background1"/>
                            </div>
                            <div class="ui-block-b" >
                                <label for="txt_dept">แผนก :</label>
                                <input type="text" name="txt_dept" id="txt_dept" value="" readonly="readonly"  class="background1"/>
                            </div>
                            <div class="ui-block-a" >
                                <label for="txt_contact">ชื่อผู้ติดต่อ :</label>
                                <input type="text" name="txt_contact" id="txt_contact" value="" readonly="readonly"  class="background1"/>
                            </div>
                            <div class="ui-block-b" >
                                <label for="txt_contactTel">เบอร์โทรผู้ติดต่อ :</label>
                                <input type="text" name="txt_contactTel" id="txt_contactTel" value="" readonly="readonly"  class="background1"/>
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
                                <label for="txt_date">วันเวลาที่ต้องการ[เดือน/วัน/ปี]:</label>
                                <input type="date" name="txt_date" id="txt_date" value="" readonly="readonly"  class="background1"/>
                                <input type="time" name="txt_time" id="txt_time" readonly="readonly"  class="background1"/>
                            </div>
                            <div class="ui-block-b" >
                                <label for="txt_contract">เลขที่สัญญา :</label>
                                <input type="text" name="txt_contract" id="txt_contract" value="" readonly="readonly"  class="background1"/>
                            </div>

                            
                            <div class="ui-block-a" >
                                <label for="sel_pm">รอบ PM (ครั้ง/ปี) :</label>
                                <input type="text" name="sel_pm" id="sel_pm" value="" readonly="readonly"  class="background1"/>
                            </div>
                            <div class="ui-block-b" >
                                <label for="sel_warantee">ระยะเวลารับประกัน (ปี) :</label>
                                <input type="text" name="sel_warantee" id="sel_warantee" value="" readonly="readonly"  class="background1"/>
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_job1">ประเภทของงาน (1) :</label>
                                <input type="text" name="sel_job1" id="sel_job1" value="" readonly="readonly"  class="background1"/>
                            </div>
                            <div class="ui-block-b" >
                                <label for="txt_job1">รายการแจ้งใช้บริการ (1) :</label>
                                <input type="text" name="txt_job1" id="txt_job1" value="" readonly="readonly"  class="background1"/>
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_job2">ประเภทของงาน (2) :</label>
                                <input type="text" name="sel_job2" id="sel_job2" value="" readonly="readonly"  class="background1"/>
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_job2">รายการแจ้งใช้บริการ (2) :</label>
                                <input type="text" name="txt_job2" id="txt_job2" value="" readonly="readonly"  class="background1"/>
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_job3">ประเภทของงาน (3) :</label>
                                <input type="text" name="sel_job3" id="sel_job3" value="" readonly="readonly"  class="background1"/>
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_job2">รายการแจ้งใช้บริการ (3) :</label>
                                <input type="text" name="txt_job3" id="txt_job3" value="" readonly="readonly"  class="background1"/>
                            </div>

                        </div><!-- <div class="ui-grid-a ui-responsive"> -->
                        <div class="ui-grid-solo ui-responsive background2">
                            
                            <h2>ข้อมูลมอบหมายงาน</h2>
                            <div class="ui-block-a">
                                <label for="sel_staff">จำนวนช่าง :</label>
                                <input type="text" name="sel_staff" id="sel_staff" value="" readonly="readonly"  class="background2"/>
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_assign_date">วันเวลาที่ Assign งาน [ปี-เดือน-วัน]:</label>
                                <input type="text" name="txt_assign_date" id="txt_assign_date" value="" readonly="readonly" class="background2" />
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_staff1">ช่างที่มอบหมาย 1 :</label>
                                <input type="text" name="sel_staff1" id="sel_staff1" value="" readonly="readonly" class="background2" />
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_staff2">ช่างที่มอบหมาย 2 :</label>
                                <input type="text" name="sel_staff2" id="sel_staff2" value="" readonly="readonly"  class="background2"/>
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_staff3">ช่างที่มอบหมาย 3 :</label>
                                <input type="text" name="sel_staff3" id="sel_staff3" value="" readonly="readonly" class="background2" />
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_staff4">ช่างที่มอบหมาย 4 :</label>
                                <input type="text" name="sel_staff4" id="sel_staff4" value="" readonly="readonly" class="background2" />
                            </div>
                            <div class="ui-block-a">
                                <label for="txt_job_status">สถานะของงาน</label>
                                <input type="text" name="txt_job_status" id="txt_job_status" readonly="readonly" />
                            </div>
                            <div class="ui-block-a">
                                <label for="txt_assignid">พนักงานผู้มอบหมายงาน</label>
                                <input type="text" name="txt_assignid" placeholder="รหัสพนักงานของท่าน" id="txt_assignid" readonly="readonly"  class="background2" />
                                <input type="text" name="txt_assignname" id="txt_assignname" readonly="readonly"  class="background2"/>
                            </div>
                        </div><!-- <div class="ui-grid-a ui-responsive"> -->

                        <div class="ui-grid-a ui-responsive background3" id="div_plan" data-theme="c">
                            <h2>ข้อมูลแผนปฏิบัติงาน</h2>
                            <div class="ui-block-a">
                                <label for="txt_plan_start">วันที่เริ่มงาน[เดือน/วัน/ปี]:</label>
                                <input type="date" name="txt_plan_start" id="txt_plan_start" />
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_date_end">วันที่ดำเนินการเสร็จ[เดือน/วัน/ปี]:</label>
                                <input type="date" name="txt_plan_end" id="txt_plan_end" />
                            </div>
                            <div class="ui-block-a">
                                <label for="txt_planid">พนักงานผู้วางแผน</label>
                                <input type="text" name="txt_planid" placeholder="รหัสพนักงานของท่าน" id="txt_planid"  value="<%=Session("STAFF_ID")%>"" />
                            </div>                            
                            <div class="ui-block-b">
                                <label for="txt_planname">ชื่อผู้วางแผน</label>
                                <input type="text" name="txt_planname" id="txt_planname" readonly="readonly" value="<%=Session("STAFF_FNAME")%>"" />                                  
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_plan_result">ผลการอนุมัติแผน:</label>
                                <input type="text" name="sel_plan_result" id="sel_plan_result" readonly="readonly" />
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_plan_comment">Comment แผนปฏิบัติงาน</label>
                                <textarea cols="40" rows="4" name="txt_plan_comment" id="txt_plan_comment"></textarea>
                            </div>
                            <div class="ui-block-a">
                                <label for="txt_plan_approveid">พนักงานผู้อนุมัติแผน</label>
                                <input type="text" name="txt_plan_approvename" id="txt_plan_approvename" readonly="readonly" />
                            </div>
                        </div><!--<div class="ui-grid-a ui-responsive">-->

                        <div class="ui-grid-a ui-responsive background4" id="div_engineer">
                            <h2>ข้อมูลการปฏิบัติงานจริง</h2>
                            <div class="ui-block-a">
                                <label for="txt_date_start">วันเวลาที่เริ่มงาน[เดือน/วัน/ปี]:</label>
                                <input type="date" name="txt_date_start" id="txt_date_start" value="" />
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_date_end">วันเวลาที่ดำเนินการเสร็จ[เดือน/วัน/ปี]:</label>
                                <input type="date" name="txt_date_end" id="txt_date_end" value="" />
                            </div>
                            <div class="ui-block-a">
                                <label for="txt_job_detail">รายละเอียดการปฏิบัติงาน</label>
                                <textarea cols="40" rows="4" name="txt_plan_comment" id="txt_job_detail"></textarea>
                            </div>
                            <div class="ui-block-b">
                            </div>
                            <div class="ui-block-a">
                                <label for="file_1">รูปประกอบ</label>
                                <input type="file" id="file_1" name="file_1" />
                            </div>
                            <div class="ui-block-b">
                                <label for="file_2">รูปประกอบ</label>
                                <input type="file" id="file_2" name="file_2" />
                            </div>
                            <div class="ui-block-a">
                                <label for="file_3">รูปประกอบ</label>
                                <input type="file" id="file_3" name="file_3" />
                            </div>
                            <div class="ui-block-b">
                                <label for="file_4">รูปประกอบ</label>
                                <input type="file" id="file_4" name="file_4" />
                            </div>
                            
                            <div class="ui-block-a">
                                <label for="sel_job_status">สถานะของงาน</label>
                                <select name="sel_job_status" id="sel_job_status" data-native-menu="false">
                                    <option value="" selected="selected">เลือกสถานะของงาน</option>
                                    <option value="Posepone">งานเลื่อน</option>
                                    <option value="Incomplete">งานไม่เสร็จ</option>
                                    <option value="Complete">งานเสร็จ</option>
                                </select>
                            </div>
                            <div class="ui-block-b">
                            </div>
                            <div class="ui-block-a">
                                <label for="txt_modid">รหัสพนักงานผู้บันทึก</label>
                                <input type="text" name="txt_modid" placeholder="รหัสพนักงานของท่าน" id="txt_modid"  value="<%=Session("STAFF_ID")%>"" />
                            </div>                            
                            <div class="ui-block-b">
                                <label for="txt_modname">ชื่อพนักงานผู้บันทึก</label>
                                <input type="text" name="txt_modname" id="txt_modname" readonly="readonly" value="<%=Session("STAFF_FNAME")%>"" />
                            </div>
                        </div><!--<div class="ui-grid-a ui-responsive">-->
						
						
                        <div class="ui-grid-a ui-responsive" id="div_button" data-theme="c">
                            <div class="ui-block-a">
                                <button class="ui-btn ui-btn-active" id ="bt_submit">บันทึกข้อมูล</button>                                
                            </div>                            
                            <div class="ui-block-b">                                
                                <button class="ui-btn ui-btn-active ui-btn-c" id ="bt_submit_e">บันทึกข้อมูลและปิดงาน</button>
                            </div>
                        </div><!--<div class="ui-grid-a ui-responsive">-->
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
<script src="../../JS/sys01.engineer.js"></script>
