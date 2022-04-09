import 'package:boeoeg_app/Android/Widgets/poll/pollItemAndroid.dart';
import 'package:boeoeg_app/Android/drawer_widget.dart';
import 'package:boeoeg_app/classes/format.dart';
import 'package:flutter/material.dart';

import '../../classes/Api/abstimmung.api.dart';
import '../../classes/Models/abstimmung.dart';

class PollPage extends StatefulWidget {
  const PollPage({Key? key}) : super(key: key);

  static const String routeName = "pollPage";

  @override
  State<PollPage> createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  bool _isLoading = true;
  List<Abstimmung> _allAbstimmungen = [];

  Future<void> getAllAbstimmungen() async {
    _allAbstimmungen = await AbstimmungApi.loadAllAbstimmungen();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllAbstimmungen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Abstimmungen"),
          backgroundColor: Theme.of(context).backgroundColor,
          actions: [
            IconButton(
              onPressed: Format.isAcceptTime
                  ? () {
                      //! Add Abstimmung
                    }
                  : null,
              icon: const Icon(Icons.add),
              alignment: Alignment.center,
            ),
          ],
        ),
        drawer: const Drawer_Widget(),
        body: _isLoading
            ? const CircularProgressIndicator(
                color: Colors.blue,
              )
            : SafeArea(
                child: RefreshIndicator(
                  color: Colors.blue,
                  onRefresh: getAllAbstimmungen,
                  child: ListView.builder(
                      itemCount: _allAbstimmungen.length,
                      itemBuilder: (context, index) {
                        return PollItemAndroid(
                            actAbstimmung: _allAbstimmungen[index]);
                      }),
                ),
              ));
  }
}
