/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.components.base
{
	import com.asbox.AsBox;
	import com.asbox.components.base.interfaces.IComponentObject;
	import com.asbox.enums.ComponentEnums;
	
	import flash.events.Event;

	/** 
	 * Component Object. Base component structure
	 * 
	 * @author Poluosmak Andrew
	 */
	public class ComponentObject implements IComponentObject
	{
		/**
		 * @private
		 */
		protected var _OwnerComponent:IComponentObject;		
		
		/**
		 * @private
		 */
		protected var _ComponentName:String = "";
		
		/**
		 * @private
		 */
		protected var _ComponentHash:String = "";
		
		/**
		 * @private
		 */
		protected var _status:int = ComponentEnums.CREATED;	
		
		/**
		 * @private
		 */
		private var _owner:Object;

		/**
		 * @private
		 */
		public function ComponentObject(owner:Object = null)
		{						
			_owner = owner;
			
			this.PreInitialize();
			
			if(_owner == null)
				AsBox.CM.Register(this);
		}
		
		public function get ComponentHash():String
		{
			return _ComponentHash;
		}

		public function set ComponentHash(value:String):void
		{
			_ComponentHash = value;
		}

		public function get ComponentName():String
		{
			return _ComponentName;
		}

		public function set ComponentName(value:String):void
		{
			_ComponentName = value;
		}

		public function get OwnerComponent():IComponentObject
		{
			return _OwnerComponent;
		}

		public function set OwnerComponent(value:IComponentObject):void
		{
			_OwnerComponent = value;
		}
		
		public function ActivateComponent():void
		{
			this._status = ComponentEnums.ACTIVE;
		}
		
		public function DeactivateComponent():void
		{
			this._status = ComponentEnums.INACTIVE;			
		}
		
		public function PreInitialize():void
		{						
		}
		
		public function Initialize(name:String):void 
		{
			this.ComponentName = name;			
			
			_status = ComponentEnums.CREATED; 	
		}
		
		public function Dispose():void
		{			
			_owner = null;
		}
		
		public function get Status():int
		{
			return _status;
		}
		
		public function set Status(value:int):void
		{
			_status = value;
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void{}		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void{}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return false;
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return false;
		}
		
		public function willTrigger(type:String):Boolean
		{
			return false;
		}

	}
}