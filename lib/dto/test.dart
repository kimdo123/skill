class ProfileDto {
  final String username;
  final String height;
  final String weight;
  final String brith;
  final String stepTarget;
  final String waterTarget;

  ProfileDto({
    required this.username,
    required this.height,
    required this.weight,
    required this.brith,
    required this.stepTarget,
    required this.waterTarget,
  });



  @override
  String toString() {
    return 'ProfileDto{username: $username, height: $height, weight: $weight, brith: $brith, stepTarget: $stepTarget, waterTarget: $waterTarget}';
  }
}
