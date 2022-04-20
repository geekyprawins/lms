import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lms_edutekzila/models/video.dart';
import 'package:lms_edutekzila/screens/video_display.dart';
import 'package:provider/provider.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    // final videos = Provider.of<List<Video>>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome, Student"),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              final videos = snapshot.data!.docs;
              Video? newVideo;
              List<Video> videosList = [];
              for (var video in videos) {
                final url = video.data()['url'] ?? "";
                final title = video.data()['title'] ?? "";
                final desc = video.data()['desc'] ?? "";
                newVideo = Video(url: url, title: title, desc: desc);
                videosList.add(newVideo);
              }

              return videos.isEmpty
                  ? const CircularProgressIndicator()
                  : Center(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 10.0,
                        ),
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                        itemBuilder: (context, index) {
                          return ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.teal),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VideoDisplay(video: videosList[index]),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(videosList[index].title!),
                              subtitle: Text(videosList[index].desc!),
                            ),
                          );
                        },
                        itemCount: videosList.length,
                      ),
                    );
            }
          },
          stream: FirebaseFirestore.instance.collection("videos").snapshots(),
        ),
      ),
    );
  }
}
