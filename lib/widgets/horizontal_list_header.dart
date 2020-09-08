import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalListHeader extends StatefulWidget {
  final String title;

  HorizontalListHeader({@required this.title});

  @override
  _HorizontalListHeaderState createState() => _HorizontalListHeaderState();
}

class _HorizontalListHeaderState extends State<HorizontalListHeader> {
  @override
  Widget build(BuildContext context) {
//    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            child: Text(
              widget.title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
          ),
          Material(
            color: Color.fromRGBO(40, 53, 70, 1.0),
            borderRadius: BorderRadius.circular(5.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(5.0),
              splashColor: Color.fromRGBO(70, 83, 100, 1.0),
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Center(
                  child: Text(
                    "See all",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
