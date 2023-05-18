import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappnew/models/news_model.dart';
import 'package:newsappnew/screens/articles.dart';
import 'package:newsappnew/widgets/horizontalOptions.dart';
import 'dart:async';

import 'package:newsappnew/services/news_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shimmer/shimmer.dart';

class CategoryNews extends StatefulWidget {
  String categoryQuery = "cars";
  List<NewsModel> news = [];
  bool isLoaded = false;

  CategoryNews({required this.categoryQuery});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.news = getNews(widget.categoryQuery);
  }

  List<NewsModel> getNews(String categoryQuery) {
    Future<http.Response> future =
        NewsClient.getNewsByQuery(widget.categoryQuery);
    // Success Result / Success Response (JSON String)
    future.then((value) {
      if (value.statusCode == 200) {
        print("all okay");
        Future.delayed(const Duration(seconds: 3), () {
          widget.isLoaded = true;
          setState(() {});
        });
      }
      print(" Data is ${value.body.runtimeType}");

      var obj = convert.jsonDecode(value.body); // string to object

      print("Result is ${obj['articles']}");
      List<dynamic> list = obj['articles'];
      widget.news = convertObjectIntoNewsObjects(list);
      // print("list is $list");
    }).catchError((err) => print("Error is $err"));
    return widget.news;
  }

  List<NewsModel> convertObjectIntoNewsObjects(List list) {
    widget.news = list.map((singleObject) {
      NewsModel news = NewsModel.fromMap(singleObject);
      return news;
    }).toList();
    //widgets = printNews();
    setState(() {});
    return widget.news;
  }

  List<Widget> printNews() {
    return widget.news.map((NewsModel newss) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) =>
                      Articles(widget.news, widget.news.indexOf(newss)))));
          setState(() {});
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              height: MediaQuery.of(context).size.height / 3.2,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(newss.urlImage!), fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: MediaQuery.of(context).size.height / 3.2,
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
              top: MediaQuery.of(context).size.height / 4.4,
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

  TextEditingController searchQ = TextEditingController();
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
              height: MediaQuery.of(context).size.height / 16,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 246, 243, 243),
                  border: Border.all(width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  InkWell(
                      onTap: () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                      child: Image.asset("assets/arrow-left-black.png")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 100,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    //color: Colors.grey,
                    child: TextField(
                      controller: searchQ,
                      cursorHeight: 20,
                      cursorColor: Colors.grey,
                      decoration: const InputDecoration(
                          //contentPadding: EdgeInsets.only(),
                          border: InputBorder.none,
                          isCollapsed: true,
                          hintText: "Search News",
                          hintStyle: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const Spacer(),
                  Image.asset("assets/mic-line.png"),
                ],
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          AutoSizeText("Categories",
              style: GoogleFonts.lato(
                  fontSize: 35.0, fontWeight: FontWeight.bold)),
          SizedBox(
            height: MediaQuery.of(context).size.height / 80,
          ),
          HorizontalOptions(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 80,
          ),
          SizedBox(
            //   color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.5,
            child: Visibility(
              visible: widget.isLoaded,
              replacement: Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 223, 222, 222),
                highlightColor: const Color.fromARGB(255, 243, 243, 242),
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: printNews(),
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: printNews(),
              ),
            ),
          ),
        ]),
      )),
    );
  }
}
