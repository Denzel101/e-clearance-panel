import 'package:cloud_firestore/cloud_firestore.dart';

class TableModel {
  final String incidentType;
  final String reportBy;
  final String incidentBrief;
  final String department;
  final String escalateTo;
  final String threatLevel;
  final String site;
  final String resolution;
  final DocumentReference reference;

  TableModel.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['incidentType'] != null),
        assert(map['reportBy'] != null),
        assert(map['incidentBrief'] != null),
        assert(map['department'] != null),
        assert(map['escalateTo'] != null),
        assert(map['threatLevel'] != null),
        assert(map['site'] != null),
        assert(map['resolution'] != null),
        incidentType = map['incidentType'] ?? '',
        reportBy = map['reportBy'] ?? '',
        incidentBrief = map['incidentBrief'] ?? '',
        department = map['department'] ?? '',
        escalateTo = map['escalateTo'] ?? '',
        threatLevel = map['threatLevel'] ?? '',
        resolution = map['resolution'] ?? '',
        site = map['site'] ?? '';

  TableModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);
}
