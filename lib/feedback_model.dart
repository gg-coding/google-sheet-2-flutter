class FeedbackModel {
  String timestamp;
  String typeapt;
  String dateapt;
  String resultapt;
  String notes;

  FeedbackModel(
      {this.timestamp, this.typeapt, this.dateapt, this.resultapt, this.notes });

  factory FeedbackModel.fromJson(dynamic json) {
    return FeedbackModel(
      timestamp: "${json['timestamp']}",
      typeapt: "${json['typeapt']}",
      dateapt: "${json['dateapt']}",
      resultapt: "${json['resultapt']}",
      notes: "${json['notes']}",
    );
  }

  Map toJson() => {
        "timestamp": timestamp,
        "typeapt": typeapt,
        "dateapt": dateapt,
        "resultapt": resultapt,
        "notes": notes
      };
}
