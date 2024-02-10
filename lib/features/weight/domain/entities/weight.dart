class Weight {
  final int? id;
  final double value;
  final DateTime timeAdded;

  Weight(
    this.id,
    this.value,
  ) : timeAdded = DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id ,
      'value': value,
      'timeAdded': timeAdded.toIso8601String(),
    };
  }
}
