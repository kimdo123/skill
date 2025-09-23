class ProfileDto {
  String? userdId;
  String? sexdstn;
  String? username;
  int? height;
  int? weight;
  String? brith;
  int? stepTarget;
  int? waterTarget;

  ProfileDto({
    this.userdId,
    this.sexdstn,
    this.username,
    this.height,
    this.weight,
    this.brith,
    this.stepTarget,
    this.waterTarget,
  });

  @override
  String toString() {
    return 'ProfileDto{userdId: $userdId, sexdstn: $sexdstn, username: $username, height: $height, weight: $weight, brith: $brith, stepTarget: $stepTarget, waterTarget: $waterTarget}';
  }
}
