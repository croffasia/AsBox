/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.scene.interfaces
{
	import com.asbox.scene.SceneOptions;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;

	/** 
	 * Scene Interface
	 * 
	 * @author Poluosmak Andrew
	 */
	public interface IScene extends IEventDispatcher
	{
		/**
		 * Initialize Scene
		 */
		function Initialize():void;

		/**
		 * Disposal Scene. Override this method for disposed our data
		 */
		function Dispose():void;
		
		/**
		 * Scene Status		 
		 */
		function get Status():int;
		
		/**
		 * @private	 
		 */
		function set Status(value:int):void;
		
		/**
		 * Show Scene.
		 * 
		 * @param _container DisplayObject container 
		 */
		function Show(_container:DisplayObjectContainer = null):void;
		
		/**
		 * Hide Scene.
		 * 
		 * @param autoRemove Set true for remove scene in system
		 */
		function Hide(autoRemove:Boolean = false):void;
		
		/**
		 * Lock / Unlock scene. 
		 * After change status called OnLockedScene() or OnUnLockedScene() handler.
		 * 
		 * @param value Locked status 
		 */
		function set Lock(value:Boolean):void;
		
		/**
		 * <code>SceneOptions</code> object 	 
		 */
		function get Options():SceneOptions;
	}
}