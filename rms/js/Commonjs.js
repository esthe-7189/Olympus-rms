function __ws__(id){
document.write(id.text);id.id='';
}

//----------------------------------- 필드(String) 내용 관련 함수  -----------------------------------
function win_pop(path, win_name, wi, he, scroll) {
	window.open(path,win_name,'width='+wi+',height='+he+',resizable=no,scrollbars='+scroll+', status=no,toolbar=no');
}
function win_pop_cookie(path, win_name, wi, he, scroll, cookie_name) {
	if ( getCookie( cookie_name ) == "" ) {
		window.open(path,win_name,'width='+wi+',height='+he+',resizable=no,scrollbars='+scroll+', status=no,toolbar=no');
	}
}
function setCookie( name, value, expiredays )
{
  var endDate = new Date();
  endDate.setDate( endDate.getDate()+ expiredays );
  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + endDate.toGMTString() + ";"
}

// 이미지 롤오버
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
// 레이어
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);


function HANA_findObj(n, d)		//v4.0	
{ 
	var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {	
	d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}	
	if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];	
	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=HANA_findObj(n,d.layers[i].document);	
	if(!x && document.getElementById) x=document.getElementById(n); return x;	
}	
function HANA_showHideLayers()	//v3.0	
{ 
	var i,p,v,obj,args=HANA_showHideLayers.arguments;	
	for (i=0; i<(args.length-2); i+=3) if ((obj=HANA_findObj(args[i]))!=null) { v=args[i+2];	
	if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }	
	obj.visibility=v; }	
}	

function startTrans(rg_img){
	if (document.images) {
		document.middle_view1.filters.blendTrans.Apply();
		document.middle_view1.src =rg_img;
		document.middle_view1.filters.blendTrans.play();
	}
}

function open_shop(obj, topPosition) {
	obj.style.visibility="visible";
	obj.style.top=topPosition;
}

function close_shop(obj) {
	obj.style.visibility="hidden";
}



/******************************
*  기능 :  문자열 Valid 검사처리 *
*  수정일 : 2002-01-25              *
*  parameter : string, space  *
*******************************/

function CheckValid(String, space)
{

   var retvalue = false;

   for (var i=0; i<String.length; i++)
   {		//String이 0("" 이나 null)이면 무조건 false
      if (space == true)
      {
         if (String.charAt(i) == ' ')
         {			//String이 0이 아닐때 space가 있어야만 true(valid)
            retvalue = true;
            break;
         }
      } else {
         if (String.charAt(i) != ' ')
         {			//string이 0이 아닐때 space가 아닌 글자가 있어야만 true(valid)
            retvalue = true;
            break;
         }
      }
   }

   return retvalue;
}

/******************************
*  기능 :  Empty 및 공백 처리    *
*  수정일 : 2002-01-25              *
*  parameter : field, error_msg  *
*******************************/

function isEmpty(field, error_msg)
{
	// error_msg가 ""이면 alert와 focusing을 하지 않는다
	if(error_msg == "") {
		if(!CheckValid(field.value, false)) 	{
			return true;
		} else {
			return false;
		}
	} else {
		if(!CheckValid(field.value, false)) {
			alert(error_msg);
			field.focus() ;
			return true;
		} else {
			return false;
		}
	}
}

function isNotSet(field, error_msg)
{ 
	//for hidden field....
	if(field.value == "")
	{
		alert(error_msg);
		return true;
	} else
	{
		return false;
	}
}

function haveSpace(field, error_msg)
{
	if(CheckValid(field.value, true))
	{
		alert(error_msg);
		field.focus();
		field.select();
		return true;
	}
	return false;
}


/******************************
*  기능 :  NumberCheck           *
*  수정일 : 2002-03-29(denial)              *
*  parameter : field, error_msg  *
*******************************/
function isNotNumber(field, error_msg)
{
	var val = field.value;

	if(isNaN(val) ) {
		if(error_msg.length > 0) {
			alert(error_msg);
			field.focus();
			field.select();
		}
		return true;
	} else {
		return false;
	}
}

/******************************
*  기능 :  NumberCheck And Empty Check
*  수정일 : 2002-04-02(denial)
*  parameter : field, error_msg
*******************************/
function isNotNumberOrEmpty(field, error_msg)
{
	var val = field.value;

	if(val.length == 0 || isNaN(val) ) {
		if(error_msg.length > 0) {
			alert(error_msg);
			field.focus();
			field.select();
		}
		return true;
	} else {
		return false;
	}
}

function alertAndFocus(field, error_msg)
{
	alert(error_msg);
	field.focus();
	field.select();
}

/***************************************
*  기능 : String 알파벳과 숫자만~ Check  *
*  수정일 : 2002-01-25                           *
*  parameter : Form                              *
****************************************/
function isNotAlphaNumeric(field,error_msg)
{

   for (var i=0; i < field.value.length; i++)
   {
      if ( ( (field.value.charAt(i) < "0") || (field.value.charAt(i) > "9") ) &&
           ( ( (field.value.charAt(i) < "A") || (field.value.charAt(i) > "Z") ) &&
             ( (field.value.charAt(i) < "a") || (field.value.charAt(i) > "z") ) ) )
	  {
         alert(error_msg);
		 field.focus();
		 field.select();
		 return true;
	   }
   }

   return false;
}

//0체크
function isNotZero(field,error_msg){
   for (var i=0; i < field.value.length; i++){
      if ( parseInt(field.value) == 0){
         alert(error_msg);
		 field.focus();
		 field.select();
		 return true;
	   }
   }
   return false;
}



// 필드(String) 길이 관련
function strLength(field)
{

   var Length = 0;

   var Nav = navigator.appName;
   var Ver = navigator.appVersion;

   var IsExplorer = false;

   var ch;

   if ( (Nav == 'Microsoft Internet Explorer') && (Ver.charAt(0) >= 4) )
   {
      IsExplorer = true;
   }

   if(IsExplorer)
   {

      for(var i = 0 ; i < field.value.length; i++)
      {

         ch = field.value.charAt(i);

         if ((ch == "\n") || ((ch >= "ㅏ") && (ch <= "히")) ||
             ((ch >="ㄱ") && (ch <="ㅎ")))
		{
	    	Length += 2;
		} else
		{
	    	Length += 1;
       	}

	  }

   }else {
      Length = field.value.length ;
   }

   return Length;
}

