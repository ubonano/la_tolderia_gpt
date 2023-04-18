import 'package:flutter/material.dart';
import '../../utils/get_it_setup.dart';
import 'branch.dart';
import 'branch_service.dart';
import 'widgets/branch_form.dart';

class BranchScreen extends StatelessWidget {
  final Branch? branch;
  final _branchService = locator<BranchService>();

  BranchScreen({Key? key, this.branch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(branch == null ? 'Nueva sucursal' : 'Editar sucursal'),
      ),
      body: BranchForm(
        branch: branch,
        onSubmit: (branch) async {
          this.branch == null
              ? await _branchService.addBranch(branch)
              : await _branchService.updateBranch(branch);
        },
      ),
    );
  }
}
