// ignore_for_file: file_names

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

class DioUtilities {
  static final Dio _dio = Dio();

  static Future<CookieJar> get cookieJar async {
    var tempDir = await getTemporaryDirectory();
    var temPath = tempDir.path;
    CookieJar jar = PersistCookieJar(
      storage: FileStorage(temPath),
    );
    return jar;
  }

  static Future<Dio> get dioInstance async {
    return _dio;
  }

  static Future<Dio> get dioInstanceAdd async {
    var jar = await cookieJar;
    _dio.interceptors.add(
      CookieManager(jar),
    );
    return _dio;
  }

  static Future<void> get clearCookie async {
    var jar = await cookieJar;
    jar.deleteAll();
    _dio.interceptors.clear();
  }
}
