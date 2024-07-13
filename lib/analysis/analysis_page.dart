import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
      Reference storageRef = FirebaseStorage.instance.ref().child('reports');

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
            content: Text('Failed to fetch files: $e'),
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
                // Open the HTML file in a WebView
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HtmlDisplayPage(
                      htmlFileUrl: fileUrls[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class HtmlDisplayPage extends StatelessWidget {
  final String htmlFileUrl;

  const HtmlDisplayPage({Key? key, required this.htmlFileUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTML File'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(htmlFileUrl)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
            useOnDownloadStart: true,
          ),
          android: AndroidInAppWebViewOptions(
            useHybridComposition: true,
          ),
        ),
      ),
    );
  }
}
