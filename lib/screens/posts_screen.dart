import 'dart:developer';
import 'dart:io';
import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../api/apis.dart';
import '../models/chat_user.dart';



class PostScreen extends StatefulWidget {

  final ChatUser user;
  const PostScreen({super.key, required this.user});


  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return MyPostScreen();
  }
}

class MyPostScreen extends StatefulWidget {
 const MyPostScreen({super.key});



  @override
  State<MyPostScreen> createState() => _MyPostScreen();
}

class _MyPostScreen extends State<MyPostScreen> {


  late File? selectedFile=null;
  String? filePath;

  TextEditingController aboutController= TextEditingController();




  Future<void> _openFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          selectedFile = File(result.files.single.path!);
        });
      }

      final appDir = await getTemporaryDirectory();
      final fileName = result!.files.single.name;
      final savedFile = await selectedFile!.copy('${appDir.path}/$fileName');
      setState(() {
        filePath = savedFile.path;
      });
    } catch (e) {
      print('Error while picking the file: $e');
    }

    log("${selectedFile!.path}");
  }

  Widget _buildFileWidget() {
    if (selectedFile == null) {
      return Text('No file selected');
    }

    String extension = selectedFile!.path.split('.').last.toLowerCase();

    if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
      return Image.file(selectedFile!);
    }
    else if (extension == 'pdf') {
      return Text('PDF file: ${selectedFile!.path}');
      // You can also use a PDF viewer package to display the PDF contents.
    }
    else if (extension == 'txt') {
      return FutureBuilder<String>(
        future: selectedFile!.readAsString(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Text('Text file contents:\n${snapshot.data}');
          } else if (snapshot.hasError) {
            return Text('Error loading text file');
          } else {
            return CircularProgressIndicator();
          }
        },
      );
    }

    else if(extension == 'obj'||extension== 'fbx' ||extension == 'gltf' || extension== 'glb'){
      return selectedFile!.path != null ?    BabylonJSViewer(
        src: 'file:///${selectedFile!.path}',
      ) : Text("no file found");
    }

    else {
      return Text('Unsupported file type: $extension');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Posting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(children: [

                TextFormField(
                  controller: aboutController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.comment,
                          color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'add about!',
                      label: const Text('about')),
                ),

                SizedBox(height: 9,),

                TextFormField(
                  controller: aboutController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_city,
                          color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'add location!',
                      label: const Text('location')),
                ),

                SizedBox(height: 9,),

              ],),



              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Container(child: _buildFileWidget(),width: 300,height: 300,)),
                ],
              ),


              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FloatingActionButton(onPressed: (){  postFile(); }, child: Icon(Icons.check)),
                    ],
                  ),
                ],
              ),
            ],
          ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: (){ _openFilePicker();},
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<Widget?> postFile() async{
    if(selectedFile!.path.isNotEmpty){
      await APIs.uploadPost(File(selectedFile!.path));
     // Navigator.pop(context);
      return null;
  }
    else return CircularProgressIndicator();
}

}