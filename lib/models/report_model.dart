class Report {
  final String id;
  final String bookingId;
  final String patientId;
  final String labId;
  final String testName;
  final DateTime date;
  final String status; // pending, validated, delivered
  final String? fileUrl;
  final bool? isValidated;
  final String? validatedBy;
  final DateTime? validatedAt;
  final Map<String, dynamic>? results;

  Report({
    required this.id,
    required this.bookingId,
    required this.patientId,
    required this.labId,
    required this.testName,
    required this.date,
    required this.status,
    this.fileUrl,
    this.isValidated,
    this.validatedBy,
    this.validatedAt,
    this.results,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['_id'] ?? json['id'] ?? '',
      bookingId: json['bookingId'] ?? '',
      patientId: json['patientId'] ?? '',
      labId: json['labId'] ?? '',
      testName: json['testName'] ?? '',
      date: DateTime.parse(
        json['date'] ?? json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      status: json['status'] ?? 'pending',
      fileUrl: json['fileUrl'] ?? json['url'],
      isValidated: json['isValidated'] ?? false,
      validatedBy: json['validatedBy'],
      validatedAt: json['validatedAt'] != null
          ? DateTime.parse(json['validatedAt'])
          : null,
      results: json['results'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingId': bookingId,
      'patientId': patientId,
      'labId': labId,
      'testName': testName,
      'date': date.toIso8601String(),
      'status': status,
      'fileUrl': fileUrl,
      'isValidated': isValidated,
      'validatedBy': validatedBy,
      'validatedAt': validatedAt?.toIso8601String(),
      'results': results,
    };
  }
}
