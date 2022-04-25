<%@ Page Language="VB" %>

<% 
    Dim cls As New MY_CLASS
    Dim clsSQL As New MY_CLASS_MSSQL
    Dim feature As String = Request.Form("feature")



    Select Case feature
        Case "staff_search"
            Try
                Dim s_id As String = Request.Form("ctrl_txt_id")
                cls.strSql = "SELECT name, lastname, uid, mobile, emloffice, positions FROM employee2 WHERE (((uid)=" & s_id & ") AND (([active])=1))"
                cls.func_SetDataSet(cls.strSql, "STAFF")
                If cls.ds.Tables("STAFF").Rows.Count > 0 Then
                    With cls.ds.Tables("STAFF").Rows(0)
                        Response.Write("SUCCESS")
                        Response.Write("|" & .Item("uid").ToString())
                        Response.Write("|" & .Item("name").ToString())
                        Response.Write("|" & .Item("lastname").ToString())
                        Response.Write("|" & .Item("mobile").ToString())
                        Response.Write("|" & .Item("emloffice").ToString())
                        Response.Write("|" & .Item("positions").ToString())
                        '<Add data to MS-SQL>
                        Try
                            clsSQL.strSql = "SELECT STAFF_ID FROM SYS01_MS_STAFF WHERE (STAFF_ID = " & s_id & ")"
                            clsSQL.func_SetDataSet(clsSQL.strSql, "EX")
                            If clsSQL.ds.Tables("EX").Rows.Count = 0 Then
                                clsSQL.strSql = "INSERT INTO SYS01_MS_STAFF (" &
                                                    "STAFF_ID, STAFF_NAME, STAFF_LNAME, STAFF_TYPE " &
                                                    ", STAFF_EMAIL, STAFF_MOBILE, STAFF_POSITION) " &
                                                 " VALUES (" &
                                                        "" & s_id & ", '" & .Item("name").ToString() & "', '" & .Item("lastname").ToString() & "', ''" &
                                                        ", '" & .Item("emloffice").ToString() & "', '" & .Item("mobile").ToString() & "', '" & .Item("positions").ToString() & "'" &
                                                 ")"
                                clsSQL.func_execute(clsSQL.strSql)
                            End If
                        Catch ex As Exception

                        End Try
                        '</Add data to MS-SQL>
                    End With
                Else
                    Response.Write("FAIL")
                End If
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "send_otp"
            Try
                Dim s_id As String = Request.Form("ctrl_txt_id")
                Dim s_mob As String = Request.Form("ctrl_txt_mob")
                Dim s_otp As String = cls.genOTP()
                clsSQL.strSql = "UPDATE SYS01_MS_STAFF SET STAFF_OTP = '" & s_otp & "' WHERE (STAFF_ID = " & s_id & ")"
                clsSQL.func_execute(clsSQL.strSql)

                Dim SMS_ As New SMS_NEW
                's_mob = "0814443772" '  For TEST
                SMS_.SEND_SMS(s_mob, "รหัส OTP = " & s_otp & vbNewLine & "ใช้รหัสนี้เพื่อยืนยันตัวตนใน LINE")
                Response.Write("SUCCESS|" & s_otp)
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "save_staff"
            Try
                Dim s_id As String = Request.Form("ctrl_txt_id")
                Dim ctrl_txt_line As String = Request.Form("ctrl_txt_line")

                clsSQL.strSql = "UPDATE SYS01_MS_STAFF SET STAFF_LINE = '" & ctrl_txt_line & "' WHERE (STAFF_ID = " & s_id & ")"
                clsSQL.func_execute(clsSQL.strSql)
                Response.Write("SUCCESS")
                Dim line_s As New LINE_DIRECT
                line_s.SEND_MSG(line_s.GENERATE_TEXT_MSG(ctrl_txt_line, "ขอบคุณสำหรับการยืนยันตัวตน " & vbNewLine & vbNewLine & "ยินดีต้อนรับเข้าสู่ โหมดพนักงาน จะแจ้ง update ต่อไปนะครับ"))
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
    End Select

%>
