class NewStoriesData {
    String? by;
    int? descendants;
    int? id;
    int? score;
    int? time;
    String?title;
    String?type;
    String?url;

    NewStoriesData({
        this.by,
        this.descendants,
        this.id,
        this.score,
        this.time,
        this.title,
        this.type,
        this.url,
    });

    factory NewStoriesData.fromJson(Map<String, dynamic> json) => NewStoriesData(
        by: json["by"],
        descendants: json["descendants"],
        id: json["id"],
        score: json["score"],
        time: json["time"],
        title: json["title"],
        type: json["type"],
        url: json["url"],
    );
}