class TopStoriesData {
    String? by;
    int? descendants;
    int? id;
    int? score;
    int? time;
    String? title;
    String? type;
    String? url;

    TopStoriesData({
        this.by,
        this.descendants,
        this.id,
        this.score,
        this.time,
        this.title,
        this.type,
        this.url,
    });

    factory TopStoriesData.fromJson(Map<String, dynamic> json) => TopStoriesData(
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
