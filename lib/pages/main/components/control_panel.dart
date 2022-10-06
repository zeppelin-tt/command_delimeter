import 'package:command_delimeter/localization/localization_constants.dart';
import 'package:command_delimeter/pages/main/components/implicitly_animated_names_list.dart';
import 'package:command_delimeter/provider/input_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class ControlPanel extends StatelessWidget {
  final VoidCallback onAddName;
  final VoidCallback onGenerate;
  final ScrollController scrollController;
  final TextEditingController inputController;
  final FocusNode focusNode;

  ControlPanel({
    required this.onAddName,
    required this.onGenerate,
    required this.scrollController,
    required this.inputController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    num _itemWidth = (400 - 12 * 4) / 3;
    final inputDataProvider = Provider.of<InputDataProvider>(context);
    return Column(
      children: <Widget>[
        SizedBox(height: 6.w),
        Expanded(
          child: ImplicitlyAnimatedNamesList(
            separatorSize: 12.w,
            borderRadius: 6.w,
            names: inputDataProvider.persons,
            scrollController: scrollController,
            onDelete: (person) => inputDataProvider.deletePerson(person),
          ),
        ),
        SizedBox(height: 6.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          height: (42 * 1.6).h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: _itemWidth.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.w), border: Border.all(color: Colors.white24, width: 1.5.w)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 6.h),
                    Text(getTranslated(context, 'number_of_teams'),
                        style: TextStyle(color: Colors.white70, fontSize: 13.0.sp)),
                    Spacer(),
                    Theme(
                      data: ThemeData(
                        textTheme: Theme.of(context).textTheme.copyWith(bodyMedium: TextStyle(color: Colors.white24)),
                        accentColor: Color(0xff2ca5e0),
                      ),
                      child: SizedBox(
                        height: 42.h,
                        child: NumberPicker(
                          minValue: 1,
                          itemWidth: 38.8.w,
                          maxValue: 12,
                          axis: Axis.horizontal,
                          onChanged: inputDataProvider.setCountTeams,
                          value: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: _itemWidth.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.w), border: Border.all(color: Colors.white24, width: 1.5.w)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 6.h),
                    Text(getTranslated(context, 'with_captains'),
                        style: TextStyle(color: Colors.white70, fontSize: 13.0.sp)),
                    Spacer(),
                    CupertinoSwitch(
                      activeColor: Color(0xff2ca5e0),
//                                trackColor: Colors.white24,
                      value: inputDataProvider.captains,
                      onChanged: (bool value) => inputDataProvider.setCaptains(value),
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.w),
                child: SizedBox(
                  height: double.infinity,
                  width: _itemWidth.w,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Color(0xff2ca5e0)),
                    onPressed: onGenerate,
                    child: Text(
                      getTranslated(context, 'generate'),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 16.0.sp),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 12.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          height: 42.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: double.infinity,
                width: (400 - _itemWidth - 12 * 3).w,
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(6.w)),
                child: TextField(
                  style: TextStyle(color: Colors.white70),
                  controller: inputController,
                  onSubmitted: (_) {
                    onAddName();
                    FocusScope.of(context).requestFocus(focusNode);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    hintText: getTranslated(context, 'enter_name'),
                    hintStyle: TextStyle(color: Colors.white60),
                  ),
                ),
              ),
              SizedBox(height: 12.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.w),
                child: SizedBox(
                  height: double.infinity,
                  width: _itemWidth.w,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Color(0xff2ca5e0)),
                    onPressed: onAddName,
                    child: Text(
                      getTranslated(context, 'add'),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 16.0.sp),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 12.w),
      ],
    );
  }
}
