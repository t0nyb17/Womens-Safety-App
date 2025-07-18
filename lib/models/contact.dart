class Contact {
  final String name;
  final String number;
  final String? id;

  Contact({
    required this.name,
    required this.number,
    this.id,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'number': number,
    'id': id ?? DateTime.now().millisecondsSinceEpoch.toString(),
  };

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    name: json['name'] ?? '',
    number: json['number'] ?? '',
    id: json['id'],
  );

  Contact copyWith({
    String? name,
    String? number,
    String? id,
  }) {
    return Contact(
      name: name ?? this.name,
      number: number ?? this.number,
      id: id ?? this.id,
    );
  }
}