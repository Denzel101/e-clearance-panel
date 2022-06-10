class ObModel {
  final String id;
  final String uid;
  final DateTime dateTime;
  final String incidentType;
  final String reportBy;
  final String incidentBrief;
  final String resolution;
  final String department;
  final String escalateTo;
  final String threatLevel;
  final String site;
  final String? comment;
  final String? other;

  ObModel({
    required this.id,
    required this.uid,
    required this.dateTime,
    required this.incidentType,
    required this.reportBy,
    required this.incidentBrief,
    required this.resolution,
    required this.department,
    required this.escalateTo,
    required this.threatLevel,
    required this.site,
    this.comment,
    this.other,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'incidentType': incidentType,
      'reportBy': reportBy,
      'incidentBrief': incidentBrief,
      'resolution': resolution,
      'department': department,
      'escalateTo': escalateTo,
      'threatLevel': threatLevel,
      'site': site,
      'comment': comment,
      'other': other,
    };
  }

  factory ObModel.fromMap(Map<String, dynamic> map) {
    return ObModel(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      incidentType: map['incidentType'] ?? '',
      reportBy: map['reportBy'] ?? '',
      incidentBrief: map['incidentBrief'] ?? '',
      resolution: map['resolution'] ?? '',
      department: map['department'] ?? '',
      escalateTo: map['escalateTo'] ?? '',
      threatLevel: map['threatLevel'] ?? '',
      site: map['site'] ?? '',
      comment: map['comment'] ?? '',
      other: map['other'] ?? '',
    );
  }
}
