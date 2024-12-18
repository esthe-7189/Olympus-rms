package com.externc.util
{
	
	/**
	 * ...
	 * @author Bongs
	 */
	public class XMLParser 
	{
		
		private var _config:Object;
		private var _items:Array;
		
		private var _errorMessage:String;
		
		public function XMLParser(xml:XML) 
		{
			_config = new Object();
			_items = new Array();
			
			parseConfig(xml.CONFIG);
			parseItems(xml.ITEMS);
		}
		
		private function parseConfig(list:XMLList):Boolean
		{
			for each (var item:XML in list.elements())
			{
				var name:String;	
				var value:String;
				
				for each (var attr:XML in item.attributes())
				{
					if (attr.name().toString().toUpperCase() == "VALUE")
					{
						name = attr.name();
						break;
					}
				}
				value = item.attribute(name).toString();
					
				if(value.toUpperCase() == "FALSE" )
				{
					value = "";
				}
				else if(value.toUpperCase() == "TRUE")
				{
					value = "TRUE";
				}
				_config[item.name().toString().toUpperCase()] = value;
			}
			return true;
		}
		
		private function parseItems(list:XMLList):Boolean
		{
			for each (var item:XML in list.elements())
			{
				var obj:Object = convertXMLToObject(item);
				if(obj != null)
					_items.push(obj);
			}
			return true;
		}
		
		private function convertXMLToObject(xml:XML):Object
		{
			var obj:Object = new Object();
			for each(var item:XML in xml.attributes())
			{	
				var name:String = item.name();
				obj[name.toUpperCase()] = item.toString();
			}
			
			if(obj["SRC"] == undefined)
				return null;
			
			return obj;
		}
		
		public function getConfig():Object
		{
			return _config;
		}
		
		public function getItems():Array
		{
			return _items;
		}
	}
	
}