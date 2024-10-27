
// import 'dart:convert';

// LatestNews latestNewsFromJson(String str) => LatestNews.fromJson(json.decode(str));

// String latestNewsToJson(LatestNews data) => json.encode(data.toJson());

// class LatestNews {
//     String ?status;
//     int ?totalResults;
//     List<Result> ?results;

//     LatestNews({
//         this.status,
//         this.totalResults,
//         this.results,
//     });

//     factory LatestNews.fromJson(Map<String, dynamic> json) => LatestNews(
//         status: json["status"],
//         totalResults: json["totalResults"],
//         results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "totalResults": totalResults,
//         "results": List<dynamic>.from(results!.map((x) => x.toJson())),
//     };
// }
// class Result {
//     String? articleId;
//     String? title;
//     String? link;
//     dynamic keywords;
//     dynamic creator;
//     dynamic videoUrl;
//     String? description;
//     String? content;
//     DateTime? pubDate;
//     String? pubDateTz;
//     String? imageUrl;
//     String? sourceId;
//     int? sourcePriority;
//     String? sourceName;
//     String? sourceUrl;
//     String? sourceIcon;
//     String? language;
//     List<String>? country;
//     List<String>? category;
//     List<String>? aiTag;
//     dynamic aiRegion;
//     dynamic aiOrg;
//     String? sentiment;
//     SentimentStats? sentimentStats;
//     bool? duplicate;

//     Result({
//         this.articleId,
//         this.title,
//         this.link,
//         this.keywords,
//         this.creator,
//         this.videoUrl,
//         this.description,
//         this.content,
//         this.pubDate,
//         this.pubDateTz,
//         this.imageUrl,
//         this.sourceId,
//         this.sourcePriority,
//         this.sourceName,
//         this.sourceUrl,
//         this.sourceIcon,
//         this.language,
//         this.country,
//         this.category,
//         this.aiTag,
//         this.aiRegion,
//         this.aiOrg,
//         this.sentiment,
//         this.sentimentStats,
//         this.duplicate,
//     });

//     factory Result.fromJson(Map<String, dynamic> json) => Result(
//         articleId: json["article_id"],
//         title: json["title"],
//         link: json["link"],
//         keywords: json["keywords"],
//         creator: json["creator"],
//         videoUrl: json["video_url"],
//         description: json["description"],
//         content: json["content"],
//         pubDate: json["pubDate"] != null ? DateTime.tryParse(json["pubDate"]) : null,
//         pubDateTz: json["pubDateTZ"],
//         imageUrl: json["image_url"],
//         sourceId: json["source_id"],
//         sourcePriority: json["source_priority"],
//         sourceName: json["source_name"],
//         sourceUrl: json["source_url"],
//         sourceIcon: json["source_icon"],
//         language: json["language"],
//         country: json["country"] != null ? List<String>.from(json["country"].map((x) => x)) : [],
//         category: json["category"] != null ? List<String>.from(json["category"].map((x) => x)) : [],
//         aiTag: json["ai_tag"] != null ? List<String>.from(json["ai_tag"].map((x) => x)) : [],
//         aiRegion: json["ai_region"],
//         aiOrg: json["ai_org"],
//         sentiment: json["sentiment"],
//         sentimentStats: json["sentiment_stats"] != null
//             ? SentimentStats.fromJson(json["sentiment_stats"])
//             : null,
//         duplicate: json["duplicate"],
//     );

//     Map<String, dynamic> toJson() => {
//         "article_id": articleId,
//         "title": title,
//         "link": link,
//         "keywords": keywords,
//         "creator": creator,
//         "video_url": videoUrl,
//         "description": description,
//         "content": content,
//         "pubDate": pubDate?.toIso8601String(),
//         "pubDateTZ": pubDateTz,
//         "image_url": imageUrl,
//         "source_id": sourceId,
//         "source_priority": sourcePriority,
//         "source_name": sourceName,
//         "source_url": sourceUrl,
//         "source_icon": sourceIcon,
//         "language": language,
//         "country": country ?? [],
//         "category": category ?? [],
//         "ai_tag": aiTag ?? [],
//         "ai_region": aiRegion,
//         "ai_org": aiOrg,
//         "sentiment": sentiment,
//         "sentiment_stats": sentimentStats?.toJson(),
//         "duplicate": duplicate,
//     };
// }

// class SentimentStats {
//     double? positive;
//     double? neutral;
//     double? negative;

//     SentimentStats({
//         this.positive,
//         this.neutral,
//         this.negative,
//     });

//     factory SentimentStats.fromJson(Map<String, dynamic> json) => SentimentStats(
//         positive: json["positive"].toDouble(),
//         neutral: json["neutral"].toDouble(),
//         negative: json["negative"].toDouble(),
//     );

//     Map<String, dynamic> toJson() => {
//         "positive": positive,
//         "neutral": neutral,
//         "negative": negative,
//     };
// }
