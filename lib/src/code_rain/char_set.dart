import 'dart:math';

const String _charSet =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#%^&*()_+-=";

class CharSetUtil {
  static String getRandom(int length) {
    var sb = StringBuffer();
    for (var i = 0; i < length; i++) {
      sb.write(_charSet[Random().nextInt(_charSet.length)]);
    }
    return sb.toString();
  }

  static String getRandomWith(int length, String reserved) {
    assert(reserved.length <= length);
    var s = getRandomWithout(length - reserved.length, reserved);
    var r = s + reserved;
    return shuffleString(r);
  }

  static String getPartialRandom(String input, {double rate = 0.9}) {
    assert(rate >= 0 && rate <= 1);
    var sb = StringBuffer();
    for (var i = 0; i < input.length; i++) {
      if (Random().nextDouble() < rate) {
        sb.write(input[i]);
      } else {
        sb.write(getRandom(1));
      }
    }
    return sb.toString();
  }

  static String shuffleString(String input) {
    List<String> characters = input.split('');
    characters.shuffle(Random());
    return characters.join();
  }

  static String getRandomWithout(int length, String without) {
    var sb = StringBuffer();
    for (var i = 0; i < length; i++) {
      var c = _charSet[Random().nextInt(_charSet.length)];
      if (without.contains(c)) {
        i--;
        continue;
      }
      sb.write(c);
    }
    return sb.toString();
  }

  static String getRandomCharacter() {
    return _charSet[Random().nextInt(_charSet.length)];
  }
}
