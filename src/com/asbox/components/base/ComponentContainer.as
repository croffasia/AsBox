/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.components.base
{
	import com.asbox.components.base.interfaces.IComponentContainer;
	import com.asbox.components.base.interfaces.IComponentObject;
	import com.asbox.managers.ComponentManager;

	public class ComponentContainer extends ComponentComands implements IComponentContainer
	{
		protected var _Components:Array = [];
		
		public function ComponentContainer(owner:Object = null)
		{
			super(owner);			
		}
		
		override public function Dispose():void
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
				(OwnerComponent as IComponentContainer).RemoveComponent(this.ComponentHash);
			}
			
			super.Dispose();
		}
		
		public function AddComponent(hash:String):Boolean 
		{ 
			var _component:IComponentObject = ComponentManager.getInstance().GetByHash(hash);
			
			if (_component == null)
				return false;
			
			_component.OwnerComponent = this as IComponentObject;
			
			_Components.push(hash);
			return true;
		}
		
		public function GetComponentByHash(hash:String):IComponentObject
		{
			var index:Number = _Components.indexOf(hash);
			
			if (index > -1)
			{
				return ComponentManager.getInstance().GetByHash(_Components[index]);			
			}
			
			return null;
		}
		
		public function GetComponentByName(name:String):IComponentObject
		{
			if (_Components.length > 0)
			{
				var _component:IComponentObject;
				
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
				var _component:IComponentObject;				
				
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
				var _component:IComponentObject;
				
				for (var i:int = 0;  i < _Components.length; i++ )
				{
					_component = ComponentManager.getInstance().GetByHash(_Components[i]);
					
					if (_component != null && _component.ComponentHash == hash)
					{
						var index:Number = _Components.indexOf(_component.ComponentHash);
						
						if (index > -1)
						{
							_component.OwnerComponent = null;
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
		
		public function get Components():Array 
		{
			return _Components;
		}
	}
}