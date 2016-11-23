package com.jbouguima.nicedates.simplepicker.abstracts
{
	import com.jbouguima.nicedates.simplepicker.events.TimeSelectionEvent;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	
	import spark.components.Group;
	import spark.components.HGroup;
	import spark.effects.Rotate;
	
	[Bindable]
	public class AbstractTimeSelector extends Group
	{
		
		
		private var angleFrom:Number = 180;
		private var angleTo:Number = 180;
		private var selectedAngleHours:Number = 180;
		private var selectedAngleMinutes:Number = 180;
		
		public var currentValues:ArrayCollection;
		private var timeHours:ArrayCollection = new ArrayCollection([12,1,2,3,4,5,6,7,8,9,10,11]);
		private var timeMinutes:ArrayCollection = new ArrayCollection([0,5,10,15,20,25,30,35,40,45,50,55]);
		private var hoursMode:Boolean;
		public var selectedMidday:String = "AM";
		private var isAM:Boolean = true;
		//public var middayModeColor:uint = 0x8ee9ef;
		public var selectedHour:Number=12;
		public var selectedMinute:Number=0;
		
		public var rotIndic:Rotate;
		public var indicHour:HGroup;
		public var indicMin:HGroup;
		
		public function AbstractTimeSelector()
		{
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, init);
		}
		
		public function init(event:FlexEvent):void
		{
			if(!currentValues) currentValues = new ArrayCollection();
			else currentValues.removeAll();
			currentValues.addAll(timeHours);
			hoursMode = true;
			addEventListener(TimeSelectionEvent.TIME_SELECTED, timeSelectedHandler);
		}
		
		public function timeSelectedHandler(event:TimeSelectionEvent):void
		{
			var _value:Number = event.cardinalSelected;
			if(hoursMode){
				currentValues.removeAll();
				currentValues.addAll(timeHours);
				selectedHour = event.valueSelected;
				//hoursMode = false;
				
			}else{
				currentValues.removeAll();
				currentValues.addAll(timeMinutes);
				selectedMinute = event.valueSelected;
			}
			
			changeSelectedAngle(_value);
		}
		
		private function changeSelectedAngle(value:Number):void
		{
			switch(value)
			{
				case 12:
				{
					angleTo = -90;
					break;
				}
				case 11:
				{
					angleTo = -120;
					break;
				}
				case 10:
				{
					angleTo = -150;
					break;
				}
				case 9:
				{
					angleTo = 180;
					break;
				}
				case 8:
				{
					angleTo = 150;
					break;
				}
				case 7:
				{
					angleTo = 120;
					break;
				}
				case 6:
				{
					angleTo = 90;
					break;
				}	
				case 5:
				{
					angleTo = 60;
					break;
				}
				case 4:
				{
					angleTo = 30;
					break;
				}
				case 3:
				{
					angleTo = 0;
					break;
				}
				case 2:
				{
					angleTo = -30;
					break;
				}	
				case 1:
				{
					angleTo = -60;
					break;
				}							
				default:
				{
					angleTo = 180;
					break;
				}
			}
			
			if(hoursMode){
				
				selectedAngleHours = angleTo;
				
				rotIndic.angleFrom = angleFrom;
				rotIndic.angleTo = angleTo;
				rotIndic.play([indicHour],false);
				
			}else{
				
				selectedAngleMinutes = angleTo;
				
				rotIndic.angleFrom = angleFrom;
				rotIndic.angleTo = angleTo;
				rotIndic.play([indicMin],false);
				
			}

		}
		
		public function itemRollOverHandler(event:MouseEvent, value:Number):void
		{

		}
		
		public function itemRollOutHandler(event:MouseEvent, value:Number):void
		{
			// TODO Auto-generated method stub
			
		}
		
		public function rotIndicEndHandler(event:EffectEvent):void
		{
			angleFrom = angleTo;
			
		}
		
		
		public function changeSelectionMode(event:MouseEvent, mode:Number):void
		{
			if(mode==0){
				hoursMode = true;
				currentValues.removeAll();
				currentValues.addAll(timeHours);
			}else{
				hoursMode = false;
				currentValues.removeAll();
				currentValues.addAll(timeMinutes);
			}
			
		}
		
		public function changeAMPMMode(event:MouseEvent):void
		{
			if(isAM){
				selectedMidday="PM";
				//middayModeColor = 0xf2e19f;
			}else{
				selectedMidday="AM";
				//middayModeColor = 0x8ee9ef;
			}
			isAM = !isAM;
		}
	}
}