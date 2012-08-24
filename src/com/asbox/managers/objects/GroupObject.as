package com.asbox.managers.objects
{
	import com.asbox.Application;
	import com.asbox.components.events.ComponentEvent;
	import com.asbox.components.interfaces.IComponent;
	import com.asbox.managers.EventManager;
	import com.asbox.utils.EventsMap;
	
	import flash.utils.Dictionary;

	public class GroupObject
	{
		private var _name:String = "";
		private var _components:Dictionary = new Dictionary(true);		

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get components():Dictionary
		{
			return _components;
		}

		public function AddComponent(component:IComponent):Boolean
		{
			if(_components[component] == null){
				_components[component] = component;
				
				return true;
			}
			
			return false;
		}
		
		public function Call(type:String):void
		{
			if (_components != null)
			{
				var eventType:String;
				
				for (var key:* in _components)
				{
					eventType = EventsMap.CreateType(IComponent(_components[key]).ComponentHash, type);
					
					if (Application.instance.hasEventListener(eventType))
					{
						Application.instance.dispatchEvent(new ComponentEvent(eventType, IComponent(_components[key]).ComponentName, IComponent(_components[key]).ComponentHash));
					}
				}
			}	
		}
		
		public function Listener(callback:Function, type:String, component:String = "", autoRemove:Boolean = false):void
		{
			if (_components != null)
			{
				for (var key:* in _components)
				{
					IComponent(_components[key]).Listener(callback, type, component, autoRemove);
				}
			}	
		}
		
		public function UnregisterListener(callback:Function, type:String, component:String = ""):void
		{
			if (_components != null)
			{
				for (var key:* in _components)
				{
					IComponent(_components[key]).UnregisterListener(callback, type, component);
				}
			}	
		}
		
		public function UnregisterAllListener():void
		{
			if (_components != null)
			{
				for (var key:* in _components)
				{
					EventManager.getInstance().removeGroup(IComponent(_components[key]).ComponentHash, Application.instance);
				}
			}	
		}
		
		public function Dispose():void
		{
			this.UnregisterAllListener();			
			_components = null;
		}
		
		public function RemoveComponent(component:IComponent):Boolean
		{
			if (_components != null && _components[component] != null)
			{
				delete _components[component];
				return true;
			}
			
			return false;
		}

		public function RemoveComponentByName(name:String):Boolean
		{
			if (_components != null)
			{
				for (var key:* in _components)
				{
					if (IComponent(_components[key]).ComponentName == name)
					{
						delete _components[key];
						return true;
					}
				}
			}
			
			return false;
		}
		
		public function RemoveComponentByHash(hash:String):Boolean
		{
			if (_components != null)
			{
				for (var key:* in _components)
				{
					if (IComponent(_components[key]).ComponentHash == hash)
					{
						delete _components[key];
						return true;
					}
				}
			}
			
			return false;
		}
	}
}