part of '../provider_package.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService) {
    _loadReminder();
  }

  static const String _reminderKey = "isReminderModeOn";
  bool _isReminderModeOn = false;
  bool get isReminderModeOn => _isReminderModeOn;

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void showNotification() {
    _notificationId = 1;
    flutterNotificationService.showNotification(
      id: _notificationId,
      title: "Reminder has been updated",
      body: "reminder has been set at 11 am",
      payload: "Please check the restaurants you have saved.",
    );
  }

  void showBigPictureNotification() {
    _notificationId += 1;
    flutterNotificationService.showBigPictureNotification(
      id: _notificationId,
      title: "New Notification",
      body: "This is a new notification with id $_notificationId",
      payload: "This is a payload from nitification with id $_notificationId",
    );
  }

  void scheduleDaily11AMNotification() {
    _notificationId = 1;
    flutterNotificationService.scheduleDaily11AMNotification(
      id: _notificationId,
    );
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests =
        await flutterNotificationService.pendingNotificationRequests();
    notifyListeners();
  }

  Future<void> cancelAllNotifications(int id) async {
    await flutterNotificationService.cancelAllNotifications(id);
  }


  void _loadReminder() async {
    final prefs = await SharedPreferences.getInstance();
    _isReminderModeOn = prefs.getBool(_reminderKey) ?? false;
    notifyListeners();
  }

  void toggleReminder() async {
    final prefs = await SharedPreferences.getInstance();
    _isReminderModeOn = !_isReminderModeOn;
    await prefs.setBool(_reminderKey, _isReminderModeOn);
    notifyListeners();
  }
}
