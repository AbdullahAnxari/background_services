import 'lib.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
  );
}

//* to ensure this is executed run app from xcode, then from xcode menu, select Simulate Background Fetch

//* // lib/services/ios_background.dart
@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

//* // lib/services/android_background.dart
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    //* lib/services/notification_service.dart
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        //*Notification
        service.setForegroundNotificationInfo(
          title: "BackGround Servives App",
          content: "Updated at ${DateTime.now()}",
        );
      }
    }

    //*Perform Background operations which is not noticeable to user
    //* lib/services/background_operations.dart
    // debugPrint('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    service.invoke('updated');
  });
}
