import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

String get aboutText =>
    "Hello! Thanks for passing by.\nMy name is Caio Zubek, and this is Photobloc, a simple, but functional Flutter app built while following the great Vandad Nahavandipoor's BLoC course.\nIt's a basic 'Photo Gallery' app, which allows you to register, upload and delete images.\nIt uses Google's Firebase for authentication and storage.\nBuilding this app was a very productive learning exercise, it helped me to grasp the core concepts of BLoC state management & implement them in a real world scenario.\nHopefully it can also serve as a bit of reference to you as well.\nOnce more, thanks for passing by. I'd love to hear some feedback and ideas for this and other projects.\nHave a good one! ";

String get courseUrl => 'https://www.youtube.com/watch?v=Mn254cnduOY';
String get githubUrl => 'https://github.com/CJSZ01';

class AboutPhotoblocDialog extends StatelessWidget {
  const AboutPhotoblocDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('About Photobloc'),
      content: Text(aboutText),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        InkWell(
          onTap: () => launchUrl(Uri.parse(courseUrl)),
          child: Column(
            children: [
              SvgPicture.asset('assets/youtube.svg', height: 32),
              const Text("Vandad's course"),
            ],
          ),
        ),
        InkWell(
          onTap: () => launchUrl(Uri.parse(githubUrl)),
          child: Column(
            children: [
              SvgPicture.asset('assets/github.svg', height: 32),
              const Text("Github repository"),
            ],
          ),
        )
      ],
    );
  }
}
