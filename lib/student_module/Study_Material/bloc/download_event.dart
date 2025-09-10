// bloc/download_event.dart

part of 'download_bloc.dart';

@immutable
abstract class DownloadEvent {}

class StartDownload extends DownloadEvent {}

class CancelDownload extends DownloadEvent {}

// Private event to update progress internally
class _DownloadProgressUpdated extends DownloadEvent {
  final double progress;
  _DownloadProgressUpdated(this.progress);
}