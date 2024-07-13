class GameMode {
  String? modeId;
  String? modeName;
  String? timeMinutes;
  String? noOfQuestion;

  GameMode({this.modeId, this.modeName, this.timeMinutes, this.noOfQuestion});

  GameMode.fromJson(Map<String, dynamic> json) {
    modeId = json['mode_id'];
    modeName = json['mode_name'];
    timeMinutes = json['time_minutes'];
    noOfQuestion = json['no_of_question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mode_id'] = modeId;
    data['mode_name'] = modeName;
    data['time_minutes'] = timeMinutes;
    data['no_of_question'] = noOfQuestion;
    return data;
  }
}
