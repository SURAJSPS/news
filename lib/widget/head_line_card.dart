import 'package:flutter/material.dart';
import 'package:news/models/headline_model.dart';


// ignore: must_be_immutable
class HeadLineCard extends StatelessWidget {
  HeadLineCard({
    Key? key,
    this.headlines,
  }) : super(key: key);
  Headlines? headlines;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        children: [
          //   title Text Widget
          _gettitleTextWidget(context, headlines),
          //   Image  Widget
          _getImage(context, headlines),
          //   Description Text Widget
          _descriptionWidget(context, headlines),
          // Divider Widget
          _getDevider(context),
        ],
      ),
    );
  }
}

// Divider Widget
_getDevider(BuildContext context) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  return new Divider(
    height: 30,
    color: colorScheme.primary,
    thickness: 10,
  );
}
//   Description Text Widget
_gettitleTextWidget(BuildContext context, Headlines? headlines) {
  // ignore: unused_local_variable
  Size size = MediaQuery.of(context).size;
  // ignore: unused_local_variable
  ColorScheme colorScheme = Theme.of(context).colorScheme;

  TextTheme textTheme = Theme.of(context).textTheme;
  return new Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Text(
      "${headlines!.title}",
      style: textTheme.bodyText1!
          .copyWith(wordSpacing: 1, fontSize: 18, color: Colors.black),
    ),
  );
}

//   Image  Widget
_getImage(BuildContext context, Headlines? headlines) {
  return new Image.network(
    "${headlines!.urlToImage}",
  );
}

//   Description Text Widget

_descriptionWidget(BuildContext context, Headlines? headlines) {
  // ignore: unused_local_variable
  Size size = MediaQuery.of(context).size;
  // ignore: unused_local_variable
  ColorScheme colorScheme = Theme.of(context).colorScheme;

  TextTheme textTheme = Theme.of(context).textTheme;
  return new Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: new Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        "${headlines!.description}",
        style: textTheme.bodyText1,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
