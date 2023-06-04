import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/constants.dart';

class Contents extends StatefulWidget {
  final int index;
  const Contents({Key? key, required this.index}) : super(key: key);

  @override
  State<Contents> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
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
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Text(
              "Contents",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 20,),
              for (var i = 0; i < Constants.titles.length; i++)
                widget.index != i?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 60,
                    decoration: BoxDecoration(
                        color: const Color(0xffF2F5FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 3)),
                    child: Center(
                      child: Text(
                        Constants.titles[i],
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ):
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 60,
                    decoration: BoxDecoration(
                        color: const Color(0xffF2F5FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 3)),
                    child: Center(
                      child: Text(
                        "${Constants.titles[i]}: now playing",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
}
