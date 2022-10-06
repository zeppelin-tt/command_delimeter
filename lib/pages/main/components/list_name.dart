import 'package:command_delimeter/model/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListName extends StatelessWidget {
  final Person person;
  final ValueChanged<Person> onDelete;

  ListName({
    required this.person,
    required this.onDelete,
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
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 310.w,
            child: Text(
              person.name,
              style: TextStyle(color: Colors.white, fontFamily: 'Foma_flibustier', fontSize: 26.0.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: CircleBorder(),
              borderRadius: BorderRadius.circular(21.h),
              radius: 21.h,
              splashColor: Colors.transparent,
              onTap: () => onDelete(person),
              child: Icon(Icons.clear, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
