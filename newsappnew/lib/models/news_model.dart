class NewsModel {
  //String? source;
  String? article;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlImage;
  String? publishedAt;
  String? content;

  // Param Constructor (UnNamed)
  NewsModel({
    //this.source,
    this.article,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlImage,
    this.publishedAt,
    this.content,
  });

// Named Constructor
  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      // source: map['source'] ?? 'N/A',
      article: map['articles'] ?? 'N/A',
      author: map['author'] ?? 'N/A',
      title: map['title'] ?? 'N/A',
      description: map['description'] ?? 'N/A',
      url: map['url'] ?? 'N/A',
      urlImage: map['urlToImage'] ?? 'N/A',
      publishedAt: map['publishedAt'] ?? 'N/A',
      content: map['content'] ?? 'N/A',
    );
    // get obj and fill the news values
  }
}
