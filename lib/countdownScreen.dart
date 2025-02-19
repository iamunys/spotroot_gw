import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotroot_gw/constant/constant.dart';
import 'package:spotroot_gw/model/getAllUser.dart';
import 'package:spotroot_gw/randompicker.dart';
import 'package:spotroot_gw/winnerScreen.dart';

class CountDownScreen extends StatefulWidget {
  final List<GetAllUser> data;
  const CountDownScreen({super.key, required this.data});

  @override
  State<CountDownScreen> createState() => _CountDownScreenState();
}

class _CountDownScreenState extends State<CountDownScreen> {
  int _secondsRemaining = 10;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
          Timer((const Duration(seconds: 7)), () {
            Get.off(const Winnerscreen());
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: const Color.fromARGB(0, 226, 207, 207),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Constant.textPrimary,
              size: 22.sp,
            )),
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 255, 0, 170).withOpacity(.3),
              const Color.fromARGB(255, 208, 0, 255).withOpacity(.3),
              const Color.fromARGB(255, 255, 0, 123).withOpacity(.3),
            ],
          ),
        ),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_secondsRemaining == 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Constant.textWithStyle(
                    fontWeight: FontWeight.w900,
                    text: 'Selecting a winning participant at random',
                    size: 24.sp,
                    maxLine: 3,
                    color: Constant.textPrimary),
              ),
            _secondsRemaining == 0
                ? const SizedBox.shrink()
                : SizedBox(
                    height: 80.h,
                    child: Center(
                      child: Constant.textWithStyle(
                          fontWeight: FontWeight.bold,
                          text: _secondsRemaining.toString(),
                          size: 50.sp,
                          maxLine: 3,
                          color: Constant.textPrimary),
                    ),
                  ),
            _secondsRemaining == 0
                ? GiveawayPicker(
                    items: widget.data,
                  )
                : const SizedBox.shrink(),
          ],
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _secondsRemaining == 10
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: 100.w,
                height: 6.h,
                child: ElevatedButton(
                  onPressed: _secondsRemaining == 10 ? startTimer : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constant.bgPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: Constant.textWithStyle(
                      text: 'Start',
                      size: 16.sp,
                      color: Constant.textSecondary,
                      fontWeight: FontWeight.w900),
                ),
              ),
            )
          : Container(),
    );
  }
}
