import 'package:flutter/material.dart';

class ServiceItem extends StatelessWidget {
  final String title, imageUrl, routeName;

  ServiceItem(this.title, this.imageUrl, this.routeName);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FadeInImage(
              height: deviceSize.width * 0.35,
              width: deviceSize.width * 0.35,
              placeholder: NetworkImage(imageUrl),
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
