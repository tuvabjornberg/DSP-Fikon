import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const double? dropDownWidth = 500;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'image here:',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 30.0,
                    ),
                  ),
                  //Container(
                  //decoration: BoxDecoration(
                  //image: DecorationImage(
                  //image: AssetImage("image/null"),
                  //),
                  //),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text("Username",
                          style: Theme.of(context).textTheme.bodyLarge),
                      Text("Level 1",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              ],
            ),
            // Dropdown video
            // https://www.youtube.com/watch?v=giV9AbM2gd8
            DropdownMenu(
              width: ProfilePage.dropDownWidth,
              enableFilter: true,
              label: Text("Friends"),
              dropdownMenuEntries: <DropdownMenuEntry>[
                DropdownMenuEntry(value: 1, label: 'James'),
                DropdownMenuEntry(value: 2, label: 'Gordon'),
                DropdownMenuEntry(value: 3, label: 'Daisy'),
                DropdownMenuEntry(value: 4, label: 'Eve'),
                DropdownMenuEntry(value: 5, label: 'Molly'),
              ],
              onSelected: (friend) {
                // Do something when you click on a friend eg take them to friend page?
              },
            ),
            // https://api.flutter.dev/flutter/material/ExpansionTile-class.html
            ExpansionTile(title: const Text("Preferences"), children: <Widget>[
              Builder(builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(24),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text('Button 1'),
                        onTap: () {
                          // Do something when Button
                        },
                      ),
                      ListTile(
                        title: Text('Button 2'),
                        onTap: () {
                          // Do something when Button
                        },
                      ),
                      // Add more buttons as needed
                    ],
                  ),
                );
              },),
            ],),
            Text("data"),
            // add firebase api
            // const SignOutButton(),
          ],
        ),
      ),
    );
  }
}
