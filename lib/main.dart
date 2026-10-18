import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vibration/vibration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppNotifications.initialize();
  runApp(const AIStudyPlannerApp());
}

const primaryColor = Color(0xFF6558F5);
const secondaryColor = Color(0xFF9278FF);
const backgroundColor = Color(0xFFF6F5FF);
const darkColor = Color(0xFF242447);

class AppNotifications {
  static final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await plugin.initialize(settings);

    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> show(String title, String message) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'study_planner',
        'Study Planner Reminders',
        channelDescription: 'Study sessions, breaks, and daily reminders',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await plugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(2147483647),
      title,
      message,
      details,
    );
  }
}

class AIStudyPlannerApp extends StatelessWidget {
  const AIStudyPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Study Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          foregroundColor: darkColor,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFFE8E5F5)),
          ),
        ),
      ),
      home: const WelcomePage(),
    );
  }
}

ButtonStyle primaryButtonStyle() => ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      minimumSize: const Size.fromHeight(52),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );

Widget sectionLabel(String value) => Text(
      value.toUpperCase(),
      style: const TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.w800,
        fontSize: 12,
        letterSpacing: 1.3,
      ),
    );

// WELCOME SCREEN

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5145CD),
              Color(0xFF7867F8),
              Color(0xFFA28BFF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .13),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: .25),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.smart_toy_rounded,
                          color: Colors.white,
                          size: 100,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.menu_book,
                                color: Colors.white, size: 30),
                            SizedBox(width: 8),
                            Icon(Icons.auto_stories,
                                color: Colors.white, size: 30),
                            SizedBox(width: 8),
                            Icon(Icons.school,
                                color: Colors.white, size: 30),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'LEARN  •  PLAN  •  ACHIEVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'AI STUDY PLANNER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 29,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Plan Smarter.\nStudy Better. Achieve More.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 1.35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Your personal companion for organized learning, '
                    'better habits, and exam preparation.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _FeatureChip(Icons.calendar_month, 'Smart Timetable'),
                      _FeatureChip(Icons.timer, 'Focus Pomodoro'),
                      _FeatureChip(Icons.insights, 'Track Progress'),
                      _FeatureChip(Icons.psychology, 'AI Analytics'),
                      _FeatureChip(Icons.style, 'Flashcards'),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StudentSetupPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: const Text(
                        'Get Started  →',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'YOUR GOALS. YOUR PLAN. YOUR SUCCESS.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.3,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip(this.icon, this.label);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .16),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// MODELS

class StudySubject {
  StudySubject({
    required this.name,
    required this.difficulty,
    required this.topics,
  });

  final String name;
  final String difficulty;
  final List<String> topics;
}

class PlannedTopic {
  PlannedTopic({
    required this.subject,
    required this.topic,
    required this.difficulty,
    required this.allocatedMinutes,
  });

  final String subject;
  final String topic;
  final String difficulty;
  final int allocatedMinutes;

  String status = 'Not started';
  int studiedSeconds = 0;
  bool breakOverdue = false;
  bool reminderSent = false;
}

// STUDENT SETUP

class StudentSetupPage extends StatefulWidget {
  const StudentSetupPage({super.key});

  @override
  State<StudentSetupPage> createState() => _StudentSetupPageState();
}

class _StudentSetupPageState extends State<StudentSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _hours = TextEditingController(text: '3');

  String _education = 'Engineering';
  String _goal = 'Balanced';
  DateTime? _examDate;
  final List<StudySubject> _subjects = [];

  @override
  void dispose() {
    _name.dispose();
    _hours.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: _examDate ?? now.add(const Duration(days: 7)),
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 10),
    );
    if (result != null && mounted) {
      setState(() => _examDate = result);
    }
  }

  Future<void> _addSubject() async {
    final result = await Navigator.push<StudySubject>(
      context,
      MaterialPageRoute(builder: (_) => const AddSubjectPage()),
    );
    if (result == null || !mounted) return;

    if (_subjects.any(
      (s) => s.name.toLowerCase() == result.name.toLowerCase(),
    )) {
      _message('This subject already exists.');
      return;
    }
    setState(() => _subjects.add(result));
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _createPlan() {
    if (!_formKey.currentState!.validate()) return;
    if (_examDate == null) {
      _message('Please select your examination date.');
      return;
    }
    if (_subjects.isEmpty) {
      _message('Please add at least one subject.');
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => StudyDashboardPage(
          studentName: _name.text.trim(),
          education: _education,
          examDate: _examDate!,
          dailyHours: int.parse(_hours.text),
          subjects: List.of(_subjects),
          examFocused: _goal == 'Exam focused',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Up Your Study Plan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Let’s plan your success!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Tell us about yourself and your examination.'),
            const SizedBox(height: 22),
            sectionLabel('Your details'),
            const SizedBox(height: 10),
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Student name',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Enter your name.' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _education,
              decoration: const InputDecoration(labelText: 'Education level'),
              items: const [
                DropdownMenuItem(value: 'School', child: Text('School')),
                DropdownMenuItem(value: 'PUC', child: Text('PUC / College')),
                DropdownMenuItem(
                  value: 'Diploma',
                  child: Text('Diploma'),
                ),
                DropdownMenuItem(
                  value: 'Engineering',
                  child: Text('Engineering'),
                ),
                DropdownMenuItem(value: 'Degree', child: Text('Degree')),
                DropdownMenuItem(
                  value: 'Postgraduate',
                  child: Text('Postgraduate'),
                ),
                DropdownMenuItem(
                  value: 'Competitive Exams',
                  child: Text('Competitive Exams'),
                ),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _education = v);
              },
            ),
            const SizedBox(height: 22),
            sectionLabel('Examination details'),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: _selectDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                _examDate == null
                    ? 'Select examination date'
                    : '${_examDate!.day}/${_examDate!.month}/${_examDate!.year}',
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _hours,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Available study hours per day',
              ),
              validator: (v) {
                final n = int.tryParse(v ?? '');
                return n == null || n < 1 || n > 16
                    ? 'Enter a number from 1 to 16.'
                    : null;
              },
            ),
            const SizedBox(height: 22),
            DropdownButtonFormField<String>(
              value: _goal,
              decoration: const InputDecoration(labelText: 'Study plan style'),
              items: const [
                DropdownMenuItem(
                  value: 'Balanced',
                  child: Text('Balanced'),
                ),
                DropdownMenuItem(
                  value: 'Exam focused',
                  child: Text('Exam focused'),
                ),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _goal = v);
              },
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(child: sectionLabel('Your subjects')),
                TextButton.icon(
                  onPressed: _addSubject,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Subject'),
                ),
              ],
            ),
            if (_subjects.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Add subjects, topics, and difficulty levels.'),
                ),
              ),
            ...List.generate(_subjects.length, (i) {
              final s = _subjects[i];
              return Card(
                child: ListTile(
                  title: Text(s.name),
                  subtitle: Text(
                    '${s.difficulty} • ${s.topics.length} topics',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () =>
                        setState(() => _subjects.removeAt(i)),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createPlan,
              style: primaryButtonStyle(),
              child: const Text('Create My Study Plan →'),
            ),
          ],
        ),
      ),
    );
  }
}

