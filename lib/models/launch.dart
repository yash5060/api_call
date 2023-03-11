class Launch {
  String? launchYear;
  String? missionName;
  String? rocketName;
  String? launchTime;
  Launch({required this.launchYear,required this.missionName,
    required this.rocketName,required this.launchTime});
  factory Launch.fromJson(List<dynamic> Json,int idx)
    => Launch(
        launchYear: Json[idx]['launch_year'],
        missionName: Json[idx]['mission_name'],
        rocketName: Json[idx]['rocket']['rocket_name'],
        launchTime: Json[idx]['launch_date_local'],
    );
}