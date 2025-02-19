import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotroot_gw/Api/DioUtilities.dart';
import 'package:spotroot_gw/constant/constant.dart';
import 'package:spotroot_gw/controlls/apiControllers.dart';
import 'package:spotroot_gw/controlls/widgetsController.dart';
import 'package:spotroot_gw/countdownScreen.dart';
import 'package:spotroot_gw/model/getAllUser.dart';

class ListAllUsers extends StatefulWidget {
  const ListAllUsers({Key? key}) : super(key: key);

  @override
  State<ListAllUsers> createState() => _ListAllUsersState();
}

class _ListAllUsersState extends State<ListAllUsers> {
  final ScrollController _scrollController = ScrollController();
  final Apicontrollers apiController = Get.put(Apicontrollers());
  final Widgetscontroller widgetsController = Get.put(Widgetscontroller());

  int page = 1;
  bool isLoading = false;
  List<GetAllUser> data = [];

  @override
  void initState() {
    super.initState();
    _fetchInitialParticipants();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchInitialParticipants() {
    getParticipants(page: page.toString(), pageSize: '50');
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreParticipants();
    }
  }

  void _loadMoreParticipants() {
    if (!isLoading) {
      setState(() {
        page++;
      });
      getParticipants(page: page.toString(), pageSize: '50');
    }
  }

  Future<void> getParticipants({
    required String page,
    required String pageSize,
  }) async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final dio = await DioUtilities.dioInstance;
      final response = await dio.get(
        'https://api.spotroot.com/admin/v1/giveaway-participants?currentPage=$page&pageSize=$pageSize&viewByOccurance=0',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      debugPrint('Get Paginated spot list : ${response.data}');

      if (response.statusCode == 200) {
        debugPrint('Get Paginated spot list : ${response.data}');
        final newData = List<GetAllUser>.from(
          (response.data['data'] as List).map(
            (item) => GetAllUser.fromJson(item),
          ),
        ).toList();

        setState(() {
          data.addAll(newData);
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching participants: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: RawScrollbar(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        controller: _scrollController,
        thumbVisibility: true,
        thickness: 2,
        radius: const Radius.circular(20),
        thumbColor: Colors.white,
        child: Container(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Constant.textWithStyle(
                      fontWeight: FontWeight.w900,
                      text: 'Good Luck \nEVERYBODY!',
                      size: 24.sp,
                      maxLine: 3,
                      color: Constant.textPrimary,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: data.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < data.length) {
                          return buildCards(
                              data[index]); // Pass single user object
                        } else if (isLoading) {
                          return const Center(
                            child: CupertinoActivityIndicator(
                              color: Colors.white,
                            ),
                          );
                        } else {
                          return const Center(
                            child: CupertinoActivityIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 1.h),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: 100.w,
          height: 6.h,
          child: ElevatedButton(
            onPressed: () async {
              Get.to(CountDownScreen(
                data: data,
              ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Constant.bgPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            child: Constant.textWithStyle(
              text: 'Find Winner',
              size: 16.sp,
              color: Constant.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCards(GetAllUser userData) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      minLeadingWidth: 0,
      minTileHeight: 0,
      leading: const CircleAvatar(
        child: Icon(
          Icons.person,
        ),
      ),
      title: Constant.textWithStyle(
        text: userData.userName ?? 'N/A',
        size: 16.sp,
        maxLine: 3,
        fontWeight: FontWeight.w900,
        color: Constant.textPrimary,
      ),
      subtitle: Constant.textWithStyle(
        text: userData.fullName ?? 'N/A',
        size: 14.sp,
        maxLine: 3,
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(255, 224, 224, 224),
      ),
    );
  }
}
