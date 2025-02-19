import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotroot_gw/constant/constant.dart';
import 'dart:async';

import 'package:spotroot_gw/model/getAllUser.dart';

import 'controlls/widgetsController.dart';

class GiveawayPicker extends StatefulWidget {
  final List<GetAllUser> items;
  final double itemWidth;
  final double height;

  const GiveawayPicker({
    Key? key,
    required this.items,
    this.itemWidth = 100,
    this.height = 80,
  }) : super(key: key);

  @override
  _GiveawayPickerState createState() => _GiveawayPickerState();
}

class _GiveawayPickerState extends State<GiveawayPicker> {
  late ScrollController _scrollController;
  Timer? _timer;
  final ScrollPhysics _scrollPhysics = const ClampingScrollPhysics();

  @override
  void initState() {
    Get.put(Widgetscontroller());

    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startHighSpeedScroll();
    });
  }

  void _startHighSpeedScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      if (_scrollController.hasClients) {
        final currentPosition = _scrollController.offset;
        final maxExtent = _scrollController.position.maxScrollExtent;
        final newPosition = currentPosition + 500;
        if (newPosition >= maxExtent) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.jumpTo(newPosition);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: _scrollPhysics,
        // itemCount:
        //     widget.items.length * 2,
        itemCount: 100,
        itemBuilder: (context, index) {
          final itemIndex = index % widget.items.length;
          return Row(
            children: [
              SizedBox(
                width: 5.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Constant.textPrimary,
                    radius: 30.sp,
                    child: Icon(
                      Icons.person,
                      size: 40.sp,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Constant.textWithStyle(
                    text: widget.items[itemIndex].userName!,
                    size: 17.sp,
                    maxLine: 3,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w900,
                    color: Constant.textPrimary,
                  ),
                  SizedBox(
                    height: .5.h,
                  ),
                  Constant.textWithStyle(
                    text: widget.items[itemIndex].fullName!,
                    size: 14.sp,
                    textAlign: TextAlign.center,
                    maxLine: 3,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 224, 224, 224),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// Example usage:
// widget.items[itemIndex].phoneNumber!