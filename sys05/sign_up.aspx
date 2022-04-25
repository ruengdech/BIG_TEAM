<%@ Page Language="VB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>[ADMIN] SAINTMED SALE FUNNEL </title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="RESOURCE/themes/ruengdech.css" rel="stylesheet" />
    <link href="RESOURCE/themes/jquery.mobile.icons.min.css" rel="stylesheet" />

    <link href="../sys01/themes/jquery.mobile.structure-1.4.5.css" rel="stylesheet" />
    <script src="../sys01/themes/jquery-1.11.1.min.js"></script>
    <script src="../sys01/themes/jquery.mobile-1.4.5.min.js"></script>
	<style>
	    .center {
		  margin: auto !important;
		  text-align: center !important;
            top: 0px;
            left: 0px;
        }
	 
	    .auto-style1 {
            width: 641px;
            height: 437px;
        }
	 
	</style>
    <script type="text/javascript" >
        var JOB_DATA = [];
        var STAFF_ID = "";
    </script>
	<%-- FOR RATING UI --%>	
    <link href="../css/css_rating.css" rel="stylesheet" />
	<script src="../JS/sys04.bar_rate.js"></script>  
	<script type="text/javascript">
		$(function () {
            $('#csi_1_1').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_1_2').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_1_3').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_2_1').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_2_2').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_2_3').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_3_1').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_3_2').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_3_3').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_4_1').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_4_2').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_4_3').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_4_4').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_5_1').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_5_2').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
            $('#csi_5_3').barrating({
                theme: 'bars-movie',
                initialRating: '0',
                allowEmpty: true,
                emptyValue: '0'
            });
		});
    </script>
	<%-- FOR RATING UI --%>
