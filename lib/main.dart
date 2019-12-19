import 'package:flutter/material.dart';
import 'package:lunar_calendar_converter/lunar_solar_converter.dart';
import 'contants/animeLines.dart';

void main() => runApp(new MyApp());

final numMap = {
  '1': '一',
  '2': '二',
  '3': '三',
  '4': '四',
  '5': '五',
  '6': '六',
  '7': '七',
  '8': '八',
  '9': '九',
  '10': '十',
  '11': '十一',
  '12': '十二',
};

final numWeekMap = {
  '1': '一',
  '2': '二',
  '3': '三',
  '4': '四',
  '5': '五',
  '6': '六',
  '7': '日',
};

final solarFestival = {
  "0101": "元旦",
  "0214": "情人节",
  "0308": "妇女节",
  "0312": "植树节",
  "0315": "消费者权益日",
  "0401": "愚人节",
  "0501": "劳动节",
  "0504": "青年节",
  "0601": "儿童节",
  "0701": "建党节",
  "0801": "建军节",
  "0910": "教师节",
  "1001": "国庆节",
  "1224": "平安夜",
  "1225": "圣诞节",
};

final lunarFestival = {
  "正月初一": "春节",
  "正月十五": "元宵节",
  "五月初五": "端午节",
  "七月初七": "七夕情人节",
  "七月十五": "中元节",
  "八月十五": "中秋节",
  "九月初九": "重阳节",
  "腊月初八": "腊八节",
  "腊月廿四": "小年",
};

class MyApp extends StatelessWidget {
  final wordPair = '1';
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // title: 'Welcome to Flutter1',
      home: new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: new Text(
            '动漫台词日历',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Helvetica',
            ),
          ),
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        ),
        body: new HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _StateHomePage createState() => _StateHomePage();
}

class _StateHomePage extends State<HomePage> {
  static var now = new DateTime.now();
  static final startDate = new DateTime(2019, 1, 1, 0, 0);
  static var whichDay = now.difference(startDate); // 今天是第几天
  static var solar =
      Solar(solarYear: now.year, solarMonth: now.month, solarDay: now.day);
  static var lunar = LunarSolarConverter.solarToLunar(solar);
 
  int index = whichDay.inDays%365%4 - 1; 
                  
  String isFestival() {
    var month = now.month.toString().padLeft(2, '0');
    var day = now.day.toString().padLeft(2, '0');
    var lunarDay = lunar.toString().replaceRange(0, 9, "");
    var festival = '';
    if (solarFestival[month + day] != null) {
      festival = solarFestival[month + day];
    }
    if (lunarFestival[lunarDay] != null) {
      festival = lunarFestival[lunarDay];
    }
    if (solarFestival[month + day] != null && lunarFestival[lunarDay] != null) {
      festival = solarFestival[month + day] + "&" + lunarFestival[lunarDay];
    }
    return festival;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 3 / 2.2,
          child: Image(
            image: AssetImage("images/dairy/${animeLines[index]['pic']}.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 18,
        ),
        ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: double.infinity, //宽度尽可能大
                // minHeight: 100, //最小高度为50像素
                maxHeight: 200 //最大高度为50像素
                ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "${animeLines[index]['lines']}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Helvetica',
                    ),
                    strutStyle: StrutStyle(
                        forceStrutHeight: true, height: 1.2, leading: 0.9),
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // height: 140,
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  child: Text(
                    '——《${animeLines[index]['title']}》${animeLines[index]['character']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Helvetica',
                    ),
                  ),
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.only(right: 20.0),
                ),
              ],
            )),
        SizedBox(
          height: 25,
        ),
        Row(children: <Widget>[
          Container(
            child: Text(
              now.day.toString().padLeft(2, '0'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 115,
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w300,
              ),
            ),
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.isFestival(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Helvetica',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '${numMap[now.month.toString().padLeft(2, '0')]}月 | 星期${numWeekMap[now.weekday.toString()]}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Helvetica',
                ),
              ),
              Text(
                '${lunar.toString().replaceRange(3, 9, "")}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Helvetica',
                ),
              ),
            ],
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child:IconButton(
                iconSize: 40.0,
                padding: EdgeInsets.all(1.0),
                icon: Icon(Icons.arrow_left),
                onPressed: () {
                  if(index>0){
                    setState(() {
                      now = now.add(new Duration(days: -1)); //减1
                      solar = Solar(solarYear: now.year, solarMonth: now.month, solarDay: now.day);
                      lunar = LunarSolarConverter.solarToLunar(solar);
                      index--;
                    });
                  }
                },
              ),
              padding: EdgeInsets.only(right:40.0),
            ),
            IconButton(
              iconSize: 40.0,
              padding: EdgeInsets.all(1.0),
              icon: Icon(Icons.arrow_right),
              onPressed: () {
                if(index < whichDay.inDays%365%4 - 1 ){
                  setState(() {
                    now = now.add(new Duration(days: 1)); //加1
                    solar = Solar(solarYear: now.year, solarMonth: now.month, solarDay: now.day);
                    lunar = LunarSolarConverter.solarToLunar(solar);
                    index++;
                  });
                }
              },
            ),
            // IconButton(
            //   padding: EdgeInsets.all(1.0),
            //   icon: Icon(Icons.file_download),
            //   onPressed: () {},
            // ),
          ],
        ),
      ],
    ));
  }
}
