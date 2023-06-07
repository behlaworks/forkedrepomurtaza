import 'package:a_level_pro/models/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/constants.dart';

class UnitDetailModalCard extends StatefulWidget {
  final String unit;
  final String title;
  final List notes;

  const UnitDetailModalCard(
      {Key? key, required this.unit, required this.title, required this.notes})
      : super(key: key);

  @override
  State<UnitDetailModalCard> createState() => _UnitDetailModalCardState();
}

class _UnitDetailModalCardState extends State<UnitDetailModalCard> {
  @override
  Widget build(BuildContext context) {
    bool completed = Constants.completedUnits.contains(widget.unit);
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
              "Unit: ${widget.unit}",
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
            child: Text(
              widget.title,
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
              widget.notes.isEmpty
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
                            for (var e in widget.notes)
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
              DatabaseService()
                  .updateUnitComplete(widget.unit)
                  .then((value) => setState(() {}));
            },
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.53,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Center(
                child:
                !completed? const Text(
                  'Mark Complete',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ):
                 const Padding(
                   padding: EdgeInsets.all(8.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         'Completed',
                         style: TextStyle(
                             fontSize: 18,
                             fontWeight: FontWeight.w700,
                             color: Colors.black),
                       ),
                       Icon(Icons.done, size: 30, color: Colors.green, weight: 15,)
                     ],
                   ),
                 )
              ),
            ),
          )
        ],
      ),
    );
  }
}
