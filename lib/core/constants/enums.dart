enum OrderBy {
  dateUp("timeAdded", false),
  dateDown("timeAdded", true),
  valueUp("value", false),
  valueDown("value", true);

  const OrderBy(
    this.filter,
    this.inDescendingOrder,
  );

  final String filter;
  final bool inDescendingOrder;
}
