class ChampionshipCategory {
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? champId;
  String? categoryId;
  String? categoryName;
  String? champName;

  ChampionshipCategory(
      {this.startDate,
        this.endDate,
        this.startTime,
        this.endTime,
        this.champId,
        this.categoryId,
        this.categoryName,
        this.champName});

  ChampionshipCategory.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'] ?? "";
    endDate = json['end_date'] ?? "";
    startTime = json['start_time'] ?? "";
    endTime = json['end_time'] ?? "";
    champId = json['champ_id'] ?? "";
    categoryId = json['category_id'] ?? "";
    categoryName = json['category_name'] ?? "";
    champName = json['champ_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['champ_id'] = champId;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['champ_name'] = champName;
    return data;
  }
}


class ChampDetails {
  String? modeId;
  String? modeName;
  String? timeMinutes;
  String? noOfQuestion;
  String? champId;
  String? champName;
  String? categoryId;
  String? categoryName;
  Null teacherId;
  Null teacherName;

  ChampDetails(
      {this.modeId,
        this.modeName,
        this.timeMinutes,
        this.noOfQuestion,
        this.champId,
        this.champName,
        this.categoryId,
        this.categoryName,
        this.teacherId,
        this.teacherName});

  ChampDetails.fromJson(Map<String, dynamic> json) {
    modeId = json['mode_id'];
    modeName = json['mode_name'];
    timeMinutes = json['time_minutes'];
    noOfQuestion = json['no_of_question'];
    champId = json['champ_id'];
    champName = json['champ_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    teacherId = json['teacher_id'];
    teacherName = json['teacher_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mode_id'] = modeId;
    data['mode_name'] = modeName;
    data['time_minutes'] = timeMinutes;
    data['no_of_question'] = noOfQuestion;
    data['champ_id'] = champId;
    data['champ_name'] = champName;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['teacher_id'] = teacherId;
    data['teacher_name'] = teacherName;
    return data;
  }
}
