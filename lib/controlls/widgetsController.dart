import 'package:get/get.dart';

class Widgetscontroller extends GetxController {
  int _numberOfWinner = 1;
  int get numberOfWinner => _numberOfWinner;
  void plusNumberOFWinner() {
    _numberOfWinner += 1;
    print(_numberOfWinner);
    update();
  }

  void minNumberOFWinner() {
    _numberOfWinner -= 1;
    print(_numberOfWinner);
    update();
  }

  bool _isGt = false;
  bool get isGt => _isGt;
  set isGt(bool v) {
    _isGt = v;
    update();
  }

  bool _isConfirmed = false;
  bool get isConfirmed => _isConfirmed;
  set isConfirmed(bool v) {
    _isConfirmed = v;
    update();
  }

  bool _iexpand = false;
  bool get iexpand => _iexpand;
  set iexpand(bool v) {
    _iexpand = v;
    update();
  }
}
