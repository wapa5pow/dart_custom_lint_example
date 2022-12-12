// ライブラリを参照する
import 'package:riverpod/riverpod.dart';

import 'other.dart';

// 他のファイルを参照する
ProviderBase<int> provider = Provider((ref) => 0);

// クラスを定義する
class Point {
  // 変数を定義する
  int x;
  String get y => 'test_hythen';
  final z = 1;

  // コンストラクタを定義する
  Point(this.x);
  // ファクトリメソッドを定義する
  factory Point.zero() => Point(0);

  // メソッドを定義する
  int getX() => x;
  void setX(int x) => this.x = x;
  int notOk(int a, int b, [int c = 2]) {
    return a + b + c;
  }
}

int useOption(int a, int b, [int c = 2]) {
  return a + b + c;
}

// メイン関数を定義する
void main() {
  // 変数を定義する
  var p = Point(1);

  // 条件分岐を使った処理を行う
  if (p.getX() < 10) {
    print('p.x is small.');
  } else {
    print('p.x is large.');
  }

  // 関数を呼び出す
  p.setX(3);
  print('p.x: ${p.getX()}');

  // 他ファイルの関数を呼び出す。
  print(add(1, 2));
}
