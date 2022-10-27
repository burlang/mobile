import 'package:flutter/material.dart';
import '../constants/constants.dart';

class SearchBuryatNameWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  const SearchBuryatNameWidget({
    this.text,
    this.onChanged,
    this.hintText,
    Key key,
  }) : super(key: key);

  @override
  State<SearchBuryatNameWidget> createState() => _SearchBuryatNameWidgetState();
}

class _SearchBuryatNameWidgetState extends State<SearchBuryatNameWidget> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Constants.color),
            borderRadius: BorderRadius.circular(5)),
        child: TextField(
            controller: controller,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: widget.text.isNotEmpty
                    ? GestureDetector(
                        child: const Icon(Icons.close, color: Colors.red),
                        onTap: () {
                          controller.clear();
                          widget.onChanged('');
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      )
                    : null,
                hintText: widget.hintText,
                icon: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.search,
                    color: Constants.color,
                  ),
                ))),
      ),
    );
  }
}
