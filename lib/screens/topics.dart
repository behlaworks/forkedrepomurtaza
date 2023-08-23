import 'package:aire/screens/physics.dart';
import 'package:aire/screens/test.dart';
import 'package:aire/screens/topicsPlayer.dart';
import 'package:flutter/material.dart';
import '../components/common ui elements/dialog.dart';
import '../data/constants.dart';
import '../models/cloud_firestore.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io'; // Import 'File' class
import 'package:flutter/foundation.dart'; // Import 'kDebugMode'
import 'package:aire/screens/pdfScreen.dart';

class Topics extends StatefulWidget {
  final int unit;

  const Topics({Key? key, required this.unit}) : super(key: key);

  @override
  State<Topics> createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  bool processing = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  Future<void> loadData() async {
    await DatabaseService()
        .listOfTopics(Constants.physicsChapters[widget.unit - 1]);
    setState(() {
      processing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: processing
            ? Center(
                child: CircularProgressIndicator(
                  color: Constants.dark,
                  strokeWidth: 4,
                ),
              )
            : SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              'assets/nextrev.png',
                              height: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              child: Center(
                                  child: Image.asset(
                                'assets/atom.png',
                                height: 50,
                              )),
                            ),
                          ),
                          const Text(
                            "Physics",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "Unit ${widget.unit} : ${Constants.physicsChapters[widget.unit - 1]}")
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.height * 0.63,
                        child: const SubTopicList()),
                  ],
                ),
              ));
  }
}

class SubTopicList extends StatelessWidget {
  const SubTopicList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView(
        children: [
          for (var i = 0; i < Constants.titles.length; i++)
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 75,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xffECCFC3)),
                      child: InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TopicsPlayer(
                                        page: i,
                                      )));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => TopicsPlayer(
                          //               index: i,
                          //             )));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  (i + 1).toString(),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  Constants.titles[i],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                )),
          const NotesButton(
              url:
                  "https://firebasestorage.googleapis.com/v0/b/a-level-pro.appspot.com/o/pastpapers%2FChapter%201%20%20physics%20.pdf?alt=media&token=d454e5e8-8bd4-4b84-af8a-2b20e7aca94e",
              ms: false,
              title: "Notes",
              anyButtonLoading: false),
          Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 75,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF0544F)),
                    child: InkWell(
                      onTap: () async {
                        Constants.completedUnits.length == 5?
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MCQTest())):
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomAlertDialog(
                                  title: "Stop!",
                                  text: "Please complete this unit before giving test."
                              );
                            });
                      },
                      child: const Center(
                        child: Text(
                          "End of unit test",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
              )),
        ],
      ),
    );
  }
}

class NotesButton extends StatefulWidget {
  final String url;
  final bool ms;
  final String title;
  final bool anyButtonLoading;

  const NotesButton(
      {Key? key,
      required this.url,
      required this.ms,
      required this.title,
      required this.anyButtonLoading})
      : super(key: key);

  @override
  State<NotesButton> createState() => _NotesButtonState();
}

class _NotesButtonState extends State<NotesButton> {
  final cacheManager = DefaultCacheManager();
  bool loading = false;

  Future<File> loadPdfFromNetwork(String url) async {
    var temp = await cacheManager.getFileFromCache(url);
    if (temp == null) {
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;
      var file = await _storeFile(url, bytes);

      // Store the downloaded file's bytes in the cache
      await cacheManager.putFile(url, bytes);

      return file;
    }
    return temp.file;
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      print('$file');
    }
    return file;
  }

  void openPdf(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfScreen(
            file: file,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      child: Container(
          clipBehavior: Clip.hardEdge,
          height: 75,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: !widget.ms
                  ? const Color(0xffECCFC3)
                  : const Color(0xffcde0f6)),
          child: InkWell(
            onTap: loading
                ? null
                : () async {
                    setState(() {
                      loading = true;
                    });
                    final file = await loadPdfFromNetwork(widget.url);
                    setState(() {
                      loading = false;
                    });
                    openPdf(context, file);
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.red,
                            strokeWidth: 4,
                          ))
                      : Image.asset(
                          'assets/next.png',
                          height: 20,
                        ),
                )
              ],
            ),
          )),
    );
  }
}
