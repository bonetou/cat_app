class Cat {
  String id;
  String breed;
  String description;
  String imageUrl;

  Cat({this.id, this.breed, this.description});

  void setImage(String url) {
    imageUrl = url;
  }

  Cat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    breed = json['name'];
    description = json['description'];
    imageUrl = "";
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.breed;
    data['description'] = this.description;
    data['url'] = this.imageUrl;
    return data;
  }
}