/****************************************
*  기능 : 문자열 길이제한                          *
*  수정일 : 2002-01-25                              *
*  parameter : field, min, max, error_msg  *
*****************************************/
function isOutOfRange(field, min, max, error_msg)
{
	if(strLength(field) < min || strLength(field) > max)
	{
		alert(error_msg);
		field.focus();
		field.select();
		return true;
	}
	return false;
}

function isNotExactLength(field, len, error_msg) {
	if(strLength(field) != len) {
		alert(error_msg);
		field.focus();
		field.select();
		return true;
	}
	return false;
}

function isOutOfNumericRange(field, min, max, error_msg) {
	if(field.value < min || field.value > max) {
		alert(error_msg);
		field.focus();
		field.select();
		return true;
	}
	return false;
}
//---------------//


//------------------------------------- SELECT, CHECK BOX 관련 함수 -------------------------------
/****************************************
*  기능 :  Select Box 선택여부 검사            *
*  수정일 : 2002-01-25                              *
*  parameter : field, error_msg                  *
*****************************************/

function isNotSelected(field, error_msg) {
	if(field.selectedIndex == 0) {
		alert(error_msg);
		field.focus() ;
		return true;
	} else {
		return false;
	}
}

/******************************
*  기능 :  Radio Button Check    *
*  수정일 : 2002-01-25              *
*  parameter : field, error_msg  *
*******************************/
function isNotCheckedRadio(field, error_msg) {
	if ( field == null ) {
		alert(error_msg);
		return true;
	}

	if ( field.length == null ) {
		if ( field.checked == true ) {
			return false;
		} else {
			alert(error_msg);
			return true;
		}
	}

	for(i = 0; i < field.length; i++) {
		if(field[i].checked == true) {
			return false;
		}
	}
	alert(error_msg);
	return true;
}
//---------------//

/**
 * Radio Button을 선택해제한다
 */
function uncheckRadio(field) {
	for(i = 0; i < field.length; i++) {
		field[i].checked = false;
	}
}

/**
 * Radio Button의 선택된 값을 가져온다
 */
function getRadioVal(field) {
	for(i = 0; i < field.length; i++) {
		if(field[i].checked == true)
			return field[i].value;
	}
	return "";
}

//------------------------------------- 특정 필드 관련 함수 ---
function checkDupID(id)
{
	if(isEmpty(id, "ID를 기입해 주세요!")) return true;
	if(isNotAlphaNumeric(id,"ID는 4~10자 사이의 숫자 및 영문 대소문자로만 기입해 주세요!")) return true;
	//if(isOutOfRange(id,4, 10, "ID는 한글 2자~5자, 영문 4~10자 이내로 기입해 주세요!")) return true;
}

function checkName(name)
{
	if(isEmpty(name, "사용자명을 기입해 주세요!")) return true;
}

/*******************************
*  기능 : 비밀번호 Check            *
*  수정일 : 2002-01-25                *
*  parameter : Form                  *
*******************************/
function isNotValidPassword(form) {

	if(isEmpty(form.password,"パスワードを入力して下さい。")) return true;
	if(isEmpty(form.password2,"パスワードを再入力して下さい。")) return true;
	if(isNotAlphaNumeric(form.password,"秘密番号は英語と数字の4~8字のみ可能です。")) return true;
	if(isNotAlphaNumeric(form.password2,"秘密番号は英語と数字の4~8字のみ可能です。")) return true;
	if(isOutOfRange(form.password, 4, 10, "秘密番号は英語と数字の4~8字のみ可能です。")) return true;
	if(isOutOfRange(form.password2, 4, 10, "秘密番号は英語と数字の4~8字のみ可能です。")) return true;
	if(form.password.value != form.password2.value) {
		alert("秘密番号が一致してないです。\n もう一回入力して下さい。");
		form.password.value="";
		form.password2.value="";
		form.password.focus();
		form.password.select();
		return true;
	}
	return false;
}

