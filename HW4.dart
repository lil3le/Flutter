//cube of a number
num cube(num number) {
  return number * number * number;
}

// greet a person 
void greet(String name) {
  print('Hello, $name');
}

//largest of three numbers
num maxNumber(num num1, num num2, num num3) {
  if (num1 >= num2 && num1 >= num3) {
    return num1;
  } else if (num2 >= num1 && num2 >= num3) {
    return num2;
  } else {
    return num3;
  }
}

// create a user 
void createUser(String name, int age, {bool isActive = true}) {
  print('User Created:');
  print('Name: $name');
  print('Age: $age');
  print('Active: $isActive');
}

// area of a rectangle 
double calculateArea({double length = 1, double width = 1}) {
  return length * width;
}

void main() {
  print('Cube of 3 = ${cube(3)}');

  print('--------------');
  greet('Ali');

  print('--------------');
  print('Max of 10, 25, 15 = ${maxNumber(10, 25, 15)}');

  print('--------------');
  createUser('Ali', 25);

  print('--------------');
  print('Area with length=5, width=3: ${calculateArea(length: 5, width: 3)}');
}