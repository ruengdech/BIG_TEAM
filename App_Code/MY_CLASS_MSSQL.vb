Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports System.Net.Mail
Imports System.Net
Public Class MY_CLASS_MSSQL

#Region "Declare"
    Public Strcon As String
    Public conn As New SqlConnection
    Public comm As New SqlCommand
    Public ds As New DataSet()
    Public da As SqlDataAdapter
    Public strSql As String
    Public DATABASE As String = "RUENGDECH_STMED"
    'Public DATABASE As String = "CHK_CORPORATE_BNHSTAFF" ' ใช้กับพนักงาน
    Public HOST As String = "192.168.0.4"
    'Public HOST As String = "US-PC\SQLEXPRESS"
    Private DBuser As String = "ruengdech"
    Private DBpassword As String = "r4442440044ST"
    Public Shared G_dtfInfo As New System.Globalization.DateTimeFormatInfo

    '
    Public G_sLine_draw9x11 As String = "_________________________________________________________________________________________________________________________"
    Public G_sLine_draw15x11 As String = "__________________________________________________________________________________________________________________________________________________________________________________________________________"
    Public G_dLine_draw9x11 As String = "=============================================================================================================="
    Public G_dLine_draw15x11 As String = "__________________________________________________________________________________________________________________________________________________________________________________________________________"
    Public G_sLine_drawA4 As String = "_________________________________________________________________________________________________________________________"
    Public G_dLine_drawA4 As String = "__________________________________________________________________________________________________________________________________________________________________________________________________________"
    '
#End Region

#Region "DATABASE FUNCTION"
    Public Sub New(Optional localDB As String = "", Optional localUser As String = "", Optional localPass As String = "")
        Dim IP As String = ""
        If IP = "127.0.0.1" Then
            HOST = "127.0.0.1"
        End If
        If localDB.Length > 2 Then
            Strcon = "Data Source=192.168.0.4; User ID =" & localUser & " ; Password=" & localPass & " ; Network Library=DBMSSOCN;Initial Catalog=" & localDB & ";"
        Else
            Strcon = "Data Source=192.168.0.4; User ID =" & DBuser & " ; Password=" & DBpassword & " ; Network Library=DBMSSOCN;Initial Catalog=" & DATABASE & ";"
        End If

    End Sub
    Public Function func_SetDataSet(ByVal strCommand As String, ByVal tbName As String) As Boolean
        Try
            ds.Tables(tbName).Rows.Clear()
        Catch ex As Exception
        End Try
        Try
            If connect_database() Then
                da = New SqlDataAdapter(strCommand, conn)
                da.SelectCommand.CommandTimeout = 180 ' กำหนดให้ Timeout เป็น 3 นาที
                da.Fill(ds, tbName.ToString)
                conn.Close()
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            conn.Close()
            'MsgBox("ไม่สามารถ ดึงข้อมูลได้ " & vbNewLine & ex.ToString)
            Return False
        End Try
    End Function
    Public Function func_execute(ByVal SQL_STRING As String) As Boolean
        Try
            If connect_database() Then
                comm = New SqlCommand(SQL_STRING, conn)
                comm.ExecuteNonQuery()
                conn.Close()
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            conn.Close()
            'MsgBox(ex.ToString)
            Return False
        End Try
    End Function
    Private Function connect_database() As Boolean
        Try
            '<connect>
            'Strcon = "Data Source=10.103.7.13; User ID =" & DBuser & " ; Password=" & DBpassword & " ; Network Library=DBMSSOCN;Initial Catalog=" & DATABASE & ";"
            conn = New SqlConnection(Strcon)
            conn.Open()
            '</connect>
            Return True
        Catch ex As Exception
            Try
                Strcon = "Data Source=US-PC\SQLEXPRESS;Password=airland;Persist Security Info=True;User ID=airland;Initial Catalog=AIR_LAND;"
                '<connect>
                conn = New SqlConnection(Strcon)
                conn.Open()
                '</connect>
                Return True
            Catch exa As Exception
                Return False
            End Try
        End Try
    End Function
