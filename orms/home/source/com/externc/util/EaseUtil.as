package com.externc.util
{
	import com.greensock.easing.*;
	
	/**
	 * ...
	 * @author Bongs
	 */
	public class EaseUtil 
	{
		private static const _easeList:Array = [{ name:"Back.easeOut", data:Back.easeOut }, 
												{ name:"Back.easeIn", data:Back.easeIn }, 
												{ name:"Back.easeInOut", data:Back.easeInOut }, 
												{ name:"Bounce.easeOut", data:Bounce.easeOut }, 
												{ name:"Bounce.easeIn", data:Bounce.easeIn }, 
												{ name:"Bounce.easeInOut", data:Bounce.easeInOut }, 
												{ name:"Circ.easeOut", data:Circ.easeOut }, 
												{ name:"Circ.easeIn", data:Circ.easeIn }, 
												{ name:"Circ.easeInOut", data:Circ.easeInOut }, 
												{ name:"Cubic.easeOut", data:Cubic.easeOut }, 
												{ name:"Cubic.easeIn", data:Cubic.easeIn }, 
												{ name:"Cubic.easeInOut", data:Cubic.easeInOut }, 
												{ name:"Elastic.easeOut", data:Elastic.easeOut }, 
												{ name:"Elastic.easeIn", data:Elastic.easeIn }, 
												{ name:"Elastic.easeInOut", data:Elastic.easeInOut }, 
												{ name:"Expo.easeOut", data:Expo.easeOut }, 
												{ name:"Expo.easeIn", data:Expo.easeIn }, 
												{ name:"Expo.easeInOut", data:Expo.easeInOut }, 
												{ name:"Linear.easeNone", data:Linear.easeNone }, 
												{ name:"Quad.easeOut", data:Quad.easeOut }, 
												{ name:"Quad.easeIn", data:Quad.easeIn }, 
												{ name:"Quad.easeInOut", data:Quad.easeInOut }, 
												{ name:"Quart.easeOut", data:Quart.easeOut }, 
												{ name:"Quart.easeIn", data:Quart.easeIn }, 
												{ name:"Quart.easeInOut", data:Quart.easeInOut }, 
												{ name:"Quint.easeOut", data:Quint.easeOut }, 
												{ name:"Quint.easeIn", data:Quint.easeIn }, 
												{ name:"Quint.easeInOut", data:Quint.easeInOut }, 
												{ name:"Sine.easeOut", data:Sine.easeOut }, 
												{ name:"Sine.easeIn", data:Sine.easeIn }, 
												{ name:"Sine.easeInOut", data:Sine.easeInOut } ];
												
		public function EaseUtil() 
		{
			
		}
		
		public static function getFunctionFromName(name:String):Function
		{
			var result:Function = null;
			for each(var item:Object in _easeList)
			{
				if (String(item.name).toUpperCase() == name.toUpperCase())
				{
					result = item.data;
					break;
				}
			}
			return result;
			
		}
		
	}
	
}