class RadarUtil {
  static int getTimestamps(int index) {
    int lastTimeStamp = 0;
    List<int> timeStamps = [0, 0, 0, 0, 0];
    bool notOver = true;
    int placeholder = 1676751000;

    int timeNowUnix = (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    while (notOver) {
      if (placeholder > timeNowUnix) {
        notOver = false;
      } else {
        lastTimeStamp = placeholder;
        timeStamps = [
          lastTimeStamp - 600,
          lastTimeStamp - 1800,
          lastTimeStamp - 3600,
          lastTimeStamp - 5400,
          lastTimeStamp - 7200
        ];
        placeholder = placeholder + 600;
      }
    }
    return timeStamps[index];
  }
}
