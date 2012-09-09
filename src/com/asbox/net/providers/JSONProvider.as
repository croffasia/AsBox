package com.asbox.net.providers
{
	import com.asbox.net.NetConfig;
	import com.asbox.net.responder.BaseResponder;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	
	public class JSONProvider extends BaseUrlLoaderProvider
	{
		public function JSONProvider(options:NetConfig)
		{
			super(options);
		}
	
		override protected function onCompleteLoad(event:Event):void
		{
			var resultObject:Object = JSON.parse(_urlloader.data);
			
			if(resultObject)
				_responder.onResult(resultObject);
		}
		
		override protected function onSecurityError(event:SecurityErrorEvent):void
		{
			var resultObject:Object = JSON.parse(_urlloader.data);			
			_responder.onStatus(resultObject);
		}
		
		override protected function onIoError(event:IOErrorEvent):void
		{
			var resultObject:Object = JSON.parse(_urlloader.data);			
			_responder.onStatus(resultObject);
		}
	}
}