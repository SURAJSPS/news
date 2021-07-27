import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/dilogpage.dart';
import 'package:news/models/headline_model.dart';
import 'package:news/util/util.dart';
import 'package:news/widget/head_line_card.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState>? _scaffoldKey;

// Local State to display items in listview
  late Future<List<Headlines>?> _list;

  @override
  void initState() {
    _list = HeadingUtil.fetchHeadLines();

    _scaffoldKey = GlobalKey();
    super.initState();
  }

  updateLayout(Future<List<Headlines>?> list) {
    setState(() {
      _list = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text('News App'),
      ),
      body: new RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 1),
            () {
              setState(() {
                HeadingUtil.headLineList.clear();

                _list = HeadingUtil.fetchHeadLines();
              });
              // ignore: deprecated_member_use
              _scaffoldKey?.currentState?.showSnackBar(
                SnackBar(
                  content: const Text('Page Refreshed'),
                ),
              );
            },
          );
        },
        child: new ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            getFilter(context),
            gertFutureBilder(context, _list),
          ],
        ),
      ),
    );
  }

  DateTime dateTo = DateTime.now();
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

  // ignore: unused_element
  Future<void> _filter(BuildContext context) async {
    // ignore: unused_local_variable
    final DateTime? pickedDate = await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return new Column(
          children: [
            new Container(
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height - 80,
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: new Column(
                children: [
                  // ignore: deprecated_member_use
                  new RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: const Color(0xFF1BC0C5),
                  ),
                  // ignore: deprecated_member_use
                  new RaisedButton(
                    onPressed: () {
                      _selectDateTo(context);
                    },
                    child: new Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: const Color(0xFF1BC0C5),
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () {
                      _selectDateTo(context);
                    },
                    child: new Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: const Color(0xFF1BC0C5),
                  ),
                  new Text(dateTo.toString()),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getFilter(context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 100,
      color: colorScheme.onPrimary,
      child: new Row(
        children: [
          TextButton.icon(
              onPressed: () {
                Future<List<Headlines>?> list = Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DilogPage(
                            callback: updateLayout,
                          )),
                );
                setState(() {
                  _list = list;
                });
              },
              icon: Icon(CupertinoIcons.slider_horizontal_3),
              label: Text('Filter')),
        ],
      ),
    );
  }
}

Widget gertFutureBilder(BuildContext context, _list) {
  return new FutureBuilder(
    builder: (context, AsyncSnapshot<List<Headlines>?> projectSnap) {
      if (!projectSnap.hasData) {
        return new Center(
          child: new Center(
            child: new CircularProgressIndicator(),
          ),
        );
      }
      return new Container(
        child: new ListView.builder(
            itemCount: projectSnap.data?.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return new HeadLineCard(
                headlines: projectSnap.data![index],
              );
            }),
      );
    },
    future: _list,
  );
}
