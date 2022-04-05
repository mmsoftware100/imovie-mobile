class MemoryConverter{
  int toGb( {int mb}){
    return (mb / 1024).toInt(); // ရှေ့က စကားလုံးပဲ ယူမှာ
  }
  int toMb({int mb}){
    return (mb % 1024).toInt(); // ရှေ့က စကားလုံးပဲ ယူမှာ
  }
  static String convertToGB( {int mb}){
    return (mb / 1024).toStringAsFixed(2); // ရှေ့က စကားလုံးပဲ ယူမှာ
  }
}