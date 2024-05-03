import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileUpload extends StatefulWidget {
  const FileUpload({super.key});

  @override
  State<FileUpload> createState() => _UploadFileState();
}

class _UploadFileState extends State<FileUpload> {

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Upload Files'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Browse Files
            Container(
              width: 307,
              height: 290,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 0.3,
                  color: Colors.grey,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(0, 4),
                    blurRadius: 4.0,
                    spreadRadius: 0.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image.asset(
                    'assets/images/upload.png',
                  ),

                  const Text(
                    "Browse Files",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF6D62F7),
                      decoration: TextDecoration.underline,
                    ),
                  ),

                  const Text(
                    "Supported formats: excel sheet, pdf, csv",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 25,),

            // Upload File
            ElevatedButton(
              onPressed: _selectFile,
              child: const Text('Select File'),
            ),
            const SizedBox(height: 20),
            if (_selectedFile != null)
              Text('Selected File: ${_selectedFile!.path}'),
          ],
        ),
      ),
    );
  }
}
