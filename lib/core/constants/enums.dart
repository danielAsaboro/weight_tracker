enum OrderBy {
  dateAsc("timeAdded", false),
  dateDsc("timeAdded", true),
  valueAsc("value", false),
  valueDsc("value", true);

  const OrderBy(
    this.filter,
    this.inDescendingOrder,
  );

  final String filter;
  final bool inDescendingOrder;
}
