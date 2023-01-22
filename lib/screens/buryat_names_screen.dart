import 'package:burlang_demo/api/burlang_api.dart';
import 'package:burlang_demo/bloc/burlang_bloc.dart';
import 'package:burlang_demo/config/router.dart';
import 'package:burlang_demo/constants/constants.dart';
import 'package:burlang_demo/models/buryat_names.dart';
import 'package:burlang_demo/widgets/appbar_widget.dart';
import 'package:burlang_demo/widgets/contacts_widget.dart';
import 'package:burlang_demo/widgets/loader_widget.dart';
import 'package:burlang_demo/widgets/navigator_widget.dart';
import 'package:burlang_demo/widgets/search_buryat_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuryatNamesScreen extends StatefulWidget {
  final String letter;
  const BuryatNamesScreen({Key key, this.letter}) : super(key: key);

  @override
  State<BuryatNamesScreen> createState() => _BuryatNamesScreenState();
}

class _BuryatNamesScreenState extends State<BuryatNamesScreen> {
  bool isLoading = false;
  bool isError = false;

  List<BuryatNames> names = [];

  String query = '';
  String errorText = '';

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BurlangBloc, BurlangState>(
      listener: (context, state) {
        if (state is BurlangInitializedNamesState) {
          if (!mounted) return;
          setState(() {
            isLoading = false;
            isError = false;
            names = state.incomeNames;
          });
        }

        if (state is BurlangErrorState) {
          if (!mounted) return;
          setState(() {
            isLoading = false;
            isError = state.isError;
            errorText = state.text;
          });
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const AppBarWidget(),
          body: isLoading
              ? const LoaderWidget(padding: EdgeInsets.zero)
              : RefreshIndicator(
                  color: Constants.color,
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2)).then((_) {
                      if (!mounted) return;
                      setState(() {
                        isLoading = true;
                      });
                      BlocProvider.of<BurlangBloc>(context).add(
                          BurlangInitializeNames(
                              letter: widget.letter, query: query));
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView(
                      children: [
                        NavigatorWidget(
                          subtitle: 'Бурятские имена',
                          routeName: RouteGenerator.LETTERS_NAMES,
                          childTitle: 'Имена на букву ${widget.letter}',
                        ),
                        SearchBuryatNameWidget(
                          text: query,
                          onChanged: searchName,
                          hintText: 'Введите имя',
                        ),
                        isError
                            ? SizedBox(
                                height: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Card(
                                          elevation: 1.0,
                                          color: const Color.fromARGB(
                                              255, 242, 222, 222),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 40),
                                            child: Center(
                                              child: Text(
                                                errorText,
                                                style: const TextStyle(
                                                    fontFamily: 'Arial',
                                                    color: Color.fromARGB(
                                                        255, 169, 69, 68)),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) {
                                  final sortedIndex = index + 1;
                                  return ListTile(
                                    title: Text(
                                      names[index].name,
                                      style: TextStyle(fontFamily: 'Arial'),
                                    ),
                                    trailing: Text(sortedIndex.toString()),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          RouteGenerator
                                              .BURYAT_NAME_DISCRIPTION,
                                          arguments: names[index].name);
                                    },
                                  );
                                },
                                itemCount: names.length,
                              ),
                        ContactsWidget()
                      ],
                    ),
                  ),
                )),
    );
  }

  searchName(String query) async {
    final searchedNames = await BurlangApi().getAllNames(widget.letter, query);
    setState(() {
      names = searchedNames;
    });
  }

  void init() {
    setState(() {
      isLoading = true;
    });
    BlocProvider.of<BurlangBloc>(context)
        .add(BurlangInitializeNames(letter: widget.letter, query: query));
  }
}
