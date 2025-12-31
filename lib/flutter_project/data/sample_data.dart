import '../model/life_lesson_control.dart';
import '../model/life_lesson.dart';
import '../model/action_plan.dart';

final List<LifeLesson> sampleData = [
  LifeLesson(
    title: 'Lost temper at work',
    happened: 'I got angry during a team meeting.',
    learned: 'I should pause before reacting.',
    date: DateTime.now(),
    isFavorite: false,
    category: LessonCategory.workStudy,
    mood: Mood.angry,
    actionPlan: null,
  ),
  LifeLesson(
    title: 'Woke up late',
    happened: 'I slept late and missed class.',
    learned: 'Good sleep discipline is important.',
    date: DateTime.now(),
    isFavorite: true,
    category: LessonCategory.personalGrowth,
    mood: Mood.sad,
    actionPlan: null,
  ),
  LifeLesson(
    title: 'Lost temper during discussion',
    happened:
        'I raised my voice during a group discussion when I felt ignored.',
    learned: 'Staying calm helps me communicate better and be respected.',
    date: DateTime.now(),
    isFavorite: true,
    category: LessonCategory.workStudy,
    mood: Mood.angry,
    actionPlan: ActionPlan(
      actionText:
          'Pause for 10 seconds and take 3 deep breaths before replying',
      isComplete: false,
      createdAt: DateTime.now(),
    ),
  ),
  LifeLesson(
    title: 'Procrastinated on assignment',
    happened: 'I kept delaying my assignment until the last night.',
    learned: 'Breaking tasks into small steps helps reduce procrastination.',
    date: DateTime.now(),
    isFavorite: false,
    category: LessonCategory.workStudy,
    mood: Mood.stressed,
    actionPlan: ActionPlan(
      actionText:
          'Start assignments by writing a simple outline on the first day',
      isComplete: false,
      createdAt: DateTime.now(),
    ),
  ),
  LifeLesson(
    title: 'Did not drink enough water',
    happened:
        'I felt tired and had a headache because I forgot to drink water.',
    learned: 'Small daily habits have a big impact on my health.',
    date: DateTime.now(),
    isFavorite: true,
    category: LessonCategory.healthWellBeing,
    mood: Mood.okay,
    actionPlan: ActionPlan(
      actionText: 'Drink one glass of water every 2 hours',
      isComplete: true,
      createdAt: DateTime.now(),
    ),
  ),
];

LifeLessonControl lifeLesson = LifeLessonControl(lessons: sampleData);
