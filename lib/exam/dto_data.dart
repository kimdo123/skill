class ProfileDtoExam {
  String? mberId;
  String? sexdstn;
  int? height;
  int? weight;
  String? name;
  String? brthdy;
  int? stepTarget;
  int? waterTarget;

  ProfileDtoExam({
    this.mberId,
    this.sexdstn,
    this.height,
    this.weight,
    this.name,
    this.brthdy,
    this.stepTarget,
    this.waterTarget,
  });

  factory ProfileDtoExam.fromJson(dynamic json) {
    return ProfileDtoExam(
      mberId: json['mberId'] ?? '',
      sexdstn: json['sexdstn'] ?? '',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      name: json['name'] ?? '',
      brthdy: json['brthdy'] ?? '',
      stepTarget: json['stepTarget'] ?? 0,
      waterTarget: json['waterTarget'] ?? 0,
    );
  }

  ProfileDtoExam copyWith({
    String? mberId,
    String? sexdstn,
    int? height,
    int? weight,
    String? name,
    String? brthdy,
    int? stepTarget,
    int? waterTarget,
  }) {
    return ProfileDtoExam(
      mberId: mberId ?? this.mberId,
      sexdstn: sexdstn ?? this.sexdstn,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      name: name ?? this.name,
      brthdy: brthdy ?? this.brthdy,
      stepTarget: stepTarget ?? this.stepTarget,
      waterTarget: waterTarget ?? this.waterTarget,
    );
  }

  @override
  String toString() {
    return 'ProfileDto{sexdstn: $sexdstn, height: $height, weight: $weight, name: $name, brthdy: $brthdy, stepTarget: $stepTarget, waterTarget: $waterTarget}';
  }
}
