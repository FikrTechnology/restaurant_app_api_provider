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

 Future<void> _showBigPictureNotification() async {
   context.read<LocalNotificationProvider>().showBigPictureNotification();
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
                          value: Theme.of(context).brightness == Brightness.light 
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
                child: Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Aktifkan Reminder',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Switch(
                          value: false,
                          onChanged: (value) {
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _requestPermission();
              },
              child: Consumer<LocalNotificationProvider>(
                builder: (context, value, child) {
                  return Text(
                    "Request permission! (${value.permission})",
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _showNotification();
              },
              child: const Text(
                "Show notification with payload and custom sound",
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _showBigPictureNotification();
              },
              child: const Text(
                "Show big picture notification",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
