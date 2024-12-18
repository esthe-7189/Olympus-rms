package  com.externc.util
{
	
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author Bongs
	 */
	public class URLUtil 
	{
		
		public function URLUtil() 
		{
			
		}
		
		public static function moveToURL(url:String, isPopup:Boolean=false):void
		{   
			if (Capabilities.playerType != "StandAlone")
			{
				var request:URLRequest = new URLRequest(url);  
				if(isPopup)
				{
					var isIE:Boolean = Boolean(ExternalInterface.call("function() {if(document.all) return 1; else return 0;}"));     
					if (isIE) 
						ExternalInterface.call("window.open", request.url); 
					else 
						navigateToURL(request, "_blank"); 
				}
				else
				{
					navigateToURL(request, "_self"); 
				}
			}
		}
		
	}
	
}