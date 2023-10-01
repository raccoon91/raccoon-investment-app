class Option {
  final String label;
  final String value;

  Option({
    required this.label,
    required this.value,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      label: json['label'],
      value: json['value'],
    );
  }
}
