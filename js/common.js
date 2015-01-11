
/*验证*/
$.minLength = function(value, length , isByte) {
  var strLength = $.trim(value).length;
  if(isByte)
    strLength = $.getStringLength(value);
    
  return strLength >= length;
};

$.maxLength = function(value, length , isByte) {
  var strLength = $.trim(value).length;
  if(isByte)
    strLength = $.getStringLength(value);
  
  return strLength <= length;
};
$.getStringLength=function(str)
{
  str = $.trim(str);
  
  if(str=="")
    return 0; 
    
  var length=0; 
  for(var i=0;i <str.length;i++) 
  { 
    if(str.charCodeAt(i)>255)
      length+=2; 
    else
      length++; 
  }
  
  return length;
}

$.checkMobilePhone = function(value){
  if($.trim(value)!='')
    return /^(13\d{9}|14\d{9}|18\d{9}|15\d{9})|(0\d{9}|9\d{8})$/i.test($.trim(value));
  else
    return true;
}

$.checkEmail = function(val){
  var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/; 
  return reg.test(val);
};

$.isInt = function(val){
  if(val == "")
    return false;
  else
    return /^\d*$/.test(val);
}

$.isFloat = function(val){
  if(val == "")
    return false;
  else
    return (/^\d*\.\d+$/.test(val) || /^\d*$/.test(val));
}


$.isNumber = function(val){
  return $.isInt(val) || $.isFloat(val);
}


//去掉字符串头尾空格   
$.trim = function(str) {
  return str.replace(/(^\s*)|(\s*$)/g, "");
}

/**  
 * 身份证15位编码规则：dddddd yymmdd xx p   
 * dddddd：地区码   
 * yymmdd: 出生年月日   
 * xx: 顺序类编码，无法确定   
 * p: 性别，奇数为男，偶数为女  
 * <p />  
 * 身份证18位编码规则：dddddd yyyymmdd xxx y   
 * dddddd：地区码   
 * yyyymmdd: 出生年月日   
 * xxx:顺序类编码，无法确定，奇数为男，偶数为女   
 * y: 校验码，该位数值可通过前17位计算获得  
 * <p />  
 * 18位号码加权因子为(从右到左) Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2,1 ]  
 * 验证位 Y = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ]   
 * 校验位计算公式：Y_P = mod( ∑(Ai×Wi),11 )   
 * i为身份证号码从右往左数的 2...18 位; Y_P为脚丫校验码所在校验码数组位置  
 *   
 */  
  
var Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 ];// 加权因子   
var ValideCode = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ];// 身份证验证位值.10代表X   


$.IdCardValidate = function(idCard) {
    idCard = $.trim(idCard.replace(/ /g, ""));
    if (idCard.length == 15) {
        return $.isValidityBrithBy15IdCard(idCard);
    } else if (idCard.length == 18) {
        var a_idCard = idCard.split("");// 得到身份证数组
        if($.isValidityBrithBy18IdCard(idCard)&&$.isTrueValidateCodeBy18IdCard(a_idCard)){
            return true;
        }else {
            return false;
        }
    } else {
        return false;
    }
}
/**  
 * 判断身份证号码为18位时最后的验证位是否正确  
 * @param a_idCard 身份证号码数组  
 * @return  
 */  
$.isTrueValidateCodeBy18IdCard=function(a_idCard) {   
    var sum = 0; // 声明加权求和变量   
    if (a_idCard[17].toLowerCase() == 'x') {   
        a_idCard[17] = 10;// 将最后位为x的验证码替换为10方便后续操作   
    }   
    for ( var i = 0; i < 17; i++) {   
        sum += Wi[i] * a_idCard[i];// 加权求和   
    }   
    valCodePosition = sum % 11;// 得到验证码所位置   
    if (a_idCard[17] == ValideCode[valCodePosition]) {   
        return true;   
    } else {   
        return false;   
    }   
}

/**  
 * 验证15位数身份证号码中的生日是否是有效生日  
 * @param idCard15 15位书身份证字符串  
 * @return  
 */  
