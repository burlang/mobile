import 'package:burlang_demo/config/router.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:flutter/material.dart';

class NavigatorWidget extends StatelessWidget {
  final String subtitle;
  final String overFlowTitle;
  final String routeName;
  final String childTitle;
  final bool isOverFlow;
  const NavigatorWidget(
      {Key key,
      this.subtitle,
      this.overFlowTitle,
      this.routeName,
      this.childTitle,
      this.isOverFlow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      color: Constants.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteGenerator.MAIN);
                    },
                    child: Text(
                      'Главная',
                      style: TextStyle(
                          color: Constants.color, fontFamily: 'Arial'),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: Text(' / '),
                ),
                overFlowTitle != null || childTitle != null
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, routeName);
                        },
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            color: Constants.color,
                            fontFamily: 'Arial',
                          ),
                        ),
                      )
                    : Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: 'Arial',
                        ),
                      ),
                childTitle != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 5, left: 5),
                        child: Text(' / '),
                      )
                    : Container(),
                childTitle != null
                    ? Expanded(
                        child: Text(
                          childTitle,
                          style: TextStyle(
                            fontFamily: 'Arial',
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            isOverFlow != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5, left: 5),
                          child: Text(' / '),
                        ),
                        Expanded(
                          child: Text(
                            overFlowTitle,
                            style: TextStyle(
                              fontFamily: 'Arial',
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
