
// png 이미지
function setPng24(obj) { 
    obj.width=obj.height=1; 
	obj.style.width = obj.width + "px"; 
    obj.style.height = obj.height + "px"; 
    obj.className=obj.className.replace(/\bpng24\b/i,''); 
    obj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');" 
    obj.src='';  
    return ''; 
} 

// 기본 플래시				
function flashObj(URL,SizeX,SizeY,LnkId,Frm,Flag) // quick
{
    document.write('            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" ');
    document.write('                    codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" ');
    document.write('                    width="'+SizeX+'" height="'+SizeY+'"  id="'+LnkId+'" align="middle">');
    document.write('            <param name="movie"     value="'+URL+'" />');
    document.write('            <param name="quality"   value="high" />');
    if ( Flag == null || Flag != 'N' )
    {
        document.write('        <param name="wmode"     value="transparent"/>');
    }
 document.write('   <param name="allowScriptAccess" value="always"/> ');
 document.write('   <param name="base" value="." />');
    document.write('            <embed base="." src="'+URL+'" quality="high" width="'+SizeX+'" height="'+SizeY+'"  align="middle" ');
  if ( Flag == null || Flag != 'N' )
    {
        document.write('         wmode="transparent" ');
    }
    document.write('             type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" allowScriptAccess="always" swLiveConnect=true name="'+LnkId+'"  />');
    document.write('            </embed></object>');
 if ( Frm == 'Y' ) { // form 태그 들어가는 페이지에 적용
  eval("window." + LnkId + " = document.forms[0]."+ LnkId +"; ");
 }
}

// flash(파일주소, 가로, 세로, 배경색, 윈도우모드, 변수, 경로)
function insertFlex(url,id){
	var s=
	"<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' id='" + id + "' width='660' height='350' codebase='http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab'>"+
	"<param name='movie' value='" + url + "' />"+
	"<param name='quality' value='high' />"+
	"<param name='bgcolor' value='#869ca7' />"+	// wmode가 transparent로 지정되지 않으면 div tag보다 위에 위치하게 된다.
	"<param name='allowScriptAccess' value='sameDomain' />"+
	"<embed src='" + url + "' quality='high' bgcolor='#869ca7' width='660' height='350' name='" + id + "' align='middle' play='true' loop='false' quality='high' allowScriptAccess='sameDomain' type='application/x-shockwave-flash' pluginspage='http://www.adobe.com/go/getflashplayer'>"+
	"</embed>"+
	"</object>";
	document.write(s);
}

//2010 0118 수정 시작
function swf_include(swfUrl,swfWidth,swfHeight,bgColor,swfName,access,flashVars){
 // 플래시 코드 정의
 var flashStr=
 "<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='"+swfWidth+"' height='"+swfHeight+"' id='"+swfName+"' align='middle' />"+
 "<param name='allowScriptAccess' value='"+access+"' />"+
 "<param name='wmode' value='transparent' />"+
 "<param name='movie' value='"+swfUrl+"' />"+
 "<param name='FlashVars' value='"+flashVars+"' />"+
 "<param name='loop' value='false' />"+
 "<param name='menu' value='false' />"+
 "<param name='quality' value='high' />"+
 "<param name='scale' value='noscale' />"+
 "<param name='bgcolor' value='"+bgColor+"' />"+
 "<param name='allowFullScreen' value='false' />"+
 "<embed src='"+swfUrl+"' FlashVars='"+flashVars+"'  quality='best' bgcolor='"+bgColor+"' width='"+swfWidth+"' height='"+swfHeight+"' name='"+swfName+"' align='middle' allowFullScreen='false' allowScriptAccess='always' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />"+
 "</object>";

 // 플래시 코드 출력
 document.write(flashStr);
};
//2010 0118 수정 끝


//quick_top
function getPosition(){
	var start, end, scale, term;
	start = parseInt (document.getElementById('btn_top').style.top, 10);
	end = document.documentElement.scrollTop +218;
	term = 5;

	if ( start != end ) {
	scale = Math.ceil( Math.abs( end - start ) / 20 );
		if ( end < start )	scale = -scale;
		document.getElementById('btn_top').style.top = parseInt (document.getElementById('btn_top').style.top, 10)+ scale + "px";
		term = 1;
	}
	setTimeout ("getPosition()", term);
}
function moveBanner() {
	document.getElementById('btn_top').style.top = document.documentElement.scrollTop + 100 + "px"; //숫자가 같으면 슬라이드 없다.
	getPosition();
	return true;
}