/******************************
*  기능 : 주민등록번호 Check     *
*  수정일 : 2002-01-25               *
*  parameter : Form                  *
*******************************/
function isNotValidPID(form) {

	if(isEmpty(form.pid1,"주민등록번호를 입력해 주세요!")) return true;
	if(isEmpty(form.pid2,"주민등록번호를 입력해 주세요!")) return true;
	if(isNotNumber(form.pid1,"주민등록번호 앞자리는 숫자로만 기입해 주세요!")) return true;
	if(isNotNumber(form.pid2,"주민등록번호 뒷자리는 숫자로만 기입해 주세요!")) return true;
	if(isNotExactLength(form.pid1, 6, "주민등록번호 앞자리는 6자리입니다!")) return true;
	if(isNotExactLength(form.pid2, 7, "주민등록번호 뒷자리는 7자리입니다!")) return true;
	strchr = form.pid1.value.concat(form.pid2.value);
	if (strchr.length == 13	) {
		nlength = strchr.length;

		num1 = strchr.charAt(0);
		num2 = strchr.charAt(1);
		num3 = strchr.charAt(2);
		num4 = strchr.charAt(3);
		num5= strchr.charAt(4);
		num6 = strchr.charAt(5);
		num7 = strchr.charAt(6);
		num8 = strchr.charAt(7);
		num9 = strchr.charAt(8);
		num10 = strchr.charAt(9);
		num11 = strchr.charAt(10);
		num12 = strchr.charAt(11);

		var total = (num1*2)+(num2*3)+(num3*4)+(num4*5)+(num5*6)+(num6*7)+(num7*8)+(num8*9)+(num9*2)+(num10*3)+(num11*4)+(num12*5);
		total = (11-(total%11)) % 10;
	//	if (total == 11) total = 1;
	//	if (total == 10) total = 0;

		if(total != strchr.charAt(12)) {
			alert("주민등록번호가 올바르지 않습니다. \n다시 입력해 주세요!");
			form.pid1.value="";
			form.pid2.value="";
			form.pid1.focus();
			return true;
		}
		return false;
	}	else
		alert("주민등록번호가 올바르지 않습니다. \n다시 입력해 주세요!");
		form.pid1.value="";
		form.pid2.value="";
		form.pid1.focus();
		return true;
}
/******************************
*  기능 : 사업자등록번호 Check  *
*  수정일 : 2002-01-25               *
*  parameter : Form                  *
*******************************/
function isNotValidBID(form) {

	if(isEmpty(form.bid1,"사업자등록번호를 입력해 주세요!")) return true;
	if(isEmpty(form.bid2,"사업자등록번호를 입력해 주세요!")) return true;
	if(isEmpty(form.bid3,"사업자등록번호를 입력해 주세요!")) return true;
	if(isNotNumber(form.bid1,"사업자등록번호 앞자리는 숫자로만 기입해 주세요!")) return true;
	if(isNotNumber(form.bid2,"사업자등록번호 가운데자리는 숫자로만 기입해 주세요!")) return true;
	if(isNotNumber(form.bid3,"사업자등록번호 뒷자리는 숫자로만 기입해 주세요!")) return true;
	if(isNotExactLength(form.bid1, 3, "사업자등록번호 앞자리는 3자리입니다!")) return true;
	if(isNotExactLength(form.bid2, 2, "사업자등록번호 뒷자리는 2자리입니다!")) return true;
	if(isNotExactLength(form.bid3, 5, "사업자등록번호 뒷자리는 5자리입니다!")) return true;
	strchr = form.bid1.value.concat(form.bid2.value.concat(form.bid3.value));

	num1 = strchr.charAt(0);
	num2 = strchr.charAt(1);
	num3 = strchr.charAt(2);
	num4 = strchr.charAt(3);
	num5= strchr.charAt(4);
	num6 = strchr.charAt(5);
	num7 = strchr.charAt(6);
	num8 = strchr.charAt(7);
	num9 = strchr.charAt(8);
	num10 = strchr.charAt(9);

	var total = (num1*1)+(num2*3)+(num3*7)+(num4*1)+(num5*3)+(num6*7)+(num7*1)+(num8*3)+(num9*5);
	total = total + ((num9 * 5) / 10);
	var tmp = total % 10;
	if(tmp == 0) {
		var num_chk = 0;
	} else {
		var num_chk = 10 - tmp;
	}

	if(num_chk != num10) {
		alert("사업자등록번호가 올바르지 않습니다. \n다시 입력해 주세요!");
		form.bid1.value="";
		form.bid2.value="";
		form.bid3.value="";
		form.bid1.focus();
		return true;
	}
	return false;
}
/******************************
*  기능 :  E-Mail Check            *
*  수정일 : 2002-01-25              *
*  parameter : field, error_msg  *
*******************************/
function isNotValidEmail(field)
{
   var checkflag = true;
   var retvalue;

   if(field.value == "") {
	   retvalue = true;
   } else {

	   if (window.RegExp) {
		  var tempstring = "a";
		  var exam = new RegExp(tempstring);
		  if (tempstring.match(exam)) {
			 var ret1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
			 var ret2 = new RegExp("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$");
			 retvalue = (!ret1.test(field.value) && ret2.test(field.value));
		  } else {
			 checkflag = false;
		  }
	   } else {
		  checkflag = false;
	   }

	   if (!checkflag) {
		  retvalue = ( (field.value != "") && (field.value.indexOf("@")) > 0 && (field.value.index.Of(".") > 0) );
	   }

   }
   if(retvalue) { return false;
   } else {
		alert("이메일 주소가 정확하지 않습니다. \n다시 입력해 주세요!");
		field.focus();
		field.select();
		return true;
   }
}

/******************************
*  기능 :  TelNumber Check      *
*  수정일 : 2002-01-25              *
*  parameter : field, error_msg  *
*******************************/
function isNotValidTel(field) {

   var Count;
   var PermitChar =
         "0123456789-";

   for (var i = 0; i < field.value.length; i++) {
      Count = 0;
      for (var j = 0; j < PermitChar.length; j++) {
         if(field.value.charAt(i) == PermitChar.charAt(j)) {
            Count++;
            break;
         }
      }

      if (Count == 0) {
         alert("전화번호가 정확하지 않습니다. \n다시 입력해 주세요!")
		 field.focus();
		 field.select();
		 return true;
         break;
      }
   }
   return false;
}
//---------------//


function isNotValidChar(field,error_msg) {

   var Count;
   var PermitChar = "0123456789-";  // 허용가능한 문자들을 모두 기록한다.

   for (var i = 0; i < field.value.length; i++) {
      Count = 0;
      for (var j = 0; j < PermitChar.length; j++) {
         if(field.value.charAt(i) == PermitChar.charAt(j)) {
            Count++;
            break;
         }
      }

      if (Count == 0) {
         alert(error_msg);
		 field.focus();
		 field.select();
		 return true;
         break;
      }
   }
   return false;
}

function isNotValidChar3(field,error_msg) {

   var Count;
   var PermitChar = "123456789-";  // 허용가능한 문자들을 모두 기록한다.

   for (var i = 0; i < field.value.length; i++) {
      Count = 0;
      for (var j = 0; j < PermitChar.length; j++) {
         if(field.value.charAt(i) == PermitChar.charAt(j)) {
            Count++;
            break;
         }
      }

      if (Count == 0) {
         alert(error_msg);
		 field.focus();
		 field.select();
		 return true;
         break;
      }
   }
   return false;
}

function isNotValidCharNum(field,error_msg) {

   var Count;
   var PermitChar = "0123456789";  // 허용가능한 문자들을 모두 기록한다.

   for (var i = 0; i < field.value.length; i++) {
      Count = 0;
      for (var j = 0; j < PermitChar.length; j++) {
         if(field.value.charAt(i) == PermitChar.charAt(j)) {
            Count++;
            break;
         }
      }

      if (Count == 0) {
         alert(error_msg);
		 field.focus();
		 field.select();
		 return true;
         break;
      }
   }
   return false;
}

