package com.asbox.components 
{
	import com.asbox.AsBox;
	import com.asbox.components.events.ComponentEvent;
	import com.asbox.components.interfaces.IComponent;
	import com.asbox.components.interfaces.IWindowComponent;
	import com.asbox.enums.ComponentEnums;
	import com.asbox.enums.DebugEnums;
	import com.asbox.managers.ComponentManager;
	import com.asbox.managers.EventManager;
	import com.asbox.utils.EventsMap;
	
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowRenderMode;
	import flash.events.Event;
		
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public class WindowComponent extends NativeWindow implements IWindowComponent 
	{
		private var _status:int = ComponentEnums.CREATED;
		private var _Components:Array = [];		
		private var _ComponentName:String = "";
		private var _ComponentHash:String = "";
		private var _OwnerComponent:IComponent;
		
		public function WindowComponent(init:NativeWindowInitOptions = null) 
		{			
			if (init == null) 
			{
				init = new NativeWindowInitOptions();
				init.renderMode = NativeWindowRenderMode.GPU;
			}
			
			super(init);					
			ComponentManager.getInstance().Register(this as IComponent);
								
			this.PreInitialize();
		}
		
		public function PreInitialize():void
		{			
			EventManager.getInstance().add(this, Event.CLOSING, onNativeWindowClosing, true, this.ComponentHash);	
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
		
		public function Show():void 
		{
			this.activate();
		}
		
		public function Hide():void 
		{
			//this.
		}
		
		public function AddComponent(hash:String):Boolean 
		{ 
			var _component:IComponent = ComponentManager.getInstance().GetByHash(hash);
			
			if (_component == null)
				return false;
						
			_component.OwnerComponent = this as IComponent;
			
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
		
		public function GetComponentByClass(component:Class):Array
		{
			var _returned:Array = [];
			
			if (_Components.length > 0)
			{
				var _component:IComponent;				
				
				for (var i:int = 0;  i < _Components.length; i++ )
				{
					_component = ComponentManager.getInstance().GetByHash(_Components[i]);
					
					if (_component != null && _component is component)
						_returned.push(_component);
				}
			}
			
			return _returned;
		}
		
		public function RemoveComponent(hash:String, system:Boolean = true):Boolean 
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
						
						if(system == true)
							ComponentManager.getInstance().Unregister(_component.ComponentHash);
						
						return true;
					}
				}
			}
			
			return false;
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
		
		public function Dispose():void 
		{									
			EventManager.getInstance().remove(this);
			
			if (_Components != null && _Components.length > 0)
			{
				while (_Components.length > 0)
				{
					this.RemoveComponent(_Components[0]);
				}
			}					
			
			if (_OwnerComponent != null)
			{
				_OwnerComponent.RemoveComponent(this.ComponentHash);
			}
			
			this.close();
			this.Call(ComponentEvent.DISPOSED);
		}
		
		private function onNativeWindowClosing(event:Event):void 
		{
			event.preventDefault();
			this.Dispose();							
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
			_OwnerComponent= value;
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