//팝업띄우기 스크롤 없는 거
function popsn(url,trgt,w,h) { 
    window.open(url,trgt,'width='+w+',height='+h+',scrollbars=no,resizable=no,copyhistory=no,toolbar=no,status=no'); 
}
//팝업띄우기 스크롤 있는 거
function popsy(url,trgt,w,h) { 
    window.open(url,trgt,'width='+w+',height='+h+',scrollbars=yes,resizable=no,copyhistory=no,toolbar=no,status=no,left=0,top=0'); 
}


//탭
function Over(imgName) {
	imgName.src = imgName.src.replace(/(_on.gif|.gif)$/i, "_on.gif");
	imgName.src = imgName.src.replace(/(_on.jpg|.jpg)$/i, "_on.jpg");
}
function Out(imgName) {
	imgName.src = imgName.src.replace(/(_on.gif|.gif)$/i, ".gif");
	imgName.src = imgName.src.replace(/(_on.jpg|.jpg)$/i, ".jpg");
}

function bgOver(bgcolor){	
	bgcolor = bgcolor.className = "over";
}
function bgOut(bgcolor){
	bgcolor = bgcolor.className = "";
}

function boxOver(bgcolor){	
	bgcolor = bgcolor.className = "view_box over";
}
function boxOut(bgcolor){
	bgcolor = bgcolor.className = "view_box";
}



function layer_events()
{
  if (document.layers) {
    document.layers['gnb_area'].captureEvents(Event.MOUSEOVER|Event.MOUSEOUT|Event.MOUSEUP);
    document.layers['gnb_area'].onmouseout = new Function("this.style.height='115'");
    document.layers['gnb_area'].onmouseover = new Function("this.style.height='260'");
  }
}

function display_open(n) {
	div_name = document.getElementById(n);

	if(div_name.style.display == "block"){
		div_name.style.display ="none";
	}else{
		div_name.style.display ="block";
	}
}


/*  답 Language 부분  */
var init_left_ban = "sites_on";

function f_ch(n){
	var left_ban = "sites_"+n ;
	var ban_div = document.getElementById(left_ban);
	var old_div = document.getElementById(init_left_ban);

	if (left_ban != init_left_ban){
		old_div.style.display = "none";
		ban_div.style.display = "block";
		init_left_ban = left_ban;
	}
}



// flash(파일주소, 가로, 세로, 배경색, 윈도우모드, 변수, 경로)
function insertFlash(url,w,h,bg,win,vars,base){
	var s=
	"<object id='flash' classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,12,36' width='"+w+"' height='"+h+"' align='middle'>"+
	"<param name='allowScriptAccess' value='always' />"+
	"<param name='movie' value='"+url+"' />"+
	"<param name='wmode' value='"+win+"' />"+	// wmode가 transparent로 지정되지 않으면 div tag보다 위에 위치하게 된다.
	"<param name='menu' value='false' />"+
	"<param name='quality' value='high' />"+
	"<param name='FlashVars' value='"+vars+"' />"+
	"<param name='bgcolor' value='"+bg+"' />"+
	"<param name='base' value='"+base+"' />"+
	"<embed src='"+url+"' FlashVars='" + vars + "' base='"+base+"' wmode='"+win+"' menu='false' quality='high' bgcolor='"+bg+"' width='"+w+"' height='"+h+"' align='middle' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />"+
	"</object>";
	document.write(s);
}


// flash(파일주소, 가로, 세로, 배경색, 윈도우모드, 변수, 경로)
function insertFlex(url,id){
	var s=
	"<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' id='" + id + "' width='660' height='350' codebase='http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab'>"+
	"<param name='movie' value='" + url + "' />"+
	"<param name='quality' value='high' />"+
	"<param name='bgcolor' value='#869ca7' />"+	// wmode가 transparent로 지정되지 않으면 div tag보다 위에 위치하게 된다.
	"<param name='allowScriptAccess' value='sameDomain' />"+
	"<embed src='" + url + "' quality='high' bgcolor='#869ca7' width='660' height='350' name='" + id + "' align='middle' play='true' loop='false' quality='high' allowScriptAccess='sameDomain' type='application/x-shockwave-flash' pluginspage='http://www.adobe.com/go/getflashplayer'>"+
	"</embed>"+
	"</object>";
	document.write(s);
}

