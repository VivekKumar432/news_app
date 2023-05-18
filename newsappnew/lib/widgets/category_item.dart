import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappnew/screens/news_categorypage.dart';

AutoSizeText _getText(String text, double fontsize, FontWeight fweight,
    {Color color = Colors.black}) {
  return AutoSizeText(
    text,
    maxLines: 1,
    style: GoogleFonts.actor(
        textStyle:
            TextStyle(fontSize: fontsize, fontWeight: fweight, color: color)),
  );
}

class DeviceDimensions {
  BuildContext context;

  DeviceDimensions(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

class MyCategoryItem extends StatelessWidget {
  String cardMessage;
  String imgPath;
  double height;
  double width;
  MyCategoryItem(
      {required this.cardMessage,
      required this.imgPath,
      required this.height,
      required this.width});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CategoryNews(
                      categoryQuery: cardMessage,
                    )));
      },
      child: SizedBox(
        height: height,
        width: width,
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image(
                  width: MediaQuery.of(context).size.height / 10,
                  height: MediaQuery.of(context).size.height / 10,
                  image: AssetImage(imgPath),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                _getText(cardMessage, 20, FontWeight.normal),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
