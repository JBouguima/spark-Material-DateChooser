package com.jbouguima.nicedates.simplepicker.events
{
	import flash.events.Event;
	
	public class TimeSelectionEvent extends Event
	{
		public static var HOUR_SELECTED:String = "hourSelected";
		public static var MINUTE_SELECTED:String = "minuteSelected";
		public static var TIME_SELECTED:String = "timeSelected";
		public var valueSelected:Number;
		public var cardinalSelected:Number;
		
		public function TimeSelectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}