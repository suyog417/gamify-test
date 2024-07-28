import 'dart:io';
import 'package:csc_picker_i18n/csc_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _name = TextEditingController();
  TextEditingController? _email;

  List<String>? interests;
  String? city = " ";
  String country = " ";
  String? state = " ";


  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController(
        text: Hive.box("UserData").get("personalInfo", defaultValue: "")["email"]);
    interests = Hive.box("UserData").get("interests",defaultValue: <String>[]);
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _name.dispose();
    _email?.dispose();
    super.dispose();
  }

  void pickProfilePicture() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      Uint8List rawData = await file.readAsBytes();
      Hive.box("UserData").put("UserImage", rawData).whenComplete(() => setState(() {}),);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No image selected")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            InkWell(
              onTap: () => pickProfilePicture(),
              child: Hero(
                tag: "UserPfp",
                child: CircleAvatar(
                  radius: MediaQuery.sizeOf(context).width * 0.15,
                  backgroundImage: MemoryImage(Hive.box("UserData").get("UserImage",defaultValue: null)),

                  onBackgroundImageError: (exception, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exception.toString())));
                  },
                ),
              ),
            ),
            const Divider(
              color: Colors.transparent,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: const TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.person),
                  text: "Personal",
                ),
                Tab(
                  icon: Icon(Icons.school_outlined),
                  text: "Education",
                ),
                Tab(
                  icon: Icon(Icons.interests_sharp),
                  text: "Interests",
                ),
              ]),
            ),
            Expanded(
              child: TabBarView(children: [
                SizedBox(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      TextFormField(
                        controller: _name,
                        decoration: InputDecoration(
                            label: const Text("Name"),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                            label: const Text("Email"),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      CSCPicker(
                        title: const Text("Address"),
                        showCities: true,
                        showStates: true,
                        cityDropdownLabel: "City",
                        layout: Layout.horizontal,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: const Border.fromBorderSide(BorderSide(color: Colors.grey)),
                        ),
                        defaultCountry: CscCountry.India,
                        onCityChanged: (value) {
                          setState(() {
                            city = value;
                          });
                        },
                        onCountryChanged: (value) {
                          setState(() {
                            country = value!;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            state = value;
                          });
                        },
                      ),
                      Text('$city $state $country'),
                      FilledButton(onPressed: () {}, child: const Text("Submit"))
                    ],
                  ),
                ),
                SizedBox(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // TODO : Show an option to add qualification and display them in tiles first school second highschool then graduation, post grdauation,etc
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_circle_outline_outlined,
                                size: Theme.of(context).textTheme.displayMedium!.fontSize,
                                color: Colors.grey,
                              ),
                              const Text("Add qualification")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.redAccent,
                  child: const Text("Interests"),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
