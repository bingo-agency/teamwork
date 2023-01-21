class ProjectModel {
  final String? id;
  final String? title;
  final String? ribbon;
  final String? description;
  final String? price;
  final String? address;
  final String? city;
  final String? views;
  final String? type;
  final String? year_build;
  final String? image_link;
  final String? video_link;
  final String? timestamp;

  ProjectModel(
      {required this.id,
      required this.title,
      required this.ribbon,
      required this.description,
      required this.price,
      required this.address,
      required this.city,
      required this.views,
      required this.type,
      required this.year_build,
      required this.image_link,
      required this.video_link,
      required this.timestamp});
}
