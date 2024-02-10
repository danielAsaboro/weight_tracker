 class Weight {
  final int? id;
  final double value;
  final DateTime timeAdded;

  Weight(
    this.id,
    this.value,
  ) : timeAdded = DateTime.now();
}
