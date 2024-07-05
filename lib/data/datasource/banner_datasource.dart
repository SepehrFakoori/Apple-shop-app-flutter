import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_application/data/model/banner.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:ecommerce_flutter_application/util/api_exception.dart';

abstract class IBannerDataSource {
  Future<List<BannerCampaign>> getBanners();
}

class BannerRemoteDatasource extends IBannerDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<BannerCampaign>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');

      return response.data["items"]
          .map<BannerCampaign>((jsonObject) => BannerCampaign.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }
}
