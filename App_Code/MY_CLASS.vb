Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.OleDb


Public Class MY_CLASS
#Region "Declare"
    Private DB_PATH As String = "D:\SOFTWARE_DEVELOPMENT\ST_MED\SM.mdb" '"D:\saintmedmirror\data\SM.mdb" '
    Public Strcon As String = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & DB_PATH & ";Jet OLEDB:Database Password=;"
    'SERVER=  D:\saintmedmirror\data          
    'Local = C:\RUENGDECH-DATA\Saint Med/SM.mdb
    'PATH oF PUBLISH = 192.168.0.3 D:\saintmedmirror\ASP_NET
    Public conn As New OleDbConnection
    Public comm As New OleDbCommand
    Public ds As New DataSet()
    Public da As OleDbDataAdapter
    Public strSql As String
    '
#End Region

#Region "DATABASE FUNCTION"

    Public Function func_SetDataSet(ByVal strCommand As String, ByVal tbName As String) As Boolean
        Try
            ds.Tables(tbName).Rows.Clear()
        Catch ex As Exception
        End Try
        Try
            If connect_database() Then
                da = New OleDbDataAdapter(strCommand, conn)
                da.SelectCommand.CommandTimeout = 600
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
                comm = New OleDbCommand(SQL_STRING, conn)
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
            conn = New OleDbConnection(Strcon)
            conn.Open()
            '</connect>
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Function connect_database_connection() As String
        Try
            '<connect>
            conn = New OleDbConnection(Strcon)
            conn.Open()
            '</connect>
            Return "OK"
        Catch ex As Exception
            Return ex.ToString
        End Try
    End Function
