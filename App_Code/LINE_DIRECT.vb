Imports Microsoft.VisualBasic
Imports Newtonsoft.Json
Imports System.Net
Imports System.IO
Imports RestSharp


Public Class LINE_DIRECT
    Private Const ChannelAccessToken As String = "YI9aw15AcICCOqF+NEneFbynhS2UL9yAHi59SYUdfs4WkUt3yjshB1XgSdUgCH+d/IeYgwJtQpgxHSdDJW2h7pssT7obYXZeFgycU2MsY2ic7of50RT2mcKyaOWzooT6WdfqdVFSaHYtq6lVL5VGdgdB04t89/1O/w1cDnyilFU="
    Private Const URL_API_PUSH As String = "https://api.line.me/v2/bot/message/push/"
    Private Const URL_API_REPLY As String = "https://api.line.me/v2/bot/message/reply/"

#Region "LINE API"
    'Public Function PUSH_MSG(msg As String) As Boolean
    '    Dim jSonString As String
    '    jSonString = msg

    '    Try
    '        '<TEST>
    '        Dim tm As Object = JsonConvert.DeserializeObject(jSonString)
    '        '<TEST>


    '        Dim client = New RestClient(URL_API_PUSH)
    '        Dim requestx = New RestRequest(Method.POST)

    '        requestx.AddHeader("content-type", "application/json")
    '        requestx.AddHeader("Authorization", "Bearer " & ChannelAccessToken)
    '        'requestx.AddJsonBody(JsonConvert.DeserializeObject(jSonString))
    '        requestx.AddParameter("application/json", tm, ParameterType.RequestBody)

    '        Dim response As IRestResponse = client.Execute(requestx)

    '        Dim my_cls As New MY_CLASS
    '        my_cls.strSql = "insert into LINE_SEND (SENT_TO,HN, MSG, SENT_TIME) VALUES    ('PUSH','','" & msg.Replace(vbNewLine, "\n") & "', GETDATE()) "
    '        my_cls.func_execute(my_cls.strSql)

    '    Catch ex As Exception

    '    End Try
    '    Return True

    '    'curl -v - X POST https:  //api.line.me/v2/bot/message/push \
    '    '    -H 'Content-Type: application/json' \
    '    '    -H 'Authorization: Bearer {channel access token}' \
    '    '    -d '{
    '    '        "to": "U4af4980629...",
    '    '        "messages":[
    '    '            {
    '    '                "type":"text",
    '    '                "text":"Hello, world1"
    '    '            },
    '    '            {
    '    '                "type":"text",
    '    '                "text":"Hello, world2"
    '    '            }
    '    '        ]
    '    '    }'

    '    ''URL: https://developers.line.biz/en/reference/messaging-api/#send-push-message
    'End Function
    'Public Function REPLY_MSG(msg As String) As Boolean
    '    Dim jSonString As String
    '    jSonString = msg

    '    Try
    '        '<TEST>
    '        Dim tm As Object = JsonConvert.DeserializeObject(jSonString)
    '        '<TEST>

    '        Dim client = New RestClient(URL_API_REPLY)
    '        Dim requestx = New RestRequest(Method.POST)

    '        requestx.AddHeader("content-type", "application/json")
    '        requestx.AddHeader("Authorization", "Bearer " & ChannelAccessToken)
    '        requestx.AddParameter("application/json", tm, ParameterType.RequestBody)

    '        Dim response As IRestResponse = client.Execute(requestx)

    '        Dim my_cls As New MY_CLASS
    '        my_cls.strSql = "insert into LINE_SEND (SENT_TO,HN, MSG, SENT_TIME) VALUES    ('REPLY','','" & msg.Replace(vbNewLine, "\n") & "', GETDATE()) "
    '        my_cls.func_execute(my_cls.strSql)
    '    Catch ex As Exception

    '    End Try
    '    Return True

    '    '       curl -v - X POST https: //api.line.me/v2/bot/message/reply \
    '    '       -H 'Content-Type: application/json' \
    '    '       -H 'Authorization: Bearer {channel access token}' \
    '    '       -d '{
    '    '           "replyToken":"nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
    '    '           "messages":[
    '    '               {
    '    '                   "type":"text",
    '    '                   "text":"Hello, user"
    '    '               },
    '    '               {
    '    '                   "type":"text",
    '    '                   "text":"May I help you?"
    '    '               }
    '    '           ]
    '    '       }'

    '    ''URL: https://developers.line.biz/en/reference/messaging-api/#send-reply-message
    'End Function

    Public Function SEND_MSG(MSG As String) As Boolean
        Dim jSonString As String
        Dim URL_API As String = ""

        jSonString = MSG

        If MSG.ToString.IndexOf("replyToken") = -1 Then
            'PUSH MSG
            URL_API = URL_API_PUSH
        ElseIf MSG.ToString.IndexOf("replyToken") <> -1 Then
            'REPLY MSG
            URL_API = URL_API_REPLY
        End If

        Try
            '<TEST>
            Dim MSG_DESERIAL_JSON As Object = JsonConvert.DeserializeObject(jSonString)
            '<TEST>


            Dim client = New RestClient(URL_API)
            Dim requestx = New RestRequest(Method.POST)

            requestx.AddHeader("content-type", "application/json")
            requestx.AddHeader("Authorization", "Bearer " & ChannelAccessToken)
            requestx.AddParameter("application/json", MSG_DESERIAL_JSON, ParameterType.RequestBody)

            Dim response As IRestResponse = client.Execute(requestx)

            Dim my_cls As New MY_CLASS_MSSQL
            my_cls.strSql = "insert into LINE_SEND (MSG, SENT_TIME) VALUES    ('" & MSG.Replace(vbNewLine, "\n").Replace("""", "dblQuote").Replace("'", "sQuote") & "', GETDATE()) "
            my_cls.func_execute(my_cls.strSql)

            Return True
        Catch ex As Exception
            Dim cls As New MY_CLASS_MSSQL
            cls.strSql = "INSERT INTO SYS03TMP (TMP) values ('SEND ERROR " & ex.ToString().Replace("""", "dblQuote").Replace("'", "sQuote") & "') "
            cls.func_execute(cls.strSql)
            Return False
        End Try
    End Function
