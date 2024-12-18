
 SUNDAY = 0;　//日曜日
 MONDAY = 1;　//月曜日
 SATURDAY = 6;　//土曜日
 MONTH_MAX = 12; //12月
 DAY_MAX_ARRAY = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31); //末日
 FEBRUARY  = 1; //2月
 LEAF_YEAR_100 = 100; //100年
 LEAF_YEAR_400 = 400; //400年
 LEAF_YEAR_INTERVAL = 4; //4年
 WEEKDAYS  = 7; //1週間
 HOLIDAYS_ARRAY = [["1","A"],["11"],["B"],["29"],["3","4","5"],[],["C"],[],["C","23"],["A"],["3","23"],["23"]]; //祝日
 HOLIDAY_STYLE = 0; //祝日
 WEEKDAY_STYLE = 1; //平日
 SUNDAY_STYLE = 2; //日曜日
 SATURDAY_STYLE = 3; //土曜日
 OTHER_MONTH_STYLE = 4; //表示する月ではない
 TODAY_STYLE = 5; //今日

//************date*************************
genzaiDt = new Date(); //今日日付を取得
global_year = genzaiDt.getYear(); //YYYYを取る
if (global_year < 2000) {
	global_year = 1900 + global_year;
}
global_month = genzaiDt.getMonth() + 1; //MMを取る
global_monthNex = genzaiDt.getMonth() + 1; //MMを取る
global_date = genzaiDt.getDate(); //DDを取る
//************date*************************

	function getCalendarList(yyyy, mm) {
		var _year = yyyy;
		var _mm = mm - 1;
		var calendarArray = new Array();
		//入力日付の1日
		var inputStartDt = new Date(_year, _mm, 1);
		var startDt;
		//入力されたデータの曜日を取得
	 	var yobi = inputStartDt.getDay();
	 	//入力されたデータの月の1日が日曜日ではない場合
	 	if (yobi != SUNDAY) {
	 		var zenGetuMaxDay = 0;
	 		//1月の場合は12月の末日を求める
	 		if (0 == inputStartDt.getMonth()) {
				zenGetuMaxDay = _getEndDay(_year - 1, MONTH_MAX - 1);
				startDt = new Date(_year - 1, MONTH_MAX - 1, zenGetuMaxDay - yobi + 1);
			}
			//1月の以外は1ヶ月前の末日を求める
			if (0 != inputStartDt.getMonth()) {		
				zenGetuMaxDay = _getEndDay(inputStartDt.getYear(), inputStartDt.getMonth() - 1);
				startDt = new Date(_year, inputStartDt.getMonth() - 1, zenGetuMaxDay - yobi + 1);		
			}
			for (var i = startDt.getDate(); i <= zenGetuMaxDay; i++) {
				var tempDate = new Date(_year, _mm - 1, i);
				calendarArray.push(tempDate);
			}
	 	}
	 	//当月
		var touGetuMaxDay = _getEndDay(inputStartDt.getYear(), inputStartDt.getMonth());
		for (var i = inputStartDt.getDate(); i <= touGetuMaxDay; i++) {
			calendarArray.push(new Date(_year, _mm, i));
		}
		//次月		
		_mm = _mm + 1;
		if (_mm == 12) {
			_year++;
			_mm = 0;
		}
		var nextMonthStartDt = new Date(_year, _mm, 1);
		var nextMonthDay = nextMonthStartDt.getDay();
		if (SUNDAY != nextMonthDay) {
			for (var i = 1;; i++) {
				var tempDate = new Date( nextMonthStartDt.getYear(), nextMonthStartDt.getMonth(), i);
				if (tempDate.getDay() == SUNDAY) break;	
				calendarArray.push(tempDate);
			}
		}
		return calendarArray;
	 }
  
	 function _getEndDay(year, month) {
		
		var endDay = DAY_MAX_ARRAY[month];
		
		if (month == FEBRUARY) {
			if (year % LEAF_YEAR_400 == 0) endDay++;
			else if (year % LEAF_YEAR_INTERVAL == 0 && year % LEAF_YEAR_100 != 0) endDay++;
		}
		return endDay;
	}

	function isHoliday(date) {
		if (date.getDay() == SUNDAY) return false;
			var holidays = _getBusinessHolidays(date.getYear(), date.getMonth() + 1);
		for (var i in holidays) {
			var holiday = holidays[i];		
			if(date.getDate() == holiday.getDate()) {
				return true;
			}
		}
		return false;
	}
	

	function _getBusinessHolidays(yyyy, mm) {
	
		var holidays = HOLIDAYS_ARRAY[mm - 1];
		var realHoliDays = _getRealHoliDays(yyyy, mm, holidays);
		_calculateAlternateDay(realHoliDays);
		return realHoliDays;
	}


	function _getRealHoliDays(yyyy, mm, holidays) {
		var realHoliDays = new Array();
		for (var i in holidays) {
			var holiday = holidays[i];
			//パタンーA：該当する月の2週目の月曜日が祝日
			if ("A" == holiday) {
				realHoliDays.push(getSiteiWeekDay(yyyy, mm, 2, MONDAY));
			//パタンーB：春分
			} else if ("B" == holiday) {
				realHoliDays.push(new Date(yyyy, mm - 1, _getSpringDay(yyyy)));
			//パタンーC：該当する月の3週目の月曜日が祝日		
			} else if ("C" == holiday) {
				realHoliDays.push(getSiteiWeekDay(yyyy, mm, 3, MONDAY));
			//該当する日が祝日
			} else {
				realHoliDays.push(new Date(yyyy, mm - 1, holiday));
			}
		}
		//9月の場合敬老の日と秋分が飛び石連休の場合三連休になる
		if (mm == 9) {
			if ((realHoliDays[1].getDate() - realHoliDays[0].getDate()) == 2) {
				realHoliDays.push(new Date(yyyy, mm - 1, realHoliDays[0].getDate() + 1));
			}
		}
		return realHoliDays;
	}
	

	function _calculateAlternateDay(realHoliDays) {
		for (var i = 0; i < realHoliDays.length; i++) {
 			var date = realHoliDays[i];
 			//祝日が日曜日の場合次の平日が休みになる
 			if (SUNDAY == date.getDay()) {
 				var alternateDay = date.getDate() + 1;
				for (var j = i + 1; j < realHoliDays.length; j++) {
					var holiDay = realHoliDays[j];
					if (holiDay.getDate() == alternateDay) {
						alternateDay++;
					}
				}
				realHoliDays.push(new Date(date.getYear(), date.getMonth(), alternateDay));
 			}
		}
	}


	function getSiteiWeekDay(yyyy, mm, num, yobi) {	
		var firstDay = new Date(yyyy, mm - 1, 1);
		var firstDayYobi = firstDay.getDay();
		var addWeekDays = 0;		
		if (yobi < firstDayYobi) {
			addWeekDays = WEEKDAYS;
		}			
		var purPoseDay = (WEEKDAYS * (num - 1)) + (yobi + addWeekDays - firstDayYobi) + 1;		
		return new Date(yyyy, mm - 1, purPoseDay);
	}

	function _getSpringDay(yyyy) {
		
		var str_yyyy = new String(yyyy);
	    var num1 = str_yyyy.substring(2,3);
	    var num2 = str_yyyy.substring(3,4);	  
	    var day;  
		if (num1 % 2 == 0) {	
			switch (num2) {
			case "0":
			case "1":
			case "4":
			case "5":
			case "8":
			case "9":
			 	day = 20;
			 	break;
			case "2":
			case "3":
			case "6":
			case "7": 
				day = 21;
			 	break;
			}								
		} else {			
			switch (num2) {
			case "0":
			case "1":
			case "4":
			case "5":
			case "8":
			case "9":			
			 	day = 21;
			 	break;
			case "2":
			case "3":
			case "6":
			case "7":		 
				day = 20;
			 	break;
			}	 
		}	
		return day;
	}

	function setStyle(object, num) {
		switch (num) {
			case HOLIDAY_STYLE:
				object.style.backgroundColor = "#FDFDFD";
				object.style.color = "red";
				object.style.height = "11pt";
				object.style.textAlign = "center";				
				object.style.cursor = "pointer";				

				break;
			case WEEKDAY_STYLE:
				object.style.backgroundColor = "#FDFDFD";
				object.style.color = "#555555";
				object.style.height = "11pt";
				object.style.textAlign = "center";
				object.style.cursor = "pointer";
				break;
			case SUNDAY_STYLE:
				object.style.backgroundColor = "#FDFDFD";
				object.style.color = "red";
				object.style.height = "11pt";
				object.style.textAlign = "center";
				object.style.cursor = "pointer";				
				break;			
			case SATURDAY_STYLE:
				object.style.backgroundColor = "#FDFDFD";
				object.style.color = "#007AC3";
				object.style.height = "11pt";
				object.style.textAlign = "center";
				object.style.cursor = "pointer";				
				break;			
			case OTHER_MONTH_STYLE:
				object.style.backgroundColor = "#FDFDFD";
				object.style.color = "#DDDDDD";
				object.style.height = "11pt";
				object.style.textAlign = "center";
				object.style.cursor = "default";				
				break;	
			case TODAY_STYLE:
				object.style.backgroundColor = "#99CC00";						
				object.style.color = "#555555";
				object.style.height = "11pt";
				object.style.textAlign = "center";
				object.style.cursor = "pointer";
				object.style.display = "block";			


				

				break;		
		}		
		
	 }		