#End Region '--"Function & Sub Procedure - Disconnect Mode"  
#Region "UTILITY FUNCTION"
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
    Public Function encryp_patient_uid(val As Double) As String
        Dim validchars As String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"

        Dim sb As String = ""
        Dim rand As New Random()
        For i As Integer = 1 To 10
            Dim idx As Integer = rand.Next(0, validchars.Length)
            Dim randomChar As Char = validchars(idx)
            sb &= randomChar
        Next i
        Dim en_i As Double = val
        en_i += 19
        en_i *= 13
        en_i -= 7
        en_i += (CInt(Date.Now.ToString("MMddyy")))
        en_i -= 39
        en_i *= 6

        en_i *= 3


        Dim enc As String = sb & en_i.ToString
        Return enc
        Dim x = enc.Split("XxXxBNH")
    End Function

    Public Function encryp_patient_uid_2020(val As Double, Optional Last_accessdate As String = "991231") As String
        '**** หลักคิด *****'
        'รูปแบบที่ได้จะมีรูปแบบดังนี้    XXXXXXXXYYYYYYYYYY?????????
        '   1. XXXXXXXX = กลุ่มชุดวันที่สิ้นสุดการอนุญาตให้เข้าถึง จำนวน 8 อักขระ คำนวณจาก 
        '       1.1 YYMMDD ปีเดือนวัน  ซึ่งจะทำงานได้ 80 ปี ระหว่าง 2020-01-01 - 2099-12-31 (รับได้ อีก 80 ปี) เริ่มเขียนปี 2020-03-04
        '       1.2 นำตัวเลขชุดที่ได้มา เข้าสูตร (((YYMMDD) * 44) + 44)
        '       1.3 ผลลัพธ์ที่ได้ จะอยู่ระหว่าง [8804888 - 43614608]
        '       1.4 ทำการแปลงตัวเลขเป็น String โดย หากผลลัพธ์จากข้อ 1.3 มีจำนวนตัวอักษรน้อยกว่า 8 ตัว ให้เติม 00 ข้างหน้า จะได้ค่าระหว่าง [08804888 - 43614608] ซึ่งเป็น String

        '   2. YYYYYYYYYY = กลุ่ม Random อักขระและตัวเลขเพื่อหลอกไม่ได้ใช้คำนวณอะไร จำนวน 10 อักขระ

        '   3. ??????? ค่า UID ของคนไข้ที่นำมาคำนวณ รองรับได้ไม่อั้น จึงไม่ทราบจำนวนความขาวอักขระ
        '       3.1 นำค่า เข้าสูตรดังนี้                  ((((((UID + 19) x 13) - 7) - 39) x 6) x 3)

        '**** หลักคิด *****'

        Dim validchars As String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        Dim sb As String = ""
        Dim rand As New Random()
        For i As Integer = 1 To 10
            Dim idx As Integer = rand.Next(0, validchars.Length)
            Dim randomChar As Char = validchars(idx)
            sb &= randomChar
        Next i
        Dim en_i As Double = val
        en_i += 19
        en_i *= 13
        en_i -= 7
        en_i -= 39
        en_i *= 6
        en_i *= 3

        Dim enc As String = sb & en_i.ToString
        Return enc
        Dim x = enc.Split("XxXxBNH")
    End Function
    Public Function decryp_patient_uid(val As String) As String
        Try
            Dim de As String = Right(val, val.Length - 10)
            Dim de_int As Double = CDbl(de)

            de_int /= 3



            de_int /= 6
            de_int += 39
            de_int -= (CInt(Date.Now.ToString("MMddyy")))
            de_int += 7
            de_int /= 13
            de_int -= 19
            de = de_int.ToString
            Return de
        Catch ex As Exception
            Return 0
        End Try
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
    Function encryp_staffSMD(sid As String) As String
        Try
            Dim int_sid As Integer = CInt(sid)
            int_sid += 1982
            int_sid *= 2
            int_sid -= CInt("04")
            int_sid *= 2
            int_sid -= 24
            Return int_sid.ToString
        Catch ex As Exception
            Return sid
        End Try
    End Function
    Function decryp_staffSMD(sid As String) As String
        Try
            Dim int_sid As Integer = CInt(sid)
            int_sid += 24
            int_sid /= 2
            int_sid += CInt("04")
            int_sid /= 2
            int_sid -= 1982
            Return int_sid.ToString
        Catch ex As Exception
            Return sid
        End Try
    End Function

    'Sub ToCsV(dGV As DataTable, filename As String)
    '    Dim stOutput As String = ""
    '    ' Export titles:
    '    Dim sHeaders As String = ""

    '    For j As Integer = 0 To dGV.Columns.Count - 1
    '        sHeaders = sHeaders.ToString() & Convert.ToString(dGV.Columns(j).ColumnName) & vbTab
    '    Next
    '    stOutput += sHeaders & vbCr & vbLf
    '    ' Export data.
    '    For i As Integer = 0 To dGV.Rows.Count - 1
    '        Dim stLine As String = ""
    '        For j As Integer = 0 To dGV.Columns.Count - 1  'dGV.Rows(i).Cells.Count - 1
    '            stLine = stLine.ToString() & Convert.ToString(dGV.Rows(i).Item(j).Value) & vbTab
    '        Next
    '        stOutput += stLine & vbCr & vbLf
    '    Next
    '    Dim utf16 As Encoding = Encoding.GetEncoding(1254)
    '    Dim output As Byte() = utf16.GetBytes(stOutput)
    '    Dim fs As New FileStream(filename, FileMode.Create)
    '    Dim bw As New BinaryWriter(fs)
    '    bw.Write(output, 0, output.Length)
    '    'write the encoded file
    '    bw.Flush()
    '    bw.Close()
    '    fs.Close()
    'End Sub

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
#End Region
#Region "GENERAL"
    Function TXT_TO_NUMBER(num As String) As String
        Try
            num = num.Replace(",", "")
            If num = "" Then num = "0"
            Return num
        Catch ex As Exception
            Return "0"
        End Try
    End Function

    Function HNFormat(str As String) As String
        Try
            If str.Length = 10 Then
                Dim tmp As String = ""
                tmp = Left(str, 2) & "-" & Mid(str, 3, 2) & "-" & Right(str, 6)
                Return tmp
            Else
                Return str
            End If
        Catch ex As Exception
            Return ""
        End Try
    End Function
    Function ExtractDateTime(str As String) As String
        Dim tmp_date(4) As String
        Dim myDateTIME As String = ""
        Dim mydate(3) As String
        Dim mytime(3) As String

        Try
            tmp_date = str.Split(" ")
            mydate = tmp_date(0).Split("/")
            mytime = tmp_date(1).Split(":")

            Dim hh, mm, ss As Integer
            hh = CInt(mytime(0))
            mm = CInt(mytime(1))
            ss = CInt(mytime(2))
            If tmp_date(2).ToUpper = "PM" Then hh += 12
            If hh = 24 Then hh = 0

            myDateTIME = CInt(mydate(2)).ToString("0000") & "-" & CInt(mydate(0)).ToString("00") & "-" & CInt(mydate(1)).ToString("00") & " " &
                             hh.ToString("00") & ":" & mm.ToString("00") & ":" & ss.ToString("00")
            ''2018-01-19 15:30:00'
            Return myDateTIME

        Catch ex As Exception
            Return ""
        End Try


    End Function
#End Region
End Class
