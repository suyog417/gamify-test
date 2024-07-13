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
