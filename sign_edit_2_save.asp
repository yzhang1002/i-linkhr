<%@ Language=VBScript%>
<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->

<%
sID = Request("signid")

If Trim(Request("billingdate")) <> "" Then
  '// update
  sql = "update sign_base set signdate='" & formatSpString(Request("signdate")) & "',billingdate='" & formatSpString(Request("billingdate")) & "',joborder='" & formatSpString(Request("joborder")) & "',timein='" & formatSpString(Request("timein")) & "',timeout='" & formatSpString(Request("timeout")) & "',hotelname='" & formatSpString(Request("hotelname")) & "',hotelrate=" & formatSpString(Request("hotelrate")) & ",venuename='" & formatSpString(Request("venuename")) & "',attention='" & formatSpString(Request("attention")) & "',staffnum=" & formatSpString(Request("staffnum")) & ",chequeinfo='" & formatSpString(Request("chequeinfo")) & "' where signid=" & sID

Else
  '// update
  sql = "update sign_base set signdate='" & formatSpString(Request("signdate")) & "',billingdate=null,joborder='" & formatSpString(Request("joborder")) & "',timein='" & formatSpString(Request("timein")) & "',timeout='" & formatSpString(Request("timeout")) & "',hotelname='" & formatSpString(Request("hotelname")) & "',hotelrate=" & formatSpString(Request("hotelrate")) & ",venuename='" & formatSpString(Request("venuename")) & "',attention='" & formatSpString(Request("attention")) & "',staffnum=" & formatSpString(Request("staffnum")) & ",chequeinfo='" & formatSpString(Request("chequeinfo")) & "' where signid=" & sID
End If

Response.Write ExecQuery(sql)

'// delete
sql = "delete from sign_list where signid=" & sID
Response.Write ExecQuery(sql)

staffid = Split(Request("staffid"),",")
timein = Split(Request("row_timein"),",")
timeout = Split(Request("row_timeout"),",")
hours = Split(Request("hours"),",")
breakhours = Split(Request("break"),",")
staffrate = Split(Request("staffrate"),",")
hotelrate = Split(Request("staff_hotelrate"),",")
amount = Split(Request("amount"),",")

For i=LBound(staffid) To UBound(staffid)

  sql = "insert into sign_list(signid,staffid,timein,timeout,hours,break,staffrate,hotelrate,amount) values (" & sID & "," & staffid(i) & ",'" & formatSpString(timein(i)) & "','" & formatSpString(timeout(i)) & "'," & formatSpString(hours(i)) & "," & formatSpString(breakhours(i)) & "," & formatSpString(staffrate(i)) & "," & formatSpString(hotelrate(i)) & "," & amount(i) & ")"

  Response.Write ExecQuery(sql)

Next

%>