package com.asbox.components 
{
	import com.asbox.AsBox;
	import com.asbox.components.events.ComponentEvent;
	import com.asbox.components.interfaces.IComponent;
	import com.asbox.enums.ComponentEnums;
	import com.asbox.enums.DebugEnums;
	import com.asbox.managers.ComponentManager;
	import com.asbox.managers.EventManager;
	import com.asbox.utils.EventsMap;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public class Component extends EventDispatcher implements IComponent 
	{		
		private var _status:int = ComponentEnums.CREATED;
		private var _OwnerComponent:IComponent;
		private var _Components:Array = [];		
		private var _ComponentName:String = "";
		private var _ComponentHash:String = "";
		
		public function Component(target:IEventDispatcher=null) 
		{
			super(target);			
			ComponentManager.getInstance().Register(this);
			
			this.PreInitialize();
		}		
		
		public function PreInitialize():void
		{			
		}
		
		public function Initialize(name:String):void 
		{
			this.ComponentName = name;			
			
			_status = ComponentEnums.CREATED; 	
			this.Call(ComponentEvent.LOADED);
		}
		
		public function ActivateComponent():void
		{
			this._status = ComponentEnums.ACTIVE;
			this.Call(ComponentEvent.ACTIVE);
		}
		
		public function DeactivateComponent():void
		{
			this._status = ComponentEnums.INACTIVE;
			this.Call(ComponentEvent.INACTIVE);
		}
		
		public function Status():int
		{
			return _status;
		}
		
		public function AddComponent(hash:String):Boolean 
		{ 
			var _component:IComponent = ComponentManager.getInstance().GetByHash(hash);
			
			if (_component == null)
				return false;
				
			_component.OwnerComponent = this;
						
			_Components.push(hash);
			return true;
		}
		
		public function GetComponentByHash(hash:String):IComponent
		{
			var index:Number = _Components.indexOf(hash);
						
			if (index > -1)
			{
				return ComponentManager.getInstance().GetByHash(_Components[index]);			
			}
								
			return null;
		}
		
		public function GetComponentByName(name:String):IComponent
		{
			if (_Components.length > 0)
			{
				var _component:IComponent;
				
				for (var i:int = 0;  i < _Components.length; i++ )
				{
					_component = ComponentManager.getInstance().GetByHash(_Components[i]);
					
					if (_component != null && _component.ComponentName == name)
						return _component;
				}
			}
			
			return null;
		}
		
		public function GetComponentByClass(component:Class):IComponent
		{
			if (_Components.length > 0)
			{
				var _component:IComponent;
				
				for (var i:int = 0;  i < _Components.length; i++ )
				{
					_component = ComponentManager.getInstance().GetByHash(_Components[i]);
					
					if (_component != null && _component is component)
						return _component;
				}
			}
			
			return null;
		}
		
		public function RemoveComponent(hash:String):Boolean 
		{ 
			if (_Components.length > 0)
			{
				var _component:IComponent;
				
				for (var i:int = 0;  i < _Components.length; i++ )
				{
					_component = ComponentManager.getInstance().GetByHash(_Components[i]);
					
					if (_component != null && _component.ComponentHash == hash)
					{
						var index:Number = _Components.indexOf(_component.ComponentHash);
						
						if (index > -1)
						{
							_Components.splice(index, 1);
							
							if (_Components == null)
								_Components = [];
						}
			
						ComponentManager.getInstance().Unregister(_component.ComponentHash);
						
						return true;
					}
				}
			}
				
			return false;
		}		
		
		public function Dispose():void 
		{			
			if (_Components != null && _Components.length > 0)
			{
				while (_Components.length > 0)
				{
					this.RemoveComponent(_Components[0]);
				}
			}
			
			if (OwnerComponent != null)
			{
				OwnerComponent.RemoveComponent(this.ComponentHash);
			}
			
			this.Call(ComponentEvent.DISPOSED);
		}
		
		public function Listener(callback:Function, type:String, component:String = "", autoRemove:Boolean = false):void
		{
			if (component == "")
				component = this.ComponentHash;
			
			if(DebugEnums.DEBUG_MODE)
				trace("Listener "+EventsMap.CreateType(component, type));
				
			EventManager.getInstance().add(AsBox.container, EventsMap.CreateType(component, type), callback, autoRemove, this.ComponentHash);
		}
		
		public function UnregisterListener(callback:Function, type:String, component:String = ""):void
		{
			if (component == "")
				component = this.ComponentHash;
			
			var eventType:String = EventsMap.CreateType(component, type);
			
			EventManager.getInstance().removeCallbackEvent(callback, eventType, AsBox.container);
		}
		
		protected function Call(type:String, data:* = null):void
		{
			var eventType:String = EventsMap.CreateType(this.ComponentHash, type);
			
			if(DebugEnums.DEBUG_MODE)
				trace("Call "+eventType);
			
			if (AsBox.container.hasEventListener(eventType))
			{
				AsBox.container.dispatchEvent(new ComponentEvent(eventType, this.ComponentName, this.ComponentHash, data));
			}
		}
		
		public function get Components():Array 
		{
			return _Components;
		}
		
		public function get ComponentName():String 
		{
			return _ComponentName;
		}
		
		public function set ComponentName(value:String):void 
		{
			_ComponentName = value;
		}
		
		public function get OwnerComponent():IComponent 
		{
			return _OwnerComponent;
		}
		
		public function set OwnerComponent(value:IComponent):void 
		{
			_OwnerComponent = value;
		}
		
		public function get ComponentHash():String 
		{
			return _ComponentHash;
		}
		
		public function set ComponentHash(value:String):void 
		{
			_ComponentHash = value;
		}
	}

}