class Alerts {
  String? senderName;
  String? event;
  int? start;
  int? end;
  String? description;
  List<String>? tags;

  Alerts(
      {this.senderName,
      this.event,
      this.start,
      this.end,
      this.description,
      this.tags});

  Alerts.fromJson(Map<String, dynamic> json) {
    senderName = json['sender_name'];
    event = json['event'];
    start = json['start'];
    end = json['end'];
    description = json['description'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_name'] = this.senderName;
    data['event'] = this.event;
    data['start'] = this.start;
    data['end'] = this.end;
    data['description'] = this.description;
    data['tags'] = this.tags;
    return data;
  }
}
