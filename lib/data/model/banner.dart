class BannerCampaign {
  String? id;
  String? collectionId;
  String? thumbnail;
  String? categoryId;

  BannerCampaign(
    this.id,
    this.collectionId,
    this.thumbnail,
    this.categoryId,
  );

  factory BannerCampaign.fromMapJson(Map<String, dynamic> jsonObject) {
    return BannerCampaign(
      jsonObject['id'],
      jsonObject['collectionId'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      jsonObject['categoryId'],
    );
  }
}
