class Prescription {
  final String id;
  final String patientId;
  final String doctorId;
  final String? appointmentId;
  final DateTime date;
  final List<Medication> medications;
  final String? diagnosis;
  final String? notes;

  Prescription({
    required this.id,
    required this.patientId,
    required this.doctorId,
    this.appointmentId,
    required this.date,
    required this.medications,
    this.diagnosis,
    this.notes,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['_id'] ?? json['id'] ?? '',
      patientId: json['patientId'] ?? json['patient'] ?? '',
      doctorId: json['doctorId'] ?? json['doctor'] ?? '',
      appointmentId: json['appointmentId'],
      date: DateTime.parse(
        json['date'] ?? json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      medications:
          (json['medications'] as List<dynamic>?)
              ?.map((m) => Medication.fromJson(m))
              .toList() ??
          [],
      diagnosis: json['diagnosis'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'appointmentId': appointmentId,
      'date': date.toIso8601String(),
      'medications': medications.map((m) => m.toJson()).toList(),
      'diagnosis': diagnosis,
      'notes': notes,
    };
  }
}

class Medication {
  final String name;
  final String dosage;
  final String frequency;
  final String duration;
  final String? instructions;

  Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.duration,
    this.instructions,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'] ?? '',
      dosage: json['dosage'] ?? '',
      frequency: json['frequency'] ?? '',
      duration: json['duration'] ?? '',
      instructions: json['instructions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'duration': duration,
      'instructions': instructions,
    };
  }
}
