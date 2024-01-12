import 'lib.dart';

class BackgroudServicesApp extends StatefulWidget {
  const BackgroudServicesApp({Key? key}) : super(key: key);

  @override
  State<BackgroudServicesApp> createState() => _BackgroudServicesState();
}

class _BackgroudServicesState extends State<BackgroudServicesApp> {
  String text = "Stop Service";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Service App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //*setAsForeground
              ElevatedButton(
                child: const Text("Foreground Mode"),
                onPressed: () {
                  FlutterBackgroundService().invoke("setAsForeground");
                },
              ),

              //*setAsBackground
              ElevatedButton(
                child: const Text("Background Mode"),
                onPressed: () {
                  FlutterBackgroundService().invoke("setAsBackground");
                },
              ),

              //*stopService
              ElevatedButton(
                child: Text(text),
                onPressed: () async {
                  final service = FlutterBackgroundService();
                  var isRunning = await service.isRunning();
                  if (isRunning) {
                    service.invoke("stopService");
                  } else {
                    service.startService();
                  }

                  if (!isRunning) {
                    text = 'Stop Service';
                  } else {
                    text = 'Start Service';
                  }
                  setState(() {});
                },
              ),

              // const Expanded(
              //   child: LogView(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
