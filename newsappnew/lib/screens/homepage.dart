import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappnew/models/news_model.dart';
import 'package:newsappnew/screens/articles.dart';
import 'package:newsappnew/screens/news_categorypage.dart';
import 'package:newsappnew/services/news_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:newsappnew/widgets/news_categories.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

List<NewsModel> news = [];
//List<Widget> widgets = [];
TextEditingController tc = TextEditingController();
String searchQuery = " ";
bool isLoaded = false;
late GoogleFonts font;
late String data;
late double size;
late FontWeight fweight;
AutoSizeText _getText(data, size, font, fweight) {
  return AutoSizeText(
    data,
    style: GoogleFonts.lato(
      color: Colors.grey,
      fontSize: size,
      fontWeight: fweight,
    ),
  );
}

class _MyHomepageState extends State<MyHomepage> {
  int redIndex = 0;

  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    news = getNews();
    print("Rannnnnnnnnnnnn");
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        redIndex++;
        if (redIndex > 8) redIndex = 0;
      });
      print("rebuild");
    });
  }

  getSearchBarMessages(index) {
    String msg;
    List<String> list = [
      "Indian Politics",
      "Business News",
      "Foregin Trade",
      "Election News",
      "Economy",
      "World Trade",
      "Olympics",
      "Technology",
      "Google"
    ];
    msg = list[index];
    return msg;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  List<NewsModel> getNews({String query = 'India'}) {
    print("i am called");
    Future<http.Response> future = NewsClient.getNewsByQuery(query);
    // Success Result / Success Response (JSON String)
    future.then((value) {
      if (value.statusCode == 200) {
        print("all okay");
        Future.delayed(const Duration(seconds: 3), () {
          isLoaded = true;
          setState(() {});
        });
      }
      print(" Data is ${value.body.runtimeType}");

      var obj = convert.jsonDecode(value.body); // string to object

      print("Result is ${obj['articles']}");
      List<dynamic> list = obj['articles'];
      news = convertObjectIntoNewsObjects(list);
      // print("list is $list");
    }).catchError((err) => print("Error is $err"));

    print("some error occured");
    return news;
  }

  List<NewsModel> convertObjectIntoNewsObjects(List list) {
    news = list.map((singleObject) {
      NewsModel news = NewsModel.fromMap(singleObject);
      return news;
    }).toList();
    //widgets = printNews();
    setState(() {});
    return news;
  }

  List<Widget> printNews() {
    return news.map((NewsModel newss) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => Articles(news, news.indexOf(newss)))));
          setState(() {});
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(newss.urlImage!), fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            //adds black background effect on news articles/thumbnails.
            Container(
              margin: const EdgeInsets.only(right: 10),
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width / 1.1,
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withAlpha(0),
                    Colors.black12,
                    Colors.black87
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 3.5,
              left: MediaQuery.of(context).size.width / 40,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: AutoSizeText(
                  newss.title!,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height / 70,
                left: MediaQuery.of(context).size.width / 40,
                child: AutoSizeText(newss.publishedAt!.substring(0, 10),
                    style: const TextStyle(
                      color: Colors.white,
                    ))),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 246, 243, 243),
                  border: Border.all(width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Image.asset("assets/search-line.png"),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                CategoryNews(categoryQuery: "India"))),
                    child: AutoSizeText(
                      getSearchBarMessages(redIndex),
                      maxLines: 1,
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(child: Image.asset("assets/mic-line.png")),
                ],
              )),
          const SizedBox(
            height: 30,
          ),
          AutoSizeText("Trending",
              maxLines: 1,
              style: GoogleFonts.lato(
                  fontSize: 35.0, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 15,
          ),
          _getText(
              "Some of the top trending news on the stories from the world news channels.",
              22.0,
              GoogleFonts.lato(),
              FontWeight.normal),
          SizedBox(
            height: MediaQuery.of(context).size.height / 80,
          ),
          const MyNewsCategories(),
          Text("Latest News",
              style: GoogleFonts.lato(
                  fontSize: 35.0, fontWeight: FontWeight.bold)),
          SizedBox(
            height: MediaQuery.of(context).size.height / 80,
          ),
          SizedBox(
            //color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.7,
            child: Visibility(
              visible: isLoaded,
              replacement: const CircularProgressIndicator(),
              // Shimmer.fromColors(
              //   baseColor: const Color.fromARGB(255, 223, 222, 222),
              //   highlightColor: const Color.fromARGB(255, 243, 243, 242),
              //   child: ListView(
              //     shrinkWrap: true,
              //     physics: const BouncingScrollPhysics(),
              //     scrollDirection: Axis.horizontal,
              //     children: printNews(),
              //   ),
              // ),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: printNews(),
              ),
            ),
          ),
        ]),
      )),
    );
  }
}
