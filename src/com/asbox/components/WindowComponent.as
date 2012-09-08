/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.components 
{
	import com.asbox.AsBox;
	import com.asbox.components.base.ComponentContainer;
	import com.asbox.components.base.interfaces.IComponentContainer;
	import com.asbox.components.base.interfaces.IComponentObject;
	import com.asbox.components.interfaces.IWindowComponent;
	import com.asbox.managers.EventManager;
	
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
		protected var _ContainerComponent:IComponentContainer;
		
		public function WindowComponent(init:NativeWindowInitOptions = null) 
		{			
			_ContainerComponent = new ComponentContainer(this);
			
			if (init == null) 
			{
				init = new NativeWindowInitOptions();
				init.renderMode = NativeWindowRenderMode.GPU;
			}
			
			super(init);	
			
			AsBox.CM.Register(this);
			
			this.PreInitialize();
		}
		
		protected function PreInitialize():void
		{			
			EventManager.getInstance().add(this, Event.CLOSING, onNativeWindowClosing, true, this.ComponentHash);	
		}
		
		public function get Status():int
		{
			return ContainerComponent.Status;
		}
		
		public function Show():void 
		{
			this.activate();
		}
		
		public function Hide():void 
		{
			this.visible = false;
		}
		
		public function Initialize(name:String):void 
		{
			ContainerComponent.Initialize(name);
		}
		
		public function ActivateComponent():void
		{
			ContainerComponent.ActivateComponent();
		}
		
		public function DeactivateComponent():void
		{
			ContainerComponent.DeactivateComponent();
		}
		
		public function AddComponent(hash:String):Boolean 
		{ 
			return ContainerComponent.AddComponent(hash);
		}
		
		public function GetComponentByHash(hash:String):IComponentObject
		{							
			return ContainerComponent.GetComponentByHash(hash);
		}
		
		public function GetComponentByName(name:String):IComponentObject
		{
			return ContainerComponent.GetComponentByName(name);
		}
		
		public function GetComponentByClass(component:Class):Array
		{
			return ContainerComponent.GetComponentByClass(component);
		}
		
		public function RemoveComponent(hash:String, system:Boolean = true):Boolean 
		{ 
			return ContainerComponent.RemoveComponent(hash, system);
		}		
		
		public function Listener(callback:Function, type:String, component:String = "", autoRemove:Boolean = false):void
		{
			ContainerComponent.Listener(callback, type, component, autoRemove);
		}
		
		public function UnregisterListener(callback:Function, type:String, component:String = ""):void
		{
			ContainerComponent.UnregisterListener(callback, type, component);
		}
		
		public function Call(type:String, data:* = null):void
		{
			ContainerComponent.Call(type, data);
		}
		
		public function get Components():Array 
		{
			return ContainerComponent.Components;
		}
		
		public function get ComponentName():String 
		{
			return ContainerComponent.ComponentName;
		}
		
		public function set ComponentName(value:String):void 
		{
			ContainerComponent.ComponentName = value;
		}
		
		public function get OwnerComponent():IComponentObject 
		{
			return ContainerComponent.OwnerComponent;
		}
		
		public function set OwnerComponent(value:IComponentObject):void 
		{
			ContainerComponent.OwnerComponent = value;
		}
		
		public function get ComponentHash():String 
		{
			return ContainerComponent.ComponentHash;
		}
		
		public function set ComponentHash(value:String):void 
		{
			ContainerComponent.ComponentHash = value;
		}
		
		public function Dispose():void 
		{									
			EventManager.getInstance().remove(this);
			this.close();			
			ContainerComponent.Dispose();
		}
		
		protected function get ContainerComponent():IComponentContainer
		{
			//if(_ContainerComponent == null)
			//	_ContainerComponent = new ComponentContainer(this);
			
			return _ContainerComponent;
		}
		
		private function onNativeWindowClosing(event:Event):void 
		{
			event.preventDefault();
			this.Dispose();							
		}
	}

}