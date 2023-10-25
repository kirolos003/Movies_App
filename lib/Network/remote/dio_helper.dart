import 'package:dio/dio.dart';

class DioHelper
{
  static Dio? dio;

  static init()
  {
    //https://api.themoviedb.org/3/movie/popular
    //https://api.themoviedb.org/3/movie/popular?api_key=026d58483e3ff0e05eb2e94b38125ce5
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response?>? getData({
  required String url,
    Map<String , dynamic>? query,
})async
  {
    return await dio!.get(
      url,
      queryParameters:query,
    );
  }
}