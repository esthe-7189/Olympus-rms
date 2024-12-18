package com.externc.util 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Bongs
	 */
	public class BitmapUtil 
	{
		
		
		public function BitmapUtil() 
		{
			
		}
		
		// 이미지에 프레임 추가
		public static function getImageFrame(source:Bitmap, width:Number, height:Number, padding:int=3, 
												frameColor:uint=0xFFFFFF, borderColor:uint=0x000000, borderThick:int=1):BitmapData
		{
			var shape:Sprite = new Sprite();
			if (borderThick > 0)
			{
				shape.graphics.lineStyle(borderThick, borderColor, 1, true, "normal", CapsStyle.NONE, JointStyle.MITER );	
				var pos:int = Math.floor(borderThick / 2);
				shape.graphics.drawRect(pos, pos, width-borderThick, height-borderThick);
			}

			if (source != null)
			{
				source.x = padding + borderThick;
				source.y = padding + borderThick;
				shape.addChild(source);
			}

			var bitmapData:BitmapData = new BitmapData(width, height, false, frameColor);
			bitmapData.draw(shape);
			return bitmapData;
		}
	
		// 비트맵 조각 구하기 
		public static function getSlicedBitmap(source:BitmapData, index:int, 
											sliceWidth:Number, sliceHeight:Number, 
											isFlipped:Boolean = false, isVertical:Boolean=true):Bitmap
		{	
			var bitmapData:BitmapData = new BitmapData(sliceWidth, sliceHeight);
			if(isFlipped)
			{
				var matrix:Matrix = new Matrix();
				matrix.translate(-sliceWidth, -sliceHeight/2);
				matrix.rotate(Math.PI);
				matrix.translate(sliceWidth * index, sliceHeight/2);
				bitmapData.draw(source, matrix);
			}
			else
			{
				if(isVertical)
					bitmapData.copyPixels(source, new Rectangle(sliceWidth * index, 0, sliceWidth, sliceHeight), new Point());
				else
					bitmapData.copyPixels(source, new Rectangle(0, sliceHeight* index, sliceWidth, sliceHeight), new Point());
			}
			return new Bitmap(bitmapData);
		}
		
		// 뒤집힌 비트맵 구하기
		public static function getFlipBitmap(source:BitmapData):Bitmap
		{
			var bitmapData:BitmapData = new BitmapData(source.width, source.height);
			var matrix:Matrix = new Matrix();
			matrix.translate(-source.width ,-source.height);
			matrix.rotate(Math.PI);
			bitmapData.draw(source, matrix);
			return new Bitmap(bitmapData);
		}
		
		
		// 반사 이미지에 드롭오프 효과 마스크 구하기 
		public static function getDropOff(width:Number, height:Number, alpha:Number=1, 
										  ratioBegin:Number=0, ratioEnd:Number=255, depth:Number=0) : DisplayObject
		{
			var shape:Sprite = new Sprite();
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( width, height, Math.PI/2 , 0 , 0 );
			shape.graphics.beginGradientFill(GradientType.LINEAR ,[0xFFFFFF, 0xFFFFFF], [0, alpha], [ratioBegin, ratioEnd], matrix);
			shape.graphics.drawRect( 0, 0, width, height);
			shape.graphics.endFill();
			
			if (depth > 0)
			{
				shape.graphics.beginFill( 0xFFFFFF);
				shape.graphics.drawRect( 0, height, width, depth);
				shape.graphics.endFill();
			}
			
			shape.cacheAsBitmap = true;	
			return shape;
		}
		
		// 반사 이미지 추가
		public static function getReflection(source:DisplayObject, height:Number=-1, alpha:Number=0.5, 
											 ratioBegin:Number=0, ratioEnd:Number=255, distance:Number=0) : Bitmap
        {
            if (height < 0)
                height = source.height * 0.3;
			var shape:Sprite = new Sprite();
			// 이미지 복사
			var matrix:Matrix = new Matrix();
            matrix.translate(0, height - source.height);
			var reflectionData:BitmapData = new BitmapData(source.width, height, true, 0);
            reflectionData.draw(source, matrix);
			var reflectionBitmap:Bitmap = new Bitmap(reflectionData);
			reflectionBitmap.cacheAsBitmap = true;
			shape.addChild(reflectionBitmap);
			var mask:DisplayObject = getDropOff(reflectionBitmap.width, reflectionBitmap.height, alpha, ratioBegin, ratioEnd);
			shape.addChild(mask);
			reflectionBitmap.mask = mask;
			reflectionBitmap.scaleY = -1;
			reflectionBitmap.y = height;
			mask.y = height;
			mask.scaleY = -1;
			return convertToBitmap(shape);
        }
		
		// 디스플레이 객체를 비트맵으로 변환
		public static function convertToBitmap(displayObejct:DisplayObject) : Bitmap
		{
			var rect:Rectangle = displayObejct.getBounds(displayObejct);
			var bitmapData:BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			bitmapData.draw(displayObejct);
			var bitmap:Bitmap = new Bitmap(bitmapData, "auto", true);
			return bitmap;
		}
		
		//
		public static function createEmptyBitmap(width:Number, height:Number, color:uint=0xFFFFFF):Bitmap
		{
			var shape:Sprite = new Sprite();
			shape.graphics.beginFill(color);
			shape.graphics.drawRect( 0, 0, width, height);
			shape.graphics.endFill();
			return convertToBitmap(shape);
		}
	}
	

	
	
}