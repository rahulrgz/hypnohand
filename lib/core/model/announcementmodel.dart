class AnnouncementModel{

  String? imageurl;
  String? videourl;
  String? url;
  String message;
  DateTime date;
  bool status;

//<editor-fold desc="Data Methods">
  AnnouncementModel({
    this.imageurl,
    this.videourl,
    this.url,
    required this.message,
    required this.date,
    required this.status,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnnouncementModel &&
          runtimeType == other.runtimeType &&
          imageurl == other.imageurl &&
          videourl == other.videourl &&
          url == other.url &&
          message == other.message &&
          date == other.date &&
          status == other.status);

  @override
  int get hashCode =>
      imageurl.hashCode ^
      videourl.hashCode ^
      url.hashCode ^
      message.hashCode ^
      date.hashCode ^
      status.hashCode;

  @override
  String toString() {
    return 'AnnouncementModel{' +
        ' imageurl: $imageurl,' +
        ' videourl: $videourl,' +
        ' url: $url,' +
        ' message: $message,' +
        ' date: $date,' +
        ' status: $status,' +
        '}';
  }

  AnnouncementModel copyWith({
    String? imageurl,
    String? videourl,
    String? url,
    String? message,
    DateTime? date,
    bool? status,
  }) {
    return AnnouncementModel(
      imageurl: imageurl ?? this.imageurl,
      videourl: videourl ?? this.videourl,
      url: url ?? this.url,
      message: message ?? this.message,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageurl': this.imageurl,
      'videourl': this.videourl,
      'url': this.url,
      'message': this.message,
      'date': this.date,
      'status': this.status,
    };
  }

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementModel(
      imageurl: map['imageurl'] as String,
      videourl: map['videourl'] as String,
      url: map['url'] as String,
      message: map['message'] as String,
      date: map['date'].toDate(),
      status: map['status'] as bool,
    );
  }

//</editor-fold>
}