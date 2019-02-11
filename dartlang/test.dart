void main() {
  try {
    int r = 12 ~/ 0;
    print(r);
  } on IntegerDivisionByZeroException {
    print('IntegerDivisionByZeroException');
  }
  
  print(List(5).length);

  var person = Person('liuzhao', 30);
  print(person());

  void myFunc({String name, num age}) {
    print('$name.$age');
  }

  myFunc(name: 'liuzhao');

  var names = new List<String>();
  names.addAll(['a', 'b']);
  print(names is List<int>);

  var extender = new Foo();
  print(extender);

  List<String> myList = new List<String>();
  print(myList);

}

class Foo<T extends Person> {}
class Child extends Person {
  String name;
  int age;
  Child(String name, int age):super(name, age){
    name = name;
    age = age;
  }
}
class Person {
  String name;
  int age;
  Person(this.name, this.age);
  call(){
    print('call class');
  }
}