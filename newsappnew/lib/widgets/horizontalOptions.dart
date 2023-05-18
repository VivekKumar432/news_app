import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:newsappnew/screens/news_categorypage.dart';

class HorizontalOptions extends StatelessWidget {
  HorizontalOptions({super.key});

  List<String> categoryList = [
    "Sports",
    "Politics",
    "World",
    "Election",
    "Business"
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
                width: 20,
              ),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: 5,
          itemBuilder: ((context, index) => Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width / 3.5,
                child: Center(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CategoryNews(
                                  categoryQuery: categoryList[index],
                                )));
                  },
                  child: AutoSizeText(
                    categoryList[index],
                    maxLines: 1,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                )),
              ))),
    );
  }
}
