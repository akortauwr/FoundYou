// import 'package:flutter/material.dart';
// import 'package:found_you_app/ui/auth/logout/view_models/logout_view_model.dart';
// import 'package:found_you_app/ui/auth/logout/widgets/logout_button.dart';
// import 'package:found_you_app/ui/home/view_models/home_view_model.dart';
// import 'package:found_you_app/ui/profile/view_models/profile_view_model.dart';
// import 'package:found_you_app/ui/profile/views/profile_view.dart';
// import 'package:provider/provider.dart';
//
// class HomeView extends StatefulWidget {
//   final HomeViewModel viewModel;
//   const HomeView({Key? key, required this.viewModel}) : super(key: key);
//
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//   int _selectedIndex = 0;
//
//   // Dummy pages for each tab – you can replace these with your own Widgets
//   final List<Widget> _pages = <Widget>[
//     Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
//     Center(child: Text('Swipe Page', style: TextStyle(fontSize: 24))),
//     Center(child: Text('Messeges Page', style: TextStyle(fontSize: 24))),
//     ProfileView(viewModel: ProfileViewModel(name: 'lala', email: 'phone'))
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   // Optional: style your bottom navigation bar to make it more appealing
//   BottomNavigationBar _buildBottomNavigationBar() {
//     return BottomNavigationBar(
//       currentIndex: _selectedIndex,
//       onTap: _onItemTapped,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.favorite),
//           label: 'Swipe',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.message),
//           label: 'Messages',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ],
//       // Customize colors, font sizes, etc. as needed
//       selectedItemColor: Theme.of(context).primaryColor,
//       unselectedItemColor: Theme.of(context).hintColor,
//       backgroundColor: Colors.purple,
//       elevation: 8,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         centerTitle: true,
//       ),
//       body: _pages.elementAt(_selectedIndex),
//       bottomNavigationBar: _buildBottomNavigationBar(),
//       // A floating logout button that can be styled further
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:found_you_app/data/services/secure_storage_service.dart';
import 'package:found_you_app/domain/models/auth/login_response/login_response.dart';
import 'package:found_you_app/routing/paths.dart';
import 'package:found_you_app/ui/common_widgets/neo_bottom_nav_bar.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';
import 'package:found_you_app/ui/home/view_models/home_view_model.dart';
import 'package:found_you_app/ui/new_matches/views/new_matches_view.dart';
import 'package:found_you_app/utils/result.dart';
import 'package:go_router/go_router.dart';


class HomeView extends StatelessWidget {
  final HomeViewModel viewModel;

  HomeView({super.key, required this.viewModel});

    List<Color> neoBrutalismColors = [
    Color(0xFF7DF9FF), // #7DF9FF
    Color(0xFF2FFF2F), // #2FFF2F
    Color(0xFFFF00F5), // #FF00F5
    Color(0xFF3300FF), // #3300FF
    Color(0xFFFFFF00), // #FFFF00
    Color(0xFFFF4911), // #FF4911
  ];



  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        child: Column(
          children: [
            Text(
              'Home View',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

            ),
            NewMatchesView(),
          ],
        ),
      )
    );
  }


}