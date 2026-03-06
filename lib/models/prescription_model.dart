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
  final String id;
  final String? medicationId;
  final String name;
  final String? type;
  final String? description;
  final String dosage;
  final String frequency;
  final String duration;
  final DateTime? endDate;
  final String? specialInstructions;
  final String? refillStatus;

  Medication({
    required this.id,
    this.medicationId,
    required this.name,
    this.type,
    this.description,
    required this.dosage,
    required this.frequency,
    required this.duration,
    this.endDate,
    this.specialInstructions,
    this.refillStatus,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'] ?? json['_id'] ?? '',
      medicationId: json['medicationId'],
      name: json['medication'] ?? json['name'] ?? '',
      type: json['type'],
      description: json['description'],
      dosage: json['dosage'] ?? '',
      frequency: json['frequency'] ?? '',
      duration: json['duration'] ?? '',
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      specialInstructions: json['specialInstructions'],
      refillStatus: json['refillStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicationId': medicationId,
      'name': name,
      'type': type,
      'description': description,
      'dosage': dosage,
      'frequency': frequency,
      'duration': duration,
      'endDate': endDate?.toIso8601String(),
      'specialInstructions': specialInstructions,
      'refillStatus': refillStatus,
    };
  }
}
