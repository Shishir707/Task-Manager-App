class StatusCountModel {
  final String id;
  final int sum;

  StatusCountModel({required this.id, required this.sum});

  factory StatusCountModel.fromJson(Map<String, dynamic> jsonData) {
    return StatusCountModel(id: jsonData["_id"], sum: jsonData["sum"]);
  }
}
