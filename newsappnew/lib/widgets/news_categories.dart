import 'package:flutter/material.dart';
import 'package:newsappnew/widgets/category_item.dart';

class MyNewsCategories extends StatelessWidget {
  const MyNewsCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          MyCategoryItem(
            imgPath: "assets/sports.png",
            cardMessage: "Sports",
            height: DeviceDimensions(context).height / 5,
            width: DeviceDimensions(context).width / 3.3,
          ),
          const SizedBox(
            width: 10,
          ),
          MyCategoryItem(
            imgPath: "assets/politics.png",
            cardMessage: "Politics",
            height: DeviceDimensions(context).height / 5,
            width: DeviceDimensions(context).width / 3.3,
          ),
          const SizedBox(
            width: 10,
          ),
          MyCategoryItem(
            imgPath: "assets/world.png",
            cardMessage: "World",
            height: DeviceDimensions(context).height / 5,
            width: DeviceDimensions(context).width / 3.3,
          ),
          const SizedBox(
            width: 10,
          ),
          MyCategoryItem(
            imgPath: "assets/health.png",
            cardMessage: "Health",
            height: DeviceDimensions(context).height / 5,
            width: DeviceDimensions(context).width / 3.3,
          ),
          const SizedBox(
            width: 10,
          ),
          MyCategoryItem(
            imgPath: "assets/education.png",
            cardMessage: "Education",
            height: DeviceDimensions(context).height / 5,
            width: DeviceDimensions(context).width / 3.3,
          ),
          const SizedBox(
            width: 10,
          ),
          MyCategoryItem(
            imgPath: "assets/business.png",
            cardMessage: "Business",
            height: DeviceDimensions(context).height / 5,
            width: DeviceDimensions(context).width / 3.3,
          ),
        ],
      ),
    );
  }
}