$.isValidityBrithBy15IdCard = function (idCard15){   
    var year =  idCard15.substring(6,8);   
    var month = idCard15.substring(8,10);   
    var day = idCard15.substring(10,12);   
    var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
    // 对于老身份证中的你年龄则不需考虑千年虫问题而使用getYear()方法   
    if(temp_date.getYear()!=parseFloat(year)   
      ||temp_date.getMonth()!=parseFloat(month)-1   
      ||temp_date.getDate()!=parseFloat(day)){   
        return false;   
      }else{   
        return true;   
      }   
}

/**  
  * 验证18位数身份证号码中的生日是否是有效生日  
  * @param idCard 18位书身份证字符串  
  * @return  
  */  
$.isValidityBrithBy18IdCard = function(idCard18){
    var year =  idCard18.substring(6,10);
    var month = idCard18.substring(10,12);
    var day = idCard18.substring(12,14);
    var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));
    // 这里用getFullYear()获取年份，避免千年虫问题
    if(temp_date.getFullYear()!=parseFloat(year)
          ||temp_date.getMonth()!=parseFloat(month)-1
          ||temp_date.getDate()!=parseFloat(day)){
            return false;
    }else{
        return true;
    }
}



function formSuccess(obj,msg)
{
  if(msg!='')
  {
    $(obj).parent().find(".f-input-tip").html("<span class='form_success'>"+msg+"</span>");
    $(obj).parent().find(".f-input-tip").css("display","block");
  }
  else
  {
    $(obj).parent().find(".f-input-tip").html("");
    $(obj).parent().find(".f-input-tip").css("display","none");
  }

  $(obj).attr("error","");
}
function formError(obj,msg)
{
  $(obj).parent().find(".f-input-tip").html("<span class='form_err'>"+msg+"</span>");
  $(obj).parent().find(".f-input-tip").css("display","block");
  $(obj).attr("error","true");
}


function setInputValue(json,frmName)
{
  try
  {
    var oChildNode = document.getElementById(frmName).getElementsByTagName("*");
    for(var i=0;i<oChildNode.length;i++)
    {
      if(oChildNode[i].name == "__hash__")
        continue;

      if(json[oChildNode[i].name] == null)
        continue;

      if (oChildNode[i].tagName.toLowerCase() == "input" || oChildNode[i].tagName.toLowerCase() == "textarea")
      {
        var sType = oChildNode[i].type.toLowerCase();
        if(sType == "radio")
        {
          $("input[name='" + oChildNode[i].name + "'][value='"+json[oChildNode[i].name]+"']").attr("checked","checked");//
        }
        else if(sType == "checkbox")
        {
          // $("input[name='" + oChildNode[i].name + "']").attr("checked",false);//

          $("input[name='" + oChildNode[i].name + "'][value='"+json[oChildNode[i].name]+"']").attr("checked","checked");//
        }
        else if(sType != "button" && sType != "submit" && sType != "reset" && sType != "file")
        {
          oChildNode[i].value = formatChar2Nor(json[oChildNode[i].name]);
        }
      }

      if (oChildNode[i].tagName.toLowerCase() == "select")
      {
        var sValue = json[oChildNode[i].name];

        for(var k=0;k<oChildNode[i].options.length;k++)
        {
          if(oChildNode[i].options[k].value == sValue)
          {
            oChildNode[i].selectedIndex = k;
            break;
          }
        }
      }
    }
  }
  catch (e)
  {
    alert(e.description);
  }
}


