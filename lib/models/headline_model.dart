// To parse this JSON data, do
//
//     final headlines = headlinesFromJson(jsonString);

// import 'dart:convert';

// Headlines headlinesFromJson(String str) => Headlines.fromJson(json.decode(str));

// String headlinesToJson(Headlines data) => json.encode(data.toJson());

class Headlines {
    Headlines({
        this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content,
    });

    Source? source;
    String? author;
    String? title;
    String? description;
    String? url;
    String? urlToImage;
    DateTime? publishedAt;
    String? content;

    factory Headlines.fromJson(Map<String, dynamic> json) => Headlines(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "source": source!.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt!.toIso8601String(),
        "content": content,
    };
}

class Source {
    Source({
        this.id,
        this.name,
    });

    dynamic id;
    String? name;

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
