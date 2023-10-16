class News{
  String? title;
  String? description;
  String? imageUrl;
  String? content;

  News({this.title, this.description, this.imageUrl, this.content});
  News.fromJson(Map<String, dynamic> json){
    title = json['title'];
    description = json['description'];
    imageUrl = json['urlToImage'];
    content = json['content'];
  }
}