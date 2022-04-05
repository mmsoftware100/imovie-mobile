
import 'package:flutter/material.dart';

class TitleRowComponent extends StatelessWidget {
  final String title;
  final bool showIcon;
  final Widget button;
  final Function onTap;

  TitleRowComponent(this.title, this.showIcon, {this.button, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.caption,
            ),
            showIcon
                ?
            Text("See More >")
            /*Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16.0,
            )

             */
                : button ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
