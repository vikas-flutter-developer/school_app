
import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  StreamSubscription<double>? _progressSubscription;

  DownloadBloc() : super(DownloadInitial()) {
    on<StartDownload>(_onStartDownload);
    on<_DownloadProgressUpdated>(_onProgressUpdate);
    on<CancelDownload>(_onCancelDownload);
  }

  // ✅ A helper function to create a dummy file for testing
  Future<String> _createDummyFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/science_exam_paper_01.pdf';
    final file = File(filePath);
    // Create a simple text file to simulate a PDF for opening purposes.
    await file.writeAsString('This is a dummy PDF file for testing the download feature.');
    return filePath;
  }

  void _onStartDownload(StartDownload event, Emitter<DownloadState> emit) {
    _progressSubscription = Stream<double>.periodic(
      const Duration(milliseconds: 200),
          (tick) => (tick + 1) / 20.0,
    )
        .take(20)
        .listen(
          (progress) {
        add(_DownloadProgressUpdated(progress));
      },
      onDone: () async {
        final downloadedFilePath = await _createDummyFile();

        // ✅ Now emit the state WITH the path of the downloaded file.
        emit(DownloadCompleted(downloadedFilePath));
      },
    );
  }

  void _onProgressUpdate(_DownloadProgressUpdated event, Emitter<DownloadState> emit) {
    emit(DownloadInProgress(event.progress));
  }

  void _onCancelDownload(CancelDownload event, Emitter<DownloadState> emit) async {
    await _progressSubscription?.cancel();
    emit(DownloadCancelled());
  }

  @override
  Future<void> close() {
    _progressSubscription?.cancel();
    return super.close();
  }
}