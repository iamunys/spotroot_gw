import 'package:get/get.dart';
import 'package:spotroot_gw/Api/api.dart';
import 'package:spotroot_gw/model/getAllUser.dart';
import 'package:spotroot_gw/model/getWinners.dart';

class Apicontrollers extends GetxController {
  Future<List<GetAllUser>?>? getAllUsers;
  Future<List<GetWinners>?>? getAllWinners;
  Future<void> getAllUsersMethod() async {
    getAllUsers = GetAllApi.getAllParticipant();
    update();
  }

  Future<void> getAllWinnersMethod({required int winner}) async {
    getAllWinners = GetAllApi.getAllWinners(winner: winner);
    update();
  }
}
