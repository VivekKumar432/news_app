import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText {
  GoogleFonts? font;
  String? data;
  double? size;
  FontWeight? fweight;

  MyText({this.data, this.font, this.fweight, this.size});
  Text getText(data, size, font, fweight) {
    return Text(
      data,
      style: GoogleFonts.lato(
        color: Colors.grey,
        fontSize: size,
        fontWeight: fweight,
      ),
    );
  }
}
