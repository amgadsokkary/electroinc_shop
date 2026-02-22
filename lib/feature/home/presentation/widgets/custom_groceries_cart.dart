import 'package:electronic_store/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class CustomGroceriesCart extends StatelessWidget {
  final String image;
  final String name;
  final Color color;
  const CustomGroceriesCart({
    super.key,
    required this.image,
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 105,
              width: 250,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(image, height: 80, width: 80),
                    SizedBox(width: 16),
                    Text(name.toString(), style: AppStyles.headlineMedium),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
