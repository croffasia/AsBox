package com.asbox
{
	import com.asbox.components.interfaces.IDisplayComponent;
	import com.asbox.managers.ComponentManager;
	import com.asbox.managers.EventManager;
	import com.asbox.managers.GroupManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class AsBox extends EventDispatcher
	{
		private static var _container:DisplayObjectContainer;	

		public static function get container():DisplayObjectContainer
		{
			return _container;
		}
		
		public static function set container(value:DisplayObjectContainer):void
		{
			_container = value;
		}

		public static function get CM():ComponentManager
		{
			return ComponentManager.getInstance();
		}

		public static function get EM():EventManager
		{
			return EventManager.getInstance();
		}

		public static function get GM():GroupManager
		{
			return GroupManager.getInstance();
		}


	}
}