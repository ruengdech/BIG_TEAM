<%@ Page Language="VB" AutoEventWireup="false" CodeFile="login.aspx.vb" Inherits="authentication_login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>jQuery Mobile: Theme Download</title>
	<link rel="stylesheet" href="../../themes/RUENGDECH.min.css" />
	<link rel="stylesheet" href="../../themes/jquery.mobile.icons.min.css" />
	<link rel="stylesheet" href="../../css/jm.css" />
    	<script src="../themes/jquery-1.11.1.min.js"></script>
	<script src="../themes/jquery.mobile-1.4.5.js"></script>
</head>
<body>
    <div data-role="page" data-theme="a">
		<div data-role="header" data-position="inline">
            
            <h1><img src="../../img/SM_LOGO.gif" width="300px" /></h1>
			<h1>Saintmed: Intranet () </h1>
		</div>
		<div data-role="content" data-theme="a">
            
			<h2>Authentication</h2>
            <center>
            <form id="form1" runat="server" data-ajax="false">
                <div>
                    <asp:Login ID="Login1" runat="server" BackColor="#EFF3FB" BorderColor="#B5C7DE" BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="Medium" ForeColor="#333333" Height="151px" Width="373px" data-ajax="false">
                        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                        <LoginButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
                        <TextBoxStyle Font-Size="0.8em" />
                        <TitleTextStyle BackColor="#507CD1" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
                    </asp:Login>
                    <asp:TextBox ID="txt_warning" type="text" runat="server" ForeColor="#FF3300" ReadOnly="True" Visible="False" Width="362px">Login Fail Please try again</asp:TextBox>
                    <br />
                </div>
            </form>
            </center>
        </div>
        </div>
</body>
</html>
