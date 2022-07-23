// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  String? id;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  Category({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });
  static List<String> categoriesStrings = [
    'Phone',
    'Smart Phone',
    'Tablet',
    'Charger',
    'Cable',
    'Case',
    'Glass',
    'HeadPhone',
    'Earphone',
    'Spearker',
    'Electricity',
    'Tandeuz',
    'Pc',
    'Pc Access',
    'Accessoire',
    'Tripods',
    'Lighting',
    'Battery',
    'Recepteur',
    'Phone Access',
    'Radio',
    'Other',
    'new'
  ];

  /// list of categories
  static List<Category> categories = [
    Category(
      id: '1',
      name: 'Electronics',
      description: 'Electronics',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Category(
      id: '2',
      name: 'Clothing',
      description: 'Clothing',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Category(
      id: '3',
      name: 'Food',
      description: 'Food',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Category(
      id: '4',
      name: 'Books',
      description: 'Books',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Category(
      id: '5',
      name: 'Sports',
      description: 'Sports',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Category(
      id: '6',
      name: 'Movies',
      description: 'Movies',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Category(
      id: '7',
      name: 'Toys',
      description: 'Toys',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Category(
      id: '8',
      name: 'Books',
      description: 'Books',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Category(
      id: '9',
      name: 'Sports',
      description: 'Sports',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Category(
      id: '10',
      name: 'Movies',
      description: 'Movies',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];
  Category copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
