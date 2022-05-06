import 'dart:io';
import 'dart:typed_data';

import 'package:another_brother/printer_info.dart';
import 'package:brotherquickstart/brother/brother_bluetooth_printer.dart';
import 'package:brotherquickstart/brother/brother_wifi_printer.dart';
import 'package:brotherquickstart/util/image_util.dart';
import 'package:brotherquickstart/util/navigation.dart';
import 'package:brotherquickstart/util/printable_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  final String title;

  const Home({Key? key, required this.title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

   List<File> _filesToPrint = List.empty(growable: true);

  bool isPrinting = false;
  PrinterInfo _printInfo = PrinterInfo();
  final myController = TextEditingController();
  TextStyle _style = GoogleFonts.oswald(color: Colors.black, fontSize: 55);
  late GlobalKey key1 = GlobalKey();

  @override
  void initState() {
    super.initState();
    initialization();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      loadPage();
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_filesToPrint.isNotEmpty && isPrinting) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.blue),
                    backgroundColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  onPressed: () => {printBrotherWifiPrinter()},
                  icon: const Icon(
                    Icons.wifi,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Print ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.blue),
                    backgroundColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  onPressed: () => {printBrotherBluetoothPrinter()},
                  icon: const Icon(
                    Icons.bluetooth,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Print  ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
              ],
            ),
          ],
        ),
        drawer: buildDrawer(),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _filesToPrint.length,
                    itemBuilder: (BuildContext context, int index) {
                      File file = _filesToPrint[index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        shadowColor: Colors.black,
                        // elevation: 11,
                        borderOnForeground: false,
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Image.file(file),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: buildBottomSheet(),
        bottomNavigationBar: buildBottomNavigationBar(),
      );
    }
    if (_filesToPrint.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.blue),
                    backgroundColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  onPressed: () => {printBrotherWifiPrinter()},
                  icon: const Icon(
                    Icons.wifi,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Print ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.blue),
                    backgroundColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  onPressed: () => {printBrotherBluetoothPrinter()},
                  icon: const Icon(
                    Icons.bluetooth,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Print  ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
              ],
            ),
          ],
        ),
        drawer: buildDrawer(),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _filesToPrint.length,
                    itemBuilder: (BuildContext context, int index) {
                      File file = _filesToPrint[index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        shadowColor: Colors.black,
                        // elevation: 11,
                        borderOnForeground: false,
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Image.file(file),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: buildBottomNavigationBar(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: buildDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(20.0),
                  child: ListTile(
                    leading: InkWell(
                        onTap: () {
                          _chooseFont();
                        },
                        child: const Icon(Icons.font_download)),
                    title: SizedBox(
                      height: 30,
                      child: TextField(
                        controller: myController,
                        onChanged: (text) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Message',
                        ),
                      ),
                    ),
                    trailing:  InkWell(
                      onTap: () {
                        printMessage();
                      },
                        child: const Icon(Icons.print)
                    ),
                  ),
                ),
                PrintableWidget(
                  builder: (key) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(20.0),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              myController.text,
                              style: _style,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  key: key1,
                ),

                const Divider(
                  height: 5,
                  thickness: 3,
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Shifting
      backgroundColor: Colors.blue, // <-- This works for fixed
      selectedItemColor: Colors.black,
      // unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.wifi),
          label: 'Printers',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bluetooth),
          label: 'Printers',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.scanner),
          label: 'Scanners',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.image),
          label: 'Select',
        ),
      ],
      currentIndex: _selectedIndex,
      // selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigation().openBrotherWifiPrinter(context);
    }
    if (_selectedIndex == 1) {
      Navigation().openBrotherBluetoothPrinter(context);
    }
    if (_selectedIndex == 2) {
      Navigation().openBrotherBrotherWifiScanner(context);
    }
    if (_selectedIndex == 3) {
      selectPictures();
    }
  }

  Future<void> loadPage() async {
    try {
      List<Permission> _permissionList = List.empty(growable: true);
      int index = -99;
      bool doAskForPermission = false;
      if (Platform.isAndroid) {
        index = Permission.values.indexWhere((f) => f.value == Permission.bluetoothScan.value);
        Permission bluetoothScan = Permission.values.elementAt(index);
        if (!await Permission.bluetoothScan.isGranted) {
          doAskForPermission = true;
        }
        index = Permission.values.indexWhere((f) => f.value == Permission.bluetoothConnect.value);
        Permission bluetoothConnect = Permission.values.elementAt(index);
        if (!await Permission.bluetoothConnect.isGranted) {
          doAskForPermission = true;
        }
        index = Permission.values.indexWhere((f) => f.value == Permission.storage.value);
        Permission storage = Permission.values.elementAt(index);
        if (!await Permission.storage.isGranted) {
          doAskForPermission = true;
        }
        debugPrint("Home: Permission: bluetoothScan: ${await Permission.bluetoothScan.isGranted}");
        debugPrint("Home: Permission: bluetoothConnect: ${await Permission.bluetoothConnect.isGranted}");
        debugPrint("Home: Permission: storage ${await Permission.storage.isGranted}");

        _permissionList = <Permission>[bluetoothScan, bluetoothConnect, storage];
        debugPrint("Home: Permission: _permissionList.length: ${_permissionList.length}");
      }
      // if (Platform.isIOS) {
      //   index = Permission.values.indexWhere((f) => f.value == Permission.storage.value);
      //   Permission storage = Permission.values.elementAt(index);
      //   if (!await Permission.storage.isGranted) {
      //     doAskForPermission = true;
      //   }
      //
      //   index = Permission.values.indexWhere((f) => f.value == Permission.bluetoothScan.value);
      //   Permission bluetoothScan = Permission.values.elementAt(index);
      //   if (!await Permission.bluetoothScan.isGranted) {
      //     doAskForPermission = true;
      //   }
      //
      //   index = Permission.values.indexWhere((f) => f.value == Permission.bluetoothAdvertise.value);
      //   Permission bluetoothAdvertise = Permission.values.elementAt(index);
      //   if (!await Permission.bluetoothAdvertise.isGranted) {
      //     doAskForPermission = true;
      //   }
      //
      //   index = Permission.values.indexWhere((f) => f.value == Permission.bluetoothConnect.value);
      //   Permission bluetoothConnect = Permission.values.elementAt(index);
      //   if (!await Permission.bluetoothConnect.isGranted) {
      //     doAskForPermission = true;
      //   }
      //   _permissionList = <Permission>[storage, bluetoothScan, bluetoothAdvertise, bluetoothConnect];
      //   debugPrint("Home: Permission: _permissionList.length: ${_permissionList.length}");
      // }
      if (doAskForPermission) {
        Navigation().openAppPermissions(context, _permissionList);
      }
    } catch (e) {
      debugPrint("Home: loadPage: ERROR $e");
    }
  }

  Future<void> printBrotherWifiPrinter() async {
    debugPrint("PrintImage: printBrotherWifiPrinter: files");
    if (_filesToPrint.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Select images to print',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.amberAccent),
      );
      return;
    }
    if (BrotherWifiPrinter.netPrinter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Wifi printer has not been selected',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.amberAccent),
      );
      return;
    }

    // _file = await ImageUtil().rotate(_file!.path, 90);
    //here is the print statement
    setState(() {
      isPrinting = true;
    });

    await BrotherWifiPrinter.print(_filesToPrint.toList(), eventListenerPrintStatus)
        .onError((error, stackTrace) => {debugPrint("PrintImage: BrotherWifiPrinter: error: $error stackTrace: $stackTrace")})
        .catchError((onError) => {debugPrint("PrintImage: BrotherWifiPrinter: onError: $onError ")});
    setState(() {
      isPrinting = false;
    });
  }

  Future<void> printBrotherBluetoothPrinter() async {
    debugPrint("PrintImage: printBrotherBluetoothPrinter: ${_filesToPrint.length}");
    if (_filesToPrint.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Select image first',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.amberAccent),
      );
      return;
    }
    if (BrotherBluetoothPrinter.bluetoothPrinter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Bluetooth printer has not been selected',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.amberAccent),
      );
      return;
    }

    // _file = await ImageUtil().rotate(_file!.path, 90);
    //here is the print statement
    setState(() {
      isPrinting = true;
    });

    await BrotherBluetoothPrinter.print(_filesToPrint.toList(), eventListenerPrintStatus).onError((error, stackTrace) {
      debugPrint("PrintImage: printBrotherBluetoothPrinter: onError:  $error stackTrace: $stackTrace");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              error.toString(),
              style: const TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.amberAccent),
      );
    }).catchError((catchError) {
      debugPrint("PrintImage: printBrotherBluetoothPrinter: catchError:  $catchError");
    });
    setState(() {
      isPrinting = false;
    });
  }

  Future<void> selectPictures() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);
    if (result == null) {
      return;
    }
    for (var file in result.files) {
      String? s = file.path;
      _filesToPrint.add(File(s!));
    }
    setState(() {});
  }

  buildDrawer() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Image.asset("assets/logo2.png", height: 150),
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 5,
                color: Colors.black,
              ),
              TextButton.icon(
                label: const Text("Home"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigation().goHome(context);
                },
                icon: const Icon(Icons.home),
              ),
              TextButton.icon(
                label: const Text("Wifi Printers"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigation().openBrotherWifiPrinter(context);
                },
                icon: const Icon(Icons.wifi),
              ),
              TextButton.icon(
                label: const Text("Bluetooth Printers"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigation().openBrotherBluetoothPrinter(context);
                },
                icon: const Icon(Icons.bluetooth),
              ),
              TextButton.icon(
                label: const Text("Wifi Scanner"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigation().openBrotherBrotherWifiScanner(context);
                },
                icon: const Icon(Icons.scanner),
              ),
            ],
          ),
        ],
      ),
    );
  }

  eventListenerPrintStatus(PrinterStatus printerStatus, PrinterInfo printInfo) async {
    debugPrint("Home: eventListenerPrintStatus: printInfo:labelNameIndex: ${printInfo.labelNameIndex}");
    debugPrint("Home: eventListenerPrintStatus: printInfo:getPaperId: ${printInfo.paperSize.getPaperId()}");
    // _printerStatus = printerStatus;
    if (printerStatus.errorCode.getName().compareTo(ErrorCode.ERROR_NONE.getName()) == 0) {
      _filesToPrint.removeAt(0);
    }
    _printInfo = printInfo;
    setState(() {});
  }

  Widget buildBottomSheet() {
    debugPrint("Home: buildBottomSheet");
    double width = (MediaQuery.of(context).size.width);
    return Container(
        color: Colors.blue,
        height: 120,
        width: width,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(":: Checking for the correct label size::", style: TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.6))),
            Text("Checking paper Size ${_printInfo.labelNameIndex}", style: TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.6))),
            Text("Checking paper Type ${_printInfo.paperSize.getName()}", style: TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.6))),
          ],
        ));
  }

  void _chooseFont() async {
    //good to know
    // debugPrint("Home: _chooseFont: value: ${GoogleFonts.asMap().keys.toList()}");
    //good to know
    var value = await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 100, 100),
      items: [
        const PopupMenuItem<String>(child: Text('AlexBrush'), value: 'AlexBrush-Regular'),
        const PopupMenuItem<String>(child: Text('lato'), value: 'lato'),
        const PopupMenuItem<String>(child: Text('oswald'), value: 'oswald'),
      ],
      elevation: 8.0,
    );
    debugPrint("Home: _chooseFont: value: $value");
    if ("AlexBrush-Regular".compareTo(value!) == 0) {
      _style = const TextStyle(color: Colors.black, fontFamily: 'AlexBrush', fontSize: 55);
    }
    if ("lato".compareTo(value) == 0) {
      _style = GoogleFonts.lato(color: Colors.black, fontSize: 55);
    }
    if ("oswald".compareTo(value) == 0) {
      _style = GoogleFonts.oswald(color: Colors.black, fontSize: 55);
    }
    setState(() {});

  }

  Future<void> printMessage() async {
    debugPrint("Home: printMessage:");
    _filesToPrint = List.empty(growable: true);
    Uint8List pngBytes = await ImageUtil.globalKeyToImage(key1);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String fullPath = '$dir/${DateTime.now().millisecond}.png';
    File capturedFile = File(fullPath);
    await capturedFile.writeAsBytes(pngBytes);
    _filesToPrint.add(capturedFile);
    setState(() {});
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

}
