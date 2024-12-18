
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


//quick_top
function initMoving(target, position, topLimit, btmLimit) {
	if (!target)
		return false;

	var obj = target;
	obj.initTop = position;
	obj.topLimit = topLimit;
	obj.bottomLimit = document.documentElement.scrollHeight - btmLimit;

	obj.style.position = "absolute";
	obj.style.zIndex= "10";
	obj.top = obj.initTop;
	obj.left = obj.initLeft;

	if (typeof(window.pageYOffset) == "number") {
		obj.getTop = function() {
			return window.pageYOffset;
		}
	} else if (typeof(document.documentElement.scrollTop) == "number") {
		obj.getTop = function() {
			return document.documentElement.scrollTop;
		}
	} else {
		obj.getTop = function() {
			return 0;
		}
	}

	if (self.innerHeight) {
		obj.getHeight = function() {
			return self.innerHeight;
		}
	} else if(document.documentElement.clientHeight) {
		obj.getHeight = function() {
			return document.documentElement.clientHeight;
		}
	} else {
		obj.getHeight = function() {
			return 1000;
		}
	}

	obj.move = setInterval(function() {
		if (obj.initTop > 0) {
			pos = obj.getTop() + obj.initTop;
		} else {
			pos = obj.getTop() + obj.getHeight() + obj.initTop;
			//pos = obj.getTop() + obj.getHeight() / 2 - 15;
		}

		if (pos > obj.bottomLimit)
			pos = obj.bottomLimit;
		if (pos < obj.topLimit)
			pos = obj.topLimit;

		interval = obj.top - pos;
		obj.top = obj.top - interval / 3;
		obj.style.top = obj.top + "px";
	}, 30)
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

function tabOver(tabName){	
	tabName = tabName.className = "on";
}
function tabOut(tabName){
	tabName = tabName.className = "";
}

function layer_events()
{
  if (document.layers) {
    document.layers['gnb_area'].captureEvents(Event.MOUSEOVER|Event.MOUSEOUT|Event.MOUSEUP);
    document.layers['gnb_area'].onmouseout = new Function("this.style.height='115'");
    document.layers['gnb_area'].onmouseover = new Function("this.style.height='260'");
  }
}
link_num = 0;
function link_open(n) {
	for(i = 0; i < document.getElementById("link_table").getElementsByTagName("tr").length; i++){		
		if (document.getElementById("link_table").getElementsByTagName("tr")[i].className == "none")
		{
			link_num = link_num+1;
		}
		
	}
	for(i = 1; i <= link_num; i++){		
		trname = document.getElementById("link"+i)			
		if (i == n)
		{
			if (trname.style.display == "")
			{
				trname.style.display = "block"
			}else{
				trname.style.display = ""
			}
		}		
	}
	
	
	
}

function gnb_size(n) {
	if (n == "1")
	{
		document.getElementById("gnb").style.height = "250px";
		document.getElementById("gnb_swf").style.height = "250px";
	}else{
		document.getElementById("gnb").style.height = "76px";
		document.getElementById("gnb_swf").style.height = "76px";
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
	"<embed src='"+swfUrl+"' FlashVars='"+flashVars+"'  quality='best' bgcolor='#EEF8FF' width='"+swfWidth+"' height='"+swfHeight+"' name='"+swfName+"' align='middle' allowFullScreen='false' allowScriptAccess='always' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />"+
	"</object>";

	// 플래시 코드 출력
	document.write(flashStr);
};
