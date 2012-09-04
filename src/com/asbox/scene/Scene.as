/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.scene
{
	import com.asbox.AsBox;
	import com.asbox.enums.SceneStatusEnums;
	import com.asbox.scene.events.SceneEvents;
	import com.asbox.scene.interfaces.IScene;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/** 
	 * Base Scene.
	 * 
	 * @author Poluosmak Andrew
	 */	
	public class Scene extends Sprite implements IScene
	{  	
		/**
		 * @private
		 */
		private var _Status:int = SceneStatusEnums.INITIALIZED;
		
		/**
		 * @private
		 */
		private var _Options:SceneOptions;
		
		/**
		 * @private
		 */
		public function Scene()
		{
			super();
		}
		
		/**
		 * Initialize Scene
		 */
		public function Initialize():void
		{
			if(!stage)
				addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
			else
				OnAddedToStage(null);
		}
		
		/**
		 * Disposal Scene. Override this method for disposed our data
		 */
		public function Dispose():void
		{
			if(_Options.locked == false)
			{
				if(parent != null && parent.contains(this))
					parent.removeChild(this);
				
				if(numChildren > 0)
				{
					while(numChildren > 0)
						removeChildAt(0);
				}
								
				AsBox.SM.Unregister(Options.Name);
				_Options.Dispose();
				
				_Status = SceneStatusEnums.DISPOSED;
				this.Dispatch(SceneEvents.CHANGE_STATUS, _Status);
			}
		}
		
		/**
		 * Lock / Unlock scene. 
		 * After change status called OnLockedScene() or OnUnLockedScene() handler.
		 * 
		 * @param value Locked status 
		 */
		public function set Lock(value:Boolean):void
		{
			if(value == true && _Options.locked != value){				
				OnLockedScene();
			} else if(value == true && _Options.locked != value) {				
				OnUnLockedScene();
			}
		}
		
		/**
		 * Lock Handler. Override this method for lock our data  
		 */
		protected function OnLockedScene():void
		{
			_Options.locked = true;
		}
		
		/**
		 * Unlock Handler. Override this method for unlock our data  
		 */
		protected function OnUnLockedScene():void
		{
			_Options.locked = false;
		}
		
		/** 
		 * @inheritDoc 
		 */
		override public function toString():String 
		{
			return "Scene: name = "+name+"; status = "+_Status;
		}
		
		/**
		 * @private   
		 */
		private function OnAddedToStage(event:Event):void
		{
			if(hasEventListener(Event.ADDED_TO_STAGE))
				removeEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
			
			this.ConfigureScene();
		}
		
		/**
		 * Configure Scene. Set <code>SceneOptions</code> for Current Scene. 
		 */
		protected function ConfigureScene(Options:SceneOptions = null):void
		{
			if(Options == null){
				Options = new SceneOptions();
				Options.Name = this.name;
			}
			
			Options.Owner = this;
			
			_Options = Options;
			
			AsBox.SM.Register(Options.Name, this);			
			this.LoadResources();
		}
		
		/**
		 * Load Scene Resources. Override this method for load our resources 
		 */
		protected function LoadResources():void
		{
			this.OnLoadResources();
		}
		
		/**
		 * OnLoad Scene Resources Handler
		 */
		protected function OnLoadResources():void
		{			
			this.OnCreateScene();
		}
		
		/**
		 * OnCreate Scene Handler 
		 */
		protected function OnCreateScene():void
		{
			_Status = SceneStatusEnums.CREATED;
			this.Dispatch(SceneEvents.CHANGE_STATUS, _Status);
		}
		
		/**
		 * Show Scene.
		 * 
		 * @param _container DisplayObject container 
		 */
		public function Show(_container:DisplayObjectContainer = null):void
		{
			if(_Status != SceneStatusEnums.DISPOSED && _Status != SceneStatusEnums.ACTIVE && _Status != SceneStatusEnums.INITIALIZED)
			{
				if(_container != null)
					_container.addChild(this);					
				
				_Status = SceneStatusEnums.ACTIVE;			
				this.Dispatch(SceneEvents.CHANGE_STATUS, _Status);
			}
		}
		
		/**
		 * Hide Scene.
		 * 
		 * @param autoRemove Set true for remove scene in system
		 */
		public function Hide(autoRemove:Boolean = false):void
		{
			if(_Options.locked == false && _Status != SceneStatusEnums.DISPOSED && _Status != SceneStatusEnums.INITIALIZED && _Status != SceneStatusEnums.DEACTIVE)
			{				
				if(parent != null && parent.contains(this))
					parent.removeChild(this);
				
				_Status = SceneStatusEnums.DEACTIVE;
				this.Dispatch(SceneEvents.CHANGE_STATUS, _Status);
				
				if(autoRemove == true)
				{
					Dispose();
				}
			}
		}

		/**
		 * Scene Status		 
		 */
		public function get Status():int
		{
			return _Status;
		}

		/**
		 * @private	 
		 */
		public function set Status(value:int):void
		{
			_Status = value;
		}		
		
		/**
		 * @private	 
		 */
		protected function Dispatch(type:String, data:* = null):void
		{
			if(hasEventListener(type))
				dispatchEvent(new SceneEvents(type, data));
		}

		/**
		 * <code>SceneOptions</code> object 	 
		 */
		public function get Options():SceneOptions
		{
			return _Options;
		}

	}
}