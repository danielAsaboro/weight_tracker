class Weight {
  final String? id;
  final String userId;
  final double value;
  final DateTime timeAdded;
  final String? foodEaten;

  Weight({
    this.id,
    required this.userId,
    required this.value,
    this.foodEaten,
    DateTime? timeAdded,
  }) : timeAdded = timeAdded ?? DateTime.now();

  factory Weight.fromJson(String docId, Map<String, dynamic> json) {
    return Weight(
      id: docId,
      userId: json['userId'],
      value: json['value'],
      foodEaten: json['foodEaten'],
      timeAdded: DateTime.parse(
        json['timeAdded'],
      ),
    );
  }

  Weight copyWith({
    String? id,
    String? userId,
    double? value,
    DateTime? timeAdded,
    String? foodEaten,
  }) {
    return Weight(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      value: value ?? this.value,
      foodEaten: foodEaten ?? this.foodEaten,
      timeAdded: timeAdded ?? this.timeAdded,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'value': value,
      'userId': userId,
      'timeAdded': timeAdded.toIso8601String(),
      'foodEaten': foodEaten,
    };
  }
}
