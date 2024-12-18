function MM_swapImage() { //v3.0
	var i,j=0,x,a=MM_swapImage.arguments; 
	document.MM_sr=new Array;
	for(i=0;i<(a.length-2);i+=3){
		if ((x=MM_findObj(a[i]))!=null){
			document.MM_sr[j++]=x; 
			if(!x.oSrc) x.oSrc=x.src; 
			x.src=a[i+2];
		}
	}
}

function MM_swapImgRestore() { //v3.0
	var i,x,a=document.MM_sr; 
	for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++){ 
	x.src=x.oSrc;
	}
}
function startTrans(rg_img){
	if (document.images) {
		document.middle_view1.filters.blendTrans.Apply();
		document.middle_view1.src =rg_img;
		document.middle_view1.filters.blendTrans.play();
	}
}

function na_open_window(name, url, left, top, width, height, toolbar, menubar, statusbar, scrollbar, resizable)
{
  toolbar_str = toolbar ? 'yes' : 'no';
  menubar_str = menubar ? 'yes' : 'no';
  statusbar_str = statusbar ? 'yes' : 'no';
  scrollbar_str = scrollbar ? 'yes' : 'no';
  resizable_str = resizable ? 'yes' : 'no';
  var objPopup = window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);
	
	if (objPopup == null)
	{
		alert("차단된 팝업을 허용해 주십시요");
		return;
	}  
}

function getCookie( name ){
	var nameOfCookie = name + "=";
	var x = 0;
	while ( x <= document.cookie.length )
	{
		var y = (x+nameOfCookie.length);
		if ( document.cookie.substring( x, y ) == nameOfCookie ) {
			if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
			endOfCookie = document.cookie.length;
			return unescape( document.cookie.substring( y, endOfCookie ) );
		}
				
		x = document.cookie.indexOf( " ", x ) + 1;
				
		if ( x == 0 ) break;
	}
			return "";
}

function setCookie( name, value, expiredays ) { 
        var todayDate = new Date(); 
        todayDate.setDate( todayDate.getDate() + expiredays ); 
        document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
} 

function CookieOpenWin(cookies,theURL,winName,features) { 
	//쿠키네임을 받아 해당쿠키가 done이 아니면 팝업띄움
	if (getCookie(cookies) != "done") {
		window.open(theURL,winName,features);
	}
}	

function check_space(str) {
	//공백을 제거하고 입력 여부 체크
	if (str.search(/\S/)<0) {
		return false;
	}
	var temp=str.replace(' ','');
	if (temp.length == 0) {
		return false;
	}
	return true;
}

function AlpaNumber(string) {
	//알파벳이나 숫자가 아닌 문자가 포함되어 있으면 false 리턴
	valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	for (var i=0; i< string.length; i++) {
		if (valid.indexOf(string.charAt(i)) == -1) {
		return false;
		}
	}
	return true;
}

function NoNumber(string) {
	if (!f_chkNoNum(string)) {
		alert("숫자는 포함될 수 없습니다.");
		return false;
	}
	return true;
}

function f_chkNoNum(string) {
	//숫자가 포함되어 있으면 false 리턴
	valid = "0123456789";
	for (var i=0; i< string.length; i++) {
		if (valid.indexOf(string.charAt(i)) != -1) {
			return false;
		}
	}
	return true;
}

function OnlyNumber(string) {
	if (!f_chkOnlyNum(string)) {
		return false;
	}
	return true;
}

function f_chkOnlyNum(string) {
	//숫자 외의 문자가 포함되어 있으면 false 리턴
	valid = "0123456789";
	for (var i=0; i< string.length; i++) {
		if (valid.indexOf(string.charAt(i)) == -1) {
			return false;
		}
	}
	return true;
}

function f_chkSpecialChar(string) {
	// 특수문자 ' 가 포함되어 있으면 false 리턴
	valid = "'";
	for (var i=0; i< string.length; i++) {
		if (valid.indexOf(string.charAt(i)) != -1) {
			return false;
		}
	}
	return true;
}

function f_chkALlSpecialChar(string) {
	// 다수의 특수문자가 포함되어 있으면 false 리턴
	valid = "~`!@#$%^&*'";
	for (var i=0; i< string.length; i++) {
		if (valid.indexOf(string.charAt(i)) != -1) {
			return false;
		}
	}
	return true;
}


function Calbyte(aquery) {
	//바이트 수 계산
	//aquery - 계산할 스트링
	var tmpStr;
	var temp=0;
	var onechar;
	var tcount;
	tcount = 0;
			 
	tmpStr = new String(aquery);
	temp = tmpStr.length;

	for (k=0;k<temp;k++) {
		onechar = tmpStr.charAt(k);
		onechar_1 = escape(onechar); // ISO -> ASCII
		if ( onechar_1.charAt(0) == "%" ) {
			onechar_1 = onechar_1.substring(1,2);
			switch ( onechar_1 ) {
			case "0":
			case "1":
			case "2":
			case "3":
			case "4":
			case "5":
			case "6":
			case "7":
				tcount++;
				break;
			default:
				tcount += 2;
				break;
			}
		}
		else if (onechar!='\r') { //Enter외
			tcount++;
		}
	}
	return tcount;
}

function f_TogShowHide(LayerName) {
	//레이어 show, hide
	var DisplayVal = document.getElementById(LayerName).style.display;
	if(DisplayVal=='none') {
		document.getElementById(LayerName).style.display = 'block';
	} else {
		document.getElementById(LayerName).style.display = 'none';
	}
}

