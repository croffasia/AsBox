package com.asbox.net.providers.interfaces
{
	import com.asbox.net.responder.BaseResponder;

	public interface INetProvider
	{
		function start():void;
		function stop():void;
		
		function call(provider:String, responderClass:BaseResponder, ... arg):void;
	}
}