part of '../../package.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          ],
        ),
      ),
    );
  }
}
