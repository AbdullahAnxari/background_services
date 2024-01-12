import 'lib.dart';

//Todo 1: set the compileSdkVersion 34
//Todo 2: set the targetSdkVersion. 34
//Todo 3: set the WidgetsFlutterBinding in main
//Todo 4: Also change the  kotlin version to (ext.kotlin_version = '1.8.10') from android> build.gradle
//Todo 4: Also add dependies

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then(
    (value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );

  await initializeService();
  runApp(const MyApp());
}
