class SearchModel {
  final String? id;
  final String? internal_lead_id;
  final String? title;
  final String? description;
  final String? price;
  final String? address;
  final String? city;
  final String? views;
  final String? type;
  final String? property_type;
  final String? purpose;
  final String? land_area;
  final String? year_build;
  final String? primary_image;
  final List? property_images;
  final String? floor_plans;
  final String? public_user_id;
  final String? comments;
  final String? video_link;
  final String? verification_status;
  final String? featured;
  final String? timestamp;
  final String? msg;

  SearchModel(
      {required this.id,
      required this.internal_lead_id,
      required this.title,
      required this.description,
      required this.price,
      required this.address,
      required this.city,
      required this.views,
      required this.type,
      required this.property_type,
      required this.purpose,
      required this.land_area,
      required this.year_build,
      required this.primary_image,
      required this.property_images,
      required this.floor_plans,
      required this.public_user_id,
      required this.comments,
      required this.video_link,
      required this.verification_status,
      required this.featured,
      required this.timestamp,
      required this.msg});
}
