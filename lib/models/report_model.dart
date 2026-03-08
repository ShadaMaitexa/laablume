class Report {
  final String id;
  final String title;
  final String category;
  final DateTime date;
  final String status;
  final String? reportUrl;
  final DateTime? resultDate;
  final String type; // lab_test or doctor_exam
  final String? image;
  final String? doctorName;
  final Map<String, dynamic>? aiAnalysis;

  Report({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.status,
    this.reportUrl,
    this.resultDate,
    required this.type,
    this.image,
    this.doctorName,
    this.aiAnalysis,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] ?? json['_id'] ?? '',
      title: json['title'] ?? json['testName'] ?? '',
      category: json['category'] ?? 'General',
      date: DateTime.parse(
        json['date'] ?? json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      status: json['status'] ?? 'pending',
      reportUrl: json['reportUrl'] ?? json['url'] ?? json['fileUrl'],
      resultDate: json['resultDate'] != null
          ? DateTime.parse(json['resultDate'])
          : null,
      type: json['type'] ?? 'lab_test',
      image: json['image'],
      doctorName: json['doctorName'],
      aiAnalysis: json['aiAnalysis'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'date': date.toIso8601String(),
      'status': status,
      'reportUrl': reportUrl,
      'resultDate': resultDate?.toIso8601String(),
      'type': type,
      'image': image,
      'doctorName': doctorName,
      'aiAnalysis': aiAnalysis,
    };
  }

  // Helper method for Report visibility rules
  bool get shouldShowReport =>
      status.toLowerCase().contains('normal') ||
      status.toLowerCase().contains('results') ||
      status.toLowerCase() == 'completed' ||
      status.toLowerCase() == 'verified';

  bool get shouldShowUnderReview => reportUrl != null && !shouldShowReport;

  bool get shouldShowNothing => reportUrl == null;
}
