
<%

'##############################################################
'#
'#	Function: GetRecordSet
'#
'##############################################################
Function GetRecordSet(byval strSQL)
	' -- given a valid SQL statement, returns a recordset with values
	DSNtemp = ConnectionString
	
	const adUseClient = 3
	const adOpenForwardOnly = 0
	const adLockBatchOptimistic = 4
	
	' Create instance of connection object and then open the
	' connection.
	Dim objConn, objRS

	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.Open "provider=microsoft.jet.oledb.4.0;data source=" & server.MapPath("db/#$st_675Yit.mdb") 

	' Create instance of recordset object and open the
	' recordset object against a table.
	Set objRS = Server.CreateObject("ADODB.Recordset")

	' Setting the cursor location to client side is important
	' to get a disconnected recordset.
	objRS.CursorLocation = adUseClient
	
	objRS.Open strSQL, _
         objConn, _
         adOpenForwardOnly, _
         adLockBatchOptimistic

	' Disconnect the recordset.
	Set objRS.ActiveConnection = Nothing

	' -- Close the connection
	objConn.Close

	set objConn = Nothing
	
	' -- return the recordset
	Set GetRecordSet = objRS

End Function


Function ExecQuery(byval strSQL)
  On Error Resume Next
  ' -- given a valid Action SQL statement, execute it
  DSNtemp = ConnectionString

  ' Create instance of connection object and then open the
  ' connection.
  Dim objConn

  Set objConn = Server.CreateObject("ADODB.Connection")
  objConn.Open "provider=microsoft.jet.oledb.4.0;data source=" & server.MapPath("db/#$st_675Yit.mdb") 

  ' -- Execute the action query
  objConn.Execute strSQL

  ' -- Close the connection
  objConn.Close
  set objConn = Nothing
  If Err.Number = 0 Then
    ExecQuery = ""
  Else
    ExecQuery = Err.Description
  End If
End Function

Function Rs2Json(Rs)
  If Rs.Eof=False And Rs.Bof=False Then 
    returnStr="{"& chr(34) &"data"& chr(34) &":" 
    While Rs.Eof = False 

      ' ------- 
      oneRecord= "{" 
      for i=0 to Rs.Fields.Count -1 
        oneRecord=oneRecord & chr(34) &Rs.Fields(i).Name&chr(34)&":" 
        oneRecord=oneRecord & chr(34) &Rs.Fields(i).Value&chr(34) &"," 
      Next 

      oneRecord=left(oneRecord,InStrRev(oneRecord,",")-1) 
      oneRecord=oneRecord & "}," 
      '------------ 
      returnStr=returnStr & oneRecord 
      Rs.MoveNext 
    Wend

    returnStr=left(returnStr,InStrRev(returnStr,",")-1) 
    returnStr=returnStr & "}" 
  End If 
  Rs.close 
  set Rs=Nothing 
  Rs2Json=returnStr 

End Function

Function FormatQoutes(strIn)
  Dim strOut
  If Right(strIn,1) = "," Then
    strOut = Left(strIn,len(strIn)-1)
  ElseIf Left(strIn,1) = "," Then
    strOut = Right(strIn,len(strIn)-1)
  Else
    strOut = strIn
  End If
  FormatQoutes = strOut
End Function 




Public Function DatetoStr(dtmSourc)
    Dim str_Year, str_Month, str_Day
    If IsDate(dtmSourc) Then
        str_Year = CStr(Year(dtmSourc))
        If Len(str_Year) < 3 Then
            str_Year = "19" + str_Year
        End If
        str_Month = CStr(Month(dtmSourc))
        If Len(str_Month) < 2 Then
            str_Month = "0" + str_Month
        End If
        str_Day = CStr(Day(dtmSourc))
        If Len(str_Day) < 2 Then
            str_Day = "0" + str_Day
        End If
        DatetoStr = str_Year + str_Month + str_Day
    Else
        DatetoStr = dtmSourc
    End If
End Function

Sub Trace2Debug(msg)
  Set obj = Server.CreateObject("SchOcx.LocalSystem")
  ret = obj.DebugTrace(msg)
  Set obj = Nothing
End Sub


Function formatSpString(inString)
  Dim strXml
  If Not IsNull(inString) Then
    inString = Replace(inString,"'","~_")
    strXml = Replace(inString,"""","~@")
    formatSpString = strXml
  Else
    formatSpString = ""
  End If
End Function

Function formatSpChar2Nor(strIn)
  If Not IsNull(strIn) Then
    strIn = Replace(strIn,"~_","'")
    strIn = Replace(strIn,Chr(13),"<br>")
    strIn = Replace(strIn,Chr(10),"<br>")

    formatSpChar2Nor = Replace(strIn,"~@","""")

    
  Else
    formatSpChar2Nor = ""
  End If
End Function

Function formatMoney(fMoney)
  Dim m
  If instr(CStr(fMoney),".") = 0 Then
    m = CStr(fMoney) & ".00"
  Else
    m = CStr(fMoney) & "00"
  End If

  formatMoney = CStr(Left(CStr(m),instr(CStr(m),".")+2))
End Function

Function toShortString(s,l)

  If Len(s) > l Then
    toShortString = Left(s,l-3) & "..."
  Else
    toShortString = s
  End If
End Function


Function formatDate2Str(sDate)
  On Error Resume Next
  Dim sD
  Dim sM
  
  If CDate(sDate) Then
  End If
  sD = Day(sDate)
  If Len(sD) = 1 Then
    sD = "0" & sD
  End If

  sM = Month(sDate)
  If Len(sM) = 1 Then
    sM = "0" & sM
  End If

  If Err.Number = 0 Then
    formatDate2Str = sD & "/" & sM & "/" & Year(sDate)
  Else
    formatDate2Str = sDate
  End If
End Function


Sub echojson(status,msg)
  Response.Write "{'status':'" & status & "','info':'" & msg & "'}"
End Sub


Function formatDate2En(sDate)
  Dim da,sMon,sDay

  If IsNull(sDate) Or sDate = "" Then
    formatDate2En = ""
    Exit Function
  End If

  da = CDate(sDate)
  sMon = Month(da)
  If len(sMon) = 1 Then
    sMon = "0" & sMon
  End If
  sDay = Day(da)
  If len(sDay) = 1 Then
    sDay = "0" & sDay
  End If

  formatDate2En = sDay & "/" & sMon & "/" & Year(da)
End Function

Function formatDate2Time(sDateTime)
  Dim da,sHour,sMi
  da = CDate(sDateTime)
  sHour = Hour(da)
  If len(sHour) = 1 Then
    sHour = "0" & sHour
  End If

  sMi = Minute(da)
  If len(sMi) = 1 Then
    sMi = "0" & sMi
  End If

  formatDate2Time = sHour & ":" & sMi
End Function


Function enDate2Str(sDate)
  Dim s
  s = Split(sDate,"/")
  enDate2Str = s(2) & "-" & s(1) & "-" & s(0)
End Function

Function formatMoney(fMoney)
  On Error Resume Next
  Dim m
  If CDbl(fMoney) < 1 And Left(fMoney,1) = "." Then
    fMoney = "0" & fMoney
  End If
  If instr(CStr(fMoney),".") = 0 Then
    m = CStr(fMoney) & ".00"
  Else
    m = CStr(fMoney) & "00"
  End If
  If Err.Number = 0 Then
    formatMoney = CStr(Left(CStr(m),instr(CStr(m),".")+2))
  Else
    formatMoney = "0.00"
  End If
End Function
%>