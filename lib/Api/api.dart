import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:spotroot_gw/Api/DioUtilities.dart';
import 'package:spotroot_gw/model/getAllUser.dart';
import 'package:spotroot_gw/model/getWinners.dart';

class GetAllApi {
  static Future<List<GetAllUser>> getAllParticipant() async {
    final dio = await DioUtilities.dioInstance;

    try {
      final response = await dio.get(
        'https://api.spotroot.com/user/v1/admin/giveaway-participants',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        var body = response.data;
        debugPrint('Subscription Plans : $body');
        final parsed =
            List<GetAllUser>.from(body.map((item) => GetAllUser.fromJson(item)))
                .toList();
        return parsed;
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {}
        if (kDebugMode) {
          ('${e.response!.data}');
          (e.response!.headers);
          ('${e.response!.requestOptions}');
        }
        return [];
      } else {
        if (kDebugMode) {
          ('${e.requestOptions}');
          (e.message);
        }
        return [];
      }
    }
  }

  static Future<List<GetWinners>> getAllWinners({required int winner}) async {
    final dio = await DioUtilities.dioInstance;

    try {
      final response = await dio.get(
        'https://api.spotroot.com/user/v1/admin/select-giveaway-users?limit=$winner',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        var body = response.data;
        debugPrint('Winner : $body');
        final parsed =
            List<GetWinners>.from(body.map((item) => GetWinners.fromJson(item)))
                .toList();
        return parsed;
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {}
        if (kDebugMode) {
          ('${e.response!.data}');
          (e.response!.headers);
          ('${e.response!.requestOptions}');
        }
        return [];
      } else {
        if (kDebugMode) {
          ('${e.requestOptions}');
          (e.message);
        }
        return [];
      }
    }
  }

  static Future<bool> addWinner(
      {required String winnerId, required String product}) async {
    final dio = await DioUtilities.dioInstance;

    try {
      final response = await dio
          .post('https://api.spotroot.com/user/v1/admin/giveaway-winner',
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                },
              ),
              data: {"winnerId": winnerId, "product": product});
      if (response.statusCode == 201) {
        var body = response.data;
        debugPrint('Winner Added Response : $body');

        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {}
        if (kDebugMode) {
          ('${e.response!.data}');
          (e.response!.headers);
          ('${e.response!.requestOptions}');
        }
        return false;
      } else {
        if (kDebugMode) {
          ('${e.requestOptions}');
          (e.message);
        }
        return false;
      }
    }
  }
}
