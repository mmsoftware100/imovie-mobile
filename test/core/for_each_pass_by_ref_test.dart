import 'package:flutter_test/flutter_test.dart';

void main(){
  test("for each pass by refrence test", (){
    int a = 1;
    int b = 2;
    int c = 3;
    List<int> intList = [a,b,c];
    intList.forEach((element) {

    });
  });
}