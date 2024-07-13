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
        actions: [
          IconButton(onPressed: () {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: const Text("SortBy"),
                content: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Radio<String>(
                        value: 'A-Z',
                        groupValue: _selectedSortOption,
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
          }, icon: const Icon(Icons.sort))
        ],
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
          return ListView.builder(
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
          },);
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


