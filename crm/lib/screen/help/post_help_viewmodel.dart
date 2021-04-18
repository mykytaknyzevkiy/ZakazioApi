import 'package:file_picker/file_picker.dart';
import 'package:rxdart/subjects.dart';
import 'package:zakazy_crm_v2/repository/FileRepository.dart';
import 'package:zakazy_crm_v2/rest/FileRest.dart';
import 'package:zakazy_crm_v2/rest/help_rest.dart';
import 'package:zakazy_crm_v2/screen/ZakazyViewModel.dart';

class PostHelpViewModel extends ZakazyViewModel {
  final _fileResponse = FileRepository();
  final _helpRest = HelpRest();

  final isLoading = BehaviorSubject<bool>.seeded(false);
  final isDone = BehaviorSubject<bool>.seeded(false);

  final selectedFiles =
      BehaviorSubject<List<PlatformFile>>.seeded(List.empty());

  post(String message, List<PlatformFile> files) async {
    isLoading.add(true);

    final fileUrls = List<String>.of({});

    for (final element in files) {
      final url = await _fileResponse.uploadFile(element);
      if (url != null) {
        print("file add");
        fileUrls.add(url);
      } else {
        print("file not add");
      }
    }

    _helpRest.add(message, fileUrls);

    isDone.add(true);

    isLoading.add(false);
  }

  @override
  close() {
    isLoading.close();
    isDone.close();
  }
}
