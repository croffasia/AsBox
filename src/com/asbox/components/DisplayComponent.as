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
	import com.asbox.components.interfaces.IDisplayComponent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public class DisplayComponent extends MovieClip implements IDisplayComponent 
	{		
		protected var _container:DisplayObjectContainer;		
		
		protected var _ContainerComponent:IComponentContainer;
		protected var _EnableAutoRegisterComponents:Boolean = true;
		
		public function DisplayComponent(DisplayContainer:DisplayObjectContainer = null) 
		{
			super();				
			
			_container = DisplayContainer;	
			_ContainerComponent = new ComponentContainer(this);
			
			AsBox.CM.Register(this);
			
			this.PreInitialize();			
		}

		public function Create(DisplayContainer:DisplayObjectContainer = null):void 
		{
			if(DisplayContainer != null)
				_container = DisplayContainer;
				
			if (_container != null && !_container.contains(this))
				_container.addChild(this);
		}
		
		public function get Status():int
		{
			return _ContainerComponent.Status;
		}
		
		protected function PreInitialize():void 
		{					
			if (_EnableAutoRegisterComponents)
			{
				if (this.numChildren > 0)
				{
					var children:*;
					
					for (var i:int = 0; i < this.numChildren; i++ )
					{
						children = this.getChildAt(i);
						
						if (children is IComponentObject)
						{
							(children as IComponentObject).OwnerComponent = this;
							this.AddComponent((children as IComponentObject).ComponentHash);
						}
					}
				}
			}				
		}
		
		public function Initialize(name:String):void 
		{
			_ContainerComponent.Initialize(name);
		}
		
		public function ActivateComponent():void
		{
			_ContainerComponent.ActivateComponent();
		}
		
		public function DeactivateComponent():void
		{
			_ContainerComponent.DeactivateComponent();
		}
		
		public function AddComponent(hash:String):Boolean 
		{ 
			return _ContainerComponent.AddComponent(hash);
		}
		
		public function GetComponentByHash(hash:String):IComponentObject
		{							
			return _ContainerComponent.GetComponentByHash(hash);
		}
		
		public function GetComponentByName(name:String):IComponentObject
		{
			return _ContainerComponent.GetComponentByName(name);
		}
		
		public function GetComponentByClass(component:Class):Array
		{
			return _ContainerComponent.GetComponentByClass(component);
		}
		
		public function RemoveComponent(hash:String, system:Boolean = true):Boolean 
		{ 
			return _ContainerComponent.RemoveComponent(hash, system);
		}		
		
		public function Listener(callback:Function, type:String, component:String = "", autoRemove:Boolean = false):void
		{
			_ContainerComponent.Listener(callback, type, component, autoRemove);
		}
		
		public function UnregisterListener(callback:Function, type:String, component:String = ""):void
		{
			_ContainerComponent.UnregisterListener(callback, type, component);
		}
		
		public function Call(type:String, data:* = null):void
		{
			_ContainerComponent.Call(type, data);
		}
		
		public function Dispose():void 
		{
			if (parent != null)
			{
				parent.removeChild(this);
			}
			
			_ContainerComponent.Dispose();
		}
		
		public function get Components():Array 
		{
			return _ContainerComponent.Components;
		}
		
		public function get ComponentName():String 
		{
			return _ContainerComponent.ComponentName;
		}
		
		public function set ComponentName(value:String):void 
		{
			_ContainerComponent.ComponentName = value;
		}
		
		public function get EnableAutoRegisterComponents():Boolean
		{
			return _EnableAutoRegisterComponents;
		}
		
		public function set EnableAutoRegisterComponents(value:Boolean):void
		{
			_EnableAutoRegisterComponents = value;
		}
		
		public function get OwnerComponent():IComponentObject 
		{
			return _ContainerComponent.OwnerComponent;
		}
		
		public function set OwnerComponent(value:IComponentObject):void 
		{
			_ContainerComponent.OwnerComponent = value;
		}
		
		public function get ComponentHash():String 
		{
			return _ContainerComponent.ComponentHash;
		}
		
		public function set ComponentHash(value:String):void 
		{
			_ContainerComponent.ComponentHash = value;
		}
	}

}