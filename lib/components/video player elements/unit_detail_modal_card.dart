import 'package:flutter/material.dart';

import '../../data/constants.dart';

class UnitDetailModalCard extends StatelessWidget {
  final String unit;
  final String title;
  final List notes;

  const UnitDetailModalCard(
      {Key? key, required this.unit, required this.title, required this.notes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Icon(
              Icons.minimize,
              size: 40,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Text(
              "Unit: $unit",
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 3, 0, 0),
                child: Text(
                  "Notes:",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              notes.isEmpty
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(23)),
                      child: const Center(
                        child: Text(
                          'No notes required for this unit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.hardEdge,
                          primary: false,
                          children: [
                            for (var e in notes)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(23),
                                  ),
                                  child: Image.network(
                                    e.toString(),
                                    fit: BoxFit.fill,
                                    frameBuilder: (context, child, frame,
                                        wasSynchronouslyLoaded) {
                                      return child;
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: Constants.dark,
                                            strokeWidth: 4,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                          ]),
                    )
            ],
          ),
          const SizedBox(
            height: 55,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.53,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: const Center(
                child: Text(
                  "Mark Complete",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
