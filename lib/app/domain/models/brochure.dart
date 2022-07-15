class Brochure {
  final String name, price, spanish, id;
  final String? age;

  Brochure(this.name, this.price, this.age, this.spanish, this.id);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'price': price,
        'spanish': spanish,
        'age': age,
        'id': id
      };

  Brochure.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        price = json['price'],
        spanish = json['spanish'],
        age = json['age'];
}
