class HealthMetric {
  final String id;
  final String type;
  final String value;
  final String unit;
  final DateTime timestamp;
  final String status; // e.g., 'Normal', 'Elevated', 'Low'

  HealthMetric({
    required this.id,
    required this.type,
    required this.value,
    required this.unit,
    required this.timestamp,
    required this.status,
  });

  factory HealthMetric.fromJson(Map<String, dynamic> json) {
    return HealthMetric(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      value: json['value'] ?? '',
      unit: json['unit'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 'Normal',
    );
  }
}
