void checkNumber() {
  int number = 20;

  if (number > 0) {
    print("Positive");
  } else if (number < 0) {
    print("Negative");
  } else {
    print("Zero");
  }
}

void printNumbers() {
  for (int i = 1; i <= 100; i++) {
    if (i == 41) {
      continue;
    }
    print(i);
  }
}

void main() {
  checkNumber();
  print('\n');
  printNumbers();
}
