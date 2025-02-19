// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotroot_gw/Api/api.dart';
import 'package:spotroot_gw/ListUsers.dart';
import 'package:spotroot_gw/constant/constant.dart';
import 'package:spotroot_gw/controlls/widgetsController.dart';
import 'package:spotroot_gw/countdownScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Get.put(Widgetscontroller());

    return Scaffold(
      backgroundColor: Colors.purple,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.all(20),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Icon(
                        Icons.wallet_giftcard_rounded,
                        size: 40.sp,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Constant.textWithStyle(
                    fontWeight: FontWeight.w900,
                    text: 'PASTE YOUR LINK HERE',
                    size: 15.sp,
                    maxLine: 3,
                    color: Constant.textPrimary),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Constant.textPrimary,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: controller,
                    cursorColor: Constant.textSecondary,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      border: InputBorder.none,
                      hintText: 'Paste your link',
                      hintStyle: TextStyle(
                        fontFamily: "Nunito",
                        color: Constant.textSecondary.withOpacity(.5),
                        fontSize: 15.sp,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: "Nunito",
                      color: Constant.textSecondary,
                      fontSize: 16.sp,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 3.h,
                // ),
                // Constant.textWithStyle(
                //     text: 'Number of Winners',
                //     size: 14.sp,
                //     color: Constant.bgPrimary.withOpacity(.8),
                //     fontWeight: FontWeight.w900),
                // SizedBox(
                //   height: 1.h,
                // ),
                // GetBuilder<Widgetscontroller>(
                //     init: Widgetscontroller(),
                //     builder: (wid) {
                //       return Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           InkWell(
                //             onTap: () {
                //               wid.minNumberOFWinner();
                //             },
                //             child: Container(
                //                 padding: const EdgeInsets.all(10),
                //                 decoration: const BoxDecoration(
                //                     shape: BoxShape.circle,
                //                     color: Constant.bgPrimary),
                //                 child: Center(
                //                   child: Icon(
                //                     Icons.remove,
                //                     size: 23.sp,
                //                     color: Constant.textSecondary,
                //                   ),
                //                 )),
                //           ),
                //           Constant.textWithStyle(
                //               text: '${wid.numberOfWinner}',
                //               size: 18.sp,
                //               color: Constant.bgPrimary,
                //               fontWeight: FontWeight.w900),
                //           InkWell(
                //             onTap: () {
                //               wid.plusNumberOFWinner();
                //             },
                //             child: Container(
                //                 padding: const EdgeInsets.all(10),
                //                 decoration: const BoxDecoration(
                //                     shape: BoxShape.circle,
                //                     color: Constant.bgPrimary),
                //                 child: Center(
                //                   child: Icon(
                //                     Icons.add,
                //                     size: 23.sp,
                //                     color: Constant.textSecondary,
                //                   ),
                //                 )),
                //           )
                //         ],
                //       );
                //     }),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  width: 100.w,
                  height: 6.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.text.isNotEmpty) {
                        if (controller.text.length > 30) {
                          Get.to(const ListAllUsers());
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constant.bgPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: Constant.textWithStyle(
                        text: 'Confirm',
                        size: 16.sp,
                        color: Constant.textSecondary,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20),
      //   child:
      // ),
    );
  }
}
