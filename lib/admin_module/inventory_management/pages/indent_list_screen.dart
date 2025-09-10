import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/app_colors.dart';
// ✨ Responsive change: Add the import for the helper
import '../../../../core/utils/screen_util_helper.dart';
import '../bloc/indent_management/indent_management_bloc.dart';
import '../bloc/indent_management/indent_management_event.dart';
import '../bloc/indent_management/indent_management_state.dart';
import '../data/models/indent_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/loading_indicator.dart';
import 'add_indent_dialog.dart';

class IndentListScreen extends StatefulWidget {
  const IndentListScreen({super.key});
  static const routeName = '/indent-list';

  @override
  State<IndentListScreen> createState() => _IndentListScreenState();
}

class _IndentListScreenState extends State<IndentListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedStatus; // For filter dropdown
  String? _selectedFilterType; // For the first filter dropdown

  @override
  void initState() {
    super.initState();
    // Initial load
    context.read<IndentBloc>().add(LoadIndents());
    _searchController.addListener(() {
      context.read<IndentBloc>().add(SearchIndents(_searchController.text));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✨ Responsive change: Initialize the helper
    ScreenUtilHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        showAddAction: true,
        addActionText: 'Add Indent',
        onAddActionPressed: () {
          showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: BlocProvider.of<IndentBloc>(context),
              // ✨ Note: Ensure AddIndentDialog is also made responsive
              child: const AddIndentDialog(),
            ),
          );
        },
        logoAssetPath: 'assets/images/edudibon_logo.png',
        pageTitle: 'Inventory Management',
      ),
      body: Column(
        children: [
          _buildSearchAndFilterBar(),
          Expanded(
            child: BlocBuilder<IndentBloc, IndentState>(
              builder: (context, state) {
                if (state.status == IndentStatusState.loading && state.indents.isEmpty) {
                  return const LoadingIndicator();
                }
                if (state.status == IndentStatusState.failure && state.indents.isEmpty) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'Failed to load indents.',
                      // ✨ Responsive change
                      style: TextStyle(fontSize: ScreenUtilHelper.fontSize(16)),
                    ),
                  );
                }
                if (state.indents.isEmpty) {
                  return Center(
                    child: Text(
                      'No indents found.',
                      // ✨ Responsive change
                      style: TextStyle(fontSize: ScreenUtilHelper.fontSize(16)),
                    ),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: PaginatedDataTable(
                    // ✨ Responsive change
                    header: Text(
                      'Indents',
                      style: TextStyle(
                          fontSize: ScreenUtilHelper.fontSize(18),
                          fontWeight: FontWeight.bold),
                    ),
                    rowsPerPage: 10,
                    // ✨ Responsive change for column headers
                    columns: [
                      DataColumn(label: Text('Sr No.', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14), fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Indent No', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14), fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Date', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14), fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Title', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14), fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Raised By', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14), fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Department', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14), fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Status', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14), fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Action', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14), fontWeight: FontWeight.bold))),
                    ],
                    source: _IndentDataSource(state.indents, context),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterBar() {
    return Padding(
      // ✨ Responsive change
      padding: EdgeInsets.all(ScreenUtilHelper.width(8.0)),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
            decoration: InputDecoration(
              hintText: 'Find: Indent No, Date, Raised by...',
              hintStyle: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
              prefixIcon: Icon(Icons.search, size: ScreenUtilHelper.scaleAll(20)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(12),
                vertical: ScreenUtilHelper.height(10),
              ),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.height(8)),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.width(12),
                      vertical: ScreenUtilHelper.height(10),
                    ),
                    prefixIcon: Icon(
                      Icons.filter_list,
                      color: Theme.of(context).primaryColor,
                      size: ScreenUtilHelper.scaleAll(20),
                    ),
                  ),
                  hint: Text('Filter By', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                  value: _selectedFilterType,
                  items: ['All', 'Date', 'Indent No', 'Raised By', 'Department']
                      .map((status) => DropdownMenuItem(
                    value: status,
                    child: Text(status, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => _selectedFilterType = value);
                    // This filter might need a different event in your BLoC
                  },
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(8)),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.width(12),
                      vertical: ScreenUtilHelper.height(10),
                    ),
                    prefixIcon: Icon(
                      Icons.filter_list,
                      color: Theme.of(context).primaryColor,
                      size: ScreenUtilHelper.scaleAll(20),
                    ),
                  ),
                  hint: Text('Status', style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                  value: _selectedStatus,
                  items: ['All', 'Pending', 'Approved', 'Rejected']
                      .map((status) => DropdownMenuItem(
                    value: status,
                    child: Text(status, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => _selectedStatus = value);
                    context.read<IndentBloc>().add(FilterIndentsByStatus(value ?? 'All'));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Data source for PaginatedDataTable
class _IndentDataSource extends DataTableSource {
  final List<IndentModel> _indents;
  final BuildContext context;

  _IndentDataSource(this._indents, this.context);

  // ✨ Fix: Implemented the function body with a default case to prevent null return errors.
  Color _getStatusColor(IndentStatus status) {
    switch (status) {
      case IndentStatus.active:
        return AppColors.success;
      case IndentStatus.inactive:
        return AppColors.error;
      case IndentStatus.pending:
        return AppColors.pending;
      default:
        return AppColors.ash; // Fallback color
    }
  }

  // ✨ Fix: Implemented the function body with a default case to prevent null return errors.
  String _getStatusText(IndentStatus status) {
    switch (status) {
      case IndentStatus.active:
        return "Active";
      case IndentStatus.inactive:
        return "Inactive";
      case IndentStatus.pending:
        return "Pending";
      default:
        return "Unknown"; // Fallback text
    }
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _indents.length) return null;
    final indent = _indents[index];
    // ✨ Responsive changes for DataCell content
    final cellTextStyle = TextStyle(fontSize: ScreenUtilHelper.fontSize(13));
    return DataRow(
      cells: [
        DataCell(Text(indent.srNo, style: cellTextStyle)),
        DataCell(Text(indent.indentNo, style: cellTextStyle)),
        DataCell(Text(DateFormat('d/M/yyyy').format(indent.date), style: cellTextStyle)),
        DataCell(Text(indent.title, style: cellTextStyle, overflow: TextOverflow.ellipsis)),
        DataCell(Text(indent.raisedBy, style: cellTextStyle)),
        DataCell(Text(indent.department, style: cellTextStyle)),
        DataCell(
          Text(
            _getStatusText(indent.status),
            style: TextStyle(
              color: _getStatusColor(indent.status),
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilHelper.fontSize(13), // Scaled font size
            ),
          ),
        ),
        DataCell(
          PopupMenuButton(
            icon: Icon(Icons.more_vert, size: ScreenUtilHelper.scaleAll(22)),
            itemBuilder: (context) => [
              PopupMenuItem(value: 'edit', child: Text('Edit', style: cellTextStyle)),
              PopupMenuItem(value: 'delete', child: Text('Delete', style: cellTextStyle)),
            ],
            onSelected: (value) {
              // Handle action
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _indents.length;

  @override
  int get selectedRowCount => 0;
}