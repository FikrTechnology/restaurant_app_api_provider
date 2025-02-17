part of '../../package.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _requestPermission() async {
    context.read<LocalNotificationProvider>().requestPermissions();
  }

  Future<void> _showNotification() async {
    context.read<LocalNotificationProvider>().showNotification();
  }

  Future<void> _scheduleDaily11AMNotification() async {
    context.read<LocalNotificationProvider>().scheduleDaily11AMNotification();
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification Permission'),
          content: const Text(
              'Notification permission is disabled. Please enable it in the device settings.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Theme.of(context).brightness == Brightness.light
                              ? 'Dark Mode'
                              : 'Light Mode',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Switch(
                          value:
                              Theme.of(context).brightness == Brightness.light
                                  ? themeProvider.isDarkModeOn
                                  : themeProvider.isLightModeOn,
                          onChanged: (value) {
                            Theme.of(context).brightness == Brightness.light
                                ? themeProvider.toggleTheme()
                                : themeProvider.toggleLightTheme();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<LocalNotificationProvider>(
                  builder: (context, valueReminder, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Aktifkan Reminder',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Switch(
                          value: valueReminder.isReminderModeOn,
                          onChanged: (value) {
                            if (value){
                              _requestPermission();
                              if (valueReminder.permission!){
                                _scheduleDaily11AMNotification();
                                _showNotification();
                                valueReminder.toggleReminder();
                              } else {
                                _showPermissionDialog(context);
                              }
                            } else {
                              valueReminder.cancelAllNotifications(1);
                              valueReminder.toggleReminder();
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