// ADD SUBJECTS AND TOPICS

class AddSubjectPage extends StatefulWidget {
  const AddSubjectPage({super.key});

  @override
  State<AddSubjectPage> createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _topic = TextEditingController();
  String _difficulty = 'Medium';
  final List<String> _topics = [];

  @override
  void dispose() {
    _name.dispose();
    _topic.dispose();
    super.dispose();
  }

  void _addTopic() {
    final value = _topic.text.trim();
    if (value.isEmpty) return;

    if (_topics.any((t) => t.toLowerCase() == value.toLowerCase())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Topic already added.')),
      );
      return;
    }

    setState(() {
      _topics.add(value);
      _topic.clear();
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    if (_topics.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one topic.')),
      );
      return;
    }

    Navigator.pop(
      context,
      StudySubject(
        name: _name.text.trim(),
        difficulty: _difficulty,
        topics: List.of(_topics),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Subject')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Build Your Syllabus',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Subject name'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Enter a subject.' : null,
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: _difficulty,
              decoration: const InputDecoration(labelText: 'Difficulty'),
              items: const [
                DropdownMenuItem(value: 'Easy', child: Text('Easy')),
                DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                DropdownMenuItem(value: 'Hard', child: Text('Hard')),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _difficulty = v);
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _topic,
                    decoration: const InputDecoration(
                      hintText: 'Enter topic or chapter',
                    ),
                    onSubmitted: (_) => _addTopic(),
                  ),
                ),
                IconButton.filled(
                  onPressed: _addTopic,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            ...List.generate(_topics.length, (i) {
              return Card(
                child: ListTile(
                  title: Text(_topics[i]),
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () =>
                        setState(() => _topics.removeAt(i)),
                  ),
                ),
              );
            }),
            const SizedBox(height: 22),
            ElevatedButton(
              onPressed: _save,
              style: primaryButtonStyle(),
              child: const Text('Save Subject'),
            ),
          ],
        ),
      ),
    );
  }
}

