import 'package:flutter/material.dart';
import '../modules/auth/auth_service.dart';
import '../utils/get_it_setup.dart';
import 'app_drawer_tiles.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final authService = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Builder(
        builder: (BuildContext context) {
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName:
                    Text(authService.currentUser?.displayName ?? 'No name'),
                accountEmail:
                    Text(authService.currentUser?.email ?? 'No email'),
              ),
              AppDrawerTiles.dailyIncomeButton(context),
              AppDrawerTiles.branchButton(context),
              AppDrawerTiles.employeeButton(context),
              AppDrawerTiles.userButton(context),
              AppDrawerTiles.pointOfSaleButton(context),
              AppDrawerTiles.logoutButton(context),
            ],
          );
        },
      ),
    );
  }
}
