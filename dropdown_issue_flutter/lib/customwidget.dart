import 'package:flutter/material.dart';

class CustomWidget extends StatefulWidget {
  CustomWidget({this.onDropdownSelected, this.reasonsList});
  List<String> reasonsList;
  Function(String) onDropdownSelected;
  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  Widget dropDownWidget(List<String> reasons) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: size.width / 1.2,
      decoration: BoxDecoration(
          border: Border.all(
        width: 0.5,
        color: Colors.grey,
      )),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
        hint: Text(
          'Select Reason to Report',
          style: TextStyle(fontSize: 12),
        ),
        value: currentSelectedValue,
        isDense: true,
        isExpanded: true,
        onChanged: (newValue) {
          print(newValue);
          setState(() {
            currentSelectedValue = newValue;
            // widget.onReasonSelected(currentSelectedValue);
          });
        },
        icon: Icon(Icons.keyboard_arrow_down),
        items: reasons.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
      )),
    );
  }

  String currentSelectedValue = null;
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return dropDownWidget(widget.reasonsList);
  }
}
