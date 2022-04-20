import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lms_edutekzila/models/video.dart';
import 'package:lms_edutekzila/widgets/custom_input.dart';
import 'package:lms_edutekzila/widgets/rounded_button.dart';

class MentorHome extends StatefulWidget {
  const MentorHome({Key? key}) : super(key: key);

  @override
  _MentorHomeState createState() => _MentorHomeState();
}

class _MentorHomeState extends State<MentorHome> {
  final TextEditingController _urlCtrl = TextEditingController();
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome, Mentor"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomInput(
                title: "Video Title",
                ctrl: _titleCtrl,
                isObscure: false,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                focusNode: FocusNode(),
                nextFocusNode: FocusNode(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomInput(
                title: "Video Url",
                ctrl: _urlCtrl,
                isObscure: false,
                textInputType: TextInputType.url,
                textInputAction: TextInputAction.done,
                focusNode: FocusNode(),
                nextFocusNode: FocusNode(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomInput(
                title: "Video Description",
                ctrl: _descCtrl,
                isObscure: false,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                focusNode: FocusNode(),
                nextFocusNode: FocusNode(),
              ),
            ),
            RoundedButton(
              bText: "Post to student",
              bFunction: () {
                Video newVideo = Video(
                  url: _urlCtrl.text,
                  title: _titleCtrl.text,
                  desc: _descCtrl.text,
                );
                FirebaseFirestore.instance
                    .collection("videos")
                    .add(newVideo.toMap());
                _urlCtrl.clear();
                _descCtrl.clear();
                _titleCtrl.clear();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Video URL posted to student!")));
              },
              textColor: Colors.black,
              bWidth: 200,
            )
          ],
        ),
      ),
    );
  }
}
