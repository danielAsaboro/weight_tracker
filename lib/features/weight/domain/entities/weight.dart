class Weight {
  final String? id;
  final double value;
  final DateTime timeAdded;
  final String? foodEaten;

  Weight({
    this.id,
    required this.value,
    this.foodEaten,
    DateTime? timeAdded,
  }) : timeAdded = timeAdded ?? DateTime.now();

  factory Weight.fromJson(String docId, Map<String, dynamic> json) {
    return Weight(
      id: docId,
      value: json['value'],
      foodEaten: json['foodEaten'],
      timeAdded: DateTime.parse(
        json['timeAdded'],
      ),
    );
  }

  Weight copyWith({
    String? id,
    double? value,
    DateTime? timeAdded,
    String? foodEaten,
  }) {
    return Weight(
      id: id ?? this.id,
      value: value ?? this.value,
      foodEaten: foodEaten ?? this.foodEaten,
      timeAdded: timeAdded ?? this.timeAdded,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'timeAdded': timeAdded.toIso8601String(),
      'foodEaten': foodEaten,
    };
  }
}
