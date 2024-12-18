package  
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;

	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.events.InteractiveScene3DEvent;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.*;

	import com.hydrotik.queueloader.QueueLoaderEvent;
		
	import com.externc.view.BaseReflectionView
	import com.externc.controls.button.*;
	import com.externc.util.*;
	
	/**
	 * ...
	 * @author Bongs
	 */
	public class RotateCubeView extends BaseReflectionView
	{	
		private var _cube:Cube;
		private var _cubeWidth:int;
		private var _cubeHeight:int;
		private var _cubeDepth:int;
		private var _container: DisplayObject3D;		
		private var _face:Number = 0;
		private var _faceList:Array;
		private var _rotation:Number = 0;
		private var _easeFunction:Function;

		public function RotateCubeView(xmlURL:Object, width:int, height:int) 
		{
			var url:String = "RotateCube.xml";
			if ( xmlURL != null)
				url = xmlURL.toString();
			
			super(url, width, height);
		}
		
		// 설정파일 읽은 후 초기화
		override protected function init():void
		{
			super.init();
				
			// 가속함수 설정
			_easeFunction = EaseUtil.getFunctionFromName(_config.TWEEN_EASE);
		}
		
		// 설정파일 읽은 후 3D 초기화
		override protected function init3D():void
		{
			super.init3D();
			
			// 크기 설정
			_cubeWidth = _config.CUBE_WIDTH;
			_cubeHeight = _config.CUBE_HEIGHT;
			if (_config.FRAME_USE == "TRUE")
			{
				_cubeWidth += (_config.FRAME_PADDING + _config.FRAME_BORDER_THICK) * 2; 
				_cubeHeight += (_config.FRAME_PADDING + _config.FRAME_BORDER_THICK) * 2;
			}	
			
			// 표면 순서, 깊이
			if (_config.TWEEN_DIRECTTION.toUpperCase() == "VERTICAL")
			{
				_faceList = ["back", "bottom", "front", "top"];
				_cubeDepth = _cubeHeight;
			}
			else
			{
				_faceList = ["back", "right", "front", "left"];
				_cubeDepth = _cubeWidth;
			}
			
			// camera setup
			camera.z -= (_cubeDepth / 2);
		
			//reflection
			if (_config.REFLECTION_USE == "TRUE") 
			{
				surfaceHeight = -_cubeHeight;
				var alpha:Number = 1 - (_config.REFLECTION_ALPHA / 100);
				var ratio:Number = 255 - (_config.REFLECTION_RATIO * 25.5);
				var mask:DisplayObject = BitmapUtil.getDropOff(_width, (_height - _cubeHeight) / 2, 1, ratio, 255, _cubeHeight / 2);
				mask.alpha = alpha;
				viewportReflection.cacheAsBitmap = true;
				viewportReflection.addChild(mask);
				viewportReflection.mask = mask;
			}

		}
		
		// 오브젝트 생성 
		override protected function createObject():void
		{
			createCube();	
			super.createObject();
		}

		// 큐브 생성
		private function createCube():void
		{
			// container
			_container = new DisplayObject3D();
			_container.visible = false;
			
			// createMaterial
			var materialsList:MaterialsList = new MaterialsList();
			var colorCube:uint = 0xFFFFFF;
			if(_config.CUBE_COLOR != "")
				colorCube = parseInt(_config.CUBE_COLOR, 16);

			materialsList.addMaterial(new ColorMaterial(colorCube), "back");
			materialsList.addMaterial(new ColorMaterial(colorCube), "bottom");
			materialsList.addMaterial(new ColorMaterial(colorCube), "front");
			materialsList.addMaterial(new ColorMaterial(colorCube), "top");
			materialsList.addMaterial(new ColorMaterial(colorCube), "left");
			materialsList.addMaterial(new ColorMaterial(colorCube), "right");
			
			// createCube
			_cube = new Cube(materialsList, _cubeWidth, _cubeDepth, _cubeHeight);
			_cube.x = 0;
			_container.addChild(_cube);
			scene.addChild(_container);
			
			_cube.addEventListener(InteractiveScene3DEvent.OBJECT_PRESS, onCubeClick);		
		}
		
		// 이미지 붙이기
		private function attachImage(index:int, content:Bitmap):void
		{
			var faceIndex:int = (_rotation / 90) % 4;
			if (faceIndex < 0)
				faceIndex += 4;
				
			var isFlipped:Boolean = (faceIndex % 2)? true : false;
			if (faceIndex > 1) isFlipped = !isFlipped;
			
			if (_config.TWEEN_DIRECTTION.toUpperCase() != "VERTICAL")
				isFlipped = false;
			
			var faceName:String = _faceList[faceIndex];
			var bitmapData:BitmapData;
			if(_config.FRAME_USE == "TRUE")
				bitmapData =  BitmapUtil.getImageFrame(content, _cubeWidth, _cubeHeight, 
																							_config.FRAME_PADDING, 
																							parseInt(_config.FRAME_COLOR, 16), 
																							parseInt(_config.FRAME_BORDER_COLOR, 16),
																							_config.FRAME_BORDER_THICK);
			else
				bitmapData = content.bitmapData;
				
			var bitmap:Bitmap;
			if (isFlipped)
				bitmap = BitmapUtil.getFlipBitmap(bitmapData);		
			else
				bitmap = new Bitmap(bitmapData);		
				
			var material:BitmapMaterial = new BitmapMaterial(bitmap.bitmapData, true);
			material.smooth = true;
			material.tiled = true;
			material.interactive = true;
			material.name = index.toString();
			_cube.replaceMaterialByName(material, faceName);
		}
		
		// 큐로더 완료 
		override protected function onQueueComplete(event:QueueLoaderEvent):void 
		{
			super.onQueueComplete(event);
			if(_loaded == _index)
				attachImage(_loaded, event.content);
			
			if (_isStart == false)
			{
				_isStart = true;
				showObject();
			}
		}
		
		// 큐로더 에러
		override protected function onQueueError(event:QueueLoaderEvent):void {
				super.onQueueError(event);
				if(_loaded == _index)
						attachImage(_loaded, null);
		}
		
		// 시작
		override protected function showObject():void 
		{
			_container.visible = true;
			
			if (_config.TWEEN_INTRO_USE == "TRUE")
			{
				_cube.y = ((_height/2) + _cubeHeight/2);
				TweenMax.to(_cube, 1.5, { y:0, ease:Bounce.easeOut } );
			}
			super.showObject();
		}
		
		// 큐브 클릭 핸들러
		private function onCubeClick(event:InteractiveScene3DEvent):void
		{	
				if (!_isStart) return;
			
				var info:Object = getSafeItem(event.face3d.material.name);
				if (info != null)
				{			
						var link:String = (info.LINK == undefined)? "" : info.LINK;
						var isPopup:Boolean = ((info.POPUP == undefined)? "" : String(info.POPUP).toUpperCase()) == "TRUE"? true:false;							
						if (_config.LINK_USE == "TRUE")
						{
							URLUtil.moveToURL(link, isPopup);
						}
						else
						{
								if (_config.LINK_CLICK_HANDLER != "")
								{
									if (Capabilities.playerType != "StandAlone")
									{
										info.INDEX = parseInt(event.face3d.material.name) + 1;
										ExternalInterface.call(_config.LINK_CLICK_HANDLER,  link);
									}
								}
						}
				}
				
		}
			
		// 버튼 클릭 핸들러
		override protected function onButtonClick(event:MouseEvent):void 
		{
			if (!_isStart) return;
			
			if (_slideTimer != null)
			{
				_slideTimer.stop();
				_slideTimer.reset();
				_slideTimer.start();
			}
			
			if (_config.TWEEN_OVERLAP_USE != "TRUE")
			{
				if (TweenMax.isTweening(_cube) == true)
						return;
			}
			
			if (event.target.name == "next")
				moveNext();
			else
				movePrev();
		}
		
		// 다음으로 이동
		private function moveNext():void
		{	
			_index++;
			if (_index == _items.length)
				_index = 0;
			_rotation += 90 % 360;
		
			if (_loaded >= _index) 
			{
				var content:Bitmap = _qLoader.getItemAt(_index).content;
				attachImage(_index, content);
			}
		
			doTween();
		}
		
		// 이전으로 이동
		private function movePrev():void
		{	
			_index--;
			if (_index < 0)
				_index += _items.length;
				
			_rotation -= 90 % 360;
			
			if (_loaded >= _index) 
			{
				var content:Bitmap = _qLoader.getItemAt(_index).content;
				attachImage(_index, content);
			}		
			
			doTween();
		}
		
		// 트윈 실행
		private function doTween():void
		{
			var time:Number = _config.TWEEN_DURATION;		
			if (_config.TWEEN_DIRECTTION.toUpperCase() == "VERTICAL")
				TweenMax.to(_cube, time, { rotationX:_rotation, ease:_easeFunction } );
			else
				TweenMax.to(_cube, time, { rotationY:_rotation, ease:_easeFunction } );
		}

		// 타이머 핸들러
		override protected function onSlideTimer(event:TimerEvent):void
		{
			if (TweenMax.isTweening(_cube) == false)
				moveNext();
		}
		
	}
	
}