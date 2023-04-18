import 'package:flutter/material.dart';
import '../../../utils/get_it_setup.dart';
import '../../../widgets/app_state_connection.dart';
import '../branch.dart';
import '../branch_service.dart';

class BranchDropdown extends StatefulWidget {
  final Branch? branch;
  final void Function(Branch?) onChanged;
  final String? Function(Branch?)? validator;

  const BranchDropdown({
    Key? key,
    required this.branch,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);

  @override
  _BranchDropdownState createState() => _BranchDropdownState();
}

class _BranchDropdownState extends State<BranchDropdown> {
  final _branchService = locator<BranchService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Branch>>(
      stream: _branchService.getBranches(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final branches = snapshot.data!;
          final selectedBranch = widget.branch != null
              ? branches.firstWhere((b) => b.id == widget.branch!.id)
              : null;

          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: DropdownButtonFormField<Branch>(
              value: selectedBranch,
              decoration: const InputDecoration(
                labelText: 'Sucursal',
                border: OutlineInputBorder(),
              ),
              items: branches.map<DropdownMenuItem<Branch>>((Branch branch) {
                return DropdownMenuItem<Branch>(
                  value: branch,
                  child: Text(branch.name),
                );
              }).toList(),
              onChanged: widget.onChanged,
              validator: widget.validator,
            ),
          );
        } else {
          return AppStateConnection.loading();
        }
      },
    );
  }
}