function fileAttach(str1, str2, str3, str4, str5, str6)
{
	var address = "/include/fileattach/FileAttachPop.asp?uptype=" + str1 + "&uptext=" + str2 + "&folder=" + str3;
	address = address + "&flag=" + str4 + str5 + "&tcount=" + str6
	popwin(address, "filePop", 308, 218, "no");
}

function popwin(Address,name,w,h,scroll){

	var popwindow = null;	 
	var LeftPosition = (screen.width) ? (screen.width-w)/2:0;
	var TopPosition = (screen.height) ? (screen.height-h)/2:0;   
	var Settings = 'height='+ h +',width='+ w +',top='+ TopPosition +',left='+ LeftPosition +',scrollbars='+ scroll +',resizable=no'
	
	popwindow = window.open(Address,name,Settings);
	popwindow.focus();

}


function mapOver(n) {
	document.getElementById("map80").src="../../images/en/wow/cultured/wow_cultured_p80_map0"+n+".jpg";
}
function mapOut() {
	document.getElementById("map80").src="../../images/en/wow/cultured/wow_cultured_p80_map00.jpg";
}
//imgCh
function imgCh(n) {
	for(i = 1; i <= 3; i++){
		img_bigw = document.getElementById("imgb");
	if(i == n){
		img_bigw.src="../../images/en/wow/innovative/innovative01_box04_imgb0"+i+".jpg";

	}else{
		}
	}
}



con_num = 0;
function con_tab(n) {	
	id_check = document.getElementById("tab_con").getElementsByTagName("div");
	for(i = 0; i < id_check.length; i++){		
		if (id_check[i].id.indexOf("con_info") != -1)
		{			
			con_num = con_num+1;			
		}		
	}
	
	a_check = document.getElementById("tab_area").getElementsByTagName("img");	
	for(i = 0; i < a_check.length; i++){		
		if (i == n-1)
		{			
			a_check[i].src = a_check[i].src.replace("_on.gif", ".gif");
			a_check[i].src = a_check[i].src.replace(".gif", "_on.gif");
			a_check[i].onmouseover = "";
			a_check[i].onmouseout = "";
		}else{
			a_check[i].src = a_check[i].src.replace("_on.gif", ".gif");
			a_check[i].onmouseover = function()	{Over(this)};
			a_check[i].onmouseout = function()	{Out(this)};
		}
	}
	for(i = 0; i < con_num; i++){
		
		con_div = document.getElementById("con_info"+i);		
		
		if (i == n)		{
			con_div.style.display = "block";
		}else{
			con_div.style.display = "none"
		}
		
	}	
	
	con_num = 0;
}
function han_simg_chg(n) {	
	simg_num = document.getElementById("han_simg").getElementsByTagName("li");	
	for(i = 1; i <= simg_num.length; i++){		
		main_img = document.getElementById("han_main_img"+i);
		if (i == n)
		{			
			main_img.style.display = "block";
			simg_num[i-1].className = "on";
		}else{
			main_img.style.display = "none";
			simg_num[i-1].className = "";
		}
	}
}

function han03_chg() {	
	main_img = document.getElementById("han03_img");
	if (main_img.src.indexOf("han_con_03_01") != -1)
	{			
		main_img.src = "/images/en/wow/cultured/han_con_03_02.jpg";
	}else{
		main_img.src = "/images/en/wow/cultured/han_con_03_01.jpg";
	}
}
function typo_chg(n) {	
	for(i = 1; i <= 3; i++){
		
		con_div = document.getElementById("typo_con"+i);		
		
		if (i == n)		{
			con_div.style.display = "block";
		}else{
			con_div.style.display = "none"
		}
		
	}	
}

function tae_simg_chg(n) {	
	simg_num = document.getElementById("tae_simg").getElementsByTagName("li");	
	for(i = 1; i <= simg_num.length; i++){		
		main_img = document.getElementById("tae_main_img"+i);
		if (i == n)
		{			
			main_img.style.display = "block";
			simg_num[i-1].className = "on";
		}else{
			main_img.style.display = "none";
			simg_num[i-1].className = "";
		}
	}
}

function tae03_chg() {	
	main_img = document.getElementById("tae03_img");
	if (main_img.src.indexOf("tae_con_03_01") != -1)
	{			
		main_img.src = "/images/en/wow/cultured/han_con_03_02.jpg";
	}else{
		main_img.src = "/images/en/wow/cultured/han_con_03_01.jpg";
	}
}




