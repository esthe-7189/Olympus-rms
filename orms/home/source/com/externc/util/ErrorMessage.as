package com.externc.util
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Bongs
	 */
	public class ErrorMessage 
	{
		
		public function ErrorMessage() 
		{
		}
		
		public static function show(owner:DisplayObjectContainer, text:String):void 
		{
			var tf:TextField = new TextField();
			tf.multiline = true;
			tf.background = true;
			tf.text = text;
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.border = true;		
			tf.x = (owner.stage.stageWidth - tf.width) / 2;
			tf.y = (owner.stage.stageHeight - tf.height) / 2;
			owner.addChild(tf);
		}		
	}
	
}