class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final int experience; // Not in API list, default to 0
  final double rating;
  final int reviewCount; // Not in API list, default to 0
  final double consultationFee;
  final DateTime? nextAvailable; // Not in API list
  final bool isOnline; // Not in API list, default false
  final List<String> languages; // Not in API list, default empty
  final String education; // Not in API list, default empty
  final String hospital; // Not in API list, default empty
  final String? imageUrl;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    this.experience = 0,
    required this.rating,
    this.reviewCount = 0,
    required this.consultationFee,
    this.nextAvailable,
    this.isOnline = false,
    this.languages = const [],
    this.education = '',
    this.hospital = '',
    this.imageUrl,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['_id'] ?? '',
      name: json['doctorName'] ?? '',
      specialty: json['specialization'] ?? '',
      experience: json['experience'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      consultationFee: (json['consultationFee'] ?? 0).toDouble(),
      nextAvailable: json['nextAvailable'] != null ? DateTime.tryParse(json['nextAvailable']) : null,
      isOnline: json['isOnline'] ?? false,
      languages: json['languages'] != null ? List<String>.from(json['languages']) : [],
      education: json['education'] ?? '',
      hospital: json['hospital'] ?? '',
      imageUrl: json['profilePictureURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'doctorName': name,
      'specialization': specialty,
      'profilePictureURL': imageUrl,
      'rating': rating,
      'consultationFee': consultationFee,
      // Include other fields if the API eventually supports them
    };
  }
}
