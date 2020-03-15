import 'package:test/test.dart';
import 'package:testing/models/food_waste_post.dart';

void main () {
  test('Post created from Map should have appropriate porperty values', () {
    final date = DateTime.parse('2020-01-01');
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    final foodWastePost = FoodWastePost.fromMap({
      'date' : date,
      'photoURL' : url,
      'quantity' : quantity,
      'latitude' : latitude,
      'longitude' : longitude
    });

    expect(foodWastePost.date, date);
    expect(foodWastePost.photoURL, url);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);

  });
}