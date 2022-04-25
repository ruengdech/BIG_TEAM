Imports Microsoft.VisualBasic
Imports SmartComm
Public Class SMS_NEW
    Private Const url As String = "https://o8.sc4msg.com"
    Dim encoding As Encoding = New UTF8Encoding(False)
    Dim smsUsername As String = "post01@saintmedotp"
    Dim smsPassword As String = "672AD38182559D8E26CC1B1F9B303316F344FED2D7515E097695342685C49F5FE246310137130DC4"

    Function SEND_SMS(MOB_ As String, MSG_ As String) As String
        Try
            'ให้ใช้งานภาษาไทยได้


            SmsClient.Init(url, encoding, smsUsername, smsPassword)



            Dim client As New SmsClient


            Dim mobileNo As String = MOB_
            Dim message As String = MSG_
            Dim scheduleTime As DateTime? = Nothing
            Dim category As String = "General"
            Dim senderName As String = ""
            Dim status As String = Nothing, taskId As String = Nothing

            Try

                Return SmsClient.SendMssage(mobileNo, message, scheduleTime, category, senderName, status, taskId)

            Catch ex As Exception
                'Console.WriteLine(ex)
                Return "Error: Unknow01"
            End Try



        Catch exxx As Exception
            'Console.WriteLine("Exception caught: {0}", ex.Message())
            Return "Error: Unknow02"
        End Try
        Return True
    End Function
End Class
'SUPPORT NET INNOVA
'เพื่อเพิ่มความรวดเร็ว และเพิ่มประสิทธิภาพในการให้บริการ ลูกค้าสามารถติดต่อ
'- Support = 086-317-0492 / 086-005-9080 
'- Account = 064-224-8232
'ขอบคุณครับ

