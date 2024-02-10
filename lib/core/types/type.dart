typedef Json = Map<String, dynamic>;
typedef OrderBy = ({Filter filter, FilterDirection direction});


enum Filter {
  date,
  max,
  min,
}

enum FilterDirection {
  ascending(false),
  descending(true);

  const FilterDirection(this.inDescendingOrder);
  final bool inDescendingOrder;
}
