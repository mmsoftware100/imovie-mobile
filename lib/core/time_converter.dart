class TimeConverter{

  static convertToHour({int minutes}){
    Duration duration = Duration(minutes: minutes);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    //return "${twoDigits(duration.inHours)} Hr $twoDigitMinutes Min";
  }
}