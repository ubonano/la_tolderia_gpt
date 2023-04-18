import 'package:flutter/material.dart';
import '../../utils/app_navigate.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_drawer.dart';
import 'widgets/point_of_sale_list.dart';

class PointOfSaleListScreen extends StatelessWidget {
  const PointOfSaleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Puntos de venta')),
      drawer: const AppDrawer(),
      body: PointOfSaleList(),
      floatingActionButton: AppButtons.addFloatAction(
        () => AppNavigate.toPointOfSale(context),
      ),
    );
  }
}
