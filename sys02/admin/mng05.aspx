<%@ Page Language="VB" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>[ADMIN] SAINTMED SALE FUNNEL </title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../RESOURCE/themes/ruengdech.css" rel="stylesheet" />
    <link href="../RESOURCE/themes/jquery.mobile.icons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile.structure-1.4.5.min.css" /> 
    <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script> 
    <script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>   
	<style>
	 .center {
		  margin: auto !important;
		  text-align: center !important;
	 }
	 
     .table_list {
          font-family: Arial, Helvetica, sans-serif;
          border-collapse: collapse;
          width: 100%;
     }
     .table_list th, .table_list td {
          border: 1px solid #ddd;
          padding: 8px;
     }
     .table_list tr:nth-child(even) {background-color: #f2f2f2;}
     .table_list tr:hover  {background-color: #ddd;}
     .table_list th {
          padding-top: 12px;
          padding-bottom: 12px;
          text-align: left;
          background-color: #4CAF50;
          color: white;
     }

	 label {
		font-size:0.8em!important;
	 }
	</style>
    <script type="text/javascript" >
        var JOB_DATA = [];
        var STAFF_ID = "";
    </script>
</head>
<% 
    Dim cls As New MY_CLASS_MSSQL()
    cls.strSql = "SELECT UID, STAFF_ID, STAFF_NAME, STAFF_LOGIN, STAFF_PASSWORD, STAFF_BOSSID, STAFF_BOSSNAME, STAFF_SALE_CATEGORY, STAFF_ROLE, STAFF_STATUS, STAFF_CWHEN, STAFF_REMARK FROM SYS02_MS_STAFF ORDER BY STAFF_ID"
    cls.func_SetDataSet(cls.strSql, "JOB_DATA")
    '0	 UID
    '1	 STAFF_ID
    '2	 STAFF_NAME
    '3	 STAFF_LOGIN
    '4	 STAFF_PASSWORD
    '5	 STAFF_BOSSID
    '6	 STAFF_BOSSNAME
    '7	 STAFF_SALE_CATEGORY
    '8	 STAFF_ROLE
    '9	 STAFF_STATUS
    '10	 STAFF_CWHEN 
    '11	 STAFF_REMARK
%>
<body>
	<div data-role="page" id="page_main">
		
		<div data-role="header" style="background-color:#43bf79!important;border-color:#43bf79!important;text-shadow:none;">
			<div style="min-height:50px;display:inline;"><img src="../../img/SM_LOGO.gif" style="display:inline; vertical-align:middle; margin: 10px 10px 10px 20px; width:130px"/><p class="lb_account" style="display:inline;vertical-align:middle" >[ADMIN] SAINTMED SALE FUNNEL</p></div>
		</div><!-- /header -->

		<div data-role="content" class="ui-content" data-theme="c">
			<div class="ui-grid-a ui-responsive">
				<div class="ui-block-a" style="width:65%;" >
					<div class="ui-bar ui-bar-a center">
						<h3>รายการข้อมูลพนักงาน</h3>
					</div>
					<input id="txt_search_01" style="width:50%; padding: 8px 8px 8px 8px; font-size:12pt" type="text" placeholder="Search.." /><br />
                    <table id="tb_list" class="table_list">
						<thead>
							<tr class="tr_main"><th style="width:50px">รหัส</th><th>ชื่อ-สกุล</th><th>ประเภท</th><th>หัวหน้า</th><th> แก้ไข </th></tr>
                        </thead>
						<tbody>
							<% 
    If cls.ds.Tables("JOB_DATA").Rows.Count > 0 Then
        For i As Integer = 0 To cls.ds.Tables("JOB_DATA").Rows.Count - 1
            With cls.ds.Tables("JOB_DATA").Rows(i)
                Response.Write("<tr>")

                Response.Write("<td>")
                Response.Write(.Item("STAFF_ID").ToString())
                Response.Write("</td>")

                Response.Write("<td>")
                Response.Write(.Item("STAFF_NAME").ToString())
                Response.Write("</td>")

                Response.Write("<td>")
                Response.Write(.Item("STAFF_SALE_CATEGORY").ToString())
                Response.Write("</td>")

                Response.Write("<td>")
                Response.Write(.Item("STAFF_BOSSNAME").ToString())
                Response.Write("</td>")

                Response.Write("<td class='center'>")
                Response.Write("<a href="""" onclick=""set_detail('" & .Item("UID").ToString() & "')""><img src = '../RESOURCE/themes/images/set02/062-pencil.png' style='width:25px'  /> </a>")
                Response.Write("</td>")

                Response.Write("</tr>")
											%>
                                            <script>
                                                JOB_DATA.push(["<%response.Write(.Item("UID").ToString)%>", "<%response.Write(.Item("STAFF_ID").ToString)%>", "<%response.Write(.Item("STAFF_NAME").ToString)%>", "<%response.Write(.Item("STAFF_LOGIN").ToString)%>", "<%response.Write(.Item("STAFF_PASSWORD").ToString)%>", "<%response.Write(.Item("STAFF_BOSSID").ToString)%>", "<%response.Write(.Item("STAFF_BOSSNAME").ToString)%>", "<%response.Write(.Item("STAFF_SALE_CATEGORY").ToString)%>", "<%response.Write(.Item("STAFF_ROLE").ToString)%>", "<%response.Write(.Item("STAFF_STATUS").ToString)%>", "<%response.Write(.Item("STAFF_CWHEN").ToString)%>", "<%response.Write(.Item("STAFF_REMARK").ToString)%>"]);
                                            </script>
											<%
                                                        End With
                                                    Next
                                                End If
											%>
						</tbody>
					</table>                    
				</div>

				<div class="ui-block-d" style="width:35%;" >
					<div class="ui-bar ui-bar-d center">
						<h3>แก้ไขข้อมูลพนักงาน</h3>
					</div>
					<div class="ui-grid-solo ui-responsive">
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<input type="text" name="txt_uuid" id="txt_uuid" value="" data-mini="true" readonly="readonly"/>
						</div>
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_id">รหัส:</label>
							<input type="text" name="txt_id" id="txt_id" value="" data-mini="true" />
						</div>
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_name">ชื่อ-นามสกุล:</label>
							<input type="text" name="txt_name" id="txt_name" data-mini="true" value="" />
						</div>
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_login">Login:</label>
							<input type="text" name="txt_login" id="txt_login" value="" data-mini="true" />
						</div>
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_pass">รหัสผ่าน:</label>
							<input type="text" name="txt_pass" id="txt_pass" value="" data-mini="true" />
						</div>
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="sel_type">ประเภท:</label>
							<select id="sel_type" name ="sel_type" data-mini="true">
								<option value="AM" >Area Manager</option>
								<option value="AS" >Area Sale</option>
								<option value="BM" >Brand Manager</option>
								<option value="BS" >Brand Sale</option>
								<option value="D" >Director</option>
							</select>
						</div>
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_role">สิทธิ์:</label>
							<input type="text" name="txt_role" id="txt_role" value="" data-mini="true" />
						</div>
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_bossid">หัวหน้า:</label>
							<div class="ui-grid-a ui-responsive">
								<div class="ui-block-a" style="width:25%">
									<input type="text" name="txt_bossid" id="txt_bossid" value="" placeholder="รหัส" data-mini="true" />
								</div>
								<div class="ui-block-b" style="width:75%">
									<input type="text" name="txt_bossname" id="txt_bossname" value="" readonly="readonly" data-mini="true"/>
								</div>
							</div>
							
						</div>
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_remark">หมายเหตุ:</label>
							<input type="text" name="txt_remark" id="txt_remark" value="" data-mini="true" />
						</div>
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="sel_status">สถานะ:</label>
							<select id="sel_status" name ="sel_status" data-mini="true">
								<option value="ACTIVE" selected="selected" >ACTIVE</option>
								<option value="INACTIVE" >INACTIVE</option>
							</select>
						</div>
						<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<div class="ui-grid-a ui-responsive">
								<div class="ui-block-a">
									<input type="button" class="ui-btn ui-btn-active ui-btn-a" value="บันทึกข้อมูล" name="bt_save" id="bt_save" data-mini="true" />
								</div>
								<div class="ui-block-b">
									<input type="button" class="ui-btn ui-btn-active ui-btn-b" value="ยกเลิก" name="bt_clear" id="bt_clear" data-mini="true" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div><!-- /content -->
        
		<div data-role="footer" data-position="fixed" style="background-color:#f1f1f3!important;vertical-align:middle;color:darkslategrey;border:none;">		
			<div class="ui-grid-d center">
				<div class="ui-block-a"><div style="background-color:#43bf79!important;font-size:5px; display:none;  ">&nbsp;</div></div>
				<div class="ui-block-b"><div style="background-color:#43bf79!important;font-size:5px; display:none;">&nbsp;</div></div>
				<div class="ui-block-c"><div style="background-color:#43bf79!important;font-size:5px; display:none;">&nbsp;</div></div>
				<div class="ui-block-d"><div style="background-color:#43bf79!important;font-size:5px; display:none;">&nbsp;</div></div>
				<div class="ui-block-e"><div style="background-color:#43bf79!important;font-size:5px;">&nbsp;</div></div>

				<div class="ui-block-a" style="min-height:30px;bottom:0;"><a href="mng01.aspx" rel="external"><img src="../RESOURCE/themes/images/set02/023-support.png" style="margin-top: 5px!important; width:30px;"  /></a></div>
				<div class="ui-block-b" style="min-height:30px;margin:auto;"><a href="mng02.aspx" rel="external"><img src="../RESOURCE/themes/images/set02/008-packaging.png" style="margin-top: 5px!important; width:30px; "/></a></div>
				<div class="ui-block-c" style="min-height:30px;margin:auto;"><a href="mng03.aspx" rel="external"><img src="../RESOURCE/themes/images/set02/004-strategy.png" style="margin-top: 5px!important; width:30px;" /></a></div>
				<div class="ui-block-d" style="min-height:30px;margin:auto;"><a href="mng04.aspx" rel="external"><img src="../RESOURCE/themes/images/set02/002-dollar.png" style="margin-top: 5px!important; width:30px;" /></a></div>
				<div class="ui-block-e" style="min-height:30px;margin:auto;"><a href="mng05.aspx" rel="external"><img src="../RESOURCE/themes/images/set02/025-hierarchy.png" style="margin-top: 5px!important; width:30px;" /></a></div>
                
				<div class="ui-block-a" style="font-size:0.7em;" >สถานะลูกค้า</div>
				<div class="ui-block-b" style="font-size:0.7em;" >สถานะสินค้า</div>
				<div class="ui-block-c" style="font-size:0.7em;" >ความเป็นไปได้</div>
				<div class="ui-block-d" style="font-size:0.7em;" >ประเภทงบ</div>
				<div class="ui-block-e" style="font-size:0.7em;" >พนักงาน</div>

				<div class="ui-block-a" ><div>&nbsp;</div></div>
				<div class="ui-block-b" ><div>&nbsp;</div></div>
				<div class="ui-block-c" ><div>&nbsp;</div></div>
				<div class="ui-block-d" ><div>&nbsp;</div></div>
				<div class="ui-block-e" ><div>&nbsp;</div></div>
			</div>
		</div><!-- /footer -->

	</div><!-- /page -->
</body>
<script src="../JS/sys02.mng05.js"></script>
</html>
