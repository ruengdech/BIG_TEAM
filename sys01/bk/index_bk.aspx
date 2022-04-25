<%@ Page Language="VB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>jQuery Mobile: Theme Download</title>
	<link rel="stylesheet" href="themes/ST_MED.css" />
	<link rel="stylesheet" href="themes/jquery.mobile.icons.min.css" />
    <link href="themes/jquery.mobile.structure-1.4.5.css" rel="stylesheet" />
    <script src="themes/jquery-1.11.1.min.js"></script>
    <script src="themes/jquery.mobile-1.4.5.min.js"></script>
    <script type="text/javascript" >
        var JOB_DATA = [];
    </script>
    <style>
        #tb_history, .table_job_list {
          font-family: Arial, Helvetica, sans-serif;
          border-collapse: collapse;
          width: 100%;
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
   </style>
	
</head>
<body>

<div data-role="page" id="page_main" data-theme="b">
		<div data-role="header" data-position="inline">
			<h2>ระบบ บริการติดตั้ง/ซ่อมบำรุงเครื่องมือแพทย์</h2>
		</div>
		<div data-role="content" data-theme="a">
            <div data-role="tabs" id="tabs"  data-theme="a" >
                <div data-role="navbar">
                  <ul>
                    <li><a href="#request" data-ajax="true">Request Form</a></li>
                    <li><a href="#history" data-ajax="false">Request History</a></li>
                  </ul>
                </div><%--<div data-role="navbar">--%>
                <div id="request" class="ui-body-d ui-content ui-corner-all">
                    <div class="ui-bar ui-bar-a">
                        <h3>Heading</h3>
                        
                    </div>
                    <div class="ui-body ui-body-a">
                        <div class="ui-grid-b ui-responsive">
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
                        <div class="ui-grid-a ui-responsive">
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
                                <label for="txt_date">วันเวลาที่ต้องการ:</label>
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
                        <div class="ui-grid-a ui-responsive">
                        </div><!-- <div class="ui-grid-a ui-responsive"> -->
                        <button class="ui-btn" id ="bt_submit">บันทึกข้อมูล</button>
                    </div><%--<div class="ui-body ui-body-a">--%>
                </div><%--<div id="request" class="ui-body-d ui-content ui-corner-all">--%>
                <div id="history">
                    <h2>ข้อมูล การขอใช้บริการ</h2>
                    <input id="myInput" style="width:94%; padding: 12px 12px 12px 12px; font-size:14pt" type="text" placeholder="Search.." /><br />
                    <div id="div_history" style="overflow-x:auto;">
                        <table id="tb_history" >
                            <tr><th style="width:50px">เลขที่</th><th>วันที่แจ้ง / แจ้งโดย</th><th>หัวข้อที่แจ้ง</th><th>สถานที่ติดตั้ง</th><th>AM / BM</th><th>สถานะ</th></tr>
                        </table>
                    </div>			
                </div><%--<div id="history">--%>
            </div><%--<div data-role="tabs" id="tabs">--%>                    
		</div><%--<div data-role="content" data-theme="a">--%>
</div><!-- /page -->
    
<div data-role="page" id="page_detail" data-theme="b">
		<div data-role="header" data-position="inline">
			<h2>ระบบ บริการติดตั้ง/ซ่อมบำรุงเครื่องมือแพทย์</h2>
		</div>
		<div data-role="content" data-theme="a">
            <div id="div_detail"></div>
            <input type="button" onclick="history.back();" value="Back"/>
 		</div><%--<div data-role="content" data-theme="a">--%>

</div><!-- /page -->
        
