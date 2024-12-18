

	function inserFlash(path, id, width, height, wmode, bgcolor, scale, quality, flashvars){
			
	 	var params = {};
	  params.width = width;
	  params.height = height;
	  params.bgcolor = bgcolor?bgcolor:"#FFFFFF";
	  params.quality = quality?quality:"high"; 	// low | medium | high | autolow | autohigh | best
	  params.scale = scale?scale:"noscale";			// noscale | showall | noborder | exactfit
	  params.wmode = wmode?wmode:"window";			// window | opaque | transparent | direct | gpu 
	  params.allowScriptAccess = "always";
	  params.flashvars = flashvars;
		
		var tag = "";
		if (navigator.userAgent.toUpperCase().indexOf("MSIE") != -1){
			tag += "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'";
			tag += "	codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0'";
			tag += "	id='"+ id +"' width='"+ width +"' height='"+ height +"'>";
			tag += "	<param name='movie' value='"+ path +"'/>";		
			for(var n in params)
				tag += "  <param name='"+ n +"' value='"+ params[n] +"'/>";
			tag += "</object>";
		}else{
			tag += "<embed src='" + path + "'";
			tag += "  name='"+ id +"'";
			tag += "  type='application/x-shockwave-flash'";
			tag += "  pluginspage='http://www.macromedia.com/go/getflashplayer'"; 
			for(var n in params)
				tag += "  "+ n +"='"+ params[n] +"'";
      tag += "/>"; 
		}
		document.write(tag);
	}
	


function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function MM_showHideLayers() { //v3.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
    obj.visibility=v; }
}

/*
function bluring(){

    if(event.srcElement != null) {
        if(event.srcElement.tagName=="A" || event.srcElement.tagName=="IMG") document.body.focus();
    }
} 
*/

//document.onfocusin = bluring;

/*
function lateOnload(){
	
	alert("ddddd");
}


if (window.addEventListener){
	alert('FOX')
	window.addEventListener("load", lateOnload, false);
}else if (window.attachEvent){
	alert('IE')
    window.attachEvent("onload", lateOnload); 
}else{
	alert('ELSE')
	lateOnload();
window.onload=lateOnload;
}
*/






//function window::onload() {
	
	//alert("ggggg");

	/*
     toHTTPS();    //http:// --> http:// �̵�

    //Determine browser, we only need this for Internet Explorer 
    if (navigator.appName == "Microsoft Internet Explorer") {

        //Array of elements to be replaced
        var arrElements = new Array(3);
        arrElements[0] = "object";
        arrElements[1] = "embed";
        arrElements[2] = "applet";


        //Loop over element types
        for (n = 0; n < arrElements.length; n++) {

            //set object for brevity
            replaceObj = document.getElementsByTagName(arrElements[n]);

            //loop over element objects returned
            for (i = 0; i < replaceObj.length; i++ ) {

                //set parent object for brevity
                parentObj = replaceObj[i].parentNode;

                //grab the html inside of the element before removing it from the DOM
                newHTML = parentObj.innerHTML;

                //remove element from the DOM
                parentObj.removeChild(replaceObj[i]);

                //stick the element right back in, but as a new object
                parentObj.innerHTML = newHTML;

               // alert(newHTML);

                }
            }
        }
*/
   //}



function setInnerTextProperty() {
    if(typeof HTMLElement != "undefined" && typeof HTMLElement.prototype.__defineGetter__ != "undefined") {
        HTMLElement.prototype.__defineGetter__("innerText",function() {
            if(this.textContent) {
                return(this.textContent)
            } 
            else {
                var r = this.ownerDocument.createRange();
                r.selectNodeContents(this);
                return r.toString();
            }
        });
        
        HTMLElement.prototype.__defineSetter__("innerText",function(sText) {
            this.innerHTML = sText
        });
    }
}
/* 글 목록 화면 function */
function fn_GoLink(strUrl, cate_cd) {

	document.forms[0].target= "_self";
    document.forms[0].CATE_CD.value = cate_cd;   
    if(typeof(document.forms[0].pageIndex) != "undefined")
        document.forms[0].pageIndex.value = "1";        
   	document.forms[0].action = strUrl;
   	document.forms[0].submit();	    
}


