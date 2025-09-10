// bloc/download_state.dart

part of 'download_bloc.dart';

@immutable
abstract class DownloadState extends Equatable { // ✅ Changed to Equatable for better state comparison
  const DownloadState();

  @override
  List<Object> get props => []; // ✅ Added props for Equatable
}

class DownloadInitial extends DownloadState {}

class DownloadInProgress extends DownloadState {
  final double progress;
  const DownloadInProgress(this.progress);

  @override
  List<Object> get props => [progress];
}

class DownloadCompleted extends DownloadState {
  final String filePath; // ✅ Added this variable to hold the file path
  const DownloadCompleted(this.filePath); // ✅ Updated the constructor

  @override
  List<Object> get props => [filePath]; // ✅ Added filePath to props
}

class DownloadCancelled extends DownloadState {}

class DownloadFailure extends DownloadState {
  final String error;
  const DownloadFailure(this.error);

  @override
  List<Object> get props => [error];
}