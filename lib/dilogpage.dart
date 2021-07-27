import 'package:flutter/material.dart';
import 'package:news/util/util.dart';


class DilogPage extends StatefulWidget {
  final Function? callback;
  const DilogPage({Key? key, this.callback}) : super(key: key);

  @override
  _DilogPageState createState() => _DilogPageState();
}

class _DilogPageState extends State<DilogPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      body: Column(
        children: [
          new Container(
            width: size.width - 10,
            height: size.height - 80,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getRow(context,_selectDateTo,_getDropDown,dateTo,_selectDateFrom,dateFrom),
                SizedBox(
                  height: 10,
                ),
                new Text('Language'),
                _getDropDownLanguage(),
              ],
            ),
          ),
          // ignore: deprecated_member_use
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // ignore: deprecated_member_use
              new RaisedButton(
                onPressed: () {
                  widget.callback!(HeadingUtil.fetchHeadLines());
                  Navigator.of(context).pop();
                },
                child: new Text(
                  "Back",
                  style: TextStyle(color: Colors.white),
                ),
                color: const Color(0xFF1BC0C5),
              ),
              // ignore: deprecated_member_use
              new RaisedButton(
                onPressed: () {
                  widget.callback!(HeadingUtil.filter(
                    fromDate:
                        "${dateFrom.year.toString()}-${dateFrom.month.toString()}-${dateFrom.day.toString()}",
                    toDate:
                        "${dateTo.year.toString()}-${dateTo.month.toString()}-${dateTo.day.toString()}",
                    lang: _dropDownlanguage,
                    sortBy: _dropDownValue,
                  ));
                  Navigator.of(context).pop();
                },
                child: new Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
                color: const Color(0xFF1BC0C5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  DateTime dateFrom = DateTime.now();
  DateTime dateTo = DateTime.now();
  Future<void> _selectDateFrom(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateFrom,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != dateFrom)
      setState(() {
        dateFrom = pickedDate;
      });
  }

  Future<void> _selectDateTo(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateTo,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != dateTo)
      setState(() {
        dateTo = pickedDate;
      });
  }

  String _dropDownValue = 'popularity';
  Widget _getDropDown() {
    return DropdownButton(
      hint: _dropDownValue.isEmpty
          ? Text('Dropdown')
          : Text(
              _dropDownValue.toUpperCase(),
              style: TextStyle(color: Colors.black),
            ),
      isExpanded: false,
      iconSize: 30.0,
      style: TextStyle(color: Colors.black),
      elevation: 20,
      items: [
        'popularity',
        'publishedAt',
      ].map(
        (val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val.toUpperCase()),
          );
        },
      ).toList(),
      onChanged: (val) {
        setState(
          () {
            _dropDownValue = val.toString();
          },
        );
      },
    );
  }

  String _dropDownlanguage = 'en';
  Widget _getDropDownLanguage() {
    return DropdownButton(
      hint: _dropDownValue.isEmpty
          ? Text('Dropdown')
          : Text(
              _dropDownlanguage.toUpperCase(),
              style: TextStyle(color: Colors.black),
            ),
      isExpanded: false,
      iconSize: 30.0,
      style: TextStyle(color: Colors.black),
      elevation: 20,
      items: [
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'he',
        'it',
        'nl',
        'no',
        'pt',
        'ru',
        'se',
        'ud',
        'zh',
      ].map(
        (val) {
          return new DropdownMenuItem<String>(
            value: val,
            child: new Text(val.toUpperCase()),
          );
        },
      ).toList(),
      onChanged: (val) {
        setState(
          () {
            _dropDownlanguage = val.toString();
          },
        );
      },
    );
  }
}

Widget getRow(BuildContext context,_selectDateTo,_getDropDown,dateTo,_selectDateFrom,dateFrom) {
  return new Row(
    children: [
      new Expanded(
        flex: 1,
        child: new Column(
          children: [
            new Text('Select Date'),
            new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new TextButton(
                  onPressed: () {
                    _selectDateFrom(context);
                  },
                  child: Text(
                    "From",
                    style: TextStyle(
                      color: const Color(0xFF1BC0C5),
                    ),
                  ),
                ),
                new Text(
                    "${dateFrom.year.toString()}-${dateFrom.month.toString()}-${dateFrom.day.toString()}"),
              ],
            ),
            new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new TextButton(
                  onPressed: () {
                    _selectDateTo(context);
                  },
                  child: Text(
                    "To",
                    style: TextStyle(
                      color: const Color(0xFF1BC0C5),
                    ),
                  ),
                ),
                new Text(
                    "${dateTo.year.toString()}-${(dateTo.month.toString().length)}-${dateTo.day.toString()}"),
              ],
            ),
          ],
        ),
      ),
      new Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text('Search By'),
            _getDropDown(),
          ],
        ),
      ),
    ],
  );
}
