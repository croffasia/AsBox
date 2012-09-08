/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.components.base
{
	import com.asbox.AsBox;
	import com.asbox.components.base.interfaces.IComponentComands;
	import com.asbox.components.events.ComponentEvent;
	import com.asbox.enums.ComponentEnums;
	import com.asbox.enums.DebugEnums;
	import com.asbox.managers.EventManager;
	import com.asbox.utils.EventsMap;
	
	public class ComponentComands extends ComponentObject implements IComponentComands
	{
		public function ComponentComands(owner:Object = null)
		{
			super(owner);
		}
		
		override public function ActivateComponent():void
		{
			super.ActivateComponent();
			this.Call(ComponentEvent.ACTIVE);
		}
		
		override public function DeactivateComponent():void
		{
			super.DeactivateComponent();
			this.Call(ComponentEvent.INACTIVE);
		}
		
		override public function Initialize(name:String):void 
		{
			super.Initialize(name);
			this.Call(ComponentEvent.LOADED);
		}
		
		override public function Dispose():void
		{
			super.Dispose();
			this.Call(ComponentEvent.DISPOSED);
		}
		
		public function UnregisterListener(callback:Function, type:String, component:String = ""):void
		{
			if (component == "")
				component = this.ComponentHash;
			
			var eventType:String = EventsMap.CreateType(component, type);
			
			EventManager.getInstance().removeCallbackEvent(callback, eventType, AsBox.container);
		}
		
		public function Listener(callback:Function, type:String, component:String = "", autoRemove:Boolean = false):void
		{
			if (component == "")
				component = this.ComponentHash;
			
			if(DebugEnums.DEBUG_MODE)
				trace("Listener "+EventsMap.CreateType(component, type));
			
			EventManager.getInstance().add(AsBox.container, EventsMap.CreateType(component, type), callback, autoRemove, this.ComponentHash);
		}
		
		public function Call(type:String, data:* = null):void
		{
			var eventType:String = EventsMap.CreateType(this.ComponentHash, type);
			
			if(DebugEnums.DEBUG_MODE)
				trace("Call "+eventType);
			
			if (AsBox.container.hasEventListener(eventType))
			{
				AsBox.container.dispatchEvent(new ComponentEvent(eventType, this.ComponentName, this.ComponentHash, data));
			}
		}
	}
}