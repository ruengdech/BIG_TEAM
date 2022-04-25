<%@ WebHandler Language="VB" Class="Handler" %>

Imports System
Imports System.IO
Imports System.Net
Imports System.Web
Imports System.Web.Script.Serialization

Public Class Handler : Implements IHttpHandler

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        'Check if Request is to Upload the File.
        If context.Request.Files.Count > 0 Then

            'Fetch the Uploaded File.
            Dim folderPath As String = context.Server.MapPath("~/sys01/Uploads/")
            Dim fileName As String = ""
            Dim uid As String = context.Request.Form.Item("id")
            Dim no As String = context.Request.Form.Item("no")
            Dim postedFile As HttpPostedFile = context.Request.Files(0)
            'Set the Folder Path.

            'SAVE FILE1
            Try
                fileName = Path.GetFileName(postedFile.FileName)
                postedFile.SaveAs(folderPath + uid + "_" & no & "_" + fileName)
                Dim cls As New MY_CLASS_MSSQL
                cls.strSql = "UPDATE SYS01_TS_REQUEST SET req_attached" & no & " ='" & uid + "_" & no & "_" + fileName & "' WHERE UID = " & uid
                cls.func_execute(cls.strSql)
            Catch ex As Exception

            End Try



            ''Send File details in a JSON Response.
            'Dim json As String = New JavaScriptSerializer().Serialize(New With {
            '    .name = fileName
            '})
            'context.Response.StatusCode = CInt(HttpStatusCode.OK)
            'context.Response.ContentType = "text/json"
            'context.Response.Write(json)
            context.Response.End()
        End If
    End Sub

    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class