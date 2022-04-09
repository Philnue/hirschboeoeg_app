import 'package:boeoeg_app/classes/Api/abstimmung.api.dart';
import 'package:boeoeg_app/classes/Models/abstimmung.dart';
import 'package:boeoeg_app/IOS/widgets/poll/pollItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../IOS/widgets/poll/addPollItem.dart';

class PollPage extends StatefulWidget {
  const PollPage({Key? key}) : super(key: key);

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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Abstimmungen",
          style: TextStyle(fontSize: 25),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.add,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(AddPoll.routeName);
          },
        ),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: SafeArea(
        child: _isLoading
            ? const CupertinoActivityIndicator()
            : SafeArea(
                child: CustomScrollView(
                  slivers: [
                    CupertinoSliverRefreshControl(
                      onRefresh: () {
                        return Future<void>.delayed(const Duration(seconds: 1))
                          ..then((_) => getAllAbstimmungen());
                      },
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return PollItem(actAbstimmung: _allAbstimmungen[index]);
                      }, childCount: _allAbstimmungen.length),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
