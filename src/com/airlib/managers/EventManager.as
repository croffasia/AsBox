/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.airlib.managers
{
	import com.airlib.managers.objects.EventObject;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * Менеджер событий. Менеджер событий предназначен для централизованного и удобного управления событиями.
	 * 
	 * <p>Менеджер позволяет добавлять, удалять, включать / выключать события по следующим критериям: 
	 * <ul>	 
	 * 		<li>всех событий</li>
	 * 		<li>всех событий определенного типа и ссылающихся на определенную фукнцию обработчик</li>
	 * 		<li>всех событий ссылающихся на фукнцию обработчик</li>
	 * 		<li>всех событий определенного типа</li>
	 * 		<li>всех событий определенной группы</li>
	 * </ul>
	 * </p>
	 * <p>В методах объекта менеджера есть возможность указания конкретного IEventDispatcher. В случае его указания, 
	 * то операция будет применена исключительно для этого объекта. В противном случае затроент все события менеджера.</p>
	 * 
	 * @author Poluosmak Andrew
	 */
	public class EventManager
	{
		/**
		 * @private
		 */
		private static var _instance:EventManager;
		
		/**
		 * @private
		 */
		private var _eventsDictionary:Array = null;
		
		/**
		 * @private
		 */
		private static var _priority:int = -1;
		
		/**
		 * @private
		 */
		public function EventManager(caller:Function = null)
		{
			if( caller != EventManager.getInstance )
				throw new Error ("EventManager is a singleton class, use getInstance() instead");
			if ( EventManager._instance != null )
				throw new Error( "Only one EventManager instance should be instantiated" );		
			
			_eventsDictionary = [];
			_priority = -1;
		}
		
		/**
		 * Возвращает объект менеджера
		 * 
		 * @return EventManager
		 */
		public static function getInstance():EventManager
		{
			if (_instance == null)
				_instance = new EventManager(arguments.callee);
			
			return _instance;
		}
		
		/**
		 * Добавление нового события
		 * 
		 * @param eventDispatcher IEventDispatcher объект
		 * @param event тип события
		 * @param callbackHandler функция обработки
		 * @param autoRemove флаг для автоудаления события, после первого использования. Может принимать значения true (удалить) / false (не удалять)
		 * @param groupName имя группы, к которой относится событие
		 * 
		 * @return Boolean 
		 */
		public function add(eventDispatcher:IEventDispatcher, event:String, callbackHandler:Function, autoRemove:Boolean = false, groupName:String = ""):Boolean 
		{
			// create event object
			var eventObj:EventObject = new EventObject();
				
			eventObj.eventDispatcher = eventDispatcher;
			eventObj.event = event;
			eventObj.callbackHandler = callbackHandler;
			eventObj.eventGroup = groupName;
			eventObj.autoRemove = autoRemove;
			
			eventObj.build();			
			_eventsDictionary.push(eventObj);
			
			return true;
		}
		
		/**
		 * Включение всех событий. Если указан IEventDispatcher объект, то включаются все события имеющие отношение к 
		 * данному объекту. В проивном случае включаются все события в менеджере
		 * 
		 * @param eventDispatcher IEventDispatcher объект
		 */		
		public function enable(eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher)){
					(_eventsDictionary[item] as EventObject).enable();
				}
			}
		}
		
		/**
		 * Включение событий ссылающихся на указанную функцию обработчик и тип события
		 * 
		 * @param callbackHandler функция обработки
		 * @param event тип события
		 * @param eventDispatcher IEventDispatcher объект. В случае, если объект не указан, то будут включены все события имеющие отношения к указанной функции и типу события.
		 */		
		public function enableCallbackEvent(callbackHandler:Function, event:String, eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher) 
					&& event == (_eventsDictionary[item] as EventObject).event && callbackHandler == (_eventsDictionary[item] as EventObject).callbackHandler){
					(_eventsDictionary[item] as EventObject).enable();
				}
			}
		}
		
		/**
		 * Включение события по типу
		 * 
		 * @param event тип события
		 * @param eventDispatcher IEventDispatcher объект. В случае, если объект не был указан, то будут включены все события в менеджере по указанному типу
		 */	
		public function enableEvent(event:String, eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher) 
					&& event == (_eventsDictionary[item] as EventObject).event){
					(_eventsDictionary[item] as EventObject).enable();
				}
			}
		}
		
		/**
		 * Включение событий по функции обработки
		 * 
		 * @param callbackHandler функция обработки
		 * @param eventDispatcher IEventDispatcher объект. В случае, если объект не был указан, то будут включены все события в менеджере ссылающиеся на указанную функцию обработки
		 */	
		public function enableCallback(callbackHandler:Function, eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher) 
					&& callbackHandler == (_eventsDictionary[item] as EventObject).callbackHandler){
					(_eventsDictionary[item] as EventObject).enable();
				}
			}
		}
		
		/**
		 * Включение событий по группе
		 * 
		 * @param groupName имя группы
		 * @param eventDispatcher IEventDispatcher объект. В случае, если объект не был указан, то будут включены все события в менеджере относящиеся к указанной группе
		 */	
		public function enableGroup(groupName:String, eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher) 
					&& groupName == (_eventsDictionary[item] as EventObject).eventGroup){
					(_eventsDictionary[item] as EventObject).enable();
				}
			}
		}
		
		/**
		 * Выключение всех событий. Если указан IEventDispatcher объект, то выключаются все события имеющие отношение к 
		 * данному объекту. В проивном случае выключаются все события в менеджере
		 * 
		 * @param eventDispatcher IEventDispatcher объект
		 */	
		public function disable(eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher)){
					(_eventsDictionary[item] as EventObject).disable();
				}
			}
		}
		
		/**
		 * Выключение событий ссылающихся на указанную функцию обработчик и тип события
		 * 
		 * @param callbackHandler функция обработки
		 * @param event тип события
		 * @param eventDispatcher IEventDispatcher объект. В случае, если объект не указан, то будут выключены все события имеющие отношения к указанной функции и типу события.
		 */	
		public function disableCallbackEvent(callbackHandler:Function, event:String, eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher) 
					&& event == (_eventsDictionary[item] as EventObject).event 
					&& callbackHandler == (_eventsDictionary[item] as EventObject).callbackHandler){
					(_eventsDictionary[item] as EventObject).disable();
				}
			}
		}
		
		/**
		 * Выключение события по типу
		 * 
		 * @param event тип события
		 * @param eventDispatcher IEventDispatcher объект. В случае, если объект не был указан, то будут выключены все события в менеджере по указанному типу
		 */
		public function disableEvent(event:String, eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher) 
					&& event == (_eventsDictionary[item] as EventObject).event){
					(_eventsDictionary[item] as EventObject).disable();
				}
			}
		}
		
		/**
		 * Выключение событий по функции обработки
		 * 
		 * @param callbackHandler функция обработки
		 * @param eventDispatcher IEventDispatcher объект. В случае, если объект не был указан, то будут выключены все события в менеджере ссылающиеся на указанную функцию обработки
		 */	
		public function disableCallback(callbackHandler:Function, eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher) 
					&& callbackHandler == (_eventsDictionary[item] as EventObject).callbackHandler){
					(_eventsDictionary[item] as EventObject).disable();
				}
			}
		}
		
		/**
		 * Выключение событий по группе
		 * 
		 * @param groupName имя группы
		 * @param eventDispatcher IEventDispatcher объект. В случае, если объект не был указан, то будут выключены все события в менеджере относящиеся к указанной группе
		 */	
		public function disableGroup(groupName:String, eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher) 
					&& groupName == (_eventsDictionary[item] as EventObject).eventGroup){
					(_eventsDictionary[item] as EventObject).disable();
				}
			}
		}
		
		/**
		 * Удаление всех событий. Если указан IEventDispatcher объект, то удаляются все события имеющие отношение к 
		 * данному объекту. В проивном случае удалаются все события в менеджере
		 * 
		 * @param eventDispatcher IEventDispatcher объект
		 */	
		public function remove(eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher)){
					_deleteEvent(item);
				}
			}
			
			if(eventDispatcher == null)
			{
				_priority = -1;
			}
			
		}
		
		/**
		 * Удаление событий ссылающихся на указанную функцию обработчик и тип события
		 * 
		 * @param callbackHandler функция обработки
		 * @param event тип события
		 * @param eventDispatcher IEventDispatcher объект. В случае, если объект не указан, то будут удалены все события имеющие отношения к указанной функции и типу события.
		 */	
		public function removeCallbackEvent(callbackHandler:Function, event:String, eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher) 
					&& event == (_eventsDictionary[item] as EventObject).event 
					&& callbackHandler == (_eventsDictionary[item] as EventObject).callbackHandler){
					_deleteEvent(item);
				}
			}
		}
				
		/**
		 * Удаление события по типу
		 * 
		 * @param event тип события
		 * @param eventDispatcher IEventDispatcher объект. В случае, если объект не был указан, то будут удалены все события в менеджере по указанному типу
		 */
		public function removeEvent(event:String, eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher) 
					&& event == (_eventsDictionary[item] as EventObject).event) {
					_deleteEvent(item);
				}
			}
		}
		
		/**
		 * Удаление событий по функции обработки
		 * 
		 * @param callbackHandler функция обработки
		 * @param eventDispatcher IEventDispatcher объект. В случае, если объект не был указан, то будут удалены все события в менеджере ссылающиеся на указанную функцию обработки
		 */	
		public function removeCallback(callbackHandler:Function, eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher) 
					&& callbackHandler == (_eventsDictionary[item] as EventObject).callbackHandler){
					_deleteEvent(item);
				}
			}
		}
		
		/**
		 * Удаление событий по группе
		 * 
		 * @param groupName имя группы
		 * @param eventDispatcher IEventDispatcher объект. В случае, если объект не был указан, то будут удалены все события в менеджере относящиеся к указанной группе
		 */	
		public function removeGroup(groupName:String, eventDispatcher:IEventDispatcher = null):void
		{
			var item:int;
			
			for(item = 0; item < _eventsDictionary.length; item++)
			{
				if((eventDispatcher == null || eventDispatcher == (_eventsDictionary[item] as EventObject).eventDispatcher) 
					&& groupName == (_eventsDictionary[item] as EventObject).eventGroup){
					_deleteEvent(item);
				}
			}
		}
		
		/**
		 * @private
		 */	
		private function _deleteEvent(item:int):void
		{
			if(_eventsDictionary[item]){
				(_eventsDictionary[item] as EventObject).destruct();
				_eventsDictionary.splice(item, 1);
			}
		} 

		/**
		 * Глобальный приоритет для событий
		 */
		public static function get priority():int
		{
			_priority++;
			return _priority;
		}
	}
}