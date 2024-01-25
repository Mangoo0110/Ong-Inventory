import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ong_inventory/common/app_text_styles.dart';

class TimeText extends StatefulWidget {
  DateTime date;
  TimeText({
    required this.date,
    super.key
  });

  @override
  State<TimeText> createState() => _TimeTextState();
}

class _TimeTextState extends State<TimeText> {

  final List<String>_monthNames = [
    "xyz",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  final List<String> _weekDayNames = [
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT",
    "SUN",
  ];

  bool detailTime = false;

  //methods ::
  late Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        
      });
     });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          detailTime = !detailTime;
        });
      },
      child:
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(getDateTimeTextFormat(dateTime: widget.date), style: AppTextStyle().boldSmallSize(),),
        )
    );
  }

  String getDateTimeTextFormat({
    required DateTime dateTime
  }) {

    String text = "";
    DateTime now = DateTime.now();
    if(dateTime.year == now.year && dateTime.month == now.month && !detailTime) {
      if(dateTime.day == now.day) {
        text = "Today,${"\n"}";
        var minute = (((DateTime.now().millisecondsSinceEpoch)/1000)/60 - ((dateTime.millisecondsSinceEpoch/1000))/60).floor();
        print(minute);
        if(minute >= 60) {
          text = "$text ${(minute/60).floor()} hours";
          if(minute % 60 == 0) {
            text = "$text, ago";
            return text;
          }
          else text = "$text,";
        }
        if ((minute % 60) > 0){
          text = "$text ${(minute % 60).floor()} minutes ago";
          
        }
        else {
          text = "Just now";
        }
        return text;
      }
      else if (dateTime.day == now.day - 1) {
        text = "Yesterday";
      }
      else {
        text = "${now.day - dateTime.day} ago";
      }
      return text;
    }
    else {
      // first weekDay e.g MON, TUE...
      text = _weekDayNames[dateTime.weekday - 1].toString();
      // second day e.g. 01, 02,...
      text = "$text, ${dateTime.day}";
      // third month e.g. 01, 02, ... 12
      if(dateTime.year != now.year && dateTime.month != now.month || detailTime) text = "$text ${_monthNames[dateTime.month]}";
      //fourth year
      if(dateTime.year != now.year || detailTime) text = "$text, ${dateTime.year}";
      // fifth hour 01...60
      if(dateTime.hour < 10){
        text = "$text${"\n"} 0${dateTime.hour}";
      }
      else {
        //text = "$text ${dateTime.hour}";
        if(dateTime.hour > 12){
          text = "$text${"\n"} ${dateTime.hour % 12}";
        } else {
          text = "$text${"\n"} ${dateTime.hour}";
        }
      }
      //  minute 00...60
      if(dateTime.minute < 10){
        text = "$text:0${dateTime.minute}";
      }
      else {
        text = "$text:${dateTime.minute}";
      }
      // lastly am or pm
      if(dateTime.hour >= 12){
        text = "$text pm";
      } else {
        text = "$text am";
      }
    }
    return text;
  }

}