<div data-role="page" id="page_assignlist" data-theme="c">
		<div data-role="header" data-position="inline">
			<h2>ระบบ บริการติดตั้ง/ซ่อมบำรุงเครื่องมือแพทย์ (SUPERVISOR)</h2>
		</div>
		<div data-role="content" data-theme="a">
                <div id="assign_list" class="ui-body-d ui-content ui-corner-all">
                    <div class="ui-bar ui-bar-a">
                        <h2>ข้อมูล การขอใช้บริการที่รอ Assign งาน</h2>                        
                    </div>
                    <div class="ui-body ui-body-a">
                        <div id="div_list_waitassign" style="overflow-x:auto;">
                            <table id="tb_list_waitassign" class="table_job_list" >
                                <tr><th style="width:50px">เลขที่</th><th>วันที่แจ้ง / แจ้งโดย</th><th>หัวข้อที่แจ้ง</th><th>สถานที่ติดตั้ง</th><th>AM / BM</th><th>สถานะ</th></tr>
                            </table>
                        </div>                    
                    </div><%--<div class="ui-body ui-body-a">--%>

                    <div class="ui-bar ui-bar-a">
                        <h2>ข้อมูล การขอใช้บริการที่ Assign ช่างแล้ว</h2>
                    </div>
                    <div class="ui-body ui-body-a">
                        <input id="txt_search_assigned" style="width:94%; padding: 12px 12px 12px 12px; font-size:14pt" type="text" placeholder="Search.." /><br />
                        <div id="div_list_assigned" style="overflow-x:auto;">
                            <table id="tb_list_assigned" >
                                <tr><th style="width:50px">เลขที่</th><th>วันที่แจ้ง / แจ้งโดย</th><th>หัวข้อที่แจ้ง</th><th>สถานที่ติดตั้ง</th><th>AM / BM</th><th>ช่างที่ได้รับ Assign</th><th>สถานะ</th></tr>
                            </table>
                        </div>                        
                    </div><%--<div class="ui-body ui-body-a">--%>                    
                </div><%--<div id="assign_list" class="ui-body-d ui-content ui-corner-all">--%>                        
 		</div><%--<div data-role="content" data-theme="a">--%>

</div><!-- /page -->

