// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:extended_image/extended_image.dart';
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

  Widget chatUser(Chat chat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (chat.bikeDetail != null)
          Column(
            children: [
              Gap(16),
              buildSnippetBike(chat.bikeDetail!),
              Gap(16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: DottedLine(
                  dashColor: Color(0XFFCECED5),
                  lineThickness: 1,
                  dashLength: 6,
                  dashGapLength: 6, // Jarak garis putus2
                ),
              ),
              Gap(16),
            ],
          ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 49, right: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                16.0,
              ),
            ),
          ),
          child: Text(
            chat.message,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Color(0XFF070623),
            ),
          ),
        ),
        Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.userName,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Color(0XFF070623),
              ),
            ),
            Gap(8),
            Image.asset(
              "assets/chat_profile.png",
              width: 40.0,
              height: 40.0,
            ),
            Gap(24),
          ],
        ),
      ],
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
          padding: const EdgeInsets.only(top: 20),
          itemCount: list.length,
          itemBuilder: (context, index) {
            Chat chat =
                Chat.fromJson(list[index].data()); // Convert data dari model
            if (chat.senderId == 'cs') {
              return ListTile(
                title: Text(chat.message),
                subtitle: Text(chat.senderId),
              );
            }
            return chatUser(chat);
          },
        );
      },
    );
  }

  Widget buildInputChat() {
    return Text('Input Chat');
  }

  Widget buildSnippetBike(Map bike) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 14),
      height: 98,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Row(
        children: [
          ExtendedImage.network(
            bike['image'],
            width: 90,
            height: 70,
            fit: BoxFit.contain,
          ),
          Gap(10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bike['name'],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF070623),
                  ),
                ),
                Text(
                  bike['category'],
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF070623),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: bike['id'],
              );
            },
            child: Text(
              "Details",
              textAlign: TextAlign.center,
              style: TextStyle(
                decorationThickness: 1,
                decoration: TextDecoration.underline,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Color(0XFF4A1DFF),
              ),
            ),
          ),
        ],
      ),
    );
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
