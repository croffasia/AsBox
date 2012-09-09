/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox
{
	import com.asbox.managers.ComponentManager;
	import com.asbox.managers.EventManager;
	import com.asbox.managers.GroupManager;
	import com.asbox.managers.SceneManager;
	import com.asbox.net.NetFactory;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	
	/** 
	 * Fast Access to managers and main display container.
	 * 
	 * @author Poluosmak Andrew
	 */
	public class AsBox extends EventDispatcher
	{
		/**
		 * @private
		 */ 
		private static var _container:DisplayObjectContainer;	

		public static function get container():DisplayObjectContainer
		{
			return _container;
		}
		
		/**
		 * @private
		 */ 
		public static function set container(value:DisplayObjectContainer):void
		{
			_container = value;
		}

		/**
		 * Component manager.
		 * @return ComponentManager
		 */
		public static function get CM():ComponentManager
		{
			return ComponentManager.getInstance();
		}

		/**
		 * Event manager.
		 * @return EventManager
		 */
		public static function get EM():EventManager
		{
			return EventManager.getInstance();
		}

		/**
		 * Component Group manager.
		 * @return EventManager
		 */
		public static function get GM():GroupManager
		{
			return GroupManager.getInstance();
		}

		/**
		 * Scene manager.
		 * @return SceneManager
		 */
		public static function get SM():SceneManager
		{
			return SceneManager.getInstance();
		}
		
		/**
		 * Net Connection providers
		 * @return NetFactory
		 */
		public static function get NF():NetFactory
		{
			return NetFactory.getInstance();
		}
	}
}