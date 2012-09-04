/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.managers
{
	import com.asbox.managers.objects.GroupObject;
	
	import flash.utils.Dictionary;

	/** 
	 * Component Group manager
	 * 
	 * @author Poluosmak Andrew
	 */
	public class GroupManager
	{
		/**
		 * @private
		 */
		private static var _instance:GroupManager;
		
		/**
		 * @private
		 */
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
		 * Group manager instance 
		 * @return GroupManager
		 */
		public static function getInstance():GroupManager
		{
			if (_instance == null)
				_instance = new GroupManager(arguments.callee);
			
			return _instance;
		}
		
		/**
		 * Register new group. If the group already exists, the new group will not be added, and returned to the existing group
		 * 
		 * @param name Unique group name
		 * 
		 * @return GroupObject
		 */
		public function Register(name:String):GroupObject
		{
			if(_groups[name] == null)
			{
				_groups[name] = new GroupObject();				
			}
			
			return _groups[name];
		}		
		
		/**
		 * Get group by name.
		 * 
		 * @param name Group name
		 * 
		 * @return GroupObject
		 */
		public function Get(name:String):GroupObject
		{
			return _groups[name];
		}
		
		/**
		 * Get groups in scene. Set the option "scene" in GroupObject, to be able to select groups belonging scene
		 * 
		 * @param name Scene name
		 * 
		 * @return Dictionary
		 */
		public function GetByScene(scene:String):Dictionary
		{
			var result:Dictionary = new Dictionary(true);
			
			if(_groups)
			{
				for(var key:String in _groups)
				{
					if(GroupObject(_groups[key]).scene == scene)
						result[key] = _groups[key];
				}
			}
			
			return result;
		}
		
		/**
		 * Unregister group
		 * 
		 * @param name Group name
		 * 
		 * @return Boolean
		 */
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
		
		/**
		 * Unregister scene groups
		 * 
		 * @param name Scene name
		 */
		public function UnregisterSceneGroups(name:String):void
		{
			if(_groups)
			{
				for(var key:String in _groups)
				{
					if(GroupObject(_groups[key]).scene == name)
					{
						this.Unregister(key);
					}					
				}
			}
		}
	}
}