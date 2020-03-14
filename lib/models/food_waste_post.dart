class FoodWastePost {

  final DateTime date;
  final String photoURL;
  final int quantity;
  final double latitude;
  final double longitude;

  FoodWastePost({this.date, this.photoURL, this.quantity, this.latitude, this.longitude});

  factory FoodWastePost.fromMap(Map<String, dynamic> json) {
    return FoodWastePost(
      date: json['date'],
      photoURL: json['photoURL'],
      quantity: json['quantity'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}