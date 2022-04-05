import 'package:flutter_test/flutter_test.dart';
import 'package:imovie/core/memory_converter.dart';

void main(){
  MemoryConverter memoryConverter;
  setUp((){
    memoryConverter = MemoryConverter();
  });

  test('should return gb when memoryConverter.toGb(2046)',(){
    // arrange
    // act
    final int result = memoryConverter.toGb(mb : 2046);
    // assert
    expect(result, 1);
  });


  test('should return extra mb  when memoryConverter.toMb(1026)',(){
    // arrange
    // act
    // mb modulus 1024
    final int result = memoryConverter.toMb(mb : 1028);
    // assert
    expect(result, 4);
  });


  test('should return GB  when memoryConverter.convertToString(mb : 1026)',(){
    // arrange
    // act
    // mb modulus 1024
    final String result = MemoryConverter.convertToGB(mb : 2012);
    // assert
    expect(result, "1.96");
  });


}