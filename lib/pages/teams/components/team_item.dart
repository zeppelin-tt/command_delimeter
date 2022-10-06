import 'package:command_delimeter/model/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamItem extends StatelessWidget {
  final Person? person;
  final String text;

  TeamItem({
    this.person,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 42.h,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.w)),
        color: person == null ? Colors.transparent : Color(0xff2ca5e0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          person == null
              ? Text(text, style: TextStyle(color: Colors.white70, fontSize: 22.0))
              : SizedBox(
                  width: 310.w,
                  child: Text(
                    person!.name,
                    style: TextStyle(color: Colors.black, fontFamily: 'Foma_flibustier', fontSize: 26.0.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
          if (person != null && person!.captain) Icon(Icons.star, color: Colors.black),
        ],
      ),
    );
  }
}
