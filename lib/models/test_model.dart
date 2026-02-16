class Test {
  final String id;
  final String name;
  final String? description;
  final double? price;
  final String? category;
  final String? preparationInstructions;
  final String? sampleType;
  final String? reportDeliveryTime;
  final bool? isPopular;
  final bool? homeCollectionAvailable;

  Test({
    required this.id,
    required this.name,
    this.description,
    this.price,
    this.category,
    this.preparationInstructions,
    this.sampleType,
    this.reportDeliveryTime,
    this.isPopular,
    this.homeCollectionAvailable,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      price: json['price']?.toDouble(),
      category: json['category'],
      preparationInstructions:
          json['preparationInstructions'] ?? json['preparation'],
      sampleType: json['sampleType'],
      reportDeliveryTime: json['reportDeliveryTime'] ?? json['deliveryTime'],
      isPopular: json['isPopular'] ?? false,
      homeCollectionAvailable: json['homeCollectionAvailable'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'preparationInstructions': preparationInstructions,
      'sampleType': sampleType,
      'reportDeliveryTime': reportDeliveryTime,
      'isPopular': isPopular,
      'homeCollectionAvailable': homeCollectionAvailable,
    };
  }
}
