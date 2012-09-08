/******************************************************************
 * AsBox - AS3 component game framework
 * Copyright (C) 2012 Poluosmal Andrew
 * Email: poluosmak.a@gmail.com
 ****************************************************************/

package com.asbox.managers
{
	import com.asbox.AsBox;
	import com.asbox.scene.Scene;
	import com.asbox.scene.interfaces.IScene;
	
	import flash.utils.Dictionary;

	/** 
	 * Scene Manager
	 * 
	 * @author Poluosmak Andrew
	 */
	public class SceneManager
	{
		/**
		 * @private
		 */
		private static var _instance:SceneManager = null;		
		
		/**
		 * @private
		 */
		private var _scenes:Dictionary = new Dictionary(true);
		
		/**
		 * @private
		 */
		public function SceneManager(caller:Function = null) 
		{
			if( caller != SceneManager.getInstance )
				throw new Error ("SceneManager is a singleton class, use getInstance() instead");
			if ( SceneManager._instance != null )
				throw new Error( "Only one SceneManager instance should be instantiated" );
		}
		
		/**
		 * Scene Manager
		 * @return SceneManager
		 */
		public static function getInstance():SceneManager
		{
			if (_instance == null) 
				_instance = new SceneManager(arguments.callee);
			
			return _instance;			
		}
		
		/**
		 * Register New Scene
		 * 
		 * @param name Unique name for the Scene
		 * @param scene Scene object (if the scene is created manually)
		 * 
		 * @return IScene
		 */
		public function Register(name:String, scene:IScene = null):IScene
		{
			if(scene == null)
				scene = new Scene();
			
			_scenes[name] = scene;
			
			return scene;
		}
		
		/**
		 * Get Scene object
		 * 
		 * @param name Scene name
		 * 
		 * @return IScene
		 */
		public function Get(name:String):IScene
		{
			return _scenes[name] as IScene;
		}
		
		/**
		 * Unregister Scene. The scene will be deleted from the system
		 * 
		 * @param name Scene name
		 */
		public function Unregister(name:String):void
		{			
			delete _scenes[name];
		}			
	}
}