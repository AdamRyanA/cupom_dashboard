class Company{

  String? id;
  String? name;
  String? cnpj;
  String? email;
  String? phone;
  String? categoria;
  String? image;

  Company(
      this.id, this.name, this.cnpj,
      this.email, this.phone,
      this.categoria, this.image
      );

  Map<String, dynamic> toMap (){
    Map<String, dynamic> map = {

    };
    return map;
  }

  factory Company.toNull(){
    return Company(
        null, null, null,
        null, null, null,
        null
    );
  }

  @override
  String toString() {
    return '{id: $id, name: $name, cnpj: $cnpj, email: $email, phone: $phone, categoria: $categoria, image: $image}';
  }
}