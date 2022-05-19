class ObModel {
  final String id;
  final String uid;
  final DateTime dateTime;
  final String incidentType;
  final String reportBy;
  final String incidentBrief;
  final String department;
  final String escalateTo;
  final String threatLevel;
  final String site;

  ObModel({
    required this.id,
    required this.uid,
    required this.dateTime,
    required this.incidentType,
    required this.reportBy,
    required this.incidentBrief,
    required this.department,
    required this.escalateTo,
    required this.threatLevel,
    required this.site,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'alarmType': incidentType,
      'reportBy': reportBy,
      'incidentBrief': incidentBrief,
      'department': department,
      'escalateTo': escalateTo,
      'threatLevel': threatLevel,
      'site': site,
    };
  }

  factory ObModel.fromMap(Map<String, dynamic> map) {
    return ObModel(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      incidentType: map['alarmType'] ?? '',
      reportBy: map['reportBy'] ?? '',
      incidentBrief: map['incidentBrief'] ?? '',
      department: map['department'] ?? '',
      escalateTo: map['escalateTo'] ?? '',
      threatLevel: map['threatLevel'] ?? '',
      site: map['site'] ?? '',
    );
  }
}
