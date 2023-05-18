import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappnew/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Articles extends StatefulWidget {
  List<NewsModel> news_articles = [];

  int index_Key;
  Articles(this.news_articles, this.index_Key);
  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  // Future<void> _launchUrl() async {
  //   if (!await launchUrl(
  //       ))) {
  //     throw 'Could not launch ';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              widget.news_articles[widget.index_Key].urlImage!),
                          fit: BoxFit.fill),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 1,
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
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
                    top: MediaQuery.of(context).size.height / 60,
                    left: MediaQuery.of(context).size.width / 50,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Image(
                          image: AssetImage("assets/arrow-left-s-line.png")),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 4,
                    left: MediaQuery.of(context).size.width / 40,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Text(
                        widget.news_articles[widget.index_Key].title!,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 8,
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  // color: Colors.teal,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.news_articles[widget.index_Key].description!,
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(children: [
                  Text(
                    widget.news_articles[widget.index_Key].content!,
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.roboto(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            print("Readmore executed");
                            var url = Uri.parse(
                                widget.news_articles[widget.index_Key].url!);
                            await canLaunchUrl(url)
                                ? await launchUrl(url,
                                    mode: LaunchMode.externalApplication)
                                : throw ("could not launch $url");
                          },
                          child: const Text(
                            "Read more here",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                        // RichText(
                        //     text: TextSpan(
                        //   text: "Read more here",
                        //   style: const TextStyle(
                        //     color: Colors.blue,
                        //     decoration: TextDecoration.underline,
                        //   ),
                        //   recognizer: TapGestureRecognizer()
                        //     ..onTap = () => launchUrl(Uri.parse(
                        //           widget.news_articles[widget.index_Key].url!,
                        //         )),
                        // )),
                      ],
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