/* 글 목록 화면 function */
function fn_GoWowLink(strUrl, cate_cd, page_id) {

	document.forms[0].target= "_self";
    document.forms[0].CATE_CD.value = cate_cd;
    document.forms[0].PAGE_ID.value = page_id;
   	document.forms[0].action = strUrl;
   	document.forms[0].submit();	    
}


/* 글 목록 화면 function */
function goFlashSearch(strKey) {
    	
	if (Replace_Blank(strKey) == '') {
		alert("Input keyword.");
		return;
	}
		
    if(typeof(document.forms[0].SEARCH_TXT) == "undefined"){
	    var input1  = document.createElement("input");
	    input1.name  = "SEARCH_TXT";
	    input1.id  = "SEARCH_TXT";
	    input1.type  = "hidden";
	    input1.value = strKey;
	    document.forms[0].appendChild(input1);    	   
    }else{
    	document.forms[0].SEARCH_TXT.value = strKey;
    }
   
    document.forms[0].target= "_self";
   	document.forms[0].action = "/orms/search/how_search_result.do";
   	document.forms[0].submit();	    
}



function fn_Gologin() {
	
	document.forms[0].target= "_self";
   	document.forms[0].action = "/en/util/util_sign_in.do";   	   	
   	document.forms[0].submit();	 	
}

function fn_Gologout() {
	document.forms[0].target= "_self";
   	document.forms[0].action = "/en/util/util_sign_out.do";   	   	
   	document.forms[0].submit();	 	
}

function fn_Navi(nave_url, cate_cd){
	document.forms[0].target= "_self";
	document.forms[0].CATE_CD.value = cate_cd;
	document.forms[0].action = nave_url;	
	document.forms[0].submit();
}


function fn_LatestTop5_view(seq, cate_cd){
	document.forms[0].target= "_self";
	document.forms[0].SEQ.value = seq;
	document.forms[0].CATE_CD.value = cate_cd;
	//document.forms[0].action = "/en/now/now_view.do";
   	//document.forms[0].submit();
   	document.location.href = "/en/now/now_view.do?CATE_CD=" + cate_cd + "&SEQ=" + seq;
}

function fn_LatestKnowTop5_view(seq, cate_cd){
	document.forms[0].target= "_self";
	document.forms[0].SEQ.value = seq;
	document.forms[0].CATE_CD.value = cate_cd;
	//document.forms[0].action = "/en/know/know_view.do";
   	//document.forms[0].submit();
	document.location.href = "/en/know/know_view.do?CATE_CD=" + cate_cd + "&SEQ=" + seq;

}

function fn_LatestAllTop5_view(url){
	document.forms[0].target= "_self";
	document.location.href = "/en" + url;
}

function fn_PollView(seq, cate_cd){
	document.forms[0].target= "_self";
	document.forms[0].SEQ.value = seq;
	document.forms[0].CATE_CD.value = cate_cd;
	document.forms[0].action = "/en/show/show_poll_input.do";
   	document.forms[0].submit();
}


function setLocation(location){
	
	setCookie("location", location, 11111);
	//document.location.href = strurl;
	
}

function setLocationIdx(){
		
    if(getCookie("location") != "" && getCookie("location") != null)
    {    
	    var iCnt = document.forms[0].location.options.length;
	    for(i= 0; i < iCnt ; i++)
	    {
	        if(document.forms[0].location.options[i].value == getCookie("location"))
	            document.forms[0].location.selectedIndex = i;
	    }
	    	    	    
    }
}


function sendMailWow(cate_cd){
	   	   
	   var strurl = "/en/wow/popup/sendmail_pop.do?CATE_CD=" + cate_cd;
	   Open_Window(strurl,500,340);
}

function CopyToClipWow(strDomain, strUrl, strCate_cd) {
	
	var txt_scrap = strDomain + strUrl + "?CATE_CD=" + strCate_cd;  
    var bname = navigator.appName;

    if(bname != "Microsoft Internet Explorer")
    {		    			                      
	    alert("Microsoft Internet Explorer Only");
	    return false;
    }

    var bSuccess; 

    bSuccess = window.clipboardData.setData('Text', txt_scrap);
    //alert(bSuccess);

    if(!bSuccess)
    {		    			                      
	    alert("Clipboard Enabled False");
	    return false;
    }else{
	    alert("Success");
	    return false;
    }				
}


