abstract class CategoryProductEvent {}

class CategoryProductInitializeEvent extends CategoryProductEvent {
  String categoryId;

  CategoryProductInitializeEvent(this.categoryId);
}
