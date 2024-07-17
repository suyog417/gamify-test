import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kgamify/bloc/catergories_bloc.dart';
import 'package:kgamify/utils/drawer.dart';
import 'package:kgamify/utils/widgets.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  String _selectedSortOption = "A-Z";

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
                            title: const Text("SortBy"),
                            content: SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.7,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    buttonPadding: EdgeInsets.zero,
                                    children: [Radio(value: "A-Z",
                                      groupValue: "A-Z", onChanged: (value) {

                                      },),Text("A-Z")],
                                  ),
                                  Radio<String>(
                                    value: 'A-Z',
                                    groupValue: _selectedSortOption,
                                    toggleable: true,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedSortOption = value!;
                                      });
                                      Navigator.pop(context, value);
                                    },
                                    activeColor: Colors.green,
                                  ),
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


