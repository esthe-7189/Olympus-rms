var myDrag = new Drag("draggable","dragelement","dragarea","dragdirection","scalepercent"); 
//퀵쇼퍼 레이어 
function FuncQuickToggle(code) { 
var evntType = event.type; 
var quickMenu = document.getElementById('Shopper'+code); 

		if('mouseenter' == evntType) {
			if('hidden' == quickMenu.style.visibility) { 
			quickMenu.style.visibility = 'visible'; 
			} 
		} else if('mouseleave' == evntType) { 
			if('visible' == quickMenu.style.visibility) { 
			quickMenu.style.visibility = 'hidden'; 
			}
		}  
} 


//퀵쇼퍼 오버버튼 
function FuncCartImg(obj, cate){ var oImg = document.getElementById(obj); 
switch(cate){ 
	case '0': oImg.src = '/orms/rms/image/admin/BtnQuickView.gif'; 
	break; 
	case '1': oImg.src = '/orms/rms/image/admin/BtnQuickView01.gif';  //1번 롤오버시 변한 이미지 
	break; 
	case '2': oImg.src = '/orms/rms/image/admin/BtnQuickView02.gif';  //2번 롤오버시 변한 이미지 
	break; 
//	case '3': oImg.src = '/rms/image/admin/BtnQuickView02.gif';  //3번 롤오버시 변한 이미지 
//	break; 
	default : break; 
	} 
} 
//퀵 Popup : STR 
function FuncQuickPopup(yVal,mVal,dVal,pg,monthVal,yearVal){ 	
	var iBody1 = document.getElementById('wPop'); 
	var iBody2 = document.getElementById('cPop'); 
	var pBody = document.getElementById('qPop'); 
	var pMain = document.getElementById('qMain');
	var dValue="";

if(dVal.length==1){
	dValue="0"+dVal;
}else{
	dValue=dVal;
}
		if('block' == iBody1.style.display){ 
			iBody1.style.display = 'none'; 
			} 
		if('block' == iBody2.style.display){ 
			iBody2.style.display = 'none'; 
			}
		if('block' == pBody.style.display){ 
			pBody.style.display = 'none'; 
			}	
		pMain.src = '/orms/rms/admin/schedule/ZoomDetailPopup.jsp?yVal='+yVal+'&mVal='+mVal+'&dVal='+dValue+'&pg='+pg+'&monthVal='+monthVal+'&yearVal='+yearVal; 
		pBody.style.display = 'block'; pBody.style.left = ((document.body.offsetWidth / 2) - (710 / 2)) + 'px'; 
		pBody.style.top = (((document.body.offsetHeight / 2) - (545 / 2)) + document.body.scrollTop) + 'px'; 
	

} 


function FuncDetailPopup(ymdList,pg){ 	
	var iBody1 = document.getElementById('wPop'); 
	var iBody2 = document.getElementById('cPop'); 
	var pBody = document.getElementById('qPop'); 
	var pMain = document.getElementById('qMain');

	if('block' == iBody1.style.display){ 
		iBody1.style.display = 'none'; 
		} 
	if('block' == iBody2.style.display){ 
		iBody2.style.display = 'none';
		} 
	if('block' == pBody.style.display){ 
		pBody.style.display = 'none'; 
		}
	pMain.src = '/orms/rms/admin/schedule/ContentDetailPopup.jsp?ymdList='+ymdList+'&pg='+pg; 
	pBody.style.display = 'block'; pBody.style.left = ((document.body.offsetWidth / 2) - (710 / 2)) + 'px'; 
		pBody.style.top = (((document.body.offsetHeight / 2) - (545 / 2)) + document.body.scrollTop) + 'px'; 
} 
function FuncDetailPopupSeq(ymdList,seq,pg,monthVal,yearVal){ 	
	var iBody1 = document.getElementById('wPop'); 
	var iBody2 = document.getElementById('cPop'); 
	var pBody = document.getElementById('qPop'); 
	var pMain = document.getElementById('qMain');

	if('block' == iBody1.style.display){ 
		iBody1.style.display = 'none'; 
		} 
	if('block' == iBody2.style.display){ 
		iBody2.style.display = 'none';
		} 
	if('block' == pBody.style.display){ 
		pBody.style.display = 'none'; 
		}
	pMain.src = '/orms/rms/admin/schedule/ContentDetailSeqPopup.jsp?ymdList='+ymdList+'&seq='+seq+'&pg='+pg+'&monthVal='+monthVal+'&yearVal='+yearVal; 
	pBody.style.display = 'block'; pBody.style.left = ((document.body.offsetWidth / 2) - (710 / 2)) + 'px'; 
		pBody.style.top = (((document.body.offsetHeight / 2) - (545 / 2)) + document.body.scrollTop) + 'px'; 
} 
/*
function FuncListCartPopup(code, prstcd, colorcd, prdNm) {
	var iBody1 = document.getElementById('qPop'); 
	var iBody2 = document.getElementById('wPop'); 
	var pBody = document.getElementById('cPop'); 
	var pMain = document.getElementById('cMain'); 
	var tBody = document.getElementById('listtypec'+code); 
	if('block' == iBody1.style.display){ iBody1.style.display = 'none'; }
	if('block' == iBody2.style.display){ iBody2.style.display = 'none'; } 
	if('block' == pBody.style.display){ pBody.style.display = 'none'; }
	
	pMain.src = '../admin/schedule/detailPopup.jsp?PrstCd='+prstcd + "&ColorCd=" + colorcd + "&PrdNm=" + prdNm + ""; 
	pBody.style.display = 'block'; 
	pBody.style.left = (parseInt(getPosition(tBody).left) + -1) +'px'; 
	pBody.style.top = (parseInt(getPosition(tBody).top) + 22) +'px'; 
	_nowCate = code; 
} 

*/