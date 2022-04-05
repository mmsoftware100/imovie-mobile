import 'package:flutter_test/flutter_test.dart';
import 'package:imovie/core/time_converter.dart';

void main(){
  setUp((){});
  test('should return time description',(){
    // arrange
    // act
    final String result = TimeConverter.convertToHour(minutes: 70);
    // assert
    expect(result, "01:10:00");
  });
}