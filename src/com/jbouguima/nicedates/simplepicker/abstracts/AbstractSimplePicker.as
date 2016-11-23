package com.jbouguima.nicedates.simplepicker.abstracts
{
	import com.jbouguima.nicedates.simplepicker.events.ChooserDateEvent;
	import com.jbouguima.nicedates.simplepicker.parts.SensibleList;
	import com.jbouguima.nicedates.simplepicker.parts.TimeSelector;
	
	import flash.display.InteractiveObject;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.Alert;
	import mx.controls.DateField;
	import mx.effects.Parallel;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.formatters.DateFormatter;
	import mx.graphics.SolidColor;
	import mx.managers.ToolTipManager;
	
	import spark.components.Group;
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.PopUpAnchor;
	import spark.components.TextInput;
	import spark.components.VGroup;
	import spark.effects.Resize;
	import spark.primitives.Ellipse;
	
	[Bindable]
	public class AbstractSimplePicker extends Group
	{
		include './langData.as';
		
		private var monthNames:Array;
		public var dayNames:Array;
		
		public var btnCal:Image;
		public var popup:PopUpAnchor;
		public var daysLst:SensibleList;
		public var monthLst:SensibleList;
		public var timeSelector:TimeSelector;
		public var container:Group;
		public var dateInput:TextInput;
		public var openChooserBtn:Group;
		public var vagueGrey:Ellipse;
		public var fadeResizeShow:Parallel;
		public var showYearsPanel:Parallel;
		public var hideYearsPanel:Parallel;
		//public var showTimePanel:Parallel;
		//public var hideTimePanel:Parallel;
		public var openPopupResize:Resize;
		public var closePopupResize:Resize;
		public var bodycontainer:VGroup;
		public var btnPrevCal:Group;
		public var btnChooseYear:Group;
		public var btnChooseTime:Group;
		public var btnNextCal:Group;
		public var currentDateLbl:Label;
		
		public var intialWidth:Number = 173;
		public var initialHeight:Number = 195;
		public var finalWidth:Number = 345;
		public var finalHeight:Number = 395;
		
		private var isValideInput:Boolean = true;
		
		[Embed(source="../resources/img/CalendarDesactive.png")]
		public var calendarClosedIcon:Class;
		
		[Embed(source="../resources/img/CalendarActive.png")]
		public var calendarOpenIcon:Class;
		
		[Embed(source="../resources/img/CalendarInvalid.png")]
		public var calendarInvalidIcon:Class;
		
		[Embed(source="../resources/img/CalendarPrevious.png")]
		public var calendarPreviousIcon:Class;
		
		[Embed(source="../resources/img/CalendarYearUp.png")]
		public var calendarYearPickUpIcon:Class;
		
		[Embed(source="../resources/img/CalendarYearDown.png")]
		public var calendarYearPickDownIcon:Class;
		
		[Embed(source="../resources/img/CalendarTimeUp.png")]
		public var calendarTimePickUpIcon:Class;
		
		[Embed(source="../resources/img/CalendarTimeDown.png")]
		public var calendarTimePickDownIcon:Class;
				
		[Embed(source="../resources/img/CalendarNext.png")]
		public var calendarNextIcon:Class;
		
		private var selectedIndex:Number = 0;
		public var currentDateDaysList:ChooserDateList;
		public var currentYearsRangeList:ArrayCollection;
		private var formatter:DateFormatter;
		
		//public var selectedDate:Number;
		public var selectedMonth:Number;
		public var selectedYear:Number;
		public var tmpSelectedMonth:Number;
		public var tmpSelectedYear:Number;
		
		public var yearCounter:Number;
		public var actualMonthYear:String;
		public var backYearColor:SolidColor;
		public var btnPrevColor:SolidColor;
		public var btnUpColor:SolidColor;
		public var btnNextColor:SolidColor;
		public var yearChooserGrp:Group;
		//public var timeChooserGrp:Group;
		public var btnOnBackColor:uint = 0xe8e8e8;
		public var btnOffBackColor:uint = 0xffffff;
		public var upDownYearChooseImg:Image;
		public var upDownTimeChooseImg:Image;
		private var monthSelectionState:Boolean;
		private var timeSelectionState:Boolean;
		private var curretDate:Date;
		
		private var _chooserDate:Date;
		private var _lang:String;
		
		public function AbstractSimplePicker()
		{
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, init);
		}
		
		protected function init(event:FlexEvent):void
		{
			curretDate = new Date();
			formatter = new DateFormatter();
			formatter.formatString = "DD/MM/YYYY";
			currentDateDaysList = new ChooserDateList();
			currentYearsRangeList= new ArrayCollection();
			
			formatPickerDefaultDate();
			currentDateLbl.text = dateInput.text = formatter.format(_chooserDate);
			
			dateInput.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, papa_mouseDownOutsideHandler);
			openChooserBtn.addEventListener(MouseEvent.CLICK, openChooserHandler);
			
			btnPrevCal.addEventListener(MouseEvent.CLICK, prevMonthHandler);
			btnChooseYear.addEventListener(MouseEvent.CLICK, openYearChooserHandler);
			btnChooseTime.addEventListener(MouseEvent.CLICK, openTimeChooserHandler);
			btnNextCal.addEventListener(MouseEvent.CLICK, nextMonthHandler);
			hideYearsPanel.addEventListener(EffectEvent.EFFECT_END, hideYearPanelEffHandler);
			showYearsPanel.addEventListener(EffectEvent.EFFECT_END, showYearPanelEffHandler);
			//hideTimePanel.addEventListener(EffectEvent.EFFECT_END, hideTimePanelEffHandler);
			//showTimePanel.addEventListener(EffectEvent.EFFECT_END, showTimePanelEffHandler);
			daysLst.addEventListener(ChooserDateEvent.DAY_SELECTED, newDateSelectedHandler);
			monthLst.addEventListener(ChooserDateEvent.MONTH_SELECTED, monthSelectionHandler);
		}
		
		private function monthSelectionHandler(evt:ChooserDateEvent):void
		{
			tmpSelectedMonth = evt.monthSelected;
			tmpSelectedYear = evt.yearSelected;
			
			currentDateDaysList.setMonthAndYear(_chooserDate, tmpSelectedMonth, tmpSelectedYear);
			actualMonthYear = monthNames[tmpSelectedMonth]+" "+tmpSelectedYear.toString();
			daysLst.dataProvider = currentDateDaysList;	
			
			monthLst.includeInLayout = false;
			monthLst.visible = false;
			hideYearsPanel.play([yearChooserGrp],false);
		}
		
		private function formatPickerDefaultDate():void
		{
			var value:Date = new Date();
			var formattedDate:Date = new Date();
			//
			if(dateInput.text && dateInput.text.length>0){

				formattedDate = DateField.stringToDate(dateInput.text, "DD/MM/YYYY");
				//Alert.show(" value = "+value);
				if(formattedDate){
					value = formattedDate;
					isValideInput = true;
					dateInput.setStyle('color', '0x3c3e3e');
				}else{
					isValideInput = false;
					if(_chooserDate)
						value = _chooserDate;
				}
					
			}
			_chooserDate = value;
			//selectedDate = value.date;
			selectedMonth = value.month;
			selectedYear = value.fullYear;
			actualMonthYear = monthNames[selectedMonth]+" "+selectedYear.toString();
			currentDateDaysList.setMonthAndYear(_chooserDate, selectedMonth, selectedYear);
			//currentDateDaysList.chooserDate = value;
			daysLst.dataProvider = currentDateDaysList;
		}
		
		protected function popup_mouseDownOutsideHandler(event:FlexMouseEvent):void
		{
			closeChooser();
		}
		private function closeChooser():void
		{
			btnCal.source = calendarClosedIcon;
			popup.displayPopUp = false;
			daysLst.visible = false;
			yearChooserGrp.visible = false;
			daysLst.includeInLayout = false;
			if(monthSelectionState || timeSelectionState){
				//monthSelectionState = false;
				hideYearsPanel.play([yearChooserGrp],false);
			}
			yearChooserGrp.includeInLayout = false;
		}
		protected function papa_mouseDownOutsideHandler(event:FocusEvent):void
		{
			// TODO Auto-generated method stub
			var focusPoint:Point = new Point();
			focusPoint.x = stage.mouseX;
			focusPoint.y = stage.mouseY;
			var i:int = (stage.getObjectsUnderPoint(focusPoint).length);
			stage.focus=InteractiveObject(stage.getObjectsUnderPoint(focusPoint)[i-1].parent);
			
		}

		
		protected function openChooserHandler(event:MouseEvent):void
		{
			formatPickerDefaultDate();
			if(!isValideInput){
				btnCal.source = calendarInvalidIcon;
				dateInput.setStyle('color', '0xe0123e');
				ToolTipManager.enabled = true;
				//dateInput.toolTip = ;
				//ToolTipManager.createToolTip("invalid date !",dateInput.x+dateInput.width,
				//	mouseY, null,dateInput);
			}else {
				ToolTipManager.enabled = false;
				btnCal.source = calendarOpenIcon;
				currentDateLbl.text = dateInput.text = formatter.format(_chooserDate);
				fadeResizeShow.play([vagueGrey], true);
				popup.displayPopUp = true;
				openPopupResize.play([container], false);
				openPopupResize.addEventListener(EffectEvent.EFFECT_END, addcalendarHandler);
			}
		}
		
		private function addcalendarHandler(evt:EffectEvent):void
		{
			daysLst.includeInLayout = true;
			yearChooserGrp.includeInLayout = true;
			daysLst.visible = true;
			yearChooserGrp.visible = true;
			monthLst.includeInLayout = false;
			monthLst.visible = false;
			timeSelector.includeInLayout = false;
			timeSelector.visible = false;
		}
		
		protected function openYearChooserHandler(event:MouseEvent):void
		{
			timeSelector.includeInLayout = false;
			timeSelector.visible = false;
			
			if(!monthSelectionState){
				monthSelectionState = true;
				showYearsPanel.play([yearChooserGrp],false);

			}else{
				monthLst.includeInLayout = false;
				monthLst.visible = false;
				hideYearsPanel.play([yearChooserGrp],false);
			}
			
		}
		
		protected function openTimeChooserHandler(event:MouseEvent):void
		{
			monthLst.includeInLayout = false;
			monthLst.visible = false;
			
			if(!timeSelectionState){
				timeSelectionState = true;
				showYearsPanel.play([yearChooserGrp],false);
			}else{
				timeSelector.includeInLayout = false;
				timeSelector.visible = false;
				hideYearsPanel.play([yearChooserGrp],false);
			}
			
		}
		
		private function hideYearPanelEffHandler(evt:EffectEvent):void
		{
			if(timeSelectionState){
				upDownTimeChooseImg.source = calendarTimePickDownIcon;
				timeSelectionState = !timeSelectionState;
			}else if(monthSelectionState){
				upDownYearChooseImg.source = calendarYearPickDownIcon;
				monthSelectionState = !monthSelectionState;
			}
			
		}
		
		private function showYearPanelEffHandler(evt:EffectEvent):void
		{
			if(timeSelectionState){
				upDownTimeChooseImg.source = calendarTimePickUpIcon;
				upDownYearChooseImg.source = calendarYearPickDownIcon;
				timeSelector.includeInLayout = true;
				timeSelector.visible = true;
				if(monthSelectionState) monthSelectionState=false;
			}else {
				buildYearsList(selectedYear);
				yearCounter = selectedYear ;
				upDownYearChooseImg.source = calendarYearPickUpIcon;
				upDownTimeChooseImg.source = calendarTimePickDownIcon;
			}
		}
		
		public function buildYearsList(year:Number):void
		{
			if(!currentYearsRangeList)currentYearsRangeList= new ArrayCollection()
			else currentYearsRangeList.removeAll();

			for(var i:Number=0;i<4;i++){
				var yearVO:YearVO = new YearVO();
				yearVO.year = year+i;
				yearVO.monthList = new ArrayCollection(monthNames);
				yearVO.actualYear = curretDate.fullYear;
				yearVO.actualMonth = curretDate.month;
				yearVO.selectedYear = selectedYear;
				yearVO.selectedMonth = selectedMonth;
				
				currentYearsRangeList.addItem(yearVO);
			}
			monthLst.includeInLayout = true;
			monthLst.visible = true;
		}
		
		protected function prevMonthHandler(event:MouseEvent):void
		{
			if(!monthSelectionState){
				// show previous month
				if(selectedMonth > 0){
					selectedMonth--;
				}else {
					selectedMonth = 11;
					selectedYear--;
				}
				//Alert.show("selectedMonth = "+selectedMonth);
				currentDateDaysList.setMonthAndYear(_chooserDate, selectedMonth, selectedYear);
				actualMonthYear = monthNames[selectedMonth]+" "+selectedYear.toString();
				daysLst.dataProvider = currentDateDaysList;	
			} else {
				yearCounter = yearCounter-4;
				buildYearsList(yearCounter);
			}
		}
		
		protected function nextMonthHandler(event:MouseEvent):void
		{
			if(!monthSelectionState){
				// show next month
				if(selectedMonth < 11){
					selectedMonth++;
				}else {
					selectedMonth = 0;
					selectedYear++;
				}
				//Alert.show("selectedMonth = "+selectedMonth);
				actualMonthYear = monthNames[selectedMonth]+" "+selectedYear.toString();
				currentDateDaysList.setMonthAndYear(_chooserDate, selectedMonth, selectedYear);
				daysLst.dataProvider = currentDateDaysList;
			} else {
				yearCounter = yearCounter+4;
				buildYearsList(yearCounter);
			}
		}
		
		
		private function newDateSelectedHandler(evt:ChooserDateEvent):void
		{
			chooserDate = evt.changedDate;
			closeChooser();
		}
		
		public function set chooserDate(value:Date):void
		{
			_chooserDate = value;
			currentDateLbl.text = dateInput.text = formatter.format(_chooserDate);
		}
		
		public function get chooserDate():Date
		{
			return _chooserDate;
		}
		
		public function set lang(value:String):void
		{
			_lang = value;
			switch(value)
			{
				case "en_US":
				{
					monthNames = monthsNames_en;
					dayNames = dayNames_en;
					break;
				}
				case "fr_FR":
				{
					monthNames = monthsNames_fr;
					dayNames = dayNames_fr;
					break;
				}
				case "ar_AR":
				{
					monthNames = monthsNames_ar;
					dayNames = dayNames_ar;
					break;
				}
			    default:
				{
					monthNames = monthsNames_en;
					dayNames = dayNames_en;
					break;
				}
			}
		}
		
		[Inspectable(category="Common",enumeration="en_US,fr_FR,ar_AR",defaultValue="en_US")]
		public function get lang():String
		{
			return _lang;
		}
		
		
	}
}