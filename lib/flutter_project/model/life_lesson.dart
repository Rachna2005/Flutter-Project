import 'action_plan.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

enum LessonCategory {
  personalGrowth,
  workStudy,
  relationshipsCommunication,
  mistakesSelfControl,
  healthWellBeing,
}

enum Mood { okay, happy, stressed, sad, angry }

class LifeLesson {
  final String id;
  String title;
  String happened;
  String learned;
  DateTime date;
  bool? isFavorite;
  LessonCategory category;
  Mood mood;
  ActionPlan? actionPlan;
  LifeLesson({
    String? id,
    required this.title,
    required this.happened,
    required this.learned,
    required this.date,
    this.isFavorite,
    required this.category,
    required this.mood,
    this.actionPlan,
  }) : id = id ?? const Uuid().v4();

}
