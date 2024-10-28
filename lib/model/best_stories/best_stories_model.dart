class BestStories {
    String ?by;
    int? descendants;
    int ?id;
    List<int>? kids;
    int? score;
    int ?time;
    String? title;
    String? type;
    String? url;

    BestStories({
        this.by,
        this.descendants,
        this.id,
        this.kids,
        this.score,
        this.time,
        this.title,
        this.type,
        this.url,
    });

    factory BestStories.fromJson(Map<String, dynamic> json) => BestStories(
        by: json["by"],
        descendants: json["descendants"],
        id: json["id"],
        kids: List<int>.from(json["kids"].map((x) => x)),
        score: json["score"],
        time: json["time"],
        title: json["title"],
        type: json["type"],
        url: json["url"],
    );
}