function getCookie(name) {
    var arg = name + "=";
    var alen = arg.length;
    var clen = document.cookie.length;
    var i = 0;
    while(i < clen) {
        var j = i + alen;
        if(document.cookie.substring(i, j) == arg) {
            var end = document.cookie.indexOf(";", j);
            if(end == -1) end = document.cookie.length;
            return unescape(document.cookie.substring(j, end));
        }
        i = document.cookie.indexOf(" ", i) + 1;
        if(i == 0) break;
    }
    return null;
}

function setCookie(name, value, expiredays )
{
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function getByteLen(str){

	return(str.length+(escape(str)+"%u").match(/%u/g).length-1);
}

function Replace_Blank(OrgStr) {

    var str = OrgStr.replace(/\ /gi,"");    //
    return str;
}

function Replace_All(OrgStr, FindStr, NewStr) {

  //\n --> \\n : \r --> \\r �Է�  
  
  var str = OrgStr.replace(eval("/" + FindStr + "/gi"), NewStr);
  return str;
}

function checkID(input) {

	var chars = "abcdefghijklmnopqrstuvwxyz0123456789";

	if(!containsCharsOnly(input, chars)){
		alert("invalid.");
		input.value = "";
		input.focus();
		return false;
	}
}

function checkPW(input) {
    var bFlag = false;

	bFlag = containsCharsOnly(input, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");
    
	if(Replace_Blank(input.value) ==  "") return false;

	if(!bFlag){
	    if(containsCharsOnly(input, "0123456789")){
		    alert("invalid.");
			input.value = "";
			input.focus();
			return false;      
        }
	}else{         
        alert("invalid.");
     	input.value = "";
		input.focus();
		return false; 
    }

}

function checkPW2(input) {
	var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

	if(!containsCharsOnly(input, chars)){
		alert("invalid.");
		input.value = "";
		input.focus();
		return false;
	}
}

function checkMailA(input) {

	var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.";

	if(!containsCharsOnly(input, chars)){
		alert("invalid.");
		input.value = "";
		input.focus();
		return false;
	}
}


function checkMailB(input) {

	var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.";

	if(!containsCharsOnly(input, chars)){
		alert("invalid.");
		input.value = "";
		input.focus();
		return false;
	}
}


function onlyNum(input){
    var chars = "0123456789";

    input.style.imeMode = "disabled";

    if(!containsCharsOnly(input, chars)){
		alert("Only Number");
		input.value = "";  // input.value.substring(0, input.value.length -1);
		input.focus();
		return false;
	}
}


function containsCharsOnly(input, chars) {
	for (var inx = 0; inx < input.value.length; inx++) {
		if (chars.indexOf(input.value.charAt(inx)) == -1)
			return false;
	}
	return true;
}


function valText(obj){

   var strValue = obj.value.replace(/[, ]/gi,"");
   var iMax = obj.maxLength;

   var limit = getByteLen(strValue);
   if(limit > iMax)
   {
		alert('�Է� ������ �ʰ� �Ͽ����ϴ�. \n' + '���� �� ����/��ȣ�� ' + iMax + '���� ' + '�ѱ��� ' + (iMax / 2) + '���� ���� �Է� �����մϴ�.' );
		obj.focus();
   }
}

function Open_Window(sUrl,sWidth,sHeight)
{
   var screenPosX = screen.availWidth/2 - sWidth / 2;
   var screenPosY = screen.availHeight/2 - sHeight / 2;
   var features = "'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, top="+screenPosY+", left="+screenPosX+", width=" + sWidth + ", height=" + sHeight + "'";

   window.open(sUrl , null, features);

}

function Open_Scroll_Window(sUrl,sWidth,sHeight)
{
   var screenPosX = screen.availWidth/2 - sWidth / 2;
   var screenPosY = screen.availHeight/2 - sHeight / 2;
   var features = "'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no, top="+screenPosY+", left="+screenPosX+", width=" + sWidth + ", height=" + sHeight + "'";

   window.open(sUrl , null, features);

}

function Open_Img_Window(src){

    var screenPosX = (screen.availWidth/2) - 1;
    var screenPosY = (screen.availHeight/2) - 1;
    window.open('/popup/ImageView.jsp?URL='+src+'&Init=yes','','scrollbars=no,status=no,toolbar=no,resizable=0,location=no,menu=no,width=2,height=2,'+'top='+screenPosY+',left='+screenPosX);

}

function Open_Full_Window(sUrl)
{

   var sWidth = screen.availWidth;
   var sHeight = screen.availHeight;
   var screenPosX = 0;
   var screenPosY = 0;

   var features = "'channel=1, hotkeys=1, titlebar=1, toolbar=1, location=1, directories=1, status=1, menubar=1, scrollbars=1, resizable=1, top="+screenPosY+", left="+screenPosX+", width=" + sWidth + ", height=" + sHeight + "'";

   window.open(sUrl , '', features);

}

function Modal_Window(sUrl,sParam, sFeature)
{
	try
	{
		var strReturn = "";
		var strFearture_TMP = "";
		if(sFeature != null)
		{
			//var strNewFearture = ModifyDialogFeature(sFeature);
			strReturn = window.showModalDialog(sUrl, sParam, sFeature);	//encodeURI(sUrl), window, "dialogWidth:670px; dialogHeight:555px;status:no;scroll:no;help:no"
		}
		else
			strReturn = window.showModalDialog(sUrl, null, sParam);

		return strReturn;
	}
	catch(exception){}
}


function movetip()
{
	
	leftx = window.event.screenX;
	topy  = window.event.screenY;
}
var leftx = null;
var topy  = null;
document.onmouseup=movetip;

function Calendar(obj)
{

	var sUrl = "/popup/calendar.jsp?cDate=" + obj.value;
	var returnValue = Modal_Window(encodeURI(sUrl), window, "dialogWidth:200px;dialogHeight:215px;status:no;scroll:no;help:no;dialogLeft:" + leftx + ";dialogTop:" + topy + ";");

	if(typeof(returnValue) != "undefined" && returnValue != "undefined")
	{
	    obj.value = returnValue
	}
}

function moveObj(currObj, nextObj)
{
    if(currObj.value.length == currObj.maxLength){
	    nextObj.focus();
	}
}

function setYYMM(strObjNm)
{
	document.all[strObjNm].value = document.all[strObjNm + "YYYY"].value + "-" + document.all[strObjNm + "MM"].value;
}

function GetUtf8String(strValue) {

    var ch = strValue;
    var retValue = "";

    var ChrLen = ch.length;
    var TotalValue = "";
    var Cho  = "";
    var Jung = "";
    var jong = "";
    for(i=0; i < ChrLen ; i++){
        var OneStr = ch.substring(i,i+1);
        var regExp1 = /[^-a-zA-Z0-9]/;
        if (regExp1.test(OneStr)){  // 
            var n_ch = OneStr.charCodeAt();
            var ch_T = (n_ch - 0xAC00) % 28;
            var ch_V = Math.floor((n_ch - 0xAC00) / 28) % 21;
            var ch_L = Math.floor(Math.floor((n_ch - 0xAC00) / 28) / 21);
            Cho = String.fromCharCode(ch_L + 0x1100);
            Jung = String.fromCharCode(ch_V + 0x1100 + 0x61);
            jong = String.fromCharCode(ch_T + 0x1100 + 0xA7);
            TotalValue = TotalValue + Cho + Jung + jong;
        }else{
            TotalValue = TotalValue + OneStr;
        }
    }
    return retValue = TotalValue.replace(" ","");
}



function calcDate(objFrom, objTo, date)
{
	var strDate1 = objFrom.value;
	var strDate2 = objTo.value;
	var ArrDate1 = strDate1.split("-");
	var ArrDate2 = strDate2.split("-");

	var date1 = new Date(ArrDate1[0], ArrDate1[1], ArrDate1[2]);
	var date2 = new Date(ArrDate2[0], ArrDate2[1], ArrDate2[2]);

	var newdate=(date2-date1)/(24*60*60*1000);

	if(newdate > date)
		return false
	else
		return true;
}

function switchDomain(){
	
	if(window.location['href'].split("/")[2].toLowerCase() != "www.koreabrand.net" ){
		if(window.location['href'].split("/")[2].toLowerCase() == "localhost" || window.location['href'].split("/")[2].substring(0, 10) == "172.25.160"){
			return window.location['href'].split("/")[2].toLowerCase();			
		}else{
			
			return "www.koreabrand.net";
		}
	}
	
	
}


function switchDomainFull(){
	
	//if(window.location['href'].split("/")[2].toLowerCase() != "www.koreabrand.net" ){
	 
	if(window.location['href'].split("/")[2].toLowerCase() == "localhost" || window.location['href'].split("/")[2].substring(0, 10) == "172.25.160" ){

		   var sPRTC = window.location['protocol'];
		   var sHREF = window.location['href'];
		   
		   //sHREF.substring()
		   tem = sHREF.substring(sPRTC.length, sHREF.length);
		   
		   alert(tem);
		   alert(window.location['href'].split("/")[2]);
		   alert(window.location['href'].split("/")[2].length + 2); //length + 2(//)
		   alert(tem.substring(window.location['href'].split("/")[2].length + 2, tem.length));
		   alert(sPRTC + "//www.olympus-rms.com" + tem.substring(window.location['href'].split("/")[2].length + 2, tem.length));
		   
		   
		
	}else{
		   
		   var sPRTC = window.location['protocol'];
		   var sHREF = window.location['href'];
		   
		   //sHREF.substring()
		   tem = sHREF.substring(sPRTC.length, sHREF.length);
		   
		   alert(tem);
		   alert(window.location['href'].split("/")[2]);
		   alert(window.location['href'].split("/")[2].length + 2); //length + 2(//)
		   alert(tem.substring(window.location['href'].split("/")[2].length + 2, tem.length));
		   alert(sPRTC + "//www.olympus-rms.com" + tem.substring(window.location['href'].split("/")[2].length + 2, tem.length));
		
	}
		
		
}
	
function toHTTPS() 
{
    //http: --> https: 
   if(typeof(document.all["https"]) == "undefined")   
   {
	   if(window.location['href'].split("/")[2].toLowerCase() == "www.korealove.org" || window.location['href'].split("/")[2] == "125.60.31.52")
	  {
		   var sPRTC = window.location['protocol'];
		   var sHREF = window.location['href'];

		   if(sPRTC.toUpperCase() != 'HTTPS:') {
			   sHREF = 'https:' + sHREF.substring(sPRTC.length, sHREF.length); 
			   window.location.replace(sHREF);
		   }
      }
   }else{ //https: --> http: 
	   if(window.location['href'].split("/")[2].toLowerCase() == "www.korealove.org" || window.location['href'].split("/")[2] == "125.60.31.52")
	  {
		   var sPRTC = window.location['protocol'];
		   var sHREF = window.location['href'];

		   if(sPRTC.toUpperCase() != 'HTTP:') {
			   sHREF = 'http:' + sHREF.substring(sPRTC.length, sHREF.length); 
			   window.location.replace(sHREF);
		   }
      }
   }

}

function MailCheck(strEmailA, strEmailB)
{    	
	var ObjMail = strEmailA + "@" + strEmailB;
    
    if(strEmailA.substring(strEmailA.length -1, strEmailA.length) == ".") return false;
    
	if(strEmailB.substring(strEmailB.length -1, strEmailB.length) == ".") return false;

    if(strEmailA.indexOf(".") != -1)
    {   
		if (ObjMail.search(/(\S+)\.(\S+)@(\S+)\.(\S+)/) == -1 ) 
		{
			return false;    
		}
		return true; 
    }else{
		if (ObjMail.search(/(\S+)@(\S+)\.(\S+)/) == -1 ) 
		{
			return false;    
		}
		return true; 
    }	
}


function isLoginname(obj) {
    len = obj.value.length;
    ret = true;

    if (len < 4)
		return false;
    if(!(	(obj.value.charAt(0) >= "0" && obj.value.charAt(0) <= "9") 
			|| (obj.value.charAt(0) >= "a" && obj.value.charAt(0) <= "z") 
			||(obj.value.charAt(0) >= "A" && obj.value.charAt(0) <= "Z")
		)
	   )
		ret = false;		
    for (i = 1; i < len; i++) {
		if((obj.value.charAt(i) >= "0" && obj.value.charAt(i) <="9") ||
		   (obj.value.charAt(i) >= "a" && obj.value.charAt(i) <= "z") ||
		   (obj.value.charAt(i) >= "A" && obj.value.charAt(i) <= "Z"))
		    ;
		else 
		    ret = false;
    }
    return ret;
		   
}

function isVaildMail(email)
{
     var result = false;

     if( email.indexOf("@") != -1 )
     {
          result = true;

          if( email.indexOf(".") != -1 )
          {
               result = true;
          }
          else
          {
               result = false;
          }
     }
     return result;
}