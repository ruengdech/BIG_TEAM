Imports Microsoft.VisualBasic
Imports System.Data
'Imports MySql.Data.MySqlClient

Public Class MY_CLASS_MYSQL

    '#Region "Declare"
    '    'Database
    '    'http://10.103.10.40/phpmyadmin/
    '    'User:   lansing
    '    'Pass:   lbsadmin

    '    Public Strcon As String
    '    Public conn As New MySqlConnection
    '    Public comm As New MySqlCommand
    '    Public ds As New DataSet()
    '    Public da As MySqlDataAdapter
    '    Public strSql As String

    '    Public DATABASE As String = "ruengdech_main"  ' ใช้กับบริษัทภายนอก
    '    Public HOST As String = "192.168.0.5"
    '    Private DBuser As String = "ruengdech"
    '    Private DBpassword As String = "r4442440044ST"
    '    Private PORT As String = "3306"
    '#End Region


    '    Public Sub New(Optional host_ As String = "", Optional database_ As String = "", Optional localUser As String = "", Optional localPass As String = "")
    '        If host_.Length > 2 Then
    '            Strcon = String.Format("server={0};database={1};port={2};user={3};password={4}", host_, database_, PORT, localUser, localPass)
    '        Else
    '            Strcon = String.Format("server={0};database={1};port={2};user={3};password={4}", HOST, DATABASE, PORT, DBuser, DBpassword)
    '        End If

    '    End Sub

    '    Public Function func_SetDataSet(ByVal strCommand As String, ByVal tbName As String) As Boolean
    '        Try
    '            ds.Tables(tbName).Rows.Clear()
    '        Catch ex As Exception
    '        End Try
    '        Try
    '            If connect_database() Then
    '                da = New MySqlDataAdapter(strCommand, conn)
    '                da.SelectCommand.CommandTimeout = 600
    '                da.Fill(ds, tbName.ToString)
    '                conn.Close()
    '                Return True
    '            Else
    '                Return False
    '            End If
    '        Catch ex As Exception
    '            conn.Close()
    '            'MsgBox("ไม่สามารถ ดึงข้อมูลได้ " & vbNewLine & ex.ToString)
    '            Return False
    '        End Try
    '    End Function

    '    Private Function connect_database() As Boolean
    '        Try
    '            '<connect>
    '            conn = New MySqlConnection(Strcon)
    '            conn.Open()
    '            '</connect>
    '            Return True
    '        Catch ex As Exception
    '            Return False
    '        End Try
    '    End Function
End Class
