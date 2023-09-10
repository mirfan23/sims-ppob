import 'const.dart';

double percentageOfSize(double size, double percentage) {
  return size * percentage / 100;
}

double percentageOfScreenHeight(double percentage) {
  return percentageOfSize(screenHeight, percentage);
}

double percentageOfScreenWidth(double percentage) {
  return percentageOfSize(screenWidth, percentage);
}

extension DoubleExtension on num {
  /// Mengembalikan nilai persentase dari lebar layar
  double get sw => percentageOfScreenWidth(toDouble());

  /// Mengembalikan nilai persentase dari tinggi layar
  double get sh => percentageOfScreenHeight(toDouble());
}
