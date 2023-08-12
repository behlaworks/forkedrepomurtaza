import "package:aire/screens/profilePage.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../models/app_state_manager.dart";

class Menu extends StatelessWidget {
  final String name;
  final String age;
  final String intake;
  final String refID;

  const Menu({Key? key, required this.name, required this.age, required this.intake, required this.refID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppStateManager myProvider = Provider.of<AppStateManager>(context);
    return Scaffold(
        backgroundColor: const Color(0xfff2f3f7),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
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
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Image.asset(
                    'assets/profile.png',
                    height: 70,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Hi! ${name[0].toUpperCase() + name.substring(1)}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              MenuBox(
                  icon: "assets/userProfile.png", title: "Profile", onTap: () {Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(name: name, age: age, refID: refID, intake: intake)),
              );}),
              const SizedBox(height: 25,),
              MenuBox(icon: "assets/diamond.png", title: "News", onTap: (){}),
              MenuBox(icon: "assets/diamond.png", title: "Share with friends", onTap: (){}),
              MenuBox(icon: "assets/diamond.png", title: "Subscriptions", onTap: (){}),
              const SizedBox(height: 25,),
              MenuBox(icon: "assets/diamond.png", title: "Contact us", onTap: (){}),
              MenuBox(icon: "assets/diamond.png", title: "Policy", onTap: (){}),
              const SizedBox(height: 25,),
              MenuBox(icon: "assets/diamond.png", title: "Logout", onTap: (){
                FirebaseAuth.instance.signOut();
                              myProvider.logout();
              }),
          ],
        ),
            )));
  }
}

class MenuBox extends StatelessWidget {
  final String icon;
  final String title;
  final Function() onTap;

  const MenuBox(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                Image.asset(
                  icon,
                  height: 30,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: Icon(Icons.chevron_right),
            )
          ],
        ),
      ),
    );
  }
}
