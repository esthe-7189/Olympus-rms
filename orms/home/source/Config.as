package  
{

	/**
	 * ...
	 * @author Bongs
	 */
	public class Config 
	{
		// 큐브
		public var CUBE_WIDTH:Number;
		public var CUBE_HEIGHT:Number;
		public var CUBE_COLOR:String = "";
		
		// 배경
		public var BACKGROUND_URL:String = "";
		public var BACKGROUND_COLOR:String = "";
		
		// 슬라이드
		public var AUTOSLIDE_USE:String = "";		
		public var AUTOSLIDE_INTERVAL:Number;				
		
		// 트윈
		public var TWEEN_DIRECTTION:String = "HORIZONTAL";	
		public var TWEEN_DURATION:Number;
		public var TWEEN_EASE:String = "";
		public var TWEEN_INTRO_USE:String = "";
		public var TWEEN_OVERLAP_USE:String = "";
		
		// 반사 
		public var REFLECTION_USE:String = "";
		public var REFLECTION_ALPHA:Number;
		public var REFLECTION_RATIO:Number;
		
		// 프레임
		public var FRAME_USE:String = "";
		public var FRAME_PADDING:Number;
		public var FRAME_COLOR:String = "";
		public var FRAME_BORDER_COLOR:String = "";
		public var FRAME_BORDER_THICK:Number;
		
		// 버튼 
		public var BUTTON_USE:String = "";
		
		public var BUTTON_PREV_URL:String = "";
		public var BUTTON_PREV_OVER_URL:String = "";
		public var BUTTON_PREV_DOWN_URL:String = "";
		public var BUTTON_PREV_LEFT:Number;
		public var BUTTON_PREV_TOP:Number;
		
		public var BUTTON_NEXT_URL:String = "";
		public var BUTTON_NEXT_OVER_URL:String = "";
		public var BUTTON_NEXT_DOWN_URL:String = "";
		public var BUTTON_NEXT_LEFT:Number;
		public var BUTTON_NEXT_TOP:Number;
		
		// 링크
		public var LINK_USE:String = "";
		public var LINK_HANDCURSOR_USE:String = "";
		public var LINK_CLICK_HANDLER:String = "";
			
		public function Config(config:Object) 
		{
			for (var name:String in config)
			{
				try
				{
					if(config[name] != "")
						this[name] = config[name];
				}catch(e:*){}
			}
		}

	}
	
}