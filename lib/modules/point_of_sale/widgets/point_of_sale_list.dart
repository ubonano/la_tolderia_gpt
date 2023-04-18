import 'package:flutter/material.dart';
import '../../../utils/app_navigate.dart';
import '../../../utils/get_it_setup.dart';
import '../../../widgets/app_list_tile.dart';
import '../../../widgets/app_stream_builder.dart';
import '../point_of_sale.dart';
import '../point_of_sale_service.dart';

class PointOfSaleList extends StatelessWidget {
  final _pointOfSaleService = locator<PointOfSaleService>();

  PointOfSaleList({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<List<PointOfSale>>(
      stream: _pointOfSaleService.getPointsOfSale(),
      onData: (pointsOfSale) => ListView.builder(
        itemCount: pointsOfSale.length,
        itemBuilder: (context, index) {
          final pointOfSale = pointsOfSale[index];
          return AppListTile(
            title: pointOfSale.name,
            subtitle: pointOfSale.branchName,
            onEdit: () =>
                AppNavigate.toPointOfSale(context, pointOfSale: pointOfSale),
            onDelete: () =>
                _pointOfSaleService.deletePointOfSale(pointOfSale.id),
          );
        },
      ),
    );
  }
}
