import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  bool notificationsEnabled = false;
  List<String> selectedHabits = [];
  List<String> selectedTimes = [];
  Map<String, String> allHabitsMap = {};

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _loadData();
  }

  Future<void> _initializeNotifications() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _localNotifications.initialize(settings: settings);
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
      allHabitsMap = Map<String, String>.from(
          jsonDecode(prefs.getString('selectedHabitsMap') ?? '{}'));
      selectedHabits = prefs.getStringList('notificationHabits') ?? [];
      selectedTimes = prefs.getStringList('notificationTimes') ?? [];
    });
  }

  Future<void> _saveNotificationSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', notificationsEnabled);
    await prefs.setStringList('notificationHabits', selectedHabits);
    await prefs.setStringList('notificationTimes', selectedTimes);
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Add opacity if not included.
    }
    return Color(int.parse('0x$hexColor'));
  }

  Future<bool> _requestPermission() async {
    final android = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return await android?.requestNotificationsPermission() ?? true;
  }

  Future<void> _sendTestNotification() async {
    if (!notificationsEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Activa las notificaciones primero')),
      );
      return;
    }
    if (selectedHabits.isEmpty || selectedTimes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Selecciona al menos un hábito y un horario')),
      );
      return;
    }

    final permitted = await _requestPermission();
    if (!permitted) {
      setState(() => notificationsEnabled = false);
      _saveNotificationSettings();
      return;
    }

    await _localNotifications.show(
      id: 1,
      title: 'Habit Reminder',
      body: 'Es hora de trabajar en: ${selectedHabits.join(', ')}',
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'habit_reminders',
          'Habit Reminders',
          channelDescription: 'Reminders for habit tracking',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Text('Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: notificationsEnabled,
              onChanged: (value) async {
                if (value) {
                  final permitted = await _requestPermission();
                  if (!permitted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Permiso de notificaciones denegado')),
                    );
                    return; // No activar el toggle sin permiso
                  }
                }
                setState(() {
                  notificationsEnabled = value;
                });
                _saveNotificationSettings();
              },
            ),
            Divider(),
            Text(
              'Select Habits for Notification',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: allHabitsMap.entries.map((entry) {
                final habit = entry.key;
                final colorHex = entry.value;
                final color = _getColorFromHex(colorHex);
                return FilterChip(
                  label: Text(habit),
                  labelStyle: TextStyle(color: color),
                  selected: selectedHabits.contains(habit),
                  selectedColor: color.withOpacity(0.3),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: color, width: 2.0),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedHabits.add(habit);
                      } else {
                        selectedHabits.remove(habit);
                      }
                    });
                    _saveNotificationSettings();
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Select Times for Notification',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: ['Morning', 'Afternoon', 'Evening'].map((time) {
                return FilterChip(
                  label: Text(time),
                  selected: selectedTimes.contains(time),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedTimes.add(time);
                      } else {
                        selectedTimes.remove(time);
                      }
                    });
                    _saveNotificationSettings();
                  },
                );
              }).toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Use the _sendTestNotification method to trigger the notification
                _sendTestNotification();
              },
              child: Text('Send Test Notification'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}