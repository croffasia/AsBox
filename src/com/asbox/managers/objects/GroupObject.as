/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.managers.objects
{
	import com.asbox.AsBox;
	import com.asbox.components.base.interfaces.IComponentContainer;
	import com.asbox.components.events.ComponentEvent;
	import com.asbox.components.interfaces.IComponent;
	import com.asbox.managers.EventManager;
	import com.asbox.utils.EventsMap;
	
	import flash.utils.Dictionary;

	/** 
	 * Component Group object
	 * 
	 * @author Poluosmak Andrew
	 */
	public class GroupObject
	{
		/**
		 * @private
		 */
		private var _name:String = "";
		
		/**
		 * @private
		 */
		private var _components:Dictionary = new Dictionary(true);
		
		/**
		 * @private
		 */
		private var _scene:String = "";

		/**
		 * Group Name
		 */
		public function get name():String
		{
			return _name;
		}

		/**
		 * @private
		 */
		public function set name(value:String):void
		{
			_name = value;
		}

		/**
		 * Components belonging to the group
		 */
		public function get components():Dictionary
		{
			return _components;
		}

		/**
		 * Add new component in Group
		 * 
		 * @param component Component
		 * 
		 * @return GroupObject
		 */
		public function AddComponent(component:IComponentContainer):GroupObject
		{
			if(_components[component] == null){
				_components[component] = component;
			}
			
			return this;
		}
		
		/**
		 * Call group action. Action called all components in group
		 * 
		 * @param type Action Type
		 * @param object Additional transfered data
		 */
		public function Call(type:String, object:* = null):void
		{
			if (_components != null)
			{
				var eventType:String;
				
				for (var key:* in _components)
				{
					eventType = EventsMap.CreateType(IComponentContainer(_components[key]).ComponentHash, type);
					
					if (AsBox.container.hasEventListener(eventType))
					{
						AsBox.container.dispatchEvent(new ComponentEvent(eventType, IComponentContainer(_components[key]).ComponentName, IComponentContainer(_components[key]).ComponentHash, object));
					}
				}
			}	
		}
		
		/**
		 * Add Listener group action.
		 * 
		 * @param callback Callback Handler
		 * @param type Action Type
		 * @param component Component Hash
		 * @param autoRemove Auto remove Listener after first call
		 */
		public function Listener(callback:Function, type:String, component:String = "", autoRemove:Boolean = false):void
		{
			if (_components != null)
			{
				for (var key:* in _components)
				{
					IComponentContainer(_components[key]).Listener(callback, type, component, autoRemove);
				}
			}	
		}
		
		/**
		 * Remove Listener group action.
		 * 
		 * @param callback Callback Handler
		 * @param type Action Type
		 * @param component Component Hash
		 */
		public function UnregisterListener(callback:Function, type:String, component:String = ""):void
		{
			if (_components != null)
			{
				for (var key:* in _components)
				{
					IComponentContainer(_components[key]).UnregisterListener(callback, type, component);
				}
			}	
		}
		
		/**
		 * Remove all Listener group action.
		 */
		public function UnregisterAllListener():void
		{
			if (_components != null)
			{
				for (var key:* in _components)
				{
					EventManager.getInstance().removeGroup(IComponentContainer(_components[key]).ComponentHash, AsBox.container);
				}
			}	
		}
		
		/**
		 * Dispose all components in group.
		 */
		public function DisposeAllComponents():void
		{
			if (_components != null)
			{
				for (var key:* in _components)
				{
					IComponentContainer(_components[key]).Dispose();
				}
			}	
		}
		
		/**
		 * Dispose group
		 */
		public function Dispose():void
		{
			this.UnregisterAllListener();	
			this.DisposeAllComponents();
			
			_components = null;
		}
		
		/**
		 * Remove component in group by object
		 * 
		 * @param component Component object
		 * 
		 * @return Boolean
		 */
		public function RemoveComponent(component:IComponent):Boolean
		{
			if (_components != null && _components[component] != null)
			{
				delete _components[component];
				return true;
			}
			
			return false;
		}

		/**
		 * Remove component in group by name
		 * 
		 * @param component Component name
		 * 
		 * @return Boolean
		 */
		public function RemoveComponentByName(name:String):Boolean
		{
			if (_components != null)
			{
				for (var key:* in _components)
				{
					if (IComponentContainer(_components[key]).ComponentName == name)
					{
						delete _components[key];
						return true;
					}
				}
			}
			
			return false;
		}
		
		/**
		 * Remove component in group by hash
		 * 
		 * @param component Component hash
		 * 
		 * @return Boolean
		 */
		public function RemoveComponentByHash(hash:String):Boolean
		{
			if (_components != null)
			{
				for (var key:* in _components)
				{
					if (IComponentContainer(_components[key]).ComponentHash == hash)
					{
						delete _components[key];
						return true;
					}
				}
			}
			
			return false;
		}

		/**
		 * Owner scene name
		 */
		public function get scene():String
		{
			return _scene;
		}

		/**
		 * @private
		 */
		public function set scene(value:String):void
		{
			_scene = value;
		}

	}
}