function isNotValidChar2(field,error_msg) {

   var NotPermitChar = "\"";  //허용되어서는 안되는 문자들을 모두 기록한다.
//   var NotPermitChar = "<>\"^&|'\\ ";  //허용되어서는 안되는 문자들을 모두 기록한다.

   if(field.value == "") return false;
   for (var i = 0; i < field.value.length; i++) {
      for (var j = 0; j < NotPermitChar.length; j++) {
         if(field.value.charAt(i) == NotPermitChar.charAt(j)) {
            ans = confirm(error_msg);
			if(ans == true) {
				return false;
			} else {
				field.focus();
				field.select();
				return true;
			}
         }
      }
   }
   return false;
}

function auto_fill_birth(pid1) {

	var year = pid1.value.substr(0,2);
	var month = pid1.value.substr(2,2);
	var date = pid1.value.substr(4,2);
	document.forms[0].year.value = year;
	document.forms[0].month.value = month;
	document.forms[0].date.value = date;

}

function hide_in(field) {
	if(field.value == field.defaultValue) field.value = "";
}
function show_out(field) {
	if(field.value == "") field.value = field.defaultValue;
}

function checkNumber(objname)
{
	var intErr = 1;
	var strValue = objname.value;
	var retCode = 0;

	for(i = 0; i < strValue.length; i++)
	{
		var retCode = strValue.charCodeAt(i);
		var retChar = strValue.substr(i, 1).toUpperCase();

		retCode = parseInt(retCode);

		// "3.4"도 숫자이다.
		if(!((retChar >= "0" && retChar <= "9") || retChar == "."))
		{
			intErr = 0; // break;
		}
	}

	var periodCnt = 0;

	while(strValue.indexOf(".") != -1)
	{
		periodCnt++;

		strValue = strValue.substr(strValue.indexOf(".") + 1, strValue.length - (strValue.indexOf(".") + 1));
	}

	// "3..4"는 숫자가 아니다.
	if(periodCnt > 1)
		intErr = 0;

	if (intErr!=1)
	{
		return true;
	}
	else return false;
}

/*function CheckID_onSubmit(form)
{
	if (form.id.value.length < 4 || form.id.value.length > 10 ||
	      IsAlphaNumeric(form.id.value) == false)
	{
	    alert("이용자ID는 영문과 숫자의 조합으로 4-10자리내에서 입력하십시오. \n한글, 띄어쓰기는 안됩니다! ");
	    form.id.focus();
	    return (false);
	}
	return (true);
}*/

/**
 * <PRE>
 * Scroll 이 없는 새 창을 띄운다
 * </PRE>
 * @param   theURL : 새로 띄울 파일 이름이다
 * @param   winName : 새창 이름
 * @param   winTitle : 새창 title
 * @param	width : 새창 가로 크기
 * @param	height : 새창 세로 크기
 * @param   param : 추가적인 화면 argument
 */
function openNoScrollWin(theURL, winName, winTitle, width, height, param)
{
	var win = window.open(theURL + "?popupTitle=" + winTitle + "&tableWidth=" + width + param, winName, "menubar=no, scrollbars=no, resizable=no, width=" + width + ", height=" + height);
}

/**
 * <PRE>
 * Scroll 이 없는 새 창을 띄운다
 * </PRE>
 * @param   theURL : 새로 띄울 파일 이름이다
 * @param   winName : 새창 이름
 * @param   winTitle : 새창 title
 * @param	width : 새창 가로 크기
 * @param	height : 새창 세로 크기
 * @param   param : 추가적인 화면 argument
 */
function openScrollWin(theURL, winName, winTitle, width, height, param)
{
	var win = window.open(theURL + "?popupTitle=" + winTitle + "&tableWidth=" + width + param, winName, "menubar=no, scrollbars=yes, resizable=no, width="+width+", height="+height) ;
}

/**
 * <PRE>
 * 제약이 없는 새 창 띄우기를 하자
 * </PRE>
 * @param   theURL : 새로 띄울 파일 이름이다
 * @param   winName : 새창 이름
 * @param   winTitle : 새창 title
 * @param	width : 새창 가로 크기
 * @param	features : 다양한 모양을 직접 준다
 * @param   param : 추가적인 화면 argument
 */
function openFlexWin(theURL,winName,winTitle, width, features, param)
{
	var win = window.open(theURL + "?popupTitle=" + winTitle + "&tableWidth=" + width + param,winName,features);
}



///////////////////// Calendar ///////////////////////////

/* 날짜만 입력해야할 때 */
function showDateCalendar(dateField)
{
	var wid = (screen.width)/2 - 560/2 ;
	var hei = (screen.height)/2 - 480/2;
	
	window.open("/common/calendar/PopCalendar.jsp?popupTitle=달력&type=date&dateField=" + dateField, "Calendar", "width=560,height=480,status=no,resizable=no,top="+hei+",left="+wid+"");
}
/* 날짜만 입력해야할 때 -- 그리드
dateField = "gridName, row, col" */
function showDateCalendarGrid(dateField)
{
	var wid = (screen.width)/2 - 560/2 ;
	var hei = (screen.height)/2 - 480/2;
	window.open("/common/calendar/PopCalendar.jsp?type=date&subType=grid&dateField=" + dateField, "Calendar", "width=560,height=480,status=no,resizable=no,top="+hei+",left="+wid+"");
}
/* 날짜와 시간 모두들 입력해야할 때 */
function showDateTimeCalendar(dateField, timeField)
{
	var wid = (screen.width)/2 - 560/2 ;
	var hei = (screen.height)/2 - 480/2;
	window.open("/common/calendar/PopCalendar.jsp?type=datetime&dateField=" + dateField + "&timeField=" + timeField, "Calendar", "width=560,height=480,status=no,resizable=no,top="+hei+",left="+wid+"");
}


/**
 * <PRE>
 * 특정 필드에 대한 수정을 막는 행위
 * </PRE>
 * @param   objectName : 수정을 중지시킬 필드객체.(주로 input type)
 */
function editStop(objectName) {
	objectName.blur();
}

/**
 * 숫자나 문자열을 통화(Money) 형식으로 만든다.( 쉼표(,) 찍는다는 소리.. )
 * @param	amount	"1234567"
 * @return	currencyString "1,234,567"
 */
