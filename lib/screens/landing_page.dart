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

  String _selectedSortOption = "A-Z";
  final List<String> _sortOptions = ["Date","Alphabetical (A-Z)","Status"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.playQuest,style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.orange
        ),),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.04444),
              child: CupertinoSearchTextField(
                padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.03),
                onChanged: (value) {
                  context.read<CategoriesBloc>().searchChampionship(value);
                },
              ),
            ),
        ),
      ),
      body: BlocConsumer<CategoriesBloc,CategoriesStates>(
        builder: (context, state) {
        if (state is CategoriesLoadedState){
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.04,vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.selectChampionship,style: Theme.of(context).textTheme.titleMedium,),
                    InkWell(
                      onTap: () {
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.04),
                            title: const Text("SortBy"),
                            content: SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...List.generate(_sortOptions.length, (index) {
                                    return ButtonBar(
                                      alignment: MainAxisAlignment.start,
                                      buttonPadding: EdgeInsets.zero,
                                      children: [Radio(value: _sortOptions.elementAt(index),
                                        groupValue: _selectedSortOption, onChanged: (value) {
                                        setState(() {
                                          _selectedSortOption = value!;
                                        });
                                        },), AutoSizeText(_sortOptions.elementAt(index))],
                                    );
                                  },)
                                  // ButtonBar(
                                  //   alignment: MainAxisAlignment.start,
                                  //   buttonPadding: EdgeInsets.zero,
                                  //   children: [Radio(value: "A-Z",
                                  //     groupValue: _selectedSortOption, onChanged: (value) {
                                  //     setState(() {
                                  //
                                  //     });
                                  //     },),const Text("Alphabetical")],
                                  // ),
                                  // ButtonBar(
                                  //   alignment: MainAxisAlignment.start,
                                  //   buttonPadding: EdgeInsets.zero,
                                  //   children: [Radio(value: "Status",
                                  //     groupValue: _selectedSortOption, onChanged: (value) {
                                  //
                                  //     },),const AutoSizeText("Status(Ongoing/Upcoming/Ended)")],
                                  // ),
                                  // ButtonBar(
                                  //   alignment: MainAxisAlignment.start,
                                  //   buttonPadding: EdgeInsets.zero,
                                  //   children: [Radio(value: "Date",
                                  //     groupValue: _selectedSortOption, onChanged: (value) {
                                  //
                                  //     },),const Text("Date")],
                                  // ),
                                ],
                              ),
                            ),
                          );
                        },);
                      },
                        child: const Icon(Icons.sort_outlined))
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.04
                ),
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
                    categoryName: curr.categoryName ?? ""
                );
                            },),
              )],
          );
        }
        if (state is CategoriesLoadingState){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CategoriesErrorState){
          return Center(child: Text(state.error),);
        }
        return Container();
      }, listener: (context, state) {

      },)
    );
  }

}