<div data-role="page" id="page_assigndetail" data-theme="c">
		<div data-role="header" data-position="inline">
			<h2>ระบบ บริการติดตั้ง/ซ่อมบำรุงเครื่องมือแพทย์ (SUPERVISOR)</h2>
		</div>
		<div data-role="content" data-theme="a">
            
                        <div class="ui-grid-b ui-responsive">
                        <h2>ข้อมูลผู้ส่งเรื่อง</h2>
                            <div class="ui-block-a" >
                                    <label for="p_assign_txt_staffId">รหัสพนักงาน :</label>
                                    <input type="text" name="p_assign_txt_staffId" id="p_assign_txt_staffId" value="" />
                            </div>
                            <div class="ui-block-b" >
                                    <label for="p_assign_txt_name">ชื่อ:</label>
                                    <input type="text" name="p_assign_txt_name" id="p_assign_txt_name" value="" />
                            </div>
                            <div class="ui-block-c" >                    
                                    <label for="p_assign_txt_lname">นามสกุล:</label>
                                    <input type="text" name="p_assign_txt_lname" id="p_assign_txt_lname" value="" />
                            </div>
                        </div><!-- <div class="ui-grid-b ui-responsive"> -->
                        <div class="ui-grid-a ui-responsive">
                            <div class="ui-block-a" >
                                    <label for="p_assign_txt_mobile">Mobile :</label>
                                    <input type="text" name="p_assign_txt_mobile" id="p_assign_txt_mobile" value="" />
                            </div>
                            <div class="ui-block-b" >
                                    <label for="p_assign_txt_email">Email: </label>
                                    <input type="email" name="p_assign_txt_email" id="p_assign_txt_email" value="" />
                            </div>
                            
                            <div class="ui-block-a" >
                                <div class="ui-field-contain">
                                    <label for="p_assign_sel_am">AM :</label>
                                    <select name="p_assign_sel_am" id="p_assign_sel_am" data-native-menu="false">
                                        <option value="0" selected="selected">เลือก AM</option>
                                    </select>
                                </div>
                            </div>
                            <div class="ui-block-b" >
                                <div class="ui-field-contain">
                                    <label for="p_assign_sel_bm">BM :</label>
                                    <select name="p_assign_sel_bm" id="p_assign_sel_bm" data-native-menu="false">
                                        <option value="0" selected="selected">เลือก BM</option>
                                    </select>
                                </div>
                            </div>

                            <h2>สถานที่ติดตั้ง</h2>
                            <div class="ui-block-a" >
                                <label for="p_assign_txt_location">โรงพยาบาล โรงแรม อื่นๆ :</label>
                                <input type="text" name="p_assign_txt_location" id="p_assign_txt_location" value="" />
                            </div>
                            <div class="ui-block-b" >
                                <label for="p_assign_txt_dept">แผนก :</label>
                                <input type="text" name="p_assign_txt_dept" id="p_assign_txt_dept" value="" />
                            </div>
                            <div class="ui-block-a" >
                                <label for="txt_contact">ชื่อผู้ติดต่อ :</label>
                                <input type="text" name="p_assign_txt_contact" id="p_assign_txt_contact" value="" />
                            </div>
                            <div class="ui-block-b" >
                                <label for="p_assign_txt_contactTel">เบอร์โทรผู้ติดต่อ :</label>
                                <input type="text" name="p_assign_txt_contactTel" id="p_assign_txt_contactTel" value="" />
                            </div>

                            <h2>รายละเอียดงาน</h2>
                            <div class="ui-block-a" >
                                <label for="p_assign_txt_date">วันเวลาที่ต้องการ:</label>
                                <input type="date" name="p_assign_txt_date" id="p_assign_txt_date" value="" />
                                <input type="time" name="p_assign_txt_time" id="p_assign_txt_time" />
                            </div>
                            <div class="ui-block-b" >
                                <label for="p_assign_txt_contract">เลขที่สัญญา :</label>
                                <input type="text" name="p_assign_txt_contract" id="p_assign_txt_contract" value="" />
                            </div>

                            
                            <div class="ui-block-a" >
                                <label for="p_assign_sel_pm">รอบ PM (ครั้ง/ปี) :</label>
                                <select name="p_assign_sel_pm" id="p_assign_sel_pm" data-native-menu="false">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                </select>
                            </div>
                            <div class="ui-block-b" >
                                <label for="p_assign_sel_warantee">ระยะเวลารับประกัน (ปี) :</label>
                                <select name="p_assign_sel_warantee" id="p_assign_sel_warantee" data-native-menu="false">
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
                                <label for="p_assign_sel_job1">ประเภทของงาน (1) :</label>
                                <select name="p_assign_sel_job1" id="p_assign_sel_job1" data-native-menu="false">
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
                                <label for="p_assign_txt_job1">รายการแจ้งใช้บริการ (1) :</label>
                                <input type="text" name="p_assign_txt_job1" id="p_assign_txt_job1" value="" />
                            </div>
                            <div class="ui-block-a">
                                <label for="p_assign_sel_job2">ประเภทของงาน (2) :</label>
                                <select name="sp_assign_el_job2" id="p_assign_sel_job2" data-native-menu="false">
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
                                <label for="p_assign_txt_job2">รายการแจ้งใช้บริการ (2) :</label>
                                <input type="text" name="p_assign_txt_job2" id="p_assign_txt_job2" value="" />
                            </div>
                            <div class="ui-block-a">
                                <label for="p_assign_sel_job3">ประเภทของงาน (3) :</label>
                                <select name="p_assign_sel_job3" id="p_assign_sel_job3" data-native-menu="false">
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
                                <label for="p_assign_txt_job3">รายการแจ้งใช้บริการ (3) :</label>
                                <input type="text" name="p_assign_txt_job3" id="p_assign_txt_job3" value="" />
                            </div>
                        </div><!-- <div class="ui-grid-a ui-responsive"> -->
                        <div class="ui-grid-a ui-responsive">
                        </div><!-- <div class="ui-grid-a ui-responsive"> -->     
 		</div><%--<div data-role="content" data-theme="a">--%>

</div><!-- /page -->   
<%--<div w3-include-html="html/page_assign.html"></div> --%>
</body>
</html>
<script src="../JS/sys01.index.js"></script>