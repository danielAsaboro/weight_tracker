enum OrderBy {
  dateUp("timeAdded", true),
  dateDown("timeAdded", false),
  valueUp("value", true),
  valueDown("value", false);

  const OrderBy(
    this.filter,
    this.inDescendingOrder,
  );

  final String filter;
  final bool inDescendingOrder;
}
