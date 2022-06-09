import 'dart:convert';

class OverModel {
  final String id;
  final String uid;
  final DateTime handedOverAt;
  final DateTime? takeOverAt;
  final String overType;
  final String name;
  final String site;
  final String narrative;
  final String? acceptingName;
  final String? comment;
  final bool isPending;
  OverModel({
    required this.id,
    required this.uid,
    required this.handedOverAt,
    required this.overType,
    required this.name,
    required this.site,
    required this.narrative,
    this.acceptingName,
    this.takeOverAt,
    this.comment,
    this.isPending = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'handedOverAt': handedOverAt.millisecondsSinceEpoch,
      'takeOverAt': takeOverAt?.millisecondsSinceEpoch,
      'overType': overType,
      'uid': uid,
      'name': name,
      'site': site,
      'narrative': narrative,
      'acceptingName': acceptingName,
      'comment': comment,
      'isPending': isPending,
    };
  }

  factory OverModel.fromMap(Map<String, dynamic> map) {
    return OverModel(
      id: map['id'] ?? '',
      handedOverAt: DateTime.fromMillisecondsSinceEpoch(map['handedOverAt']),
      takeOverAt: map['takeOverAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['takeOverAt'])
          : null,
      overType: map['overType'] ?? '',
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      site: map['site'] ?? '',
      narrative: map['narrative'] ?? '',
      acceptingName: map['acceptingName'],
      comment: map['comment'],
      isPending: map['isPending'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory OverModel.fromJson(String source) =>
      OverModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OverModel &&
        other.id == id &&
        other.uid == uid &&
        other.handedOverAt == handedOverAt &&
        other.takeOverAt == takeOverAt &&
        other.overType == overType &&
        other.name == name &&
        other.site == site &&
        other.narrative == narrative &&
        other.acceptingName == acceptingName &&
        other.comment == comment &&
        other.isPending == isPending;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        handedOverAt.hashCode ^
        takeOverAt.hashCode ^
        overType.hashCode ^
        name.hashCode ^
        site.hashCode ^
        narrative.hashCode ^
        acceptingName.hashCode ^
        comment.hashCode ^
        isPending.hashCode;
  }

  @override
  String toString() {
    return 'OverModel(id: $id, uid: $uid, handedOverAt: $handedOverAt, takeOverAt: $takeOverAt, overType: $overType, name: $name, site: $site, narrative: $narrative, acceptingName: $acceptingName, comment: $comment, isPending: $isPending)';
  }
}
