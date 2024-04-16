class SliderSetting {
  List<dynamic> sliders;

//<editor-fold desc="Data Methods">
  SliderSetting({
    required this.sliders,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SliderSetting &&
          runtimeType == other.runtimeType &&
          sliders == other.sliders);

  @override
  int get hashCode => sliders.hashCode;

  @override
  String toString() {
    return 'SliderSetting{' + ' sliders: $sliders,' + '}';
  }

  SliderSetting copyWith({
    List<dynamic>? sliders,
  }) {
    return SliderSetting(
      sliders: sliders ?? this.sliders,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sliders': this.sliders,
    };
  }

  factory SliderSetting.fromMap(Map<String, dynamic> map) {
    return SliderSetting(
      sliders: map['sliders'] as List<dynamic>,
    );
  }

//</editor-fold>
}
