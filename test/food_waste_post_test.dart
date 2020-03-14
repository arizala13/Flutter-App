import 'package:test/test.dart';
import 'package:testing/models/food_waste_post.dart';

void main () {
  test('Post created from Map should have appropriate porperty values', () {
    final date = DateTime.parse('2020-01-01');
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    final food_waste_post = FoodWastePost.fromMap({
      'date' : date,
      'photoURL' : url,
      'quantity' : quantity,
      'latitude' : latitude,
      'longitude' : longitude
    });

    expect(food_waste_post.date, date);
    expect(food_waste_post.photoURL, url);
    expect(food_waste_post.quantity, quantity);
    expect(food_waste_post.latitude, latitude);
    expect(food_waste_post.longitude, longitude);

  });
}