#End Region '--"Function & Sub Procedure - Disconnect Mode"  
#Region "UTILITY FUNCTION"
    Public Function URL_removeParameter(str As String) As String
        Try
            Dim my_str As String = str
            Dim pos_ As Integer = my_str.IndexOf("?")
            my_str = my_str.Substring(0, pos_)
            Return my_str
        Catch ex As Exception
            Return str
        End Try
    End Function
    Public Function extract_first_mobile(val As String) As String
        Try
            Dim myTemp As String = val.Replace("-", "")
            Dim counter As Double
            Dim MyOut(100) As String
            Dim output As String
            Dim getRight As Integer = 0

            For j As Integer = 1 To val.Length
                If Mid(myTemp, j, 1) = "/" Or Mid(myTemp, j, 1) = "," Or Mid(myTemp, j, 1) = " " Then
                    counter = counter + 1
                ElseIf IsNumeric(Mid(myTemp, j, 1)) Then
                    MyOut(counter) = MyOut(counter) & Mid(myTemp, j, 1)
                End If
            Next


            output = ""
            For j = 0 To 100
                MyOut(j) = Replace(MyOut(j), " ", "")
                getRight = Len(MyOut(j)) - 2
                If Len(MyOut(j)) >= 9 Then
                    If Left(MyOut(j), 2) = "08" Then
                        output = output & MyOut(j) & ","
                    ElseIf Left(MyOut(j), 2) = "01" Then
                        output = output & " 081" & Right(MyOut(j), getRight) & ","
                    ElseIf Left(MyOut(j), 2) = "09" Then
                        If Len(MyOut(j)) = 10 Then
                            output = output & MyOut(j) & ","
                        Else
                            output = output & " 089" & Right(MyOut(j), getRight) & ","
                        End If
                    ElseIf Left(MyOut(j), 2) = "06" Then
                        output = output & MyOut(j) & ","
                    End If
                End If
                MyOut(j) = ""
            Next

            Return Left(output, 10)

        Catch ex As Exception
            Return ex.ToString

        End Try


    End Function
    Public Function genOTP() As String
        Dim validchars As String = "1234567890"

        Dim sb As String = ""
        Dim rand As New Random()
        For i As Integer = 1 To 6
            Dim idx As Integer = rand.Next(0, validchars.Length)
            Dim randomChar As Char = validchars(idx)
            sb &= randomChar
        Next i
        Return sb
    End Function
    Public Function number_to_string(ByVal value As Double) As String
        Dim num, ret As String
        Dim first, second As String
        ret = ""
        num = value.ToString("###.00")
        Dim tmp As String() = num.Split(".")
        first = tmp(0)
        second = tmp(1)
        Dim digit2 As Boolean = False
        Do Until first.Length = 0
            Select Case first.Length
                Case 1
                    If Microsoft.VisualBasic.Left(first, 1) = "1" And digit2 Then
                        ret &= "เอ็ดบาท"
                    ElseIf Microsoft.VisualBasic.Left(first, 1) = "0" Then
                        ret &= "บาท"
                    Else
                        ret &= number_tran(Microsoft.VisualBasic.Left(first, 1)) & "บาท"
                    End If
                Case 2, 8
                    If Microsoft.VisualBasic.Left(first, 1) <> "0" Then
                        If Microsoft.VisualBasic.Left(first, 1) = "2" Then
                            ret &= "ยี่สิบ"
                        ElseIf Microsoft.VisualBasic.Left(first, 1) = "1" Then
                            ret &= "สิบ"
                        Else
                            ret &= number_tran(Microsoft.VisualBasic.Left(first, 1)) & "สิบ"
                        End If
                        digit2 = True
                    Else
                        digit2 = False
                    End If
                Case 3, 9
                    If Microsoft.VisualBasic.Left(first, 1) <> "0" Then
                        ret &= number_tran(Microsoft.VisualBasic.Left(first, 1)) & "ร้อย"
                    End If
                Case 4, 10
                    If Microsoft.VisualBasic.Left(first, 1) <> "0" Then
                        ret &= number_tran(Microsoft.VisualBasic.Left(first, 1)) & "พัน"
                    End If
                Case 5, 11
                    If Microsoft.VisualBasic.Left(first, 1) <> "0" Then
                        ret &= number_tran(Microsoft.VisualBasic.Left(first, 1)) & "หมื่น"
                    End If
                Case 6, 12
                    If Microsoft.VisualBasic.Left(first, 1) <> "0" Then
                        ret &= number_tran(Microsoft.VisualBasic.Left(first, 1)) & "แสน"
                    End If
                Case 7, 13
                    If Microsoft.VisualBasic.Left(first, 1) <> "0" Then
                        ret &= number_tran(Microsoft.VisualBasic.Left(first, 1)) & "ล้าน"
                    End If
            End Select
            first = Microsoft.VisualBasic.Right(first, first.Length - 1)
        Loop
        If second <> "00" Then
            Do Until second.Length = 0
                Select Case second.Length
                    Case 1
                        If Microsoft.VisualBasic.Left(second, 1) = "1" And digit2 Then
                            ret &= "เอ็ดสตางค์"
                        ElseIf Microsoft.VisualBasic.Left(second, 1) = "0" Then
                            ret &= "สตางค์"
                        Else
                            ret &= number_tran(Microsoft.VisualBasic.Left(second, 1)) & "สตางค์"
                        End If
                    Case 2
                        If Microsoft.VisualBasic.Left(second, 1) = "0" Then
                            digit2 = False
                        Else
                            If Microsoft.VisualBasic.Left(second, 1) = "2" Then
                                ret &= "ยี่สิบ"
                            Else
                                ret &= number_tran(Microsoft.VisualBasic.Left(second, 1)) & "สิบ"
                            End If
                            digit2 = True
                        End If
                End Select
                second = Microsoft.VisualBasic.Right(second, second.Length - 1)
            Loop
        Else
            ret &= "ถ้วน"
        End If
        Return ret
    End Function
    Function number_tran(ByVal str As String) As String
        Select Case str
            Case 1
                Return "หนึ่ง"
            Case 2
                Return "สอง"
            Case 3
                Return "สาม"
            Case 4
                Return "สี่"
            Case 5
                Return "ห้า"
            Case 6
                Return "หก"
            Case 7
                Return "เจ็ด"
            Case 8
                Return "แปด"
            Case 9
                Return "เก้า"
            Case Else
                Return ""
        End Select
    End Function
    Function DMY_YMD(ByVal str As String, ByVal strSeparate As String) As String
        Dim MM As String = ""
        Dim DD As String = ""
        Dim YY As String = ""
        Dim Ret As String = ""

        Dim tmp() As String
        Try
            tmp = str.Split(strSeparate)
            Ret = tmp(2) & strSeparate & CInt(tmp(1)).ToString("00") & strSeparate & CInt(tmp(0)).ToString("00")
        Catch ex As Exception

        End Try
        Return Ret
    End Function
    Function MDY_YMD(ByVal str As String, ByVal strSeparate As String) As String
        Dim Ret As String = ""

        Dim tmp() As String
        tmp = str.Split(strSeparate)
        Ret = tmp(2) & strSeparate & CInt(tmp(0)).ToString("00") & strSeparate & CInt(tmp(1)).ToString("00")
        Return Ret
    End Function
    Function MDY_DMY(ByVal str As String, ByVal strSeparate As String) As String
        Dim Ret As String = ""
        Dim tmp() As String
        Try
            tmp = str.Split(strSeparate)
            Ret = CInt(tmp(1)).ToString("00") & strSeparate & CInt(tmp(0)).ToString("00") & strSeparate & tmp(2)
        Catch ex As Exception
        End Try
        Return Ret
    End Function
    Function YMD_DMY(ByVal str As String, ByVal strSeparate As String) As String

        Dim Ret As String = ""

        Dim tmp() As String
        Try

            tmp = str.Split(strSeparate)
            Ret = CInt(tmp(2)).ToString("00") & strSeparate & CInt(tmp(1)).ToString("00") & strSeparate & tmp(0)
        Catch ex As Exception

        End Try
        Return Ret
    End Function
    Function YMD_MDY(ByVal str As String, ByVal strSeparate As String) As String
        Dim Ret As String = ""

        Dim tmp() As String
        tmp = str.Split(strSeparate)
        Ret = tmp(1) & strSeparate & tmp(2) & strSeparate & tmp(0)
        Return Ret
    End Function


    Function sendEmail(m_address() As String, m_from As String, m_msg As String, Optional m_subject As String = "JOB REQUEST SYSTEM") As String

        System.Net.ServicePointManager.Expect100Continue = True
        System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12


        '<SMD O365 SMTP>
        'noreply@saintmed.com
        'You@2022
        'POP settings 
        'Server name: outlook.office365.com

        'Port: 995

        'Encryption method: SSL

        '        IMAP settings 
        'Server name: outlook.office365.com

        'Port: 993

        'Encryption method: SSL

        '        SMTP settings 
        'Server name: smtp.office365.com

        'Port: 587
        '</SMD O365 SMTP>

        'Dim smtpClient As SmtpClient = New SmtpClient("mail.saintmed.com", 587)
        Dim smtpClient As SmtpClient = New SmtpClient("smtp.office365.com")

        smtpClient.UseDefaultCredentials = False

        smtpClient.Credentials = New System.Net.NetworkCredential("noreply@saintmed.com", "You@2022")
        smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network
        smtpClient.EnableSsl = True
        smtpClient.Port = 587


        m_from = "noreply@saintmed.com"
        Dim mailMessage As MailMessage = New MailMessage(m_from, m_address(0))
        mailMessage.Subject = m_subject
        mailMessage.Body = m_msg
        mailMessage.IsBodyHtml = True
        Try
            For i As Integer = 1 To m_address.Length - 1
                mailMessage.To.Add(m_address(i))
            Next
        Catch ex As Exception

        End Try

        Try
            '//smtpClient.SendMailAsync(mailMessage)
            smtpClient.Send(mailMessage)
            Return "SUCCESS"
        Catch ex As Exception
            Return "FAIL: " & ex.ToString
        End Try




        '---------------------------

        'Try
        '    System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12
        '    Dim smtp As New System.Net.Mail.SmtpClient


        '    smtp.Host = "smtp.office365.com"
        '    smtp.Port = 587
        '    smtp.EnableSsl = True
        '    smtp.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network
        '    smtp.UseDefaultCredentials = True
        '    smtp.Credentials = New System.Net.NetworkCredential("noreply@saintmed.com", "You@2020")
        '    smtp.Send(mailMessage)
        '    Return "SUCCESS"
        'Catch ex As Exception
        '    ''SG2PR02CA0121.apcprd02.prod.outlook.com
        '    Return "FAIL: " & ex.ToString

        'End Try
        ''Try

        ''    Dim msg_ As New MimeMessage
        ''    msg_.From.Add(New MailboxAddress("noreply@saintmed.com", "noreply@saintmed.com"))
        ''    Try

        ''        For i As Integer = 1 To m_address.Length - 1
        ''            msg_.To.Add(New MailboxAddress(m_address(i), m_address(i)))
        ''        Next
        ''    Catch ex As Exception

        ''    End Try
        ''    msg_.Subject = m_subject
        ''    Dim body_msg As New BodyBuilder
        ''    body_msg.HtmlBody = m_msg
        ''    msg_.Body = body_msg.ToMessageBody

        ''    Dim smtp_c As New MailKit.Net.Smtp.SmtpClient()
        ''    smtp_c.Connect("smtp.office365.com", 587, MailKit.Security.SecureSocketOptions.StartTls)
        ''    smtp_c.Authenticate("noreply@saintmed.com", "You@2020")
        ''    smtp_c.Send(msg_)
        ''    smtp_c.Disconnect(True)

        ''    Return "SUCCESS"
        ''Catch ex As Exception
        ''    Return "FAIL: " & ex.ToString

        ''End Try

    End Function
#End Region

End Class
