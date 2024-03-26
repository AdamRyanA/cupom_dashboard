class Company{

  Company();

  Map<String, dynamic> toMap (){
    Map<String, dynamic> map = {

    };
    return map;
  }

  factory Company.toNull(){
    return Company();
  }

  factory Company.fromJson(dynamic json) {
    return Company();
  }

  @override
  String toString() {
    return '{}';
  }
}