function getWhere(frmName)
{
  var oChildNode = document.getElementById(frmName).getElementsByTagName("*");
  var sWhere = "";
  for(var i=0;i<oChildNode.length;i++)
  {
    var operation = oChildNode[i].getAttribute("operation");
    if(operation == "" || operation == null)
      operation = "=";

    var datatype = oChildNode[i].getAttribute("datatype");
    if(datatype == "" || datatype == null)
      datatype = "0";

    if(oChildNode[i].getAttribute("must") == "true")
    {
      if(oChildNode[i].tagName == "SELECT")
      {
        if(oChildNode[i].options[oChildNode[i].selectedIndex].value == "")
        {
          alert("no empty");
          oChildNode[i].focus();
          return false;
        }
      }
      if(oChildNode[i].value == "")
      {
        alert("no empty");
        oChildNode[i].focus();
        return false;
      }
    }
    
    if(oChildNode[i].getAttribute("ignore") == "true")
      continue;
    
    if (oChildNode[i].tagName.toLowerCase() == "input" || oChildNode[i].tagName.toLowerCase() == "textarea")
    {
      var sType = oChildNode[i].type.toLowerCase();
      if(sType != "button" && sType != "submit" && sType != "reset" && sType != "file" && oChildNode[i].name.toLowerCase() != "txtwhere")
      {
        if(oChildNode[i].value != "")
        {
          if(operation == "like")
            sWhere += oChildNode[i].name + " like '%" + formatSpChar(oChildNode[i].value) + "%' AND ";
          else if(datatype == "3")
            sWhere += " format("+oChildNode[i].name+",'yyyy-mm-dd')" + operation + "'" + formatSpChar(oChildNode[i].value) + "' AND ";
          else if(datatype == "4")
            sWhere += " format("+oChildNode[i].name+",'yyyy-mm-dd hh:m')" + operation + "'" + formatSpChar(oChildNode[i].value) + "' AND ";
          else
            sWhere += oChildNode[i].name + operation + "'" + formatSpChar(oChildNode[i].value) + "' AND ";
        }
      }
    }

    if (oChildNode[i].tagName.toLowerCase() == "select")
    {
      if(oChildNode[i].options[oChildNode[i].selectedIndex].value != "")
      {
        if(operation == "like")
          sWhere += oChildNode[i].name + " like '%" + formatSpChar(oChildNode[i].options[oChildNode[i].selectedIndex].value) + "% AND ";
        else
          sWhere += oChildNode[i].name + operation + "'" + formatSpChar(oChildNode[i].options[oChildNode[i].selectedIndex].value) + "' AND ";
      }
    }
  }

  sWhere = sWhere.substring(0,sWhere.length - 5);
  return sWhere;
}


function formatSpChar(val)
{
  return val;
}
function isInt(sValue)
{
    if(sValue == "")
      return false;
    else
      return /^\d*$/.test(sValue);
}

//+------------------------------------
// 是否是浮点数
//-------------------------------------
function isFloat(sValue)
{
    return (/^\d*\.\d+$/.test(sValue) || /^\d*$/.test(sValue));
}

//+------------------------------------
// 是否是数字
//-------------------------------------
function isNumber(sValue)
{
    return isInt(sValue) || isFloat(sValue);
}


function checkurl(str_url) { 
  var strRegex = "^((https|http|ftp|rtsp|mms)?://)"  
          + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" 
          + "(([0-9]{1,3}\.){3}[0-9]{1,3}" 
          + "|"  
          + "([0-9a-z_!~*'()-]+\.)*"   
          + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." 
          + "[a-z]{2,6})" 
          + "(:[0-9]{1,4})?"
          + "((/?)|" 
          + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";   
  var re = new RegExp(strRegex);   
  return re.test(str_url);   
}

