package com.asbox.net.providers
{
	import com.asbox.AsBox;
	import com.asbox.net.NetConfig;
	import com.asbox.net.providers.interfaces.INetProvider;
	import com.asbox.net.responder.BaseResponder;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class BaseUrlLoaderProvider implements INetProvider
	{
		public var EVENT_GROUP:String = "_BaseUrlLoaderProvider_";
		
		protected var _urlloader:URLLoader;
		protected var _options:NetConfig;
		protected var _responder:BaseResponder;
		
		public function BaseUrlLoaderProvider(options:NetConfig)
		{
			_options = options;
		}
		
		public function start():void
		{
			_urlloader = new URLLoader();
			_urlloader.dataFormat = URLLoaderDataFormat.TEXT;
			
			AsBox.EM.add(_urlloader, IOErrorEvent.IO_ERROR, onIoError, false, EVENT_GROUP);
			AsBox.EM.add(_urlloader, SecurityErrorEvent.SECURITY_ERROR, onSecurityError, false, EVENT_GROUP);
			AsBox.EM.add(_urlloader, Event.COMPLETE, onCompleteLoad, false, EVENT_GROUP);
		}
		
		protected function onCompleteLoad(event:Event):void
		{
			var resultObject:Object = JSON.parse(_urlloader.data);
			
			if(resultObject)
				_responder.onResult(resultObject);
		}
		
		protected function onSecurityError(event:SecurityErrorEvent):void
		{
			var resultObject:Object = JSON.parse(_urlloader.data);			
			_responder.onStatus(resultObject);
		}
		
		protected function onIoError(event:IOErrorEvent):void
		{
			var resultObject:Object = JSON.parse(_urlloader.data);			
			_responder.onStatus(resultObject);
		}
		
		public function stop():void
		{
			AsBox.EM.removeGroup(EVENT_GROUP);
			_urlloader.close();
		}
		
		public function call(provider:String, responderClass:BaseResponder, ...arg):void
		{			
			var request:URLRequest = new URLRequest(_options.ServerUrl+_options.ProviderName+provider+_options.ProviderExt);
			request.method = URLRequestMethod.POST;
			
			_responder = responderClass;
			
			if(arg.length > 0)
			{
				var variables:URLVariables = new URLVariables();
				
				for(var i:int = 0; i < arg.length; i++)
				{
					if(arg[i] is Object)
					{
						for(var key:String in arg[i])
						{
							variables[key] = arg[i][key];
						}
					}
				}
				
				request.data = variables;
			}	
			
			_urlloader.load(request);
		}
	}
}