</head>
<% 
'Dim cls_sap As New MY_CLASS_MSSQL("SAINTMED", "ruengdech", "r4442440044ST")
'cls_sap.strSql = "SELECT   CardCode, CardName, CardType, Address, ZipCode, MailAddres, MailZipCod, Phone1, Phone2, Fax FROM  OCRD" 'CUSTOMER TABLE SAP
'cls_sap.strSql = "select code,name from ocst where country = 'TH'" ' PROVINCE TABLE SAP
'cls_sap.func_SetDataSet(cls.strSql, "JOB_DATA")
%>
<body>
	<div data-role="page" id="page_main">		
		<div data-role="header" style="background-color:#1294A6!important;border-color:#43bf79!important;text-shadow:none;">
			<center>
			<div style="min-height:50px;display:inline;">
				<img class="auto-style1" src="../img/header.PNG" style="display:inline; vertical-align:middle;  width:100%; height:90%"/>
            </div>
			</center>
		</div><!-- /header -->

		<div data-role="content" class="ui-content" data-theme="c">			
			<center>
				<h4>ลงทะเบียนลูกค้า<br />บริษัท เซนต์เมด จำกัด (มหาชน)</h4>
			</center>
			<div class="ui-grid-solo ui-responsive">
				<div class="ui-bar ui-bar-d center">
						<h3>ส่วนที่ 1: ข้อมูลทั่วไปของผู้รับบริการ</h3>
				</div>
				<div class="ui-grid-b ui-responsive">
					<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_date">วันที่รับบริการ:</label>
                            <input type="date" name="txt_date" id="txt_date" data-date-format="DD MMMM YYYY" />
					</div>
					<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
							<label for="txt_dept">หน่วยงาน:</label>
							<input type="text" name="txt_dept" id="txt_dept" />
					</div>
					<div class="ui-block-c" style="padding-left:10px; padding-right:10px">
							<label for="txt_hospital">โรงพยาบาล/องค์กร:</label>
							<input type="text" name="txt_hospital" id="txt_hospital" value="" />
					</div>
				</div>

					<div class="ui-bar ui-bar-c center">
						<h3>ส่วนที่ 2: ความพึงพอใจในการให้บริการระดับใด</h3>						
					</div>
					<div class="ui-grid-b ui-responsive"  data-role="content" style="border-width:1px!important" data-theme="a">
						<center><b>ความเป็นรูปธรรมในการให้บริการ</b></center><br />
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
								<label for="csi_1_1">1.1 พนักงานมีความพร้อมในการให้บริการ:</label>							
								<select id="csi_1_1">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
						<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
								<label for="csi_1_2">1.2 พนักงานแต่งกายด้วยชุดยูนิฟอร์ม สะอาด:</label>							
								<select id="csi_1_2">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
						<div class="ui-block-c" style="padding-left:10px; padding-right:10px">
								<label for="csi_1_3">1.3 เครื่องมือและอุปกรณ์มีมาตรฐาน ครบถ้วนและเพียงพอในการให้บริการ:</label>							
								<select id="csi_1_3">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
					</div>
					<div class="ui-grid-b ui-responsive"  data-role="content" style="border-width:1px!important" data-theme="a">
						<center><b>ความเชื่อถือและไว้วางใจได้</b></center><br />
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
								<label for="csi_2_1">2.1 การให้บริการมีแผนการให้บริการและให้บริการตรงตามแผนที่กำหนด:</label>							
								<select id="csi_2_1">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
						<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
								<label for="csi_2_2">2.2 การให้บริการตรงเวลาในการนัดหมาย:</label>							
								<select id="csi_2_2">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
						<div class="ui-block-c" style="padding-left:10px; padding-right:10px">
								<label for="csi_2_3">2.3 เครื่องมือและอุปกรณ์ทางการแพทย์ใช้งานได้ดีตามปกติหลังการให้บริการ:</label>							
								<select id="csi_2_3">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
					</div>
					<div class="ui-grid-b ui-responsive"  data-role="content" style="border-width:1px!important" data-theme="a">
						<center><b>การตอบสนองต่อลูกค้า</b></center><br />
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
								<label for="csi_3_1">3.1 พนักงานมีความกระตือรือร้นและเอาใจใส่ในการให้บริการ:</label>							
								<select id="csi_3_1">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
						<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
								<label for="csi_3_2">3.2 พนักงานให้บริการและแก้ไขปัญหาได้ถูกต้อง รวดเร็ว ไม่มีข้อผิดพลาด:</label>							
								<select id="csi_3_2">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
						<div class="ui-block-c" style="padding-left:10px; padding-right:10px">
								<label for="csi_3_3">3.3 เวลามีปัญหาในการใช้งาน สามารถติดต่อได้สะดวกทั้งในและนอกเวลางาน:</label>							
								<select id="csi_3_3">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
					</div>
					<div class="ui-grid-c ui-responsive"  data-role="content" style="border-width:1px!important" data-theme="a">
						<center><b>การให้ความเชื่อมั่นต่อลูกค้า</b></center><br />
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
								<label for="csi_4_1">4.1 พนักงานมีความรู้และความเชี่ยวชาญในเครื่องมือและอุปกรณ์ทางการแพทย์เป็นอย่างดี:</label>							
								<select id="csi_4_1">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
						<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
								<label for="csi_4_2">4.2 พนักงานสามารถให้ข้อมูล คำแนะนำที่เป็นประโยชน์และตอบข้อซักถามได้อย่างถูกต้องและชัดเจน:</label>							
								<select id="csi_4_2">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
						<div class="ui-block-c" style="padding-left:10px; padding-right:10px">
								<label for="csi_4_3">4.3 พนักงานมีมนุษยสัมพันธ์ที่ดี ใช้คำพูดสุภาพและกริยามารยาทเหมาะสม:</label>							
								<select id="csi_4_3">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
						<div class="ui-block-d" style="padding-left:10px; padding-right:10px">
								<label for="csi_4_4">4.4 พนักงานปฏิบัติตามมาตรการความปลอดภัยโดยเคร่งครัด:</label>							
								<select id="csi_4_4">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
					</div>
					<div class="ui-grid-a ui-responsive"  data-role="content" style="border-width:1px!important" data-theme="a">
						<center><b>การรู้จักและเข้าใจลูกค้า</b></center><br />
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
								<label for="csi_5_1">5.1 พนักงานมีความเข้าใจในความต้องการของลูกค้า:</label>							
								<select id="csi_5_1">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
						<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
								<label for="csi_5_2">5.2 พนักงานมีน้ำใจและยินดีให้การช่วยเหลือในการแก้ไขปัญหา:</label>							
								<select id="csi_5_2">
								  <option value="1">น้อย</option>
								  <option value="2">ค่อนข้างน้อย</option>
								  <option value="3">ปานกลาง</option>
								  <option value="4">ค่อนข้างมาก</option>
								  <option value="5">มาก</option>
								</select>
						</div>
					</div>
					<div class="ui-grid-single ui-responsive"  data-role="content" style="border-width:1px!important" data-theme="a">
						<center><b>ความคิดเห็น / ข้อเสนอแนะ</b></center><br />
						<div class="ui-block-a">
							<label for="csi_suggestion">ข้อมูล:</label>
							<textarea id="csi_suggestion" maxlength="2000" style="width:100%"></textarea>
						</div>
					</div>

                <div class="ui-grid-a" style="padding-left:10px; padding-right:10px">
						<input type="text" name="txt_ref1" id="txt_ref1" value="" style="1display:none;" />
						<input type="text" name="txt_ref2" id="txt_ref2" value="" style="1display:none;" />
                        <div class="ui-block-a">
	                        <input type="button" class="ui-btn ui-btn-active ui-btn-a" value="บันทึกข้อมูล" name="bt_save" id="bt_save" />
                        </div>
                        <div class="ui-block-b">
	                        <input type="button" class="ui-btn ui-btn-active ui-btn-b" value="ยกเลิก" name="bt_clear" id="bt_clear" />
                        </div>
                </div>
			</div>
				
		
		</div><!-- /content -->
	</div><!-- /page -->
</body>
<script src="../JS/sys05.sign_up.js"></script>
</html>