#End Region

#Region "UTILITY"
    Function GENERATE_TEXT_MSG(lineid As String, msgIn As String, Optional line_type As String = "PUSH") As String

        Try
            Dim MSGS As String = ""
            Dim line_api_type As String = "to"
            If line_type = "REPLY" Then line_api_type = "replyToken"


            MSGS = "" &
                            "{" &
                            "    '" & line_api_type & "': '" & lineid & "'," &
                            "    'messages': [" &
                            "        {" &
                                        "'type': 'text', " &
                                        "'text': '" & msgIn & "' " &
                            "        }" &
                            "    ]" &
                            "}"
            'MSGS = MSGS.Replace(vbCrLf, "")

            Return MSGS

        Catch ex As WebException
            'Console.WriteLine(ex.Message)
            Return ""
        Catch ex As Exception
            'Console.WriteLine(ex.Message)
            Return ""
        End Try

    End Function
    Function GENERATE_IMAGE_MSG(lineid As String, IMG_URL As String, Optional IMG_PREVIEW As String = "", Optional line_type As String = "PUSH") As String
        Try
            Dim MSGS As String = ""
            Dim line_api_type As String = "to"
            If line_type = "REPLY" Then line_api_type = "replyToken"
            If IMG_PREVIEW = "" Then IMG_PREVIEW = IMG_URL

            MSGS = "" &
                            "{" &
                            "    '" & line_api_type & "': '" & lineid & "'," &
                            "    'messages': [" &
                            "        {" &
                                        "'type': 'image', " &
                                        "'originalContentUrl': '" & IMG_URL & "', " &
                                        "'previewImageUrl': '" & IMG_PREVIEW & "' " &
                            "        }" &
                            "    ]" &
                            "}"
            MSGS = MSGS.Replace(vbCrLf, "")

            Return MSGS

        Catch ex As WebException
            'Console.WriteLine(ex.Message)
            Return ""
        Catch ex As Exception
            'Console.WriteLine(ex.Message)
            Return ""
        End Try
    End Function
    Function GENERATE_VDO_MSG(lineid As String, VDO_URL_MP4 As String, Optional IMG_PREVIEW As String = "", Optional line_type As String = "PUSH") As String
        Try
            Dim MSGS As String = ""
            Dim line_api_type As String = "to"
            If line_type = "REPLY" Then line_api_type = "replyToken"

            MSGS = "" &
                            "{" &
                            "    '" & line_api_type & "': '" & lineid & "'," &
                            "    'messages': [" &
                            "        {" &
                                        "'type': 'video', " &
                                        "'originalContentUrl': '" & VDO_URL_MP4 & "', " &
                                        "'previewImageUrl': '" & IMG_PREVIEW & "' " &
                            "        }" &
                            "    ]" &
                            "}"
            MSGS = MSGS.Replace(vbCrLf, "")

            Return MSGS

        Catch ex As WebException
            'Console.WriteLine(ex.Message)
            Return ""
        Catch ex As Exception
            'Console.WriteLine(ex.Message)
            Return ""
        End Try
    End Function
    Function GENERATE_LOCATION_MSG(lineid As String, TITLE As String, ADDR_DETAIL As String, LATITUDE As String, LONGTITUDE As String, Optional line_type As String = "PUSH") As String
        Try
            Dim MSGS As String = ""
            Dim line_api_type As String = "to"
            If line_type = "REPLY" Then line_api_type = "replyToken"

            MSGS = "" &
                            "{" &
                            "    '" & line_api_type & "': '" & lineid & "'," &
                            "    'messages': [" &
                            "        {" &
                                        "'type': 'location', " &
                                        "'title': '" & TITLE & "', " &
                                        "'address': '" & ADDR_DETAIL & "', " &
                                        "'latitude': " & LATITUDE & ", " &
                                        "'longitude': " & LONGTITUDE & ", " &
                            "        }" &
                            "    ]" &
                            "}"
            MSGS = MSGS.Replace(vbCrLf, "")

            Return MSGS

        Catch ex As WebException
            'Console.WriteLine(ex.Message)
            Return ""
        Catch ex As Exception
            'Console.WriteLine(ex.Message)
            Return ""
        End Try
    End Function

    Function GENERATE_CALL_MSG(lineid As String, msgIn As String, Optional line_type As String = "PUSH") As String

        Try
            Dim MSGS As String = ""
            Dim line_api_type As String = "to"
            If line_type = "REPLY" Then line_api_type = "replyToken"


            MSGS = "" &
                            "{" &
                            "    '" & line_api_type & "': '" & lineid & "'," &
                            "    'messages': ["

            '*************************************** FLEX HERE
            MSGS &= "  { " &
                    "    'type': 'flex', " &
                    "    'altText': 'Chat with US', " &
                    "    'contents': { " &
                    "  'type': 'bubble'," &
                    "  'hero': {" &
                    "    'type': 'image'," &
                    "    'url': 'https://saintmed.dyndns.biz/line/img/callcenter.png'," &
                    "    'size': 'full'," &
                    "    'aspectRatio': '20:13'," &
                    "    'aspectMode': 'cover'," &
                    "    'action': {" &
                    "      'type': 'uri'," &
                    "      'label': 'Line'," &
                    "      'uri': 'https://linecorp.com/'" &
                    "    }" &
                    "  }," &
                    "  'body': {" &
                    "    'type': 'box'," &
                    "    'layout': 'vertical'," &
                    "    'contents': [" &
                    "      {" &
                    "        'type': 'text'," &
                    "        'text': 'Bot ไม่สามารถตอบได้ '," &
                    "        'weight': 'bold'," &
                    "        'size': 'lg'," &
                    "        'color': '#5D5757FF'," &
                    "        'align': 'center'," &
                    "      }," &
                    "      {" &
                    "        'type': 'text'," &
                    "        'text': 'ขออภัยด้วยค่ะ Bot กำลังเรียนรู้ '," &
                    "        'align': 'center'," &
                    "        'margin': 'lg'," &
                    "        'wrap': true" &
                    "      }," &
                    "      {" &
                    "        'type': 'text'," &
                    "        'text': 'เซนต์เมด ยินดีให้บริการท่านผ่าน เจ้าหน้าที่ตอบ Chat คลิกที่ปุ่มคุยกับเจ้าหน้าที่ค่ะ'," &
                    "        'align': 'center'," &
                    "        'margin': 'lg'," &
                    "        'wrap': true" &
                    "      }" &
                    "    ]" &
                    "  }," &
                    "  'footer': {" &
                    "    'type': 'box'," &
                    "    'layout': 'vertical'," &
                    "    'flex': 0," &
                    "    'spacing': 'sm'," &
                    "    'contents': [" &
                    "      {" &
                    "        'type': 'button'," &
                    "        'action': {" &
                    "          'type': 'uri'," &
                    "          'label': 'แชทกับเจ้าหน้าที่'," &
                    "          'uri': 'https://lin.ee/ZVh37ZU'" &
                    "        }," &
                    "        'color': '#1294A6FF'," &
                    "        'height': 'sm'," &
                    "        'style': 'primary'" &
                    "      }," &
                    "      {" &
                    "        'type': 'button'," &
                    "        'action': {" &
                    "          'type': 'uri'," &
                    "          'label': 'เบอร์โทรติดต่อ'," &
                    "          'uri': 'https://saintmed.dyndns.biz/line/img/smd.aspx?a=call'" &
                    "        }," &
                    "        'color': '#16707CFF'," &
                    "        'height': 'sm'," &
                    "        'style': 'primary'" &
                    "      }," &
                    "      {" &
                    "        'type': 'spacer'," &
                    "        'size': 'sm'" &
                    "      }" &
                    "    ]" &
                    "  }" &
                    "}" &
                    "} "
            '*************************************** /FLEX HERE


            MSGS &= "    ]" &
                            "}"
            MSGS = MSGS.Replace(vbCrLf, "")

            Return MSGS

        Catch ex As WebException
            'Console.WriteLine(ex.Message)
            Return ""
        Catch ex As Exception
            'Console.WriteLine(ex.Message)
            Return ""
        End Try
    End Function
    Function GENERATE_PRODUCTS_MASK(lineid As String, msgIn As String, Optional line_type As String = "PUSH") As String

        Try
            Dim MSGS As String = ""
            Dim line_api_type As String = "to"
            If line_type = "REPLY" Then line_api_type = "replyToken"


            MSGS = "" &
                            "{" &
                            "    '" & line_api_type & "': '" & lineid & "'," &
                            "    'messages': ["

            '*************************************** FLEX HERE
            MSGS &= "  { " &
                    "    'type': 'flex', " &
                    "    'altText': 'สินค้าหมวด Mask', " &
                    "    'contents':  " &
                    "{" &
                    "  'type': 'carousel'," &
                    "  'contents': [" &
                    "    {" &
                    "      'type': 'bubble'," &
                    "      'hero': {" &
                    "        'type': 'image'," &
                    "        'url': 'https://sale.saintmed.com/wp-content/uploads/2021/08/Airfit-N20-Classic-01-600x600.jpg'," &
                    "        'size': 'full'," &
                    "        'aspectRatio': '1:1'," &
                    "        'aspectMode': 'cover'," &
                    "        'action': {" &
                    "          'type': 'uri'," &
                    "          'label': 'Line'," &
                    "          'uri': 'https://linecorp.com/'" &
                    "        }" &
                    "      }," &
                    "      'body': {" &
                    "        'type': 'box'," &
                    "        'layout': 'vertical'," &
                    "        'contents': [" &
                    "          {" &
                    "            'type': 'text'," &
                    "            'text': 'Airfit N20 Classic'," &
                    "            'weight': 'bold'," &
                    "            'size': 'xl'," &
                    "            'color': '#007BFFFF'," &
                    "            'align': 'center'," &
                    "            'contents': []" &
                    "          }," &
                    "          {" &
                    "            'type': 'text'," &
                    "            'text': '5,500 บาท'," &
                    "            'weight': 'regular'," &
                    "            'size': 'md'," &
                    "            'flex': 0," &
                    "            'align': 'end'," &
                    "            'wrap': true," &
                    "            'contents': []" &
                    "          }," &
                    "          {" &
                    "            'type': 'box'," &
                    "            'layout': 'vertical'," &
                    "            'spacing': 'sm'," &
                    "            'margin': 'lg'," &
                    "            'contents': [" &
                    "              {" &
                    "                'type': 'box'," &
                    "                'layout': 'baseline'," &
                    "                'spacing': 'sm'," &
                    "                'contents': [" &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': 'Brand'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#007BFF'," &
                    "                    'flex': 2," &
                    "                    'contents': []" &
                    "                  }," &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': 'Resmed'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#3D3C3CFF'," &
                    "                    'flex': 5," &
                    "                    'wrap': true," &
                    "                    'contents': []" &
                    "                  }" &
                    "                ]" &
                    "              }," &
                    "              {" &
                    "                'type': 'box'," &
                    "                'layout': 'baseline'," &
                    "                'spacing': 'sm'," &
                    "                'contents': [" &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': 'Warantee'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#007BFF'," &
                    "                    'flex': 2," &
                    "                    'contents': []" &
                    "                  }," &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': '1 year'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#3D3C3CFF'," &
                    "                    'flex': 5," &
                    "                    'wrap': true," &
                    "                    'contents': []" &
                    "                  }" &
                    "                ]" &
                    "              }" &
                    "            ]" &
                    "          }" &
                    "        ]" &
                    "      }," &
                    "      'footer': {" &
                    "        'type': 'box'," &
                    "        'layout': 'vertical'," &
                    "        'flex': 0," &
                    "        'spacing': 'sm'," &
                    "        'contents': [" &
                    "          {" &
                    "            'type': 'button'," &
                    "            'action': {" &
                    "              'type': 'uri'," &
                    "              'label': 'ซื้อสินค้า'," &
                    "              'uri': 'https://bit.ly/2Wa1Mpa'" &
                    "            }," &
                    "            'color': '#D23E69E5'," &
                    "            'height': 'sm'," &
                    "            'style': 'primary'" &
                    "          }," &
                    "          {" &
                    "            'type': 'button'," &
                    "            'action': {" &
                    "              'type': 'uri'," &
                    "              'label': 'แชทกับเจ้าหน้าที่'," &
                    "              'uri': 'https://lin.ee/ZVh37ZU'" &
                    "            }," &
                    "            'color': '#1294A6FF'," &
                    "            'height': 'sm'," &
                    "            'style': 'primary'" &
                    "          }," &
                    "          {" &
                    "            'type': 'button'," &
                    "            'action': {" &
                    "              'type': 'uri'," &
                    "              'label': 'เบอร์โทรติดต่อ'," &
                    "              'uri': 'https://saintmed.dyndns.biz/line/img/smd.aspx?a=call'" &
                    "            }," &
                    "            'color': '#16707CFF'," &
                    "            'height': 'sm'," &
                    "            'style': 'primary'" &
                    "          }," &
                    "          {" &
                    "            'type': 'spacer'," &
                    "            'size': 'sm'" &
                    "          }" &
                    "        ]" &
                    "      }" &
                    "    }," &
                    "    {" &
                    "      'type': 'bubble'," &
                    "      'hero': {" &
                    "        'type': 'image'," &
                    "        'url': 'https://sale.saintmed.com/wp-content/uploads/2021/08/Airfit-N20-01-600x600.jpg'," &
                    "        'size': 'full'," &
                    "        'aspectRatio': '1:1'," &
                    "        'aspectMode': 'cover'," &
                    "        'action': {" &
                    "          'type': 'uri'," &
                    "          'label': 'Line'," &
                    "          'uri': 'https://linecorp.com/'" &
                    "        }" &
                    "      }," &
                    "      'body': {" &
                    "        'type': 'box'," &
                    "        'layout': 'vertical'," &
                    "        'contents': [" &
                    "          {" &
                    "            'type': 'text'," &
                    "            'text': 'Airfit N20'," &
                    "            'weight': 'bold'," &
                    "            'size': 'xl'," &
                    "            'color': '#007BFFFF'," &
                    "            'align': 'center'," &
                    "            'contents': []" &
                    "          }," &
                    "          {" &
                    "            'type': 'text'," &
                    "            'text': '7,000 บาท'," &
                    "            'weight': 'regular'," &
                    "            'size': 'md'," &
                    "            'flex': 0," &
                    "            'align': 'end'," &
                    "            'wrap': true," &
                    "            'contents': []" &
                    "          }," &
                    "          {" &
                    "            'type': 'box'," &
                    "            'layout': 'vertical'," &
                    "            'spacing': 'sm'," &
                    "            'margin': 'lg'," &
                    "            'contents': [" &
                    "              {" &
                    "                'type': 'box'," &
                    "                'layout': 'baseline'," &
                    "                'spacing': 'sm'," &
                    "                'contents': [" &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': 'Brand'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#007BFF'," &
                    "                    'flex': 2," &
                    "                    'contents': []" &
                    "                  }," &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': 'Resmed'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#3D3C3CFF'," &
                    "                    'flex': 5," &
                    "                    'wrap': true," &
                    "                    'contents': []" &
                    "                  }" &
                    "                ]" &
                    "              }," &
                    "              {" &
                    "                'type': 'box'," &
                    "                'layout': 'baseline'," &
                    "                'spacing': 'sm'," &
                    "                'contents': [" &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': 'Warantee'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#007BFF'," &
                    "                    'flex': 2," &
                    "                    'contents': []" &
                    "                  }," &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': '1 year'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#3D3C3CFF'," &
                    "                    'flex': 5," &
                    "                    'wrap': true," &
                    "                    'contents': []" &
                    "                  }" &
                    "                ]" &
                    "              }" &
                    "            ]" &
                    "          }" &
                    "        ]" &
                    "      }," &
                    "      'footer': {" &
                    "        'type': 'box'," &
                    "        'layout': 'vertical'," &
                    "        'flex': 0," &
                    "        'spacing': 'sm'," &
                    "        'contents': [" &
                    "          {" &
                    "            'type': 'button'," &
                    "            'action': {" &
                    "              'type': 'uri'," &
                    "              'label': 'ซื้อสินค้า'," &
                    "              'uri': 'https://bit.ly/3CTApQW'" &
                    "            }," &
                    "            'color': '#D23E69E5'," &
                    "            'height': 'sm'," &
                    "            'style': 'primary'" &
                    "          }," &
                    "          {" &
                    "            'type': 'button'," &
                    "            'action': {" &
                    "              'type': 'uri'," &
                    "              'label': 'แชทกับเจ้าหน้าที่'," &
                    "              'uri': 'https://lin.ee/ZVh37ZU'" &
                    "            }," &
                    "            'color': '#1294A6FF'," &
                    "            'height': 'sm'," &
                    "            'style': 'primary'" &
                    "          }," &
                    "          {" &
                    "            'type': 'button'," &
                    "            'action': {" &
                    "              'type': 'uri'," &
                    "              'label': 'เบอร์โทรติดต่อ'," &
                    "              'uri': 'https://saintmed.dyndns.biz/line/img/smd.aspx?a=call'" &
                    "            }," &
                    "            'color': '#16707CFF'," &
                    "            'height': 'sm'," &
                    "            'style': 'primary'" &
                    "          }," &
                    "          {" &
                    "            'type': 'spacer'," &
                    "            'size': 'sm'" &
                    "          }" &
                    "        ]" &
                    "      }" &
                    "    }," &
                    "    {" &
                    "      'type': 'bubble'," &
                    "      'hero': {" &
                    "        'type': 'image'," &
                    "        'url': 'https://sale.saintmed.com/wp-content/uploads/2021/08/Airfit-N30i-01.jpg'," &
                    "        'size': 'full'," &
                    "        'aspectRatio': '1:1'," &
                    "        'aspectMode': 'cover'," &
                    "        'action': {" &
                    "          'type': 'uri'," &
                    "          'label': 'Line'," &
                    "          'uri': 'https://linecorp.com/'" &
                    "        }" &
                    "      }," &
                    "      'body': {" &
                    "        'type': 'box'," &
                    "        'layout': 'vertical'," &
                    "        'contents': [" &
                    "          {" &
                    "            'type': 'text'," &
                    "            'text': 'Airfit N30i'," &
                    "            'weight': 'bold'," &
                    "            'size': 'xl'," &
                    "            'color': '#007BFFFF'," &
                    "            'align': 'center'," &
                    "            'contents': []" &
                    "          }," &
                    "          {" &
                    "            'type': 'text'," &
                    "            'text': '7,000 บาท'," &
                    "            'weight': 'regular'," &
                    "            'size': 'md'," &
                    "            'flex': 0," &
                    "            'align': 'end'," &
                    "            'wrap': true," &
                    "            'contents': []" &
                    "          }," &
                    "          {" &
                    "            'type': 'box'," &
                    "            'layout': 'vertical'," &
                    "            'spacing': 'sm'," &
                    "            'margin': 'lg'," &
                    "            'contents': [" &
                    "              {" &
                    "                'type': 'box'," &
                    "                'layout': 'baseline'," &
                    "                'spacing': 'sm'," &
                    "                'contents': [" &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': 'Brand'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#007BFF'," &
                    "                    'flex': 2," &
                    "                    'contents': []" &
                    "                  }," &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': 'Resmed'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#3D3C3CFF'," &
                    "                    'flex': 5," &
                    "                    'wrap': true," &
                    "                    'contents': []" &
                    "                  }" &
                    "                ]" &
                    "              }," &
                    "              {" &
                    "                'type': 'box'," &
                    "                'layout': 'baseline'," &
                    "                'spacing': 'sm'," &
                    "                'contents': [" &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': 'Warantee'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#007BFF'," &
                    "                    'flex': 2," &
                    "                    'contents': []" &
                    "                  }," &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': '1 year'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#3D3C3CFF'," &
                    "                    'flex': 5," &
                    "                    'wrap': true," &
                    "                    'contents': []" &
                    "                  }" &
                    "                ]" &
                    "              }" &
                    "            ]" &
                    "          }" &
                    "        ]" &
                    "      }," &
                    "      'footer': {" &
                    "        'type': 'box'," &
                    "        'layout': 'vertical'," &
                    "        'flex': 0," &
                    "        'spacing': 'sm'," &
                    "        'contents': [" &
                    "          {" &
                    "            'type': 'button'," &
                    "            'action': {" &
                    "              'type': 'uri'," &
                    "              'label': 'ซื้อสินค้า'," &
                    "              'uri': 'https://bit.ly/3y20euk'" &
                    "            }," &
                    "            'color': '#D23E69E5'," &
                    "            'height': 'sm'," &
                    "            'style': 'primary'" &
                    "          }," &
                    "          {" &
                    "            'type': 'button'," &
                    "            'action': {" &
                    "              'type': 'uri'," &
                    "              'label': 'แชทกับเจ้าหน้าที่'," &
                    "              'uri': 'https://lin.ee/ZVh37ZU'" &
                    "            }," &
                    "            'color': '#1294A6FF'," &
                    "            'height': 'sm'," &
                    "            'style': 'primary'" &
                    "          }," &
                    "          {" &
                    "            'type': 'button'," &
                    "            'action': {" &
                    "              'type': 'uri'," &
                    "              'label': 'เบอร์โทรติดต่อ'," &
                    "              'uri': 'https://saintmed.dyndns.biz/line/img/smd.aspx?a=call'" &
                    "            }," &
                    "            'color': '#16707CFF'," &
                    "            'height': 'sm'," &
                    "            'style': 'primary'" &
                    "          }," &
                    "          {" &
                    "            'type': 'spacer'," &
                    "            'size': 'sm'" &
                    "          }" &
                    "        ]" &
                    "      }" &
                    "    }," &
                    "    {" &
                    "      'type': 'bubble'," &
                    "      'hero': {" &
                    "        'type': 'image'," &
                    "        'url': 'https://sale.saintmed.com/wp-content/uploads/2021/08/Pixi-01-600x434.jpg'," &
                    "        'size': 'full'," &
                    "        'aspectRatio': '1:1'," &
                    "        'aspectMode': 'cover'," &
                    "        'action': {" &
                    "          'type': 'uri'," &
                    "          'label': 'Line'," &
                    "          'uri': 'https://linecorp.com/'" &
                    "        }" &
                    "      }," &
                    "      'body': {" &
                    "        'type': 'box'," &
                    "        'layout': 'vertical'," &
                    "        'contents': [" &
                    "          {" &
                    "            'type': 'text'," &
                    "            'text': 'PIXI'," &
                    "            'weight': 'bold'," &
                    "            'size': 'xl'," &
                    "            'color': '#007BFFFF'," &
                    "            'align': 'center'," &
                    "            'contents': []" &
                    "          }," &
                    "          {" &
                    "            'type': 'text'," &
                    "            'text': '7,800 บาท'," &
                    "            'weight': 'regular'," &
                    "            'size': 'md'," &
                    "            'flex': 0," &
                    "            'align': 'end'," &
                    "            'wrap': true," &
                    "            'contents': []" &
                    "          }," &
                    "          {" &
                    "            'type': 'box'," &
                    "            'layout': 'vertical'," &
                    "            'spacing': 'sm'," &
                    "            'margin': 'lg'," &
                    "            'contents': [" &
                    "              {" &
                    "                'type': 'box'," &
                    "                'layout': 'baseline'," &
                    "                'spacing': 'sm'," &
                    "                'contents': [" &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': 'Brand'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#007BFF'," &
                    "                    'flex': 2," &
                    "                    'contents': []" &
                    "                  }," &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': 'Resmed'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#3D3C3CFF'," &
                    "                    'flex': 5," &
                    "                    'wrap': true," &
                    "                    'contents': []" &
                    "                  }" &
                    "                ]" &
                    "              }," &
                    "              {" &
                    "                'type': 'box'," &
                    "                'layout': 'baseline'," &
                    "                'spacing': 'sm'," &
                    "                'contents': [" &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': 'Warantee'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#007BFF'," &
                    "                    'flex': 2," &
                    "                    'contents': []" &
                    "                  }," &
                    "                  {" &
                    "                    'type': 'text'," &
                    "                    'text': '1 year'," &
                    "                    'size': 'sm'," &
                    "                    'color': '#3D3C3CFF'," &
                    "                    'flex': 5," &
                    "                    'wrap': true," &
                    "                    'contents': []" &
                    "                  }" &
                    "                ]" &
                    "              }" &
                    "            ]" &
                    "          }" &
                    "        ]" &
                    "      }," &
                    "      'footer': {" &
                    "        'type': 'box'," &
                    "        'layout': 'vertical'," &
                    "        'flex': 0," &
                    "        'spacing': 'sm'," &
                    "        'contents': [" &
                    "          {" &
                    "            'type': 'button'," &
                    "            'action': {" &
                    "              'type': 'uri'," &
                    "              'label': 'ซื้อสินค้า'," &
                    "              'uri': 'https://bit.ly/3miig9t'" &
                    "            }," &
                    "            'color': '#D23E69E5'," &
                    "            'height': 'sm'," &
                    "            'style': 'primary'" &
                    "          }," &
                    "          {" &
                    "            'type': 'button'," &
                    "            'action': {" &
                    "              'type': 'uri'," &
                    "              'label': 'แชทกับเจ้าหน้าที่'," &
                    "              'uri': 'https://lin.ee/ZVh37ZU'" &
                    "            }," &
                    "            'color': '#1294A6FF'," &
                    "            'height': 'sm'," &
                    "            'style': 'primary'" &
                    "          }," &
                    "          {" &
                    "            'type': 'button'," &
                    "            'action': {" &
                    "              'type': 'uri'," &
                    "              'label': 'เบอร์โทรติดต่อ'," &
                    "              'uri': 'https://saintmed.dyndns.biz/line/img/smd.aspx?a=call'" &
                    "            }," &
                    "            'color': '#16707CFF'," &
                    "            'height': 'sm'," &
                    "            'style': 'primary'" &
                    "          }," &
                    "          {" &
                    "            'type': 'spacer'," &
                    "            'size': 'sm'" &
                    "          }" &
                    "        ]" &
                    "      }" &
                    "    }" &
                    "  ]" &
                    "}" &
                    "} "
            '*************************************** /FLEX HERE


            MSGS &= "    ]" &
                            "}"
            MSGS = MSGS.Replace(vbCrLf, "")

            Return MSGS

        Catch ex As WebException
            'Console.WriteLine(ex.Message)
            Return ""
        Catch ex As Exception
            'Console.WriteLine(ex.Message)
            Return ""
        End Try
    End Function
#End Region

#Region "FLEX UI"

#End Region


End Class