import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  final String? url;
  final String? desc;
  final String? title;
  final String? id;

  Video({
    this.url,
    this.desc,
    this.title,
    this.id,
  });

  factory Video.fromDoc(QueryDocumentSnapshot doc) {
    return Video(
      url: doc.get('url'),
      title: doc.get('title'),
      desc: doc.get('desc'),
      id: doc.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'desc': desc,
    };
  }
}
