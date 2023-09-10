class BannerItem {
  final String bannerName;
  final String bannerImage;
  final String description;

  BannerItem({
    required this.bannerName,
    required this.bannerImage,
    required this.description,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      bannerName: json['banner_name'],
      bannerImage: json['banner_image'],
      description: json['description'],
    );
  }
}

class BannerResponse {
  final int status;
  final String message;
  final List<BannerItem> data;

  BannerResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> bannerList = json['data'];
    List<BannerItem> banners =
        bannerList.map((banner) => BannerItem.fromJson(banner)).toList();

    return BannerResponse(
      status: json['status'],
      message: json['message'],
      data: banners,
    );
  }
}
