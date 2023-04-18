import 'package:flutter/material.dart';
import 'point_of_sale.dart';
import 'point_of_sale_service.dart';
import 'widgets/point_of_sale_form.dart';
import '../../../utils/get_it_setup.dart';

class PointOfSaleScreen extends StatelessWidget {
  final PointOfSale? pointOfSale;
  final _pointOfSaleService = locator<PointOfSaleService>();

  PointOfSaleScreen({Key? key, this.pointOfSale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pointOfSale == null
            ? 'Agregar punto de venta'
            : 'Modificar punto de venta'),
      ),
      body: PointOfSaleForm(
        pointOfSale: pointOfSale,
        onSubmit: (PointOfSale pointOfSale) async {
          pointOfSale.id.isEmpty
              ? await _pointOfSaleService.addPointOfSale(pointOfSale)
              : await _pointOfSaleService.updatePointOfSale(pointOfSale);
        },
      ),
    );
  }
}
