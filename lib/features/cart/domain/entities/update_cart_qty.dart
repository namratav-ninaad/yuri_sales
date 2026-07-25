class UpdateCartQty {
  final int lineId;
  final int qty;

  const UpdateCartQty({required this.lineId, required this.qty});

  Map<String, dynamic> toMap() {
    return {"line_id": lineId, "qty": qty};
  }
}
