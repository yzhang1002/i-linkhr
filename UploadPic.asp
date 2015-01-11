<HTML>
<HEAD>
<TITLE>upload file</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css/css.css" type="text/css" rel="stylesheet" />
<style type="text/css">
body, a, table, div, span, td, th, input, select{font:9pt;font-family: Verdana, Arial, Helvetica, sans-serif;}
body {padding:0px;margin:0px}
</style>
</head>
<body bgcolor=menu>
<form action="upFile.asp" method="post" name="myform" enctype="multipart/form-data">
<input type="file" name="uploadfile" class="f-input" style="width:325px;">
<input type="button" name="ub" value="Upload Photo" onclick="doUpload()" class="but" style="height:25px;">
</form>

<script language=javascript>

function doUpload()
{
  if(CheckUploadForm())
    document.myform.submit();
}
var sAllowExt = "GIF|JPG|JPEG|BMP";

function CheckUploadForm() {
  if (!IsExt(document.myform.uploadfile.value,sAllowExt)){
		parent.UploadError("Please select a valid Pic file to upload.");
		return false;
	}
	return true
}

function IsExt(url, opt){
  var sTemp;
  var b=false;
  var s=opt.toUpperCase().split("|");
  for (var i=0;i<s.length ;i++ ){
    sTemp=url.substr(url.length-s[i].length-1);
    sTemp=sTemp.toUpperCase();
    s[i]="."+s[i];
    if (s[i]==sTemp){
      b=true;
      break;
    }
  }
  return b;
}

</script>

</body>
</html>

