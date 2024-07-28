import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgamify/bloc/catergories_bloc.dart';
import 'package:kgamify/utils/drawer.dart';
import 'package:kgamify/utils/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _selectedSortOption = "Date";
  final List<String> _sortOptions = ["Date", "A-Z", "Status"];

  @override
  void dispose() {
    // TODO: implement dispose
    if (FocusManager.instance.primaryFocus!.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerEnableOpenDragGesture: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            AppLocalizations.of(context)!.playQuest,
            style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.orange),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.04444),
              child: CupertinoSearchTextField(
                autofocus: false,
                padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.03),
                onChanged: (value) {
                  context.read<CategoriesBloc>().searchChampionship(value);
                },
              ),
            ),
          ),
        ),
        body: BlocConsumer<CategoriesBloc, CategoriesStates>(
          builder: (context, state) {
            if (state is CategoriesLoadedState) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width * 0.04, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.selectChampionship,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    contentPadding:
                                        EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.04),
                                    title: const Text("SortBy"),
                                    content: StatefulBuilder(
                                      builder: (context, setState) {
                                        return SizedBox(
                                          width: MediaQuery.sizeOf(context).width * 0.8,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ...List.generate(
                                                _sortOptions.length,
                                                (index) {
                                                  return ButtonBar(
                                                    alignment: MainAxisAlignment.start,
                                                    buttonPadding: EdgeInsets.zero,
                                                    children: [
                                                      Radio(
                                                        value: _sortOptions.elementAt(index),
                                                        groupValue: _selectedSortOption,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _selectedSortOption = value!;
                                                            context
                                                                .read<CategoriesBloc>()
                                                                .sortChampionships(value);
                                                            Navigator.pop(context);
                                                          });
                                                        },
                                                      ),
                                                      AutoSizeText(_sortOptions.elementAt(index))
                                                    ],
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.sort_outlined))
                      ],
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<CategoriesBloc>().refreshCategories();
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.sizeOf(context).width * 0.04),
                        itemCount: state.models!.length,
                        itemBuilder: (context, index) {
                          final curr = state.models?.elementAt(index);
                          return ChampionshipInfo(
                              startDate: curr!.startDate ?? "",
                              endDate: curr.endDate ?? "",
                              startTime: curr.startTime ?? "",
                              endTime: curr.endTime ?? "",
                              champId: curr.champId ?? "",
                              categoryId: curr.categoryId ?? "",
                              champName: curr.champName ?? "",
                              categoryName: curr.categoryName ?? "");
                        },
                      ),
                    ),
                  )
                ],
              );
            }
            if (state is CategoriesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CategoriesErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            return Container();
          },
          listener: (context, state) {},
        ));
  }
}
