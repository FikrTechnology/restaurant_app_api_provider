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

  Future<void> _scheduleDaily11AMNotification() async {
    context.read<LocalNotificationProvider>().scheduleDaily11AMNotification();
  }

  Future<void> _checkPendingNotificationRequests() async {
    final localNotificationProvider = context.read<LocalNotificationProvider>();
    await localNotificationProvider.checkPendingNotificationRequests(context);

    if (!mounted) {
      return;
    }

    return showDialog(
     context: context,
     builder: (BuildContext context) {
       final pendingData = context.select(
           (LocalNotificationProvider provider) =>
               provider.pendingNotificationRequests);
       return AlertDialog(
         title: Text(
           '${pendingData.length} pending notification requests',
           maxLines: 1,
           overflow: TextOverflow.ellipsis,
         ),
         content: SizedBox(
           height: 300,
           width: 300,
           child: ListView.builder(
             itemCount: pendingData.length,
             shrinkWrap: true,
             itemBuilder: (context, index) {
               final item = pendingData[index];
               return ListTile(
                 title: Text(
                  item.title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                 ),
                 subtitle: Text(
                  item.body ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                 ),
                 contentPadding: EdgeInsets.zero,
                 trailing: IconButton(
                  onPressed: (){
                    localNotificationProvider
                    ..cancelAllNotifications(item.id)
                    ..checkPendingNotificationRequests(context);
                  }, 
                  icon: const Icon(Icons.delete_outline)
                ),
               );
             },
           ),
         ),
         actions: <Widget>[
           TextButton(
             onPressed: () {
               Navigator.of(context).pop();
             },
             child: const Text('OK'),
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
                          onChanged: (value) {},
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
            ElevatedButton(
              onPressed: () async {
                await _scheduleDaily11AMNotification();
              },
              child: const Text(
                "Schedule daily 11AM notification",
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _checkPendingNotificationRequests();
              },
              child: const Text(
                "Check pending notification requests",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
