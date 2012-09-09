package com.asbox.net.providers
{
	import com.asbox.net.NetConfig;
	import com.asbox.net.providers.interfaces.INetProvider;
	import com.asbox.net.responder.BaseResponder;
	import com.asbox.utils.XMLToObject;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	
	public class XMLProvider extends BaseUrlLoaderProvider
	{
		
		public function XMLProvider(options:NetConfig)
		{
			super(options)
		}
		
		override protected function onCompleteLoad(event:Event):void
		{
			XML.ignoreWhitespace = true; 
			var resultObject:Object = XMLToObject.Parse(new XML(_urlloader.data));
			
			if(resultObject)
				_responder.onResult(resultObject);
		}
		
		override protected function onSecurityError(event:SecurityErrorEvent):void
		{
			XML.ignoreWhitespace = true;
			var resultObject:Object = XMLToObject.Parse(new XML(_urlloader.data));			
			_responder.onStatus(resultObject);
		}
		
		override protected function onIoError(event:IOErrorEvent):void
		{
			XML.ignoreWhitespace = true;
			var resultObject:Object = XMLToObject.Parse(new XML(_urlloader.data));			
			_responder.onStatus(resultObject);
		}
	}
}