function checkemail(str) {   
  var re = /^([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;   
  return re.test(str);   
}



function showHint(msg)
{
  var s = $("script").attr("src");
  var s1 = s.split("/js")[0];
  jQuery.facebox('<img src="'+s1+'/js/facebox/loading.gif">&nbsp;&nbsp;<font color="blue">' + msg + '</font>');
}

function hintMsg(msg)
{
  var s = $("script").attr("src");
  var s1 = s.split("/js")[0];
  $('#facebox .content').html('<img src="'+s1+'/js/facebox/refresh.gif">&nbsp;&nbsp;<font color="red">'+msg+'</font>');
}

function hideHint()
{
  $('#facebox').fadeOut(function() {
    $('#facebox .content').removeClass().addClass('content')
    $('#facebox .loading').remove()
    $(document).trigger('afterClose.facebox')
  })

  $('#facebox_overlay').fadeOut(200, function(){
    $("#facebox_overlay").removeClass("facebox_overlayBG")
    $("#facebox_overlay").addClass("facebox_hide")
    $("#facebox_overlay").remove();
  })
}

function setUrlTipBox(sID)
{
   // 提示层
  $("#" + sID).qtip(
  {
     content: {
        text:"加载中......",
        url:TIP_URL,
        data:TIP_DATA,
        method:"post",
        title: {
           text: TIP_TITLE,
           button: '关闭'
        }
     },
     position: {
       target: $(document.body), // Position it via the document body...
       corner: 'center' // ...at the center of the viewport
     },
     show: { 
        when: 'click', 
        solo: true // Only show one tooltip at a time
     },
     hide: false,
     style: {
        tip: true, // Apply a speech bubble tip to the tooltip at the designated tooltip corner
        border: {
           width: 9,
           radius: 4,
           color: '#666666'
        },
        name: 'light', // Use the default light style
        width: TIP_WIDTH // Set the tooltip width
     },
     api: {
       beforeShow: function()
       {
          $('#qtip-blanket').fadeIn(this.options.show.effect.length);
       },
       beforeHide: function()
       {
          $('#qtip-blanket').fadeOut(this.options.hide.effect.length);
       }
    }

  });

  // 遮罩层
  $('<div id="qtip-blanket">')
  .css({
     position: 'absolute',
     top: $(document).scrollTop(), 
     left: 0,
     height: $(document).height(), 
     width: '100%',

     opacity: 0.7,
     backgroundColor: 'black',
     zIndex: 5000  
  })
  .appendTo(document.body)
  .hide();
}


function showHint(msg)
{
  var s = $("script").attr("src");
  var s1 = s.split("/js")[0];
  jQuery.facebox('<img src="js/facebox/loading.gif">&nbsp;&nbsp;<font color="blue">' + msg + '</font>');
}

function hintMsg(msg)
{
  var s = $("script").attr("src");
  var s1 = s.split("/js")[0];
  $('#facebox .content').html('<img src="js/facebox/refresh.gif">&nbsp;&nbsp;<font color="red">'+msg+'</font>');
}

function hideHint()
{
  $('#facebox').fadeOut(function() {
    $('#facebox .content').removeClass().addClass('content')
    $('#facebox .loading').remove()
    $(document).trigger('afterClose.facebox')
  })

  $('#facebox_overlay').fadeOut(200, function(){
    $("#facebox_overlay").removeClass("facebox_overlayBG")
    $("#facebox_overlay").addClass("facebox_hide")
    $("#facebox_overlay").remove();
  })
}

function setUrlTipBoxD(jObj,TIP_URL,TIP_TITLE,TIP_WIDTH,TIP_DATA)
{
   // 提示层
  jObj.qtip(
  {
     content: {
        text:"加载中......",
        url:TIP_URL,
        data:TIP_DATA,
        method:"post",
        title: {
           text: TIP_TITLE,
           button: '关闭'
        }
     },
     position: {
       target: $(document.body), // Position it via the document body...
       corner: 'center' // ...at the center of the viewport
     },
     show: { 
        when: 'click', 
        solo: true // Only show one tooltip at a time
     },
     hide: false,
     style: {
        tip: true, // Apply a speech bubble tip to the tooltip at the designated tooltip corner
        border: {
           width: 9,
           radius: 4,
           color: '#666666'
        },
        name: 'light', // Use the default light style
        width: TIP_WIDTH // Set the tooltip width
     },
     api: {
       beforeShow: function()
       {
          $('#qtip-blanket').fadeIn(this.options.show.effect.length);
       },
       beforeHide: function()
       {
          $('#qtip-blanket').fadeOut(this.options.hide.effect.length);
          try{CloseTip();}catch(e){};
       }
    }

  });

  // 遮罩层
  $('<div id="qtip-blanket">')
  .css({
     position: 'absolute',
     top: $(document).scrollTop(), 
     left: 0,
     height: $(document).height(), 
     width: '100%',

     opacity: 0.7,
     backgroundColor: 'black',
     zIndex: 5000  
  })
  .appendTo(document.body)
  .hide();
}



function EncodeUtf8(s1)
{
  var s = escape(s1);
  var sa = s.split("%");
  var retV ="";
  if(sa[0] != "") retV = sa[0];
  for(var i = 1; i < sa.length; i ++)
  {
    if(sa[i].substring(0,1) == "u")
    {
      retV += Hex2Utf8(Str2Hex(sa[i].substring(1,5)));
    }
    else
    {
      retV += "%" + sa[i];
    }
  }
  return retV;
}



function Str2Hex(s)
{
  var c = "";
  var n;
  var ss = "0123456789ABCDEF";
  var digS = "";
  for(var i = 0; i < s.length; i ++)
  {
    c = s.charAt(i);
    n = ss.indexOf(c);
    digS += Dec2Dig(eval(n));
  }
  return digS;
}

//----------------------------------------------------------------------------
function Dec2Dig(n1)
{
  var s = "";
  var n2 = 0;
  for(var i = 0; i < 4; i++)
  {
    n2 = Math.pow(2,3 - i);
    if(n1 >= n2)
    {
      s += '1';
      n1 = n1 - n2;
    }
    else
    {
      s += '0';
    }
  }
  return s;
}

//----------------------------------------------------------------------------
function Dig2Dec(s)
{
  var retV = 0;
  if(s.length == 4)
  {
    for(var i = 0; i < 4; i ++)
    {
      retV += eval(s.charAt(i)) * Math.pow(2, 3 - i);
    }
    return retV;
  }
  return -1;
}

//----------------------------------------------------------------------------
function Hex2Utf8(s)
{
  var retS = "";
  var tempS = "";
  var ss = "";
  if(s.length == 16)
  {
    tempS = "1110" + s.substring(0, 4);
    tempS += "10" + s.substring(4, 10); 
    tempS += "10" + s.substring(10,16); 
    var sss = "0123456789ABCDEF";
    for(var i = 0; i < 3; i ++)
    {
      retS += "%";
      ss = tempS.substring(i * 8, (eval(i)+1)*8);
      retS += sss.charAt(Dig2Dec(ss.substring(0,4)));
      retS += sss.charAt(Dig2Dec(ss.substring(4,8)));
    }
  }
  return retS;
}


function formatMoney(x)
{
  var f = parseFloat(x);
  if (isNaN(f)) {
    return false;
  }
  var f = Math.round(x*100)/100;
  var s = f.toString();
  var rs = s.indexOf('.');
  if (rs < 0) {
    rs = s.length;
    s += '.';
  }
  while (s.length <= rs + 2) {
    s += '0';
  }
  return s;
}


function checkUserLogin()
{
  var logUserID = $("#loginUserTop").attr("userid");
  if(logUserID == "")
    return false;
  else
    return true;
}

function doLoginRef()
{
  location.href = g_web_url + "/index/user_login/refurl/" + EncodeUtf8(location.href.replace(/\//g, "|")) + "";
}


function PCAS(obj_1,obj_2,obj_3)
{
  var ar = ["请选择省份","请选择城市","请选择区县"];
  var pindex = 0;
  //初始化
  $("<option value=''>"+ar[0]+"</option>").appendTo($("#"+obj_1));
  $("<option value=''>"+ar[1]+"</option>").appendTo($("#"+obj_2));
  $("<option value=''>"+ar[2]+"</option>").appendTo($("#"+obj_3));
  
  initSelect("",obj_1);

  $("#"+obj_1).change(function(){
    pindex = $("#"+obj_1).get(0).selectedIndex;
    $("#"+obj_2).empty();

    $("<option value=''>"+ar[1]+"</option>").appendTo($("#"+obj_2));
    if (pindex!=0){
      initSelect($(this).val(),obj_2);
    }
    $("#"+obj_3).empty();
    $("<option value=''>"+ar[2]+"</option>").appendTo($("#"+obj_3));
  });


  $("#"+obj_2).change(function(){
    pindex = $(this).get(0).selectedIndex;
    $("#"+obj_3).empty();
    $("<option value=''>"+ar[2]+"</option>").appendTo($("#"+obj_3));
    if (pindex!=0){
      initSelect($(this).val(),obj_3);
    }
  });

}

function initSelect(code,objid)
{
  $.ajax({ 
    url: g_web_url + "/base/get_city/code/" + code, 
    data: "",
    type:"post",
    dataType: "json",
    success: function(obj){
      if(obj.data != null)
        for(var i=0;i<obj.data.length;i++)
        {
          if(obj.data[i].code == $("#"+objid).attr("code"))
          {
            $("<option value='"+obj.data[i].code+"' selected>"+obj.data[i].value+"</option>").appendTo($("#"+objid));
            $("#"+objid).change();
          }
          else
            $("#"+objid).append("<option value='"+obj.data[i].code+"'>"+obj.data[i].value+"</option>");  
        }
  }});
}


function formatChar2Nor(strIn)
{
  return strIn.replace(/\~_/g, "'").replace(/\~@/g, "\"");
}

function formatDate(sDate)
{
  var dateTmp=sDate.split("-");
  if(dateTmp.length == 1)
  {
    dateTmp=sDate.split("/");
  }

  if(dateTmp.length > 1)
  {
    return new Date(dateTmp[2],dateTmp[1],dateTmp[0]);
  }
  else
    return "";
}


function formatDate2Str(sDate)
{
  var dateTmp=sDate.split("-");
  if(dateTmp.length == 1)
  {
    dateTmp=sDate.split("/");
  }

  if(dateTmp.length > 1)
  {
    return dateTmp[2] + "-" + dateTmp[1] + "-" + dateTmp[0];
  }
  else
    return "";
}

function formatStr2EnDate(sDate)
{
  var dateTmp=sDate.split("-");
  if(dateTmp.length == 1)
  {
    dateTmp=sDate.split("/");
  }
  var mon = dateTmp[1];
  if(parseInt(mon) < 10)
    mon = "0" + mon;

  var day = dateTmp[2];
  if(parseInt(day) < 10)
    day = "0" + day;

  if(dateTmp.length > 1)
  {
    return day + "/" + mon + "/" + dateTmp[0];
  }
  else
    return "";
}

function checkTime(sTime)
{
  if(sTime == "")
    return false;

  if(sTime.length > 5 || sTime.length < 3)
    return false;

  var dateTmp=sTime.split(":");
  if(dateTmp.length == 1 || dateTmp.length > 2)
    return false;
  else if(parseInt(dateTmp[0]) > 23)
    return false;
  else if(parseInt(dateTmp[1]) > 60)
    return false;
  else
    return true;
}

/*
var dt1 = "2009-11-5 17:00"  
var dt2 = "2009-11-6 2:30"
var re=getHoursDiff(dt1,dt2);
var h=parseInt(re);
var m=parseInt((re-h)*60);
alert(h+":"+m);
*/
function getHoursDiff(dt1,dt2) {
  if(typeof(dt1)=="string") {
    dt1=new Date(dt1.replace(/-/,'/'));
    dt2=new Date(dt2.replace(/-/,'/'));
  }
  var res=dt2-dt1;
  if(isNaN(res))
    throw Error("invalid dates arguments");
  return res/(1000*60*60);
}

var g_time_in = ""; 
var g_time_out = "";
function getSignHours(sDay,timein,timeout)
{
  dt1=new Date((sDay + " " + timein).replace(/-/,'/'));
  dt2=new Date((sDay + " " + timeout).replace(/-/,'/'));
  
  var hours = getHoursDiff(dt1,dt2);

  if(hours <= 0) {
    var dt2 = new Date(dt2.getFullYear(),dt2.getMonth(),dt2.getDate()+1,dt2.getHours(),dt2.getMinutes());
    g_time_out = dt2.getFullYear() + "-" + (dt2.getMonth()+1) + "-" + dt2.getDate() + " " + dt2.getHours() + ":" + dt2.getMinutes()
    hours = getHoursDiff(dt1,dt2);
  }
  g_time_in = dt1.getFullYear() + "-" + (dt1.getMonth()+1) + "-" + dt1.getDate() + " " + dt1.getHours() + ":" + dt1.getMinutes()
  g_time_out = dt2.getFullYear() + "-" + (dt2.getMonth()+1) + "-" + dt2.getDate() + " " + dt2.getHours() + ":" + dt2.getMinutes()
  
  return formatMoney(hours);
}