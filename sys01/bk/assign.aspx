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

	
</head>
<body>

<div data-role="page" data-theme="b">
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
                                    <label for="sel_am">BM :</label>
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
                                    <option value="install_medequipment">ติดตั้งเครื่องมือแพทย์</option>
                                    <option value="demo">Demo</option>
                                    <option value="move_medequipment">ย้ายเครื่องมือแพทย์</option>
                                    <option value="product_show">แสดงสินค้า</option>
                                    <option value="product_spare">สำรองเครื่อง</option>
                                    <option value="maintain">ตรวจเช็คระบบ</option>
                                    <option value="ma">Preventive Maintainance</option>
                                    <option value="other">อื่นๆ</option>
                                </select>
                            </div>
                            <div class="ui-block-b" >
                                <label for="txt_job1">รายการแจ้งใช้บริการ (1) :</label>
                                <input type="text" name="txt_job1" id="txt_job1" value="" />
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_job2">ประเภทของงาน (2) :</label>
                                <select name="sel_job2" id="sel_job2" data-native-menu="false">
                                    <option value="install_medequipment">ติดตั้งเครื่องมือแพทย์</option>
                                    <option value="demo">Demo</option>
                                    <option value="move_medequipment">ย้ายเครื่องมือแพทย์</option>
                                    <option value="product_show">แสดงสินค้า</option>
                                    <option value="product_spare">สำรองเครื่อง</option>
                                    <option value="maintain">ตรวจเช็คระบบ</option>
                                    <option value="ma">Preventive Maintainance</option>
                                    <option value="other">อื่นๆ</option>
                                </select>
                            </div>
                            <div class="ui-block-b">
                                <label for="txt_job2">รายการแจ้งใช้บริการ (2) :</label>
                                <input type="text" name="txt_job2" id="txt_job2" value="" />
                            </div>
                            <div class="ui-block-a">
                                <label for="sel_job3">ประเภทของงาน (3) :</label>
                                <select name="sel_job3" id="sel_job3" data-native-menu="false">
                                    <option value="install_medequipment">ติดตั้งเครื่องมือแพทย์</option>
                                    <option value="demo">Demo</option>
                                    <option value="move_medequipment">ย้ายเครื่องมือแพทย์</option>
                                    <option value="product_show">แสดงสินค้า</option>
                                    <option value="product_spare">สำรองเครื่อง</option>
                                    <option value="maintain">ตรวจเช็คระบบ</option>
                                    <option value="ma">Preventive Maintainance</option>
                                    <option value="other">อื่นๆ</option>
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
                    <p>Your theme was successfully downloaded. You can use this page as a reference for how to link it up!</p>
			
			
                </div><%--<div id="history">--%>
            </div><%--<div data-role="tabs" id="tabs">--%>                    
		</div><%--<div data-role="content" data-theme="a">--%>

</div><!-- /page -->
</body>
</html>
<script src="../JS/sys01.index.js"></script>