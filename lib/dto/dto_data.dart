class ProfileDto {
  String? mberId;
  String? sexdstn;
  int? height;
  int? weight;
  String? name;
  String? brthdy;
  int? stepTarget;
  int? waterTarget;

  ProfileDto({
    this.mberId,
    this.sexdstn,
    this.height,
    this.weight,
    this.name,
    this.brthdy,
    this.stepTarget,
    this.waterTarget,
  });

  factory ProfileDto.fromJson(dynamic json) {
    return ProfileDto(
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

  ProfileDto copyWith({
    String? mberId,
    String? sexdstn,
    int? height,
    int? weight,
    String? name,
    String? brthdy,
    int? stepTarget,
    int? waterTarget,
  }) {
    return ProfileDto(
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
