import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:burlang_demo/widgets/drawer_widget.dart';
import 'package:burlang_demo/widgets/loader_widget.dart';
import 'package:burlang_demo/widgets/new_widget.dart';
import 'package:burlang_demo/widgets/search_dictionary_word_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/appbar_widget.dart';

class SearchWordScreen extends StatefulWidget {
  const SearchWordScreen({Key key}) : super(key: key);

  @override
  State<SearchWordScreen> createState() => _SearchWordScreenState();
}

class _SearchWordScreenState extends State<SearchWordScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<BurlangBloc, BurlangState>(
      listener: (context, state) {
        if (state is BurlangInitializedNewsState) {
          if (!mounted) return;
          setState(() {
            isLoading = false;
          });
        }
        if (state is BurlangErrorState) {
          if (!mounted) return;
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: const AppBarWidget(),
        body: isLoading
            ? const LoaderWidget(padding: EdgeInsets.zero)
            : GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: RefreshIndicator(
                    color: Constants.color,
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 2))
                          .then((_) {
                        setState(() {
                          isLoading = true;
                        });
                        BlocProvider.of<BurlangBloc>(context)
                            .add(BurlangInitializeNews());
                      });
                    },
                    child: ListView(shrinkWrap: true, children: const [
                      SearchDictionaryWordWidget(),
                      NewsWidget()
                    ]),
                  ),
                ),
              ),
      ),
    );
  }
}
