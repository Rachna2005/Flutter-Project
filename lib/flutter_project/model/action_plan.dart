import 'package:uuid/uuid.dart';

class ActionPlan {
  final String id;
  final String actionText;
  bool isComplete;
  final DateTime createdAt;
  ActionPlan({
    String? id,
    required this.actionText,
    this.isComplete = false,
    required this.createdAt,
  }) : id = id ?? const Uuid().v4();

  void toggleCompleted() {
    isComplete = !isComplete;
  }
}
