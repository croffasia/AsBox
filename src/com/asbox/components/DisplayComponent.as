package com.asbox.components 
{
	import com.asbox.Application;
	import com.asbox.enums.ComponentEnums;
	import com.asbox.components.events.ComponentEvent;
	import com.asbox.components.interfaces.IComponent;
	import com.asbox.components.interfaces.IDisplayComponent;
	import com.asbox.managers.ComponentManager;
	import com.asbox.managers.EventManager;
	import com.asbox.utils.EventsMap;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public class DisplayComponent extends Sprite implements IDisplayComponent 
	{		
		private var _status:int = ComponentEnums.CREATED;
		private var _container:DisplayObjectContainer;
		private var _OwnerComponent:IComponent;
		private var _Components:Array = [];		
		private var _ComponentName:String = "";
		private var _ComponentHash:String = "";
		private var _EnableAutoRegisterComponents:Boolean = true;
		
		public function DisplayComponent(DisplayContainer:DisplayObjectContainer = null) 
		{
			super();				
			
			ComponentManager.getInstance().Register(this);
			
			_container = DisplayContainer;		
			this.PreInitialize();			
		}

		public function Create(DisplayContainer:DisplayObjectContainer = null):void 
		{
			if(DisplayContainer != null)
				_container = DisplayContainer;
				
			if (_container != null)
				_container.addChild(this);
		}
		
		public function PreInitialize():void 
		{					
			if (_EnableAutoRegisterComponents)
			{
				if (this.numChildren > 0)
				{
					var children:*;
					
					for (var i:int = 0; i < this.numChildren; i++ )
					{
						children = this.getChildAt(i);
						
						if (children is IComponent)
						{
							(children as IComponent).OwnerComponent = this;
							this.AddComponent((children as IComponent).ComponentHash);
						}
					}
				}
			}	
			
			trace("DisplayComponent :: PreInitialize Components length "+Components.length);
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
		
		public function Listener(callback:Function, type:String, component:String = "", autoRemove:Boolean = false):void
		{
			if (component == "")
				component = this.ComponentHash;
				
			EventManager.getInstance().add(Application.instance, EventsMap.CreateType(component, type), callback, autoRemove, this.ComponentHash);
		}
		
		public function UnregisterListener(callback:Function, type:String, component:String = ""):void
		{
			if (component == "")
				component = this.ComponentHash;
			
			var eventType:String = EventsMap.CreateType(component, type);
			
			EventManager.getInstance().removeCallbackEvent(callback, eventType, Application.instance);
		}
		
		protected function Call(type:String):void
		{
			var eventType:String = EventsMap.CreateType(this.ComponentHash, type);
			
			if (Application.instance.hasEventListener(eventType))
			{
				Application.instance.dispatchEvent(new ComponentEvent(eventType, this.ComponentHash, this.ComponentHash));
			}
		}
		
		public function Dispose():void 
		{
			if (parent != null)
			{
				parent.removeChild(this);
			}
			
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
		
		public function get EnableAutoRegisterComponents():Boolean
		{
			return _EnableAutoRegisterComponents;
		}
		
		public function set EnableAutoRegisterComponents(value:Boolean):void
		{
			_EnableAutoRegisterComponents = value;
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