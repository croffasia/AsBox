package com.asbox.net
{
	import com.asbox.net.providers.AMFProvider;
	import com.asbox.net.providers.JSONProvider;
	import com.asbox.net.providers.interfaces.INetProvider;
	
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;

	public class NetFactory
	{
		public static const AMF:String = "AMF";
		public static const XML:String = "XML";
		public static const JSON:String = "JSON";
		
		/**
		 * @private
		 */
		private static var _instance:NetFactory = null;	
		
		/**
		 * @private
		 */
		private var _providers:Dictionary = new Dictionary(true);
		
		/**
		 * @private
		 */
		private var _ActiveProvider:String = "";
		
		/**
		 * @private
		 */
		public function NetFactory(caller:Function = null) 
		{
			if( caller != NetFactory.getInstance )
				throw new Error ("NetFactory is a singleton class, use getInstance() instead");
			if ( NetFactory._instance != null )
				throw new Error( "Only one NetFactory instance should be instantiated" );			
		}
		
		/**
		 * Net Factory
		 * @return SceneManager
		 */
		public static function getInstance():NetFactory
		{
			if (_instance == null) 
				_instance = new NetFactory(arguments.callee);
			
			return _instance;			
		}
		
		public function RegisterProvider(name:String, provider:INetProvider):void
		{			
			provider.start();
			_providers[name] = provider;
		}
		
		public function UnregisterProvider(name:String):void
		{
			delete _providers[name];
		}

		public function get ActiveProvider():String
		{
			return _ActiveProvider;
		}

		public function set ActiveProvider(value:String):void
		{
			if(value != "")
				_ActiveProvider = value;
		}

		public function GetApi(providerName:String = ""):INetProvider
		{
			if(providerName == "")
				providerName = _ActiveProvider;
			
			if(providerName){
				
				return (_providers[providerName]) as INetProvider;
			} else {
				return null;
			}
		}
	}
}