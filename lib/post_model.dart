class Post {
  final String name;
  final String code;
  final String? color1;
  final String id;

  Post({
    required this.name,
    required this.code,
    required this.color1,
    required this.id,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'] as String,
      code: json['code'] as String,
      color1: json['color1'] as String?,
      id: json['id'] as String,
    );
  }
}