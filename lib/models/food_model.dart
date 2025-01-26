class Food {
  final int? id;
  final String title;
  final String description;
  final String image;
  final double price;

  Food({this.id, required this.title, required this.description, required this.image, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'price': price,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      image: map['image'],
      price: map['price'],
    );
  }
}
