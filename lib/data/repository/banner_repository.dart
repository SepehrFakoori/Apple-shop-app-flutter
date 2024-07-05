import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter_application/data/datasource/banner_datasource.dart';
import 'package:ecommerce_flutter_application/data/model/banner.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:ecommerce_flutter_application/util/api_exception.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannerCampaign>>> getBanners();
}

class BannerRepository extends IBannerRepository {
  final IBannerDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<BannerCampaign>>> getBanners() async {
    try {
      var response = await _dataSource.getBanners();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error we got!");
    }
  }
}
