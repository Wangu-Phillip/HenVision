import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {

  File? _selectedFile;

  void _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // GET SCREEN WIDTH
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Upload Files'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
              child: Container(
                width: screenWidth * 0.9,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(0, 1),
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // PDF ICON
                    const Icon(
                      Icons.picture_as_pdf,
                      color: Color(0xFF6D62F7),
                      size: 25,
                    ),

                    // FILE NAME
                    Text(
                      "Uploaded file_${index+1}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),

                    // DOWNLOAD ICON
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.download,
                        size: 25,
                        color: Color(0xFF6D62F7),
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, right: 15.0),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF7070E7),
          onPressed: _selectFile,
          child: const Icon(
              Icons.cloud_upload_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

