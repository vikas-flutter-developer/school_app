import '../models/inventory_request_model.dart';
import '../models/indent_model.dart'; // Assuming you have this

abstract class InventoryRepository {
  Future<List<InventoryRequestModel>> getInventoryRequests();
  Future<void> approveInventoryRequest(String requestId);
  Future<List<IndentModel>> getIndents({
    String? searchTerm,
    String? statusFilter,
  });
  Future<void> addIndent(IndentModel indent);
}

class MockInventoryRepository implements InventoryRepository {
  List<InventoryRequestModel> _requests = [
    InventoryRequestModel(
      id: '1',
      className: 'Class X-A',
      teacherName: 'Teacher Name',
      requestDate: DateTime.now(),
      roomNo: '115',
    ),
    InventoryRequestModel(
      id: '2',
      className: 'Class X-A',
      teacherName: 'Teacher Name',
      requestDate: DateTime.now(),
      roomNo: '115',
    ),
  ];

  List<IndentModel> _indents = List.generate(
    20,
    (i) => IndentModel(
      srNo: (i + 1).toString(),
      indentNo: '#${10000 + i * 123}',
      date: DateTime.now().subtract(Duration(days: i)),
      title: 'Lorem Ipsum Item',
      raisedBy: 'User ${i % 3 + 1}',
      department: 'Dept ${i % 2 + 1}',
      status:
          i % 3 == 0
              ? IndentStatus.active
              : (i % 3 == 1 ? IndentStatus.inactive : IndentStatus.pending),
    ),
  );

  @override
  Future<List<InventoryRequestModel>> getInventoryRequests() async {
    await Future.delayed(const Duration(seconds: 1));
    return _requests;
  }

  @override
  Future<void> approveInventoryRequest(String requestId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _requests =
        _requests.map((req) {
          if (req.id == requestId) {
            return req.copyWith(status: RequestStatus.approved);
          }
          return req;
        }).toList();
  }

  @override
  Future<List<IndentModel>> getIndents({
    String? searchTerm,
    String? statusFilter,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    List<IndentModel> filteredIndents = _indents;
    if (searchTerm != null && searchTerm.isNotEmpty) {
      filteredIndents =
          filteredIndents
              .where(
                (indent) =>
                    indent.indentNo.toLowerCase().contains(
                      searchTerm.toLowerCase(),
                    ) ||
                    indent.title.toLowerCase().contains(
                      searchTerm.toLowerCase(),
                    ) ||
                    indent.raisedBy.toLowerCase().contains(
                      searchTerm.toLowerCase(),
                    ),
              )
              .toList();
    }
    if (statusFilter != null &&
        statusFilter.isNotEmpty &&
        statusFilter != "All") {
      // Assuming "All" means no filter
      IndentStatus filter;
      switch (statusFilter.toLowerCase()) {
        case "pending":
          filter = IndentStatus.pending;
          break;
        case "active":
          filter = IndentStatus.active;
          break;
        case "inactive":
          filter = IndentStatus.inactive;
          break;
        default:
          return filteredIndents; // Or throw error
      }
      filteredIndents =
          filteredIndents.where((indent) => indent.status == filter).toList();
    }
    return filteredIndents;
  }

  @override
  Future<void> addIndent(IndentModel indent) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _indents.insert(
      0,
      indent.copyWith(
        srNo: (_indents.length + 1).toString(),
        indentNo: '#${10000 + _indents.length * 123}',
      ),
    );
  }
}
