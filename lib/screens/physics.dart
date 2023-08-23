import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io'; // Import 'File' class
import 'package:flutter/foundation.dart'; // Import 'kDebugMode'
import 'package:aire/screens/campaignMCQ.dart';
import 'package:aire/screens/pdfScreen.dart';
import 'package:flutter/material.dart';
import 'package:aire/models/cloud_firestore.dart';
import '../components/chapterBox.dart';
import '../data/constants.dart';

class PhysicsContentPage extends StatefulWidget {
  const PhysicsContentPage({Key? key}) : super(key: key);

  @override
  State<PhysicsContentPage> createState() => _PhysicsContentPageState();
}

class _PhysicsContentPageState extends State<PhysicsContentPage> {
  int completedPercent = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    DatabaseService().unitCompletionCalculator().then((value) {
      completedPercent = value.toInt();
      setState(() {
        processing = false;
      });
    });
  }

  bool processing = true;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const Content(),
      const Practice(),
      const PastPapers()
      // ProfilePage(name: name, age: age, refID: referralID, intake: intake)
    ];
    return Scaffold(
        backgroundColor: const Color(0xfff2f3f7),
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white),
                                      child: Center(
                                          child: Image.asset(
                                        'assets/atom.png',
                                        height: 50,
                                      )),
                                    ),
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Physics",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        "5 videos",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xfff2f3f7),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "$completedPercent% Completed",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = 0;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: _selectedIndex == 0
                                                ? Colors.red
                                                : Colors.transparent,
                                            width: 3),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: const Center(
                                      child: Text(
                                        "Units",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: _selectedIndex == 1
                                                ? Colors.red
                                                : Colors.transparent,
                                            width: 3),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: const Center(
                                      child: Text(
                                        "Practice",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = 2;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: _selectedIndex == 2
                                                ? Colors.red
                                                : Colors.transparent,
                                            width: 3),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: const Center(
                                      child: Text(
                                        "Past Papers",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.height * 0.63,
                        child: widgetOptions.elementAt(_selectedIndex)),
                  ],
                ),
              ));
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView(
        children: [
          for (var i = 0; i < Constants.physicsChapters.length; i++)
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: ChapterBox(
                  name: Constants.physicsChapters[i],
                  unit: i + 1,
                )),
        ],
      ),
    );
  }
}

class Practice extends StatelessWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MCQCampaign()));
                    },
                    child: const Center(
                      child: Text(
                        "P1 campaign mode",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )),
            )),
      ],
    );
  }
}

class PastPapers extends StatefulWidget {
  const PastPapers({Key? key}) : super(key: key);

  @override
  State<PastPapers> createState() => _PastPapersState();
}

class _PastPapersState extends State<PastPapers> {
  int selected = 1;
  bool anyButtonLoading = false;
  void updateAnyButtonLoading(bool isLoading) {
    setState(() {
      anyButtonLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = 1;
                });
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                    color: selected == 1 ? Colors.white : Colors.transparent,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12))),
                child: const Center(
                  child: Text("Topical papers"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = 2;
                });
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                    color: selected == 2 ? Colors.white : Colors.transparent,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12))),
                child: const Center(
                  child: Text("Yearly papers"),
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(12))),
              width: MediaQuery.of(context).size.width * 0.9,
              child: selected == 1
                  ? SingleChildScrollView(
                    child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          PastPaperButton(
                              updateAnyButtonLoading: updateAnyButtonLoading,
                            anyButtonLoading: anyButtonLoading,
                              url:
                                  "https://firebasestorage.googleapis.com/v0/b/a-level-pro.appspot.com/o/Chapter%201.pdf?alt=media&token=c8dc98e7-3e14-4e37-8411-a72228e89357",
                              ms: false,
                            title: "P1 QP chapter 1"
                          ),
                          PastPaperButton(
                              updateAnyButtonLoading: updateAnyButtonLoading,
                              anyButtonLoading: anyButtonLoading,
                              url:
                                  "https://firebasestorage.googleapis.com/v0/b/a-level-pro.appspot.com/o/pastpapers%2Fphysicalquantities-and-measure_qp.pdf?alt=media&token=4fc31e5b-d213-4230-b7df-83f5bb4e020f",
                              ms: false,
                          title: "P2 QP chapter 1"),
                          PastPaperButton(
                              updateAnyButtonLoading: updateAnyButtonLoading,
                              anyButtonLoading: anyButtonLoading,
                              url:
                              "https://firebasestorage.googleapis.com/v0/b/a-level-pro.appspot.com/o/pastpapers%2Ftpch1ms.pdf?alt=media&token=f6762406-1795-45b7-9343-9b4c1dc54928",
                              ms: true,
                              title: "P2 MS chapter 1"
                          ),
                        ],
                      ),
                  )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        PastPaperButton(
                            updateAnyButtonLoading: updateAnyButtonLoading,
                            anyButtonLoading: anyButtonLoading,
                            url:
                            "https://firebasestorage.googleapis.com/v0/b/a-level-pro.appspot.com/o/pastpapers%2F9702_s22_qp_22.pdf?alt=media&token=e2d45d96-4ac7-42d5-906c-94df0bfe40d0",
                            ms: false,
                            title: "M/J 22 P2"
                        ),
                      ],
                    ),
            ),
          ),
        )
      ],
    );
  }
}

class PastPaperButton extends StatefulWidget {
  final String url;
  final bool ms;
  final String title;
  final bool anyButtonLoading;
  final Function(bool) updateAnyButtonLoading;

  const PastPaperButton({Key? key, required this.url, required this.ms, required this.title, required this.anyButtonLoading, required this.updateAnyButtonLoading})
      : super(key: key);

  @override
  State<PastPaperButton> createState() => _PastPaperButtonState();
}

class _PastPaperButtonState extends State<PastPaperButton> {
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
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
      child: Container(
          clipBehavior: Clip.hardEdge,
          height: 75,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: !widget.ms
                  ? const Color(0xffECCFC3)
                  : const Color(0xffcde0f6)),
          child: InkWell(
            onTap:  widget.anyButtonLoading
                ? null
                : () async {
              widget.updateAnyButtonLoading(true);
              setState(() {
                loading = true;
              });
              final file = await loadPdfFromNetwork(widget.url);
              setState(() {
                loading = false;
              });
              widget.updateAnyButtonLoading(false);
              openPdf(context, file);
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
                      widget.title,
                      style:
                          const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
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
