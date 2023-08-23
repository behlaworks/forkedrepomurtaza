import "package:aire/screens/premium.dart";
import "package:aire/screens/profilePage.dart";
import "package:clipboard/clipboard.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:share/share.dart";
import "../components/common ui elements/dialog.dart";
import "../models/app_state_manager.dart";

class Menu extends StatelessWidget {
  final String name;
  final String age;
  final String intake;
  final String refID;

  const Menu(
      {Key? key,
      required this.name,
      required this.age,
      required this.intake,
      required this.refID})
      : super(key: key);

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color(0xfff2f3f7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        side:
            BorderSide(color: Colors.grey, width: 1.0), // Optional border side
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          // Content of the BottomSheet
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Contact info",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
              SizedBox(height: 10,),
              SelectableText(
                "murtaza.0903@gmail.com",
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10,),
              SelectableText(
                "+92 335 1215353",
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              )

              // Add more options as needed
            ],
          ),
        );
      },
    );
  }

  Future<void> shareCopiedText() async {
    // Get text from clipboard
    String copiedText = await FlutterClipboard.paste();

    // Check if there's any text to share
    if (copiedText != null && copiedText.isNotEmpty) {
      // Open share dialog with the copied text
      Share.share(copiedText);
    }
  }

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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                icon: "assets/userProfile.png",
                title: "Profile",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                            name: name,
                            age: age,
                            refID: refID,
                            intake: intake)),
                  );
                },
                state: 'single',
                height: 30,
              ),
              const SizedBox(
                height: 25,
              ),
              MenuBox(
                icon: "assets/megaphone.png",
                title: "News",
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const CustomAlertDialog(
                            title: "Coming soon!",
                            text: "We are actively working."
                        );
                      });
                },
                state: 'top',
                height: 30,
              ),
              MenuBox(
                icon: "assets/share.png",
                title: "Share with friends",
                onTap: () {
                  // Copy text to clipboard
                  FlutterClipboard.copy(refID).then((value) {
                    // Share the copied text
                    Share.share(
                        "Hey download aire app now: here is my referral id: $refID");
                  }).catchError(
                      (error) => print('Error copying to clipboard: $error'));
                },
                state: '',
                height: 25,
              ),
              MenuBox(
                icon: "assets/premium1.png",
                title: "Subscriptions",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PremiumSubscriptions()),
                  );
                },
                state: 'bottom',
                height: 30,
              ),
              const SizedBox(
                height: 25,
              ),
              MenuBox(
                icon: "assets/contact.png",
                title: "Contact us",
                onTap: () {
                  _showBottomSheet(context);
                },
                state: 'top',
                height: 28,
              ),
              MenuBox(
                icon: "assets/policy.png",
                title: "Policy",
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const CustomAlertDialog(
                            title: "Coming soon!",
                            text: "We are actively working."
                        );
                      });
                },
                state: 'bottom',
                height: 30,
              ),
              const SizedBox(
                height: 25,
              ),
              MenuBox(
                icon: "assets/logout.png",
                title: "Logout",
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  myProvider.logout();
                },
                state: 'single',
                height: 30,
              ),
            ],
          ),
        )));
  }
}

class MenuBox extends StatelessWidget {
  final double height;
  final String icon;
  final String title;
  final Function() onTap;
  final String state;

  const MenuBox(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onTap,
      required this.state,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: state == 'top'
                ? const BorderRadius.vertical(top: Radius.circular(12))
                : state == "bottom"
                    ? const BorderRadius.vertical(bottom: Radius.circular(12))
                    : state == "single"
                        ? BorderRadius.circular(12)
                        : BorderRadius.zero),
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
                  height: height,
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
