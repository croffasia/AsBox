package com.asbox.net.providers
{
	import com.asbox.AsBox;
	import com.asbox.net.NetConfig;
	import com.asbox.net.providers.interfaces.INetProvider;
	import com.asbox.net.responder.BaseResponder;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	
	public class AMFProvider implements INetProvider
	{
		public static const EVENT_GROUP:String = "_NetConnection_";
		private var _netConnection:NetConnection;
		private var _options:NetConfig;
		
		public function AMFProvider(options:NetConfig)
		{
			_options = options;
		}
		
		public function start():void
		{
			_netConnection = new NetConnection();	
			_netConnection.maxPeerConnections = 1;
			_netConnection.objectEncoding = ObjectEncoding.AMF3;
			//_netConnection.addHeader("Accept-Encoding: gzip");
			
			AsBox.EM.add(_netConnection, AsyncErrorEvent.ASYNC_ERROR, onAsyncError, false, EVENT_GROUP);
			AsBox.EM.add(_netConnection, NetStatusEvent.NET_STATUS, onNetStatus, false, EVENT_GROUP);
			AsBox.EM.add(_netConnection, IOErrorEvent.IO_ERROR, onIoError, false, EVENT_GROUP);
			AsBox.EM.add(_netConnection, SecurityErrorEvent.SECURITY_ERROR, onSecurityError, false, EVENT_GROUP);			
			
			_netConnection.connect(_options.ServerUrl);
		}
		
		protected function onSecurityError(event:SecurityErrorEvent):void
		{
			this.stop();
		}
		
		protected function onIoError(event:IOErrorEvent):void
		{
			this.stop();
		}
		
		protected function onNetStatus(event:NetStatusEvent):void
		{
			if (event.info.code == "NetConnection.Call.Failed")
				trace("Unable to find gateway");
			
			this.stop();
		}
		
		protected function onAsyncError(event:AsyncErrorEvent):void
		{
			this.stop();
		}
		
		public function stop():void
		{
			AsBox.EM.removeGroup(EVENT_GROUP);
			_netConnection.close();
		}
		
		public function call(provider:String, responderClass:BaseResponder, ...arg):void
		{
			var argument:Array = [];
			argument.push(provider);
			argument.push(responderClass);
			argument.push.apply(null, arg);
			
			_netConnection.call.apply(null, argument);
		}
	}
}