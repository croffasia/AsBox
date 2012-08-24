package com.asbox.managers
{
	import com.asbox.managers.objects.GroupObject;
	
	import flash.utils.Dictionary;

	public class GroupManager
	{
		/**
		 * @private
		 */
		private static var _instance:GroupManager;
		
		private var _groups:Dictionary = new Dictionary(true);
		
		/**
		 * @private
		 */
		public function GroupManager(caller:Function = null)
		{
			if( caller != GroupManager.getInstance )
				throw new Error ("GroupManager is a singleton class, use getInstance() instead");
			if ( GroupManager._instance != null )
				throw new Error( "Only one GroupManager instance should be instantiated" );		
		}
		
		/**
		 * Возвращает объект менеджера
		 * 
		 * @return EventManager
		 */
		public static function getInstance():GroupManager
		{
			if (_instance == null)
				_instance = new GroupManager(arguments.callee);
			
			return _instance;
		}
		
		public function Register(name:String):GroupObject
		{
			if(_groups[name] == null)
			{
				_groups[name] = new GroupObject();
				return _groups[name];
			}
			
			return null;
		}		
		
		public function Get(name:String):GroupObject
		{
			return _groups[name];
		}
		
		public function Unregister(name:String):Boolean
		{
			if(_groups[name] != null)
			{
				GroupObject(_groups[name]).Dispose();
				delete _groups[name];
				
				return true;
			}
			
			return false;
		}
	}
}