import 'package:flutter/material.dart';

class UnitDetailModalCard extends StatelessWidget {
  final int unit;

  const UnitDetailModalCard({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Icon(Icons.minimize, size: 40, color: Colors.white,),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Text(
              "Unit: ${unit.toString()}",
              style: const TextStyle(
                  fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
            child: Text(
              "Introduction to quantities.",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Contents",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
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
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(23)),
            child: const Center(
              child: Text(
                'No notes required for this unit',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Container(
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
          )
        ],
      ),
    );
  }
}
