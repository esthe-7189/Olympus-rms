package com.externc.controls.button 
{
	import com.greensock.TweenMax;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	/**
	 * ...
	 * @author Bongs
	 */
	
	public class GlowImageButton extends BaseImageButton
	{
		
		private var _color:uint = 0xFFFFFF;
		private var _alpha:Number = 1.0;
		private var _blurX:Number = 6;
		private var _blurY:Number = 6;
		private var _strength:Number = 2;
		private var _duration:Number = 0.5;
		public function GlowImageButton(upURL:String, overURL:String = "", downURL:String = "",
										color:uint = 0xFFFFFF, alpha:Number = 1.0, 
										blurX:Number=6, blurY:Number=6, strength:Number=2, duration:Number=0.5) 
		{
			
			super(upURL, overURL, downURL);
			
			_color = color;
			_alpha = alpha;
			_blurX = blurX;
			_blurY = blurY;
			_strength = strength;
			_duration = duration;
			
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseHandler);
		}
		
		private function onMouseHandler(event:MouseEvent):void 
		{		
			switch(event.type) 
			{
				case MouseEvent.MOUSE_OVER:
					TweenMax.to(this, _duration, {glowFilter:{color:_color, alpha:_alpha, blurX:_blurX, blurY:_blurY, strength:_strength} });
				break;
				case MouseEvent.MOUSE_OUT:
					TweenMax.killTweensOf(this);
					this.filters = null;
				break;
				default:
			}
			
		}
		
		
	}
	
}