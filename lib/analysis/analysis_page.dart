import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class AnalysisPage extends StatefulWidget {
  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  List<String> fileNames = [];
  List<String> fileUrls = [];

  @override
  void initState() {
    super.initState();
    fetchFilesFromStorage();
  }

  Future<void> fetchFilesFromStorage() async {
    String? nextPageToken; // Initialize nextPageToken as nullable
    try {
      Reference storageRef = FirebaseStorage.instance.ref();

      do {
        final listResult = await storageRef.list(ListOptions(
          maxResults: 100,
          pageToken: nextPageToken,
        ));

        for (var item in listResult.items) {
          fileNames.add(item.name);
          // Get the download URL for the file
          String downloadURL = await item.getDownloadURL();
          fileUrls.add(downloadURL);
        }

        setState(() {});
        nextPageToken = listResult.nextPageToken;
      } while (nextPageToken != null);
    } catch (e) {
      // Handle unauthorized access error
      print('Error fetching files: $e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('You do not have permission to access the files.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // Function to open the file URL
  Future<void> openFileUrl(String url) async {
    if (await canLaunch(url)) {
      if (kIsWeb) {
        // Use url_launcher_web for web platforms
        launch(url, forceSafariVC: false);
      } else {
        // Fallback to url_launcher for other platforms
        launch(url);
      }
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis Files'),
      ),
      body: fileNames.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: fileNames.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.insert_drive_file),
              title: Text(fileNames[index]),
              onTap: () {
                // Open the file URL when tapped
                openFileUrl(fileUrls[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