function formatCurrency(amount)
{
	amount = new String(amount);
	var amountLength = amount.length;
	var modulus = amountLength % 3;
	var currencyString = amount.substr(0,modulus);
	for(i=modulus; i<amountLength; i=i+3) {
		if(currencyString != "") 
			currencyString += ",";
		currencyString += amount.substr(i, 3);
	}
	return currencyString;
}

///////////////////// LotteMRO Specific Functions ///////////////////////////
/**
 * 아이템 수량별 할인가를 반환한다(수량별 할인가 정보가 없을 경우 기본가 반환)
 *
 * @param	arrDiscount	수량별 할인가 배열
 * @param	qty	수량
 * @param	defaultSellPrice	기본 가격
 * @return	discountPrice	할인가
 */
function calcDiscountPrice(arrDiscount, qty, defaultSellPrice)
{
	var discountPrice = defaultSellPrice;
	var prevQty = 0;

	for( i=0; i<arrDiscount.length; i++ ) {
		if(qty >= prevQty && qty < arrDiscount[i][0]) {
			break;
		} else {
			discountPrice = arrDiscount[i][1];
			prevQty = arrDiscount[i][0];
		}
	}
	
	return discountPrice;
}
/**
 * 아이템 판매가를 반환한다(수량별 할인가 정보가 없을 경우 기본가 반환)
 *
 * @param	arrDiscount	수량별 할인가 배열
 * @param	qty	수량
 * @param	defaultSellPrice	기본 가격
 * @param	addedPrice	옵션으로 인해 추가된 가격(옵션가 총합)
 * @return	판매가
 */
function calcSellPrice(arrDiscount, qty, defaultSellPrice, addedPrice)
{
	return (calcDiscountPrice(arrDiscount, qty, defaultSellPrice) + addedPrice) * qty;
}
/**
 * 아이템 원가를 반환한다
 *
 * @param	defaultPrimeCost	기본 가격
 * @param	addedPrice	옵션으로 인해 추가된 가격(옵션가 총합)
 * @return	원가
 */
function calcPrimeCost(defaultPrimeCost, addedPrice)
{
	return defaultPrimeCost + addedPrice;
}

/*
 * 사업자 등록 번호를 검사한다.
 */
function isNotValidBIZ(form) {

	if(isEmpty(form.bizregno1,"사업자등록번호를 입력해 주세요!")) return true;
	if(isEmpty(form.bizregno2,"사업자등록번호를 입력해 주세요!")) return true;
	if(isEmpty(form.bizregno3,"사업자등록번호를 입력해 주세요!")) return true;
	if(isNotNumber(form.bizregno1,"사업자등록번호 앞자리는 숫자로만 기입해 주세요!")) return true;
	if(isNotNumber(form.bizregno2,"사업자등록번호 가운데자리는 숫자로만 기입해 주세요!")) return true;
	if(isNotNumber(form.bizregno3,"사업자등록번호 뒷자리는 숫자로만 기입해 주세요!")) return true;
	if(isNotExactLength(form.bizregno1, 3, "사업자등록번호 앞자리는 3자리입니다!")) return true;
	if(isNotExactLength(form.bizregno2, 2, "사업자등록번호 뒷자리는 2자리입니다!")) return true;
	if(isNotExactLength(form.bizregno3, 5, "사업자등록번호 뒷자리는 5자리입니다!")) return true;
	strchr = form.bizregno1.value.concat(form.bizregno2.value.concat(form.bizregno3.value));

	num1 = strchr.charAt(0);
	num2 = strchr.charAt(1);
	num3 = strchr.charAt(2);
	num4 = strchr.charAt(3);
	num5 = strchr.charAt(4);
	num6 = strchr.charAt(5);
	num7 = strchr.charAt(6);
	num8 = strchr.charAt(7);
	num9 = strchr.charAt(8);
	num10 = strchr.charAt(9);

	var total = (num1*1)+(num2*3)+(num3*7)+(num4*1)+(num5*3)+(num6*7)+(num7*1)+(num8*3)+(num9*5);
	total = total + ((num9 * 5) / 10);
	var tmp = total % 10;
	if(tmp == 0) {
		var num_chk = 0;
	} else {
		var num_chk = 10 - tmp;
	}

	if(num_chk != num10) {
		alert("사업자등록번호가 올바르지 않습니다. \n다시 입력해 주세요!");
		form.bizregno1.value="";
		form.bizregno2.value="";
		form.bizregno3.value="";
		form.bizregno1.focus();
		return true;
	}
	return false;
}

/**
 * Confirm창을 띄우고 "예"이면 false를 "아니오"이면 true를 리턴한다
 * (JSP 사용예 : if(didNotConfirm("주문을 취소하시겠습니까?")) return;)
 */
function didNotConfirm(question) {
	return !confirm(question);
}

/**
 * 검색어가 입력되는 FORM element를 초기화 한다.
 * 
 * @param	검색어 입력 FORM
 */
function doInit(frm)
{
	for (i = 0; i < frm.elements.length; i++)
	{
		frm.elements[i].value = "";
	}
}

/******************************
*  기능 :  Positive NumberCheck           *
*  수정일 : 2002-04-10(withsun)              *
*  parameter : field, error_msg  *
*******************************/
function isNotPositiveNumber(field, error_msg)
{
   for (var i=0; i < field.value.length; i++)
   {
      if ( field.value.charAt(i) < "1" || field.value.charAt(i) > "9" )
	  {
         alert(error_msg);
		 field.focus();
		 field.select();
		 return true;
	   }
   }
}


/**
 * ENTER키 다운 되었을때 넘겨받은 Function실행
 *
 * @param	func	실행할 Function명
 */
function enterKeyDown(func)
{
	enter = event.keyCode;
	if(enter == 13)
	{
		eval(func);
	}

}

/**
 * 특정키 다운 되었을때 넘겨받은 Function실행
 *
 * @param	func	실행할 Function명
 */
function keyDown(func)
{
	enter = event.keyCode;
	if(enter == 13)
	{
		eval(func);
	}

}


