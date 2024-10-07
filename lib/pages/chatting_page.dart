// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motobike_app/models/chat.dart';
import 'package:gap/gap.dart';

class ChattingPage extends StatefulWidget {
  final String uid;
  final String userName;

  const ChattingPage({
    Key? key,
    required this.uid,
    required this.userName,
  }) : super(key: key);

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  late final Stream<QuerySnapshot<Map<String, dynamic>>> streamChats;

  @override
  void initState() {
    streamChats = FirebaseFirestore.instance
        .collection('CS')
        .doc(widget.uid)
        .collection('chats')
        .snapshots(); // ambil data realtime pake snapshots
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(20 + MediaQuery.of(context).padding.top),
          buildHeader(),
          Expanded(
            // Mengisi ruang kosong
            child: buildChats(),
          ),
          buildInputChat(),
        ],
      ),
    );
  }

  Widget buildChats() {
    return StreamBuilder(
      stream: streamChats,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No Chats'),
          );
        }
        final list = snapshot.data!.docs;
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            Chat chat =
                Chat.fromJson(list[index].data()); // Convert data dari model
            return ListTile(
              title: Text(chat.message),
              subtitle: Text(chat.senderId),
            );
          },
        );
      },
    );
  }

  Widget buildInputChat() {
    return Text('Input Chat');
  }

  Widget buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onDoubleTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/ic_arrow_back.png",
                width: 24.0,
                height: 24.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Customer Service",
              textAlign: TextAlign.center, // Pake ini karna di wrap Expanded
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0XFF070623),
              ),
            ),
          ),
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              "assets/ic_more.png",
              width: 24.0,
              height: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