function f_TogShow(LayerName) {
	//레이어 show
	document.getElementById(LayerName).style.display = 'block';
}

function f_TogHide(LayerName) {
	//레이어 hide
	document.getElementById(LayerName).style.display = 'none';
}

function Move_Cur(arg,nextname,len) {
	//alert(arg);
	//alert(nextname);
	//alert(len);
	// 자동 Focus 이동
  if (arg.length == len) {
      nextname.focus() ;
      return;
   }
}

function JuminCheck(jumin1, jumin2){
	//주민번호 체크 
		var str_jumin1 = jumin1;
  		var str_jumin2 = jumin2;
		var check = false;

		  var i2=0
		  for (var i=0;i< str_jumin1.length;i++)
		  {
		      var ch1 = str_jumin1.substring(i,i+1);
		      if (ch1<"0" || ch1>"9") { i2=i2+1 }
		  }
		  if ((str_jumin1 == "") || ( i2 != 0 ))
		  {
		   return check;
		  }
		
		  var i3=0
		  for (var i=0;i<str_jumin2.length;i++)
		  {
		      var ch1 = str_jumin2.substring(i,i+1);
		      if (ch1<"0" || ch1>"9") { i3=i3+1 }
		  }
		  if ((str_jumin2 == "") || ( i3 != 0 ))
		  {
		  	return check;
		  }
		
		  var f1=str_jumin1.substring(0,1)
		  var f2=str_jumin1.substring(1,2)
		  var f3=str_jumin1.substring(2,3)
		  var f4=str_jumin1.substring(3,4)
		  var f5=str_jumin1.substring(4,5)
		  var f6=str_jumin1.substring(5,6)
		  var hap=f1*2+f2*3+f3*4+f4*5+f5*6+f6*7
		  var l1=str_jumin2.substring(0,1)
		  var l2=str_jumin2.substring(1,2)
		  var l3=str_jumin2.substring(2,3)
		  var l4=str_jumin2.substring(3,4)
		  var l5=str_jumin2.substring(4,5)
		  var l6=str_jumin2.substring(5,6)
		  var l7=str_jumin2.substring(6,7)
		  hap=hap+l1*8+l2*9+l3*2+l4*3+l5*4+l6*5
		  hap=hap%11
		  hap=11-hap
		  hap=hap%10
		  if (hap != l7){
		    return check;
		  }
		return true;
}


function Menu_chg(vID, vToColor)
{
	document.getElementById(vID).style.backgroundColor = vToColor;
}

function Layer_show(vID, vMenuWidth)
{
	f_TogShow(vID);

	//해상도 달라짐에 따른 레이어 위치 셋팅
	var LeftPosPixel = 0;
	var LeftPixel = 0;
	
	LeftPixel = (document.body.clientWidth - 780)/2;
	
	if(LeftPixel > 0){
		LeftPosPixel = LeftPixel + vMenuWidth;
	}
	else{
		LeftPosPixel = vMenuWidth;
	}	
	
	document.getElementById(vID).style.left = LeftPosPixel;
}


/*
===============================================================================
*  i.e patch
===============================================================================
*/


// flashWrite(파일경로, 가로, 세로, 아이디, 배경색, 변수, 윈도우모드) 
function flashWrite(url,w,h,id,bg,vars,win){ 

 // 플래시 코드 정의 
 var flashStr= 
 "<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='"+w+"' height='"+h+"' id='"+id+"' align='middle'>"+ 
 "<param name='allowScriptAccess' value='always' />"+ 
 "<param name='movie' value='"+url+"' />"+ 
 "<param name='FlashVars' value='"+vars+"' />"+ 
 "<param name='wmode' value='"+win+"' />"+ 
 "<param name='menu' value='false' />"+ 
 "<param name='quality' value='high' />"+ 
 "<param name='bgcolor' value='"+bg+"' />"+ 
 "<embed src='"+url+"' FlashVars='"+vars+"' wmode='"+win+"' menu='false' quality='high' bgcolor='"+bg+"' width='"+w+"' height='"+h+"' name='"+id+"' align='middle' allowScriptAccess='always' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />"+ 
 "</object>"; 

 // 플래시 코드 출력 
 document.write(flashStr); 

} 
//동영상 
function aviPlay(src,w,h) { 
document.write('<embed src="'+src+'" width='+w+' height='+h+'>') 
} 


// flashWrite(파일경로, 가로, 세로, 아이디, 배경색, 변수, 윈도우모드) 
function flashWrite(url,w,h,id,bg,vars,win){ 

 // 플래시 코드 정의 
 var flashStr= 
 "<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='"+w+"' height='"+h+"' id='"+id+"' align='middle'>"+ 
 "<param name='allowScriptAccess' value='always' />"+ 
 "<param name='movie' value='"+url+"' />"+ 
 "<param name='FlashVars' value='"+vars+"' />"+ 
 "<param name='wmode' value='"+win+"' />"+ 
 "<param name='menu' value='false' />"+ 
 "<param name='quality' value='high' />"+ 
 "<param name='bgcolor' value='"+bg+"' />"+ 
 "<embed src='"+url+"' FlashVars='"+vars+"' wmode='"+win+"' menu='false' quality='high' bgcolor='"+bg+"' width='"+w+"' height='"+h+"' name='"+id+"' align='middle' allowScriptAccess='always' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />"+ 
 "</object>"; 

 // 플래시 코드 출력 
 document.write(flashStr); 

} 
//동영상 
function aviPlay(src,w,h) { 
document.write('<embed src="'+src+'" width='+w+' height='+h+'>') 
} 