/**
 * 주언진 8자리 문자열을 날짜포맷(YYYY-MM-DD or YYYY/MM/DD)로 바꾸어준다.
 *
 * @param	source		변환할 8자리 날짜문자열
 * @param	format		날짜형식
 * @return	ret			변환된 날짜 문자열
 **/
function dateFormat(source, format)
{
	ret = "";
	delimiter = "";

	if (format.indexOf("-") != -1)
		delimiter = "-";
	else if (format.indexOf("/") != -1)
		delimiter = "/";
	else
	{
		alert("입력된 날짜포맷이 잘못되었습니다.");
		return;
	}

	if (source.length == 8)
	{
		ret = source.substring(0, 4) + delimiter + source.substring(4, 6) + delimiter + source.substring(6, 8);
	} else if (source.length == 10)
	{
		ret = source.substring(0, 4) + delimiter + source.substring(5, 7) + delimiter + source.substring(8, 10);
	} else
	{
		alert("입력된 날짜형식이 잘못되었습니다.");
		return;
	}
	return ret;
}

/**
 * 날짜형식이 올바른지 검사
 *
 * @param	astrValue	날짜포맷(yyyymmdd, yyyy/mm/dd, yyyy-mm-dd)
 * @param	astrNotNull:	nn:not null, "": null 허용
 * @return	true/false
 **/
function blnOkDate(astrValue, astrNotNull)
{
	var arrDate;
	
	if (astrValue=='')
	{
		if (astrNotNull == "nn")
			return false;
		else
			return true;
	}else{	
		if (astrValue.indexOf("-") != -1) 
			arrDate = astrValue.split("-");
		else if (astrValue.indexOf("/") != -1) 
			arrDate = astrValue.split("/");
		else
		{
			if (astrValue.length != 8) return false;
			astrValue = astrValue.substring(0,4)+"/"+astrValue.substring(4,6)+"/" +astrValue.substring(6,8);
			arrDate = astrValue.split("/");
		}
	
		if (arrDate.length != 3) return false;		
		
		var chkDate = new Date(arrDate[0] + "/" + arrDate[1] + "/" + arrDate[2]);		
		if (isNaN(chkDate) == true ||
			(arrDate[1] != chkDate.getMonth() + 1 || arrDate[2] != chkDate.getDate())) 
		{
			return false;
		}
	}
	return true;
}


/**
 * 그리드 날짜 셀에서 날짜를 입력받고서 유효한지 체크(yyyymmdd or yyyy-mm-dd or yyyy/mm/dd)후 틀리면 Calendar Popup
 *
 * @param	fgName	그리드객체명
 * @param	row		행수
 * @param	col		열수
 **/
function openCalendarInGrid(fgName, row, col)
{
	var fg = document.all(fgName);
	if (!blnOkDate(fg.TextMatrix(row, col), "nn"))
	{
		fg.TextMatrix(row, col) = "";
		showDateCalendarGrid(fgName + ", " + row + ", " + col);
	}
	else
		fg.TextMatrix(row, col) = dateFormat(fg.TextMatrix(row, col), "YYYY-MM-DD");

}

/**
 * INPUT field에서 날짜를 입력받고서 유효한지 체크(yyyymmdd or yyyy-mm-dd or yyyy/mm/dd)후 틀리면 Calendar Popup
 *
 * @param	field	INPUT 객체
 **/
function openCalendar(dateField)
{
	var obj = eval("document." + dateField);
	if (!blnOkDate(obj.value, "nn"))
	{
		obj.value = "";
		showDateCalendar(dateField);
	}
	else
		obj.value = dateFormat(obj.value, "YYYY-MM-DD");

}

/**
 * 문자열내에 있는 ', "를 \', \" 로변환한다.
 *
 * @param	str	변환할 문자열
 **/
function toValidStr(str)
{
	/*
	alert(str);
	var ret = "";
	for (i = 0; i < str.length; i++)
	{
		if (str.charAt(i) == '\'')
			ret += '\\\'';
		else if (str.charAt(i) == '"')
			ret += '\\\"';
		else
			ret += str.charAt(i);
	}
	*/

	re1 = /\'/gi;
	re2 = /\"/gi;
	str = str.replace(re1, "\\\'");
	str = str.replace(re2, "\\\""); 
	return str;	
	
}

function encChar(str)
{
	var temp1 = "@@@@@";
	re1 = /\'/g;
	re2 = /\"/g;
	str = str.replace(re1, temp1);
	return str;
}	

function decChar(str)
{
	re3 = /@@@@@/g;
	str = str.replace(re3, "'");
	return str;
}


// system의 현재날짜를 return: yyyymmdd
function strGetToDay()
{
 	 var today=new Date();
 	 
 	 var strToDay = today.getYear();
 	 
 	 if (today.getMonth()+1 < 10)
 	 	strToDay += "-0"+(today.getMonth()+1);
 	 else
 	 	strToDay += "-" + today.getMonth()+1;
 	 
 	 if (today.getDate() < 10)
 	 	strToDay += "-0"+today.getDate();
 	 else
 	 	strToDay += "-" + today.getDate();
 	 	
 	 return strToDay; 	 	 
}

