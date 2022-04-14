import 'package:boeoeg_app/classes/Api/news.api.dart';
import 'package:boeoeg_app/classes/Models/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);
  static const routeName = '/news';

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<News> _allEntries = [];
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    getNews();
    super.initState();
  }

  Future<void> getNews() async {
    //!Internet schauen wenn offline
    _allEntries = await NewsApi.loadAllNews();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Neuigkeiten",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        border: Border(
            bottom: BorderSide(
          color: Theme.of(context).dividerColor,
        )),
      ),
      child: SafeArea(
        child: _isLoading
            ? CupertinoActivityIndicator()
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: _allEntries.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_allEntries[index].neuigkeit,
                              maxLines: 3, textAlign: TextAlign.center),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
