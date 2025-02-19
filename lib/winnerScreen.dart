import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotroot_gw/Api/api.dart';
import 'package:spotroot_gw/constant/constant.dart';
import 'package:spotroot_gw/controlls/apiControllers.dart';
import 'package:spotroot_gw/controlls/widgetsController.dart';
import 'package:spotroot_gw/model/getWinners.dart';

class Winnerscreen extends StatefulWidget {
  const Winnerscreen({super.key});

  @override
  State<Winnerscreen> createState() => _WinnerscreenState();
}

class _WinnerscreenState extends State<Winnerscreen> {
  final apiController = Get.put(Apicontrollers());

  late ScrollController _scrollController;
  @override
  void initState() {
    Get.put(Widgetscontroller());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      apiController.getAllWinnersMethod(winner: 1);
    });
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Constant.textWithStyle(
                      fontWeight: FontWeight.w900,
                      text: 'Congratulations, you\'ve won!',
                      size: 24.sp,
                      maxLine: 3,
                      color: Constant.textPrimary),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Expanded(
                child: GetBuilder<Apicontrollers>(
                  init: Apicontrollers(),
                  builder: (apiController) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await apiController.getAllWinnersMethod(winner: 1);
                      },
                      child: FutureBuilder<List<GetWinners>?>(
                        future: apiController.getAllWinners,
                        builder: (context, snapshot) {
                          // Loading State
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CupertinoActivityIndicator(
                                color: Constant.bgPrimary,
                                radius: 20,
                              ),
                            );
                          }

                          // Error State
                          if (snapshot.hasError) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 60,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Error: ${snapshot.error}',
                                    style: TextStyle(
                                      color: Constant.textPrimary,
                                      fontSize: 16.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  // ElevatedButton(
                                  //   onPressed: () => apiController
                                  //       .getAllWinnersMethod(winners: 1),
                                  //   child: const Text('Retry'),
                                  // ),
                                ],
                              ),
                            );
                          }

                          // Empty State
                          if (!snapshot.hasData ||
                              snapshot.data == null ||
                              snapshot.data!.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.list_alt,
                                    color: Constant.bgPrimary,
                                    size: 60,
                                  ),
                                  const SizedBox(height: 16),
                                  Constant.textWithStyle(
                                    text: 'No Winners Found',
                                    size: 18.sp,
                                    maxLine: 2,
                                    fontWeight: FontWeight.w600,
                                    color: Constant.textPrimary,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }

                          // Data State
                          final data = snapshot.data!;
                          return ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: buildCards(data[index]),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildCards(GetWinners data) {
    return GetBuilder<Widgetscontroller>(
        init: Widgetscontroller(),
        builder: (wid) {
          return InkWell(
            onTap: () {
              if (wid.iexpand) {
                wid.iexpand = false;
              } else {
                wid.iexpand = true;
              }
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                width: 100.w,
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(data.profileImage!.resized!),
                          backgroundColor: Colors.grey[200],
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Constant.textWithStyle(
                              text: data.userName!,
                              size: 15.sp,
                              maxLine: 3,
                              fontWeight: FontWeight.w900,
                              color: Constant.textSecondary,
                            ),
                            Constant.textWithStyle(
                              text: data.fullName!,
                              size: 14.sp,
                              maxLine: 3,
                              fontWeight: FontWeight.w600,
                              color: Constant.textSecondary,
                            ),
                            Constant.textWithStyle(
                              text: 'Km Purhcased : ${data.kmsInHand}',
                              size: 14.sp,
                              maxLine: 3,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 0, 150, 244),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (wid.iexpand) ...[
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => wid.isGt = false,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: .5,
                                      color: !wid.isGt
                                          ? Colors.transparent
                                          : Constant.textSecondary),
                                  color: !wid.isGt
                                      ? Constant.bgBlue
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Constant.textWithStyle(
                                    text: '16 PRO',
                                    textAlign: TextAlign.center,
                                    size: 14.sp,
                                    color: !wid.isGt
                                        ? Constant.textPrimary
                                        : Constant.textSecondary,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => wid.isGt = true,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: .5,
                                      color: wid.isGt
                                          ? Colors.transparent
                                          : Constant.textSecondary),
                                  color: wid.isGt
                                      ? Constant.bgBlue
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Constant.textWithStyle(
                                    text: 'GT 650',
                                    textAlign: TextAlign.center,
                                    size: 14.sp,
                                    color: wid.isGt
                                        ? Constant.textPrimary
                                        : Constant.textSecondary,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 4.5.h,
                        width: 100.w,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              final String product =
                                  wid.isGt ? 'RE-GT-650' : 'IPHONE-16-PRO';

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const Center(
                                    child: CircularProgressIndicator()),
                              );

                              bool isSuccessful = await GetAllApi.addWinner(
                                winnerId: data.id.toString(),
                                product: product,
                              );

                              Navigator.of(context).pop();

                              if (isSuccessful) {
                                setState(() {
                                  wid.isConfirmed = true;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Constant.textWithStyle(
                                      text:
                                          'Winner successfully added for $product',
                                      size: 15.sp,
                                      maxLine: 3,
                                      fontWeight: FontWeight.w600,
                                      color: Constant.textPrimary,
                                    ),
                                    backgroundColor: Constant.bgSecondaryGreen,
                                  ),
                                );
                              } else {
                                setState(() {
                                  wid.isConfirmed = false;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Constant.textWithStyle(
                                      text:
                                          'Winner successfully added for $product',
                                      size: 15.sp,
                                      maxLine: 3,
                                      fontWeight: FontWeight.w600,
                                      color: Constant.textPrimary,
                                    ),
                                    backgroundColor: Constant.bgRed,
                                  ),
                                );
                              }
                            } catch (e) {
                              Navigator.of(context).pop();

                              print('Error adding winner: $e');

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content:
                                      Text('An unexpected error occurred: $e'),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                              );

                              setState(() {
                                wid.isConfirmed = false;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                wid.isConfirmed ? Colors.grey : Colors.pink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Constant.textWithStyle(
                              text: wid.isConfirmed ? 'Confirmed' : 'Confirm',
                              size: 14.sp,
                              color: Constant.textPrimary,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          );
        });
  }
}