//주어진 값(val)을 소수점이하 num자리수에서 반올림한값을 리턴한다.
function round(val, num)
{
	val = val * Math.pow(10, num - 1);
	val = Math.round(val);
	val = val / Math.pow(10, num - 1);
	return val;
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


//특정 필드값에 대해서 끝자리를 10단위로  전환
function roundValue(field) {

  field.value = Math.round(eval(field.value)/10) * 10

}

/*
 * 사업자 등록 번호를 검사한다.
 */
function isNotValidBIZNo(form) {
	
	if(isEmpty(form.site_serial1,"사업자등록번호를 입력해 주세요!")) return true;
	if(isEmpty(form.site_serial2,"사업자등록번호를 입력해 주세요!")) return true;
	if(isEmpty(form.site_serial3,"사업자등록번호를 입력해 주세요!")) return true;
	if(isNotNumber(form.site_serial1,"사업자등록번호 앞자리는 숫자로만 기입해 주세요!")) return true;
	if(isNotNumber(form.site_serial2,"사업자등록번호 가운데자리는 숫자로만 기입해 주세요!")) return true;
	if(isNotNumber(form.site_serial3,"사업자등록번호 뒷자리는 숫자로만 기입해 주세요!")) return true;
	if(isNotExactLength(form.site_serial1, 3, "사업자등록번호 앞자리는 3자리입니다!")) return true;
	if(isNotExactLength(form.site_serial2, 2, "사업자등록번호 뒷자리는 2자리입니다!")) return true;
	if(isNotExactLength(form.site_serial3, 5, "사업자등록번호 뒷자리는 5자리입니다!")) return true;
	strchr = form.site_serial1.value.concat(form.site_serial2.value.concat(form.site_serial3.value));

	num1 = strchr.charAt(0);
	num2 = strchr.charAt(1);
	num3 = strchr.charAt(2);
	num4 = strchr.charAt(3);
	num5 = strchr.charAt(4);
	num6 = strchr.charAt(5);
	num7 = strchr.charAt(6);
	num8 = strchr.charAt(7);
	num9 = strchr.charAt(8);
	num10 = strchr.charAt(9);

	var total = (num1*1)+(num2*3)+(num3*7)+(num4*1)+(num5*3)+(num6*7)+(num7*1)+(num8*3)+(num9*5);
	total = total + parseInt((num9 * 5) / 10);
	var tmp = total % 10;

	if(tmp == 0) {
		var num_chk = 0;
	} else {
		var num_chk = 10 - tmp;
	}

	if(num_chk != num10) {
		alert("사업자등록번호가 올바르지 않습니다. \n다시 입력해 주세요!");
		form.site_serial1.value="";
		form.site_serial2.value="";
		form.site_serial3.value="";
		form.site_serial1.focus();
		return true;
	}
	return false;
}
// Main 에서 날짜와 요일을 보여준다. return :ex) 2004년 8월 20일 (금요일) 
function getMainDateViewStr() {
	view_today = new Date();
	var count_day = view_today.getDay();
	var view_week;
	if      ( count_day ==0 ) view_week ="일";
	else if ( count_day ==1 ) view_week ="월";
	else if ( count_day ==2 ) view_week ="화";
	else if ( count_day ==3 ) view_week ="수";
	else if ( count_day ==4 ) view_week ="목";
	else if ( count_day ==5 ) view_week ="금";
	else if ( count_day ==6 ) view_week ="토";
	return view_today.getYear() + "년 " + (view_today.getMonth()+1) + "월 " + view_today.getDate()+"일 (" + view_week + "요일)";
} 



///////////////////////////////////////////// obj_common /////////////////////////////////////////////////////////////////////////
// 플래시 호출 flashWrite(파일경로, 가로, 세로, 아이디, 배경색, 변수, 윈도우모드)
function flashWrite(url,width,height){
	// 플래시 코드 정의
	var flashStr=
	document.write("<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='"+width+"' height='"+height+"' align='middle'>");
	document.write("<param name='allowScriptAccess' value='always' />");
	document.write("<param name='movie' value='"+url+"' />");
	document.write("<param name='menu' value='false' />");
	document.write("<param name='quality' value='high' />");
	document.write("<param name='wmode' value='transparent' />");
	document.write("<param name='bgcolor' value='#FFFFFF' />");
	document.write("<embed src='"+url+"' menu='false' quality='high' width='"+width+"' height='"+height+"' align='middle' allowScriptAccess='always' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />");
	document.write("</object>");

	// 플래시 코드 출력
	document.write(flashStr);
}



//-- 일반적으로 단순한 플래쉬 일 경우
/*
	-- 파라미터 정보 --

	width : 가로크기
	height : 세로크기
	url : 플래쉬 파일의 경로
*/

function swfView(width, height, url){
	document.write("<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' ");
	document.write("		codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0' ");
	document.write("		width='"+width+"' height='"+height+"' align='middle'>");
	document.write("	<param name='allowScriptAccess' value='sameDomain' /> ");
	document.write("	<param name='movie'				value='"+url+"' /> ");
	document.write("	<param name='quality'			value='high' /> ");
	document.write("	<param name='wmode'				value='transparent'> ");
	document.write("	<embed src='"+url+"' quality='high' width='"+width+"' height='"+height+"' align='middle' ");
	document.write("		allowScriptAccess='sameDomain' type='application/x-shockwave-flash' ");
	document.write("		pluginspage='http://www.macromedia.com/go/getflashplayer' />");
	document.write("</object>");
}



/*
	-- 파라미터 정보 --

	id : 클래스 아이디
	width : 가로크기
	height : 세로크기
	url : 플래쉬 파일의 경로
*/

function flexView(id, width, height, url){
	document.write("<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' "); 
	document.write("		codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,14,0' "); 
	document.write("		width='"+width+"' height='"+height+"' id='"+id+"'> ");
	document.write("	  <param name='src' value='"+url+"'> ");
	document.write("	  <param name='wmode' value='transparent'> ");
	document.write("	  <embed pluginspage='http://www.macromedia.com/go/getflashplayer' "); 
	document.write("			 width='"+width+"' height='"+height+"' src='"+url+"'/> ");
	document.write("</object>");
/*
	document.write("<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' ");
	document.write("		codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,14,0' ");
	document.write("		width='"+width+"' height='"+height+"' align='middle' id='"+id+"'>");
	document.write("	<param name='src' value='"+url+"'>");
	document.write("	<embed src='"+url+"' quality='high' width='"+width+"' height='"+height+"' align='middle' ");
	document.write("		allowScriptAccess='sameDomain' type='application/x-shockwave-flash' ");
	document.write("		pluginspage='http://www.macromedia.com/go/getflashplayer' />");
	document.write("</object>");
*/
}



function swfView2(width, height, idname, obname, allowscriptaccess, quality, wmode, scale, bgcolor, swLiveConnect, fvalues, base, url){

	document.write("<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' ");
	document.write("		codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' ");

	if(idname != ""){
		document.write("		id='"+idname+"' ");
	}

	document.write("		width='"+width+"' ");
	document.write("		height='"+height+"'>");

	document.write("	<param name='movie'				value='"+url+"'/>");
	document.write("	<param name='quality'			value='"+quality+"'/>");
	document.write("	<param name='wmode'				value='"+wmode+"'/>");

	if(allowscriptaccess != ""){
		document.write("	<param name='allowscriptaccess' value='"+allowscriptaccess+"'/>");
	}

	if(base != ""){
		document.write("	<param name='base'			value='"+base+"'/>");
	}

	if(bgcolor != ""){
		document.write("	<param name='bgcolor'		value='"+bgcolor+"' /> ");
	}

	if ( fvalues != "" ) {
		document.write("	<param name='flashVars'		value='"+fvalues+"'/> ");    
	}

	document.write("	<param name='scale'				value='"+scale+"' />");
	document.write("	<embed	src					='"+url+"'");
	document.write("			base				='"+base+"' ");
	document.write("			scale				='"+scale+"' ");
	document.write("			swLiveConnect		='"+swLiveConnect+"' ");

	if(idname != ""){
		document.write("			id					='"+idname+"' ");
	}

	if(obname != ""){
		document.write("			name				='"+obname+"' ");
	}

	if(allowscriptaccess != ""){
		document.write("			allowScriptAccess	='"+allowscriptaccess+"' ");
	}

	document.write("			quality				='"+quality+"' ");
	document.write("			wmode				='"+wmode+"' ");
	document.write("			width				='"+width+"' ");
	document.write("			height				='"+height+"' ");
	document.write("			type='application/x-shockwave-flash' ");
	document.write("			pluginspage='http://www.macromedia.com/go/getflashplayer'></embed>");
	document.write("</object>");

}

//-- SeeLive 방송 보기
function seeLiveView(id, name, width, height, serverIP, basePort, useUniPort, channel, noTicket, autoPlay, startDelay, wheelVolumeControl, customLogo, customLogoOnWhite){

	document.write("<object id='"+id+"' name='"+name+"' width='"+width+"' height='"+height+"' ");
	document.write("		CLASSID='CLSID:8eeb54d5-cc70-40e4-b015-ac478c02ecc8'>");
	document.write("	<param name='ServerIP'				value='"+serverIP+"'> ");
	document.write("	<param name='BasePort'				value='"+basePort+"'> ");
	document.write("	<param name='UseUniPort'			value='"+useUniPort+"'>"); 
	document.write("	<param name='Channel'				value='"+channel+"'> ");
	document.write("	<param name='NoTicket'				value='"+noTicket+"'> ");
	document.write("	<param name='AutoPlay'				value='"+autoPlay+"'>");
	document.write("	<PARAM NAME='StartDelay'			VALUE='"+startDelay+"'> ");
	document.write("	<PARAM NAME='WheelVolumeControl'	VALUE='"+wheelVolumeControl+"'> ");
	document.write("	<PARAM NAME='CustomLogo'			VALUE='"+customLogo+"'>");
	document.write("	<PARAM NAME='CustomLogoOnWhite'		VALUE='"+customLogoOnWhite+"'>");
	document.write("</object>");
}

//-- Microsoft Windows Media Player 재생
function mediaPlayerView(id, name, width, height, showcontrols, autostart, autorewind, autosize, autoresize, transparentatstart, loop, url) {
	document.write("<object id='"+id+"' codeBase='http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701' "); 
	document.write("		type='application/x-oleobject' standby='Loading Microsoft Windows Media Player components...' "); 
	document.write("		width='"+width+"' height='"+height+"' classid='clsid:22D6F312-B0F6-11D0-94AB-0080C74C7E95' name='"+name+"'> ");
	document.write("	<param name='ShowControls' value='"+showcontrols+"'> ");
	document.write("	<param name='AutoStart' value='"+autostart+"'> ");
	document.write("	<param name='AutoRewind' value='"+autorewind+"'> ");
	document.write("	<param name='Autosize' value='"+autosize+"'> ");
	document.write("	<param name='AutoResize' value='"+autoresize+"'> ");
	document.write("	<param name='TransparentAtStart' value='"+transparentatstart+"'> ");
	document.write("	<param name='loop' value='"+loop+"'> ");
	document.write("	<param name='Filename' value='"+url+"'> ");
	document.write("	<embed type='application/x-mplayer2' pluginspage='http://www.microsoft.com/Windows/Downloads/Contents/Products/MediaPlayer/' "); 
	document.write("		id='"+id+"' name='"+name+"' showpositioncontrols='0' showcontrols='0' autosize='0' autostart='1' showdisplay='0' ");
	document.write("		showstatusbar='0' showtracker='1' loop='1' width='"+width+"'  height='"+height+"' src='"+url+"'> ");
	document.write("	</embed> "); 
	document.write("</object> ");
}

//-- object를 통으로 스트링으로 묶어서 보내 경우
function objAll(objString){	
	document.write(objString);
}


//상품상세보기_썸네일 이미지 마우스 오버시 테두리 생기게 
function tableOut(thiss) {
	thiss.style.borderColor='#E1E1E1';
	thiss.style.backgroundColor='#E1E1E1';
}
function tableOver(thiss) {
	thiss.style.borderColor="#FF7900";
}

function clearText(theField){
	if (theField.defaultValue==theField.value)
		theField.value="";
}
function isDigit(obj){
		inputStr = obj.value;
		for( var i = 0 ; i < inputStr.length ; i++ )
		{
			var oneChar = inputStr.charAt(i)
			if (oneChar < "0" || oneChar > "9")
			{
				return false;
			}
		}
		return true;
	}


function isNoChar(field,error_msg) {
   var NotPermitChar = ",\"";  //허용되어서는 안되는 문자들을 모두 기록한다.
//   var NotPermitChar = "<>\"^&|'\\ ";  //허용되어서는 안되는 문자들을 모두 기록한다.

   if(field.value == "") return false;
   for (var i = 0; i < field.value.length; i++) {
      for (var j = 0; j < NotPermitChar.length; j++) {
         if(field.value.charAt(i) == NotPermitChar.charAt(j)) {
            ans = confirm(error_msg);
			if(ans == true) {
				return true;
			} else {
				field.focus();
				field.select();
				return true;
			}
         }
      }
   }
   return false;
}

function Replace_Blank(OrgStr) {

    var str = OrgStr.replace(/\ /gi,"");    //
    return str;
}