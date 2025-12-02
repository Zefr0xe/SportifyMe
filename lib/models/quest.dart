class Quest {
  final String id;
  final String name;
  final String type;
  final int target;
  final int current;
  final String iconPath;
  final bool isLocked;
  final String? description;
  final int? reward; // coins reward

  Quest({
    required this.id,
    required this.name,
    required this.type,
    required this.target,
    this.current = 0,
    required this.iconPath,
    this.isLocked = false,
    this.description,
    this.reward,
  });

  double get progress => target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;
  bool get isCompleted => current >= target;

  Quest copyWith({
    String? id,
    String? name,
    String? type,
    int? target,
    int? current,
    String? iconPath,
    bool? isLocked,
    String? description,
    int? reward,
  }) {
    return Quest(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      target: target ?? this.target,
      current: current ?? this.current,
      iconPath: iconPath ?? this.iconPath,
      isLocked: isLocked ?? this.isLocked,
      description: description ?? this.description,
      reward: reward ?? this.reward,
    );
  }
}
