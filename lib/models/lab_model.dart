class LabModel {
  final String id;
  final String labName;
  final String location;
  final String contactInfo;
  final double rating;

  LabModel({
    required this.id,
    required this.labName,
    required this.location,
    required this.contactInfo,
    required this.rating,
  });

  factory LabModel.fromJson(Map<String, dynamic> json) {
    return LabModel(
      id: json['_id'] ?? '',
      labName: json['labName'] ?? '',
      location: json['location'] ?? '',
      contactInfo: json['contactInfo'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'labName': labName,
      'location': location,
      'contactInfo': contactInfo,
      'rating': rating,
    };
  }
}
