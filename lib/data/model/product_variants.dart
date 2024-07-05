import 'package:ecommerce_flutter_application/data/model/variant.dart';
import 'package:ecommerce_flutter_application/data/model/variant_type.dart';

class ProductVariants {
  VariantType variantType;
  List<Variant> variantList;

  ProductVariants(this.variantType, this.variantList);
}
