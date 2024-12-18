package  com.externc.view
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import org.papervision3d.core.effects.view.ReflectionView;
	
	import com.hydrotik.queueloader.QueueLoader;
	import com.hydrotik.queueloader.QueueLoaderEvent;
	
	import com.externc.util.XMLParser;
	import com.externc.util.ErrorMessage;
	import com.externc.controls.button.BaseImageButton;
	
	/**
	 * ...
	 * @author Bongs
	 */
	public class BaseReflectionView extends ReflectionView
	{
		protected var _qLoader:QueueLoader;
		protected var _config:Config;	
		protected var _items:Array;
		protected var _loaded:int = 0;
		protected var _index:int = 0;
		protected var _slideTimer:Timer;
		protected var _isStart:Boolean;
		
		public function BaseReflectionView(url:String, width:int, height:int) 
		{
			super(width, height, false, true);
			_width = width;
			_height = height;	
			
			preInit();
			loadXML(url);
		}
		
		// 초기화
		protected function preInit():void
		{
			_qLoader = new QueueLoader(true);
			_qLoader.addEventListener(QueueLoaderEvent.ITEM_ERROR, onQueueError, false, 0, true);
			_qLoader.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, onQueueComplete, false, 0, true);
			_qLoader.addEventListener(QueueLoaderEvent.QUEUE_COMPLETE, onQueueAllComplete, false, 0, true);
			
		}
		
		// XML 로딩 
		protected function loadXML(url:String):void 
		{
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(url);
			loader.addEventListener(Event.COMPLETE, onXMLComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onXMLError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onXMLSecurityError);
			loader.load(request);
		}
	
		// XML 로딩 완료
		protected function onXMLComplete(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var xml:XML;
			try
			{
				xml = new XML(loader.data);
			}
			catch (e:TypeError)
			{
				ErrorMessage.show(this, "XML 파일 분석에 실패하였습니다.\n" + e.message);
				return;
            }
			
			var parser:XMLParser = new XMLParser(xml);
			_config = new Config(parser.getConfig());
			_items = parser.getItems();
			
			init();
			init3D();
			createBackground();
		}
		
		// 배경 생성
		protected function createBackground():void
		{
			if (_config.BACKGROUND_COLOR == "" && _config.BACKGROUND_URL == "") 
			{
				createObject();
				return;
			}
			
			var background:Sprite = new Sprite();
			parent.addChildAt(background, parent.numChildren - 1);

			if (_config.BACKGROUND_COLOR != "")
			{
				background.graphics.beginFill(parseInt(_config.BACKGROUND_COLOR, 16));
				background.graphics.drawRect(0, 0, _width, _height);
				background.graphics.endFill();
			}
				
			// 배경 이미지
			if (_config.BACKGROUND_URL != "")
			{
				var qBGLoader:QueueLoader = new QueueLoader(true);
				qBGLoader.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, onBGComplete, false, 0, true);
				qBGLoader.addItem(_config.BACKGROUND_URL, background);
				qBGLoader.execute();
			}
			else
			{
				createObject();
			}
		}
		
		private function onBGComplete(event:QueueLoaderEvent):void {
			createObject();
		}
		
		// 오브젝트 생성
		protected function createObject():void 
		{
			createButton();
			for each(var item:Object in _items)
			{
				if(item.SRC != undefined)
					_qLoader.addItem(item.SRC, null);
			}
			try{
				_qLoader.execute();
			}catch (e:*) { 
				ErrorMessage.show(this, "XML 파일에 등록된 아이템이 하나도 없습니다." );
				return;
			}
			
			addEventListener(Event.ENTER_FRAME, onRender); 
		}
		
		// 버튼 생성
		protected function createButton():void
		{
			if (_config.BUTTON_USE == "TRUE")
			{				
				var prevButton:BaseImageButton = new BaseImageButton(_config.BUTTON_PREV_URL, 
																														 _config.BUTTON_PREV_OVER_URL, 
																														 _config.BUTTON_PREV_DOWN_URL);
				prevButton.name = "prev";
				if (_config.BUTTON_PREV_LEFT == -1 )
				{
					prevButton.x = _width / 2;
					prevButton.isHorizontalCenter = true;
				}
				else
				{
					prevButton.x = _config.BUTTON_PREV_LEFT;
				}
				if (_config.BUTTON_PREV_TOP == -1 )
				{
					prevButton.y = _height / 2;
					prevButton.isVerticalCenter = true;
				}
				else
				{
					prevButton.y = _config.BUTTON_PREV_TOP;
				}			
				prevButton.addEventListener(MouseEvent.CLICK, onButtonClick);
				prevButton.visible = false;
				parent.addChild(prevButton);
				
				var nextButton:BaseImageButton = new BaseImageButton(_config.BUTTON_NEXT_URL,
																														 _config.BUTTON_NEXT_OVER_URL, 
																														 _config.BUTTON_NEXT_DOWN_URL);
				nextButton.name = "next";
				if (_config.BUTTON_NEXT_LEFT == -1 )
				{
					nextButton.x = _width / 2;
					nextButton.isHorizontalCenter = true;
				}
				else
				{
					nextButton.x = _config.BUTTON_NEXT_LEFT;
				}
				if (_config.BUTTON_NEXT_TOP == -1 )
				{
					nextButton.y = _height / 2;
					nextButton.isVerticalCenter = true;
				}
				else
				{
					nextButton.y = _config.BUTTON_NEXT_TOP;
				}	
				nextButton.addEventListener(MouseEvent.CLICK, onButtonClick);
				nextButton.visible = false;
				parent.addChild(nextButton);	
			}
		}
		
		// 버튼 클릭 핸들러
		protected  function onButtonClick(event:MouseEvent):void 
		{
			
		}
		
		// 초기화
		protected function init():void 
		{
		}
		
		// 3D 초기화
		protected function init3D():void 
		{
			opaqueBackground = null;
			camera.focus = 100;
			camera.zoom = 10;
			camera.z = -1000;
			camera.ortho = false;	
			viewport.interactive = true;
			if (_config.LINK_HANDCURSOR_USE == "TRUE")
				viewport.buttonMode = true;
			
		}
		
		// 안전한 아이템 구하기
		protected function getSafeItem(name:String):Object 
		{
			var info:Object = null;
			try
			{
				var index:int = parseInt(name);
				info = _items[index];
			}
			catch (e:*) 
			{ 
				return null;
			}
			return info;
		}
		
		// XML IO 에러
		protected function onXMLError(event:IOErrorEvent):void 
		{ 
			ErrorMessage.show(this, "XML 파일 로딩에 실패하였습니다.\n" + event.text);
		}
		
		// XML 보안 에러
		protected function onXMLSecurityError(event:SecurityErrorEvent):void 
		{ 
			ErrorMessage.show(this, "XML 파일을 읽을 수 있는 권한이 없습니다.\n" + event.text);
		}

		// 큐로더 완료 
		protected function onQueueComplete(event:QueueLoaderEvent):void {
			_loaded = event.index;
		}
		
		// 첫번째 이미지가 로딩됐으면 슬라이드 시작
		protected function showObject():void {
			if (_config.AUTOSLIDE_USE == "TRUE")
			{
				var delay:Number = (_config.AUTOSLIDE_INTERVAL < 1)? 3 * 1000: _config.AUTOSLIDE_INTERVAL * 1000;
				delay += _config.TWEEN_DURATION * 1000;
				_slideTimer = new Timer(delay);
				_slideTimer.addEventListener(TimerEvent.TIMER, onSlideTimer);
				_slideTimer.start();
			}
		}
		
		// 큐로더 전체 완료
		protected function onQueueAllComplete(event:QueueLoaderEvent):void { 
			//trace("onQueueAllComplete ");
		}
		
		// 큐로더 에러
		protected function onQueueError(event:QueueLoaderEvent):void {
			_loaded = event.index;
			trace("onQueueError: " + event.message);
		}
		
		// 엔터프레임 핸들러 
		protected function onRender(event:Event):void
		{
			singleRender(); 
		}
		
		// 타이머 핸들러
		protected function onSlideTimer(event:TimerEvent):void
		{
		}
	}
	
}