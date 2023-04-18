import 'package:flutter/material.dart';
import '../../../utils/app_navigate.dart';
import '../../../utils/get_it_setup.dart';
import '../../../widgets/app_list_tile.dart';
import '../../../widgets/app_stream_builder.dart';
import '../branch.dart';
import '../branch_service.dart';

class BranchList extends StatefulWidget {
  const BranchList({super.key});

  @override
  _BranchListState createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  final _branchService = locator<BranchService>();

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<List<Branch>>(
      stream: _branchService.getBranches(),
      onData: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final branch = data[index];
          return AppListTile(
            title: branch.name,
            onEdit: () => AppNavigate.toBranch(context, branch: branch),
            onDelete: () => _branchService.deleteBranch(branch.id),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _branchService.dispose();
    super.dispose();
  }
}