// STUDY DASHBOARD

class StudyDashboardPage extends StatefulWidget {
  const StudyDashboardPage({
    super.key,
    required this.studentName,
    required this.education,
    required this.examDate,
    required this.dailyHours,
    required this.subjects,
    required this.examFocused,
  });

  final String studentName;
  final String education;
  final DateTime examDate;
  final int dailyHours;
  final List<StudySubject> subjects;
  final bool examFocused;

  @override
  State<StudyDashboardPage> createState() => _StudyDashboardPageState();
}

class _StudyDashboardPageState extends State<StudyDashboardPage>
    with WidgetsBindingObserver {
  final FlutterTts _tts = FlutterTts();
  final Map<int, Timer> _timers = {};
  final Map<int, Timer> _reminders = {};
  final Map<int, int> _secondsLeft = {};
  final Map<int, String> _timerMode = {};

  late final List<PlannedTopic> _plan;
  int _tab = 0;
  bool _demoMode = true;
  bool _voiceEnabled = true;
  bool _vibrationEnabled = true;
  bool _dailyCompletionAnnounced = false;

  int get _studyDuration => _demoMode ? 10 : 25 * 60;
  int get _breakDuration => _demoMode ? 5 : 5 * 60;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _plan = _buildPlan();
    _tts.setLanguage('en-US');
    _tts.setSpeechRate(0.48);
    _tts.setVolume(1.0);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    for (final t in _timers.values) {
      t.cancel();
    }
    for (final t in _reminders.values) {
      t.cancel();
    }
    _tts.stop();
    super.dispose();
  }

  List<PlannedTopic> _buildPlan() {
    if (widget.subjects.isEmpty) return [];

    int weight(String difficulty) {
      if (difficulty == 'Hard') return 3;
      if (difficulty == 'Easy') return 1;
      return 2;
    }

    final totalMinutes = widget.dailyHours * 60;
    final totalWeight = widget.subjects.fold<int>(
      0,
      (sum, s) => sum + weight(s.difficulty),
    );

    final allocations = widget.subjects
        .map((s) => totalMinutes * weight(s.difficulty) ~/ totalWeight)
        .toList();

    var assigned = allocations.fold<int>(0, (a, b) => a + b);

    for (int i = 0; assigned < totalMinutes; i = (i + 1) % allocations.length) {
      allocations[i]++;
      assigned++;
    }

    final result = <PlannedTopic>[];

    for (int i = 0; i < widget.subjects.length; i++) {
      final subject = widget.subjects[i];
      if (subject.topics.isEmpty) continue;

      final each = allocations[i] ~/ subject.topics.length;
      final remainder = allocations[i] % subject.topics.length;

      for (int j = 0; j < subject.topics.length; j++) {
        result.add(
          PlannedTopic(
            subject: subject.name,
            topic: subject.topics[j],
            difficulty: subject.difficulty,
            allocatedMinutes: each + (j < remainder ? 1 : 0),
          ),
        );
      }
    }

    return result;
  }

  int get _completed =>
      _plan.where((p) => p.status == 'Completed').length;

  int get _studiedSeconds =>
      _plan.fold(0, (sum, p) => sum + p.studiedSeconds);

  double get _progress =>
      _plan.isEmpty ? 0 : _completed / _plan.length;

  Future<void> _notify(
    String title,
    String message, {
    bool speak = true,
    bool vibrate = true,
  }) async {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$title\n$message'),
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
        ),
      );

    try {
      await AppNotifications.show(title, message);
    } catch (_) {
      // On-screen text feedback remains available.
    }

    if (vibrate && _vibrationEnabled) {
      try {
        final supported = await Vibration.hasVibrator() ?? false;
        if (supported) {
          await Vibration.vibrate(duration: 500);
        }
      } catch (_) {}
    }

    if (speak && _voiceEnabled) {
      try {
        await _tts.stop();
        await _tts.speak('$title. $message');
      } catch (_) {}
    }
  }

  void _startFocus(int i) {
    _timers[i]?.cancel();
    _reminders[i]?.cancel();

    if (_plan[i].status == 'Completed') return;

    setState(() {
      _plan[i].status = 'In progress';
      _plan[i].breakOverdue = false;
      _plan[i].reminderSent = false;
      _timerMode[i] = 'Focus';
      _secondsLeft[i] = _studyDuration;
    });

    _notify(
      'Study session started',
      'Focus on ${_plan[i].topic} for '
      '${_demoMode ? '10 seconds' : '25 minutes'}.',
    );

    _runTimer(i, 'Focus', _studyDuration);
  }

  void _startBreak(int i) {
    _timers[i]?.cancel();

    setState(() {
      _timerMode[i] = 'Break';
      _secondsLeft[i] = _breakDuration;
      _plan[i].breakOverdue = false;
    });

    _notify(
      'Break time',
      'Relax for ${_demoMode ? '5 seconds' : '5 minutes'}.',
    );

    _runTimer(i, 'Break', _breakDuration);
  }

  void _runTimer(int i, String mode, int duration) {
    _timers[i]?.cancel();
    var remaining = duration;

    _timers[i] = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      remaining--;

      if (remaining <= 0) {
        timer.cancel();
        _timers.remove(i);

        if (mode == 'Focus') {
          setState(() {
            _secondsLeft[i] = 0;
            _plan[i].studiedSeconds += duration;
            _timerMode[i] = 'Break';
          });

          _notify(
            'Study session completed',
            'Great work! Your break is starting now.',
          );

          _startBreak(i);
        } else {
          setState(() {
            _secondsLeft[i] = 0;
            _timerMode[i] = 'Break finished';
            _plan[i].breakOverdue = true;
            _plan[i].reminderSent = false;
          });

          _notify(
            'Break finished',
            'Your break is over. Please return to studying.',
          );

          _scheduleReturnReminder(i);
        }
      } else {
        setState(() => _secondsLeft[i] = remaining);
      }
    });
  }

  void _scheduleReturnReminder(int i) {
    _reminders[i]?.cancel();

    _reminders[i] = Timer(
      _demoMode ? const Duration(seconds: 5) : const Duration(minutes: 1),
      () {
        if (!mounted) return;

        final p = _plan[i];
        if (p.breakOverdue && p.status != 'Completed') {
          setState(() => p.reminderSent = true);
          _notify(
            'Study reminder',
            'You have not returned to ${p.topic} yet. '
            'Your break is over. Please start studying.',
          );
        }
      },
    );
  }

  void _pauseTimer(int i) {
    _timers[i]?.cancel();
    _timers.remove(i);

    setState(() => _timerMode[i] = 'Paused');

    _notify(
      'Timer paused',
      'Your study timer has been paused. Resume when ready.',
      speak: false,
      vibrate: false,
    );
  }

  void _completeTopic(int i) {
    _timers[i]?.cancel();
    _timers.remove(i);
    _reminders[i]?.cancel();
    _reminders.remove(i);

    setState(() {
      _plan[i].status = 'Completed';
      _plan[i].breakOverdue = false;
      _timerMode.remove(i);
      _secondsLeft.remove(i);
    });

    if (_completed == _plan.length && _plan.isNotEmpty) {
      _dailyCompletionAnnounced = true;
      _notify(
        'Excellent work!',
        'You have completed all your planned topics. '
        'Keep up the great work!',
      );
    } else {
      _notify(
        'Topic completed',
        '${_plan[i].topic} is complete. Great work!',
      );
    }
  }

  void _markIncomplete(int i) {
    _timers[i]?.cancel();
    _timers.remove(i);
    _reminders[i]?.cancel();
    _reminders.remove(i);

    setState(() {
      _plan[i].status = 'Incomplete';
      _plan[i].breakOverdue = false;
      _timerMode.remove(i);
      _secondsLeft.remove(i);
    });

    _notify(
      'Topic marked incomplete',
      '${_plan[i].topic} remains unfinished. '
      'Review it in your next study session.',
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final daysLeft = widget.examDate
        .difference(DateTime.now())
        .inDays
        .clamp(0, 3650);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Study Planner',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Timer and notification settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: _showSettings,
          ),
        ],
      ),
      body: IndexedStack(
        index: _tab,
        children: [
          _buildTimetable(daysLeft),
          _buildProgress(),
          _buildFlashcards(),
          _buildRisk(daysLeft),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Timetable',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.style_outlined),
            selectedIcon: Icon(Icons.style),
            label: 'Flashcards',
          ),
          NavigationDestination(
            icon: Icon(Icons.shield_outlined),
            selectedIcon: Icon(Icons.shield),
            label: 'Risk Analysis',
          ),
        ],
      ),
    );
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheetState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Study Settings',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SwitchListTile(
                  title: const Text('Demonstration mode'),
                  subtitle: const Text('10-second study / 5-second break'),
                  value: _demoMode,
                  onChanged: (value) {
                    setState(() => _demoMode = value);
                    setSheetState(() {});
                  },
                ),
                SwitchListTile(
                  title: const Text('Voice announcements'),
                  value: _voiceEnabled,
                  onChanged: (value) {
                    setState(() => _voiceEnabled = value);
                    setSheetState(() {});
                  },
                ),
                SwitchListTile(
                  title: const Text('Vibration reminders'),
                  value: _vibrationEnabled,
                  onChanged: (value) {
                    setState(() => _vibrationEnabled = value);
                    setSheetState(() {});
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'Changes to timer mode apply to the next session.',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimetable(int daysLeft) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Hello, ${widget.studentName}! 👋',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          'Education level: ${widget.education}',
          style: const TextStyle(color: Colors.black54),
        ),
        const Text('Small steps every day lead to big achievements.'),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [primaryColor, secondaryColor],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'YOUR EXAM COUNTDOWN',
                style: TextStyle(color: Colors.white70, letterSpacing: 1),
              ),
              const SizedBox(height: 8),
              Text(
                '$daysLeft days to go',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.dailyHours} hours daily • '
                '${widget.subjects.length} subjects',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 14),
              LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.white30,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                '${(_progress * 100).round()}% of topics completed',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Today’s Smart Timetable',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          '${_demoMode ? 'Demo: 10 sec study + 5 sec break' : 'Normal: 25 min study + 5 min break'}. '
          'Hard subjects receive more allocated study time.',
          style: const TextStyle(color: Colors.black54, height: 1.5),
        ),
        const SizedBox(height: 12),
        if (_plan.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text('No topics available. Add subjects to your plan.'),
            ),
          ),
        ...List.generate(_plan.length, _topicCard),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () => setState(() => _tab = 1),
          icon: const Icon(Icons.insights),
          label: const Text('View Study Progress'),
        ),
      ],
    );
  }

  Widget _topicCard(int i) {
    final p = _plan[i];
    final mode = _timerMode[i];
    final running = _timers.containsKey(i);
    final remaining = _secondsLeft[i] ?? 0;

    final difficultyColor = p.difficulty == 'Hard'
        ? Colors.redAccent
        : p.difficulty == 'Easy'
            ? Colors.green
            : Colors.orange;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    p.subject,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  label: Text(p.difficulty),
                  backgroundColor:
                      difficultyColor.withValues(alpha: .12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(p.topic),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  avatar: const Icon(Icons.schedule, size: 16),
                  label: Text('${p.allocatedMinutes} min allocated'),
                ),
                Chip(label: Text(p.status)),
              ],
            ),
            if (mode != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE9FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      mode == 'Break'
                          ? 'BREAK TIME'
                          : mode == 'Break finished'
                              ? 'BREAK COMPLETED'
                              : mode == 'Paused'
                                  ? 'TIMER PAUSED'
                                  : 'FOCUS SESSION',
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _formatTime(remaining),
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      mode == 'Break'
                          ? 'Relax before your next session.'
                          : mode == 'Break finished'
                              ? 'Your break has ended.'
                              : 'Focus on this topic.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (!running && p.status != 'Completed')
                  FilledButton.icon(
                    onPressed: () {
                      if (mode == 'Break finished' || mode == 'Paused') {
                        _startFocus(i);
                      } else {
                        _startFocus(i);
                      }
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: Text(
                      mode == 'Break finished'
                          ? 'Resume Study'
                          : _demoMode
                              ? 'Start 10 sec'
                              : 'Start 25 min',
                    ),
                  ),
                if (running)
                  OutlinedButton.icon(
                    onPressed: () => _pauseTimer(i),
                    icon: const Icon(Icons.pause),
                    label: const Text('Pause'),
                  ),
                if (p.status != 'Completed')
                  OutlinedButton.icon(
                    onPressed: () => _completeTopic(i),
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Complete'),
                  ),
                if (p.status != 'Completed')
                  TextButton(
                    onPressed: () => _markIncomplete(i),
                    child: const Text('Mark incomplete'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgress() {
    final inProgress = _plan.where((p) => p.status == 'In progress').length;
    final notStarted = _plan.where((p) => p.status == 'Not started').length;
    final incomplete = _plan.where((p) => p.status == 'Incomplete').length;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Your Study Progress',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Your dashboard updates as you change topic status.'),
        const SizedBox(height: 22),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: _progress,
                        strokeWidth: 12,
                        backgroundColor: const Color(0xFFEDE9FF),
                        color: primaryColor,
                      ),
                      Center(
                        child: Text(
                          '${(_progress * 100).round()}%',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text('$_completed of ${_plan.length} topics completed'),
                const SizedBox(height: 8),
                Text('Recorded focus time: ${_studiedSeconds ~/ 60} minutes'),
              ],
            ),
          ),
        ),
        _progressRow('Completed', _completed, Colors.green),
        _progressRow('In progress', inProgress, Colors.blue),
        _progressRow('Not started', notStarted, Colors.orange),
        _progressRow('Incomplete', incomplete, Colors.redAccent),
      ],
    );
  }

  Widget _progressRow(String label, int count, Color color) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: .12),
          child: Icon(Icons.circle, color: color, size: 15),
        ),
        title: Text(label),
        trailing: Text(
          '$count',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // These are local educational explanations, not AI-generated or verified
  // answers. A real AI provider or trusted notes source must be connected
  // for automatic subject-specific answer generation.

  String _makeAnswer(String subject, String topic) {
    final t = topic.toLowerCase();
    final engineering = widget.education == 'Engineering' ||
        widget.education == 'Postgraduate';

    if (t.contains('cnn') || t.contains('convolutional neural')) {
      return engineering
          ? 'A Convolutional Neural Network (CNN) is a deep learning '
              'architecture designed to learn spatial features from '
              'grid-like data, especially images. Convolutional layers '
              'apply learnable filters, activation functions introduce '
              'non-linearity, and pooling or strided operations reduce '
              'spatial dimensions. The extracted features are used by '
              'later layers for tasks such as image classification and '
              'object detection. The exact architecture depends on the task.'
          : 'A Convolutional Neural Network (CNN) is a type of AI model '
              'that learns patterns in images. It can identify features '
              'such as edges, shapes, and objects. CNNs are commonly used '
              'for image recognition.';
    }

    if (t.contains('backpropagation') || t.contains('backpropogation')) {
      return 'Backpropagation is an algorithm used to calculate how much '
          'each model parameter contributes to prediction error. It '
          'propagates gradients backward through the network using the '
          'chain rule of calculus. An optimizer then uses those gradients '
          'to update the parameters and reduce the loss.';
    }

    if (t.contains('activation function')) {
      return 'An activation function transforms a neuron’s input and '
          'introduces non-linearity into a neural network. Common examples '
          'include ReLU, sigmoid, and tanh. Without suitable non-linear '
          'activations, stacking linear layers would still represent '
          'only a linear transformation.';
    }

    if (t.contains('optimization') || t.contains('optimizer')) {
      return 'Optimization is the process of adjusting a model’s parameters '
          'to reduce a loss function. Gradient descent and its variants, '
          'including SGD and Adam, use gradients to guide parameter updates. '
          'Learning rate, data quality, and model design affect convergence.';
    }

    if (t.contains('forward pass') || t.contains('forwardpass')) {
      return 'A forward pass sends input data through the network layers '
          'to calculate a prediction. During training, the prediction is '
          'compared with the target to calculate a loss. Backpropagation '
          'then calculates gradients used for parameter updates.';
    }

    if (t.contains('arithmetic progression')) {
      return 'An arithmetic progression (AP) is a sequence in which the '
          'difference between consecutive terms is constant. If the first '
          'term is a and the common difference is d, the nth term is '
          'aₙ = a + (n − 1)d. The sum of n terms is '
          'Sₙ = n/2 [2a + (n − 1)d].';
    }

    if (t.contains('quadratic')) {
      return 'A quadratic equation has the form ax² + bx + c = 0, where '
          'a is non-zero. Its roots can be calculated using '
          'x = (−b ± √(b² − 4ac))/(2a). The discriminant b² − 4ac '
          'indicates whether the roots are real and distinct, real and equal, '
          'or complex.';
    }

    if (t.contains('linear algebra')) {
      return 'Linear algebra studies vectors, matrices, and linear '
          'transformations. It is used to solve systems of linear equations '
          'and is fundamental to computer graphics, engineering, and machine '
          'learning. Matrix multiplication and vector operations are key '
          'tools.';
    }

    if (t.contains('probability')) {
      return 'Probability measures how likely an event is to occur. For '
          'equally likely outcomes, P(A) = favourable outcomes / total '
          'possible outcomes. Probability values lie between 0 and 1. '
          'Conditional probability describes the probability of an event '
          'given that another event has occurred.';
    }

    if (t.contains('statistics')) {
      return 'Statistics is the study of collecting, organizing, analysing, '
          'and interpreting data. Measures such as mean, median, variance, '
          'and standard deviation describe data. Inferential statistics '
          'uses sample data to draw conclusions about a population.';
    }

    if (t.contains('neural network') || t.contains('deep learning')) {
      return 'Deep learning uses neural networks with multiple layers to '
          'learn representations from data. Training typically involves '
          'a forward pass, loss calculation, backpropagation, and parameter '
          'updates by an optimizer. Performance depends on data, model '
          'architecture, and training choices.';
    }

    return 'Study $topic in the context of $subject. Begin with its formal '
        'definition, identify its important principles or formulas, and '
        'work through a relevant example. Then explain the concept in your '
        'own words and solve a practice question without referring to notes. '
        'This is a study guide, not a verified subject-specific answer.';
  }

  String _makeApplicationQuestion(String subject, String topic) {
    if (topic.toLowerCase().contains('cnn')) {
      return 'How are CNNs used to analyse images?';
    }
    if (topic.toLowerCase().contains('backprop')) {
      return 'How does backpropagation help train a neural network?';
    }
    if (topic.toLowerCase().contains('arithmetic progression')) {
      return 'How would you find the nth term of an arithmetic progression?';
    }
    return 'Give an example of how $topic is used in $subject.';
  }

  Widget _buildFlashcards() {
    final cards = <Map<String, String>>[];

    for (final p in _plan) {
      cards.add({
        'subject': p.subject,
        'topic': p.topic,
        'question': 'What is ${p.topic}?',
        'answer': _makeAnswer(p.subject, p.topic),
      });
      cards.add({
        'subject': p.subject,
        'topic': p.topic,
        'question': _makeApplicationQuestion(p.subject, p.topic),
        'answer': _makeAnswer(p.subject, p.topic),
      });
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Topic Flashcards',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Education level: ${widget.education}. '
          'Review each answer and compare it with your course notes.',
          style: const TextStyle(color: Colors.black54, height: 1.5),
        ),
        const SizedBox(height: 18),
        if (cards.isEmpty)
          const Text('Add subjects and topics to create flashcards.'),
        ...List.generate(
          cards.length,
          (i) => _FlashcardTile(
            subject: cards[i]['subject']!,
            topic: cards[i]['topic']!,
            question: cards[i]['question']!,
            answer: cards[i]['answer']!,
          ),
        ),
      ],
    );
  }

  Widget _buildRisk(int daysLeft) {
    final unfinished = _plan.where((p) => p.status != 'Completed').length;
    final hard = _plan.where(
      (p) => p.difficulty == 'Hard' && p.status != 'Completed',
    ).length;
    final overdue = _plan.where((p) => p.breakOverdue).length;

    late String risk;
    late Color color;
    late String explanation;

    if (daysLeft <= 3 && unfinished > 0) {
      risk = 'High risk';
      color = Colors.red;
      explanation =
          'Your exam is close and $unfinished topics remain unfinished. '
          'Prioritize important topics and revise strategically.';
    } else if (hard >= 3 || (_plan.isNotEmpty && unfinished > _plan.length * .6)) {
      risk = 'Moderate risk';
      color = Colors.orange;
      explanation =
          'Several difficult or unfinished topics remain. Prioritize them '
          'and monitor your daily progress.';
    } else {
      risk = 'Lower risk';
      color = Colors.green;
      explanation =
          'Your current topic statuses do not indicate a major immediate '
          'risk. Continue following your schedule.';
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Study Risk Analysis',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.shield_outlined, color: color, size: 40),
                const SizedBox(height: 10),
                Text(
                  risk,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 10),
                Text(explanation),
              ],
            ),
          ),
        ),
        _riskRow('Days until exam', '$daysLeft'),
        _riskRow('Unfinished topics', '$unfinished'),
        _riskRow('Difficult topics remaining', '$hard'),
        _riskRow('Breaks awaiting restart', '$overdue'),
        const SizedBox(height: 15),
        FilledButton.icon(
          onPressed: () => setState(() => _tab = 0),
          icon: const Icon(Icons.calendar_month),
          label: const Text('Review My Timetable'),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () {
            final left = _plan.where((p) => p.status != 'Completed').toList();
            if (left.isEmpty) {
              _notify('All done', 'You have completed all your topics.');
              return;
            }
            _notify(
              'Daily task reminder',
              '${left.length} topic(s) remain unfinished today. '
              'Please review your timetable.',
            );
          },
          icon: const Icon(Icons.notifications_active_outlined),
          label: const Text('Check Daily Tasks'),
        ),
      ],
    );
  }

  Widget _riskRow(String label, String value) {
    return Card(
      child: ListTile(
        title: Text(label),
        trailing: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
    );
  }
}

// FLASHCARD WIDGET

class _FlashcardTile extends StatefulWidget {
  const _FlashcardTile({
    required this.subject,
    required this.topic,
    required this.question,
    required this.answer,
  });

  final String subject;
  final String topic;
  final String question;
  final String answer;

  @override
  State<_FlashcardTile> createState() => _FlashcardTileState();
}

class _FlashcardTileState extends State<_FlashcardTile> {
  bool _showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.subject,
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.topic,
              style: const TextStyle(color: Colors.black54),
            ),
            const Divider(height: 24),
            Text(
              widget.question,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_showAnswer) ...[
              const SizedBox(height: 12),
              Text(widget.answer, style: const TextStyle(height: 1.6)),
            ],
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => setState(() => _showAnswer = !_showAnswer),
              child: Text(_showAnswer ? 'Hide Answer' : 'Show Answer'),
            ),
          ],
        ),
      ),
    );
  }
}