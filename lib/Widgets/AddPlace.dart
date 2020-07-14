import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import '../Providers/Places_List.dart';

class AddPlace extends StatefulWidget {
  static const String id = '/AddPlace';
  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  File _image;
  final _titleController = TextEditingController();
  void _saveImage(File pickedImage) {
    if (pickedImage == null) {
      return;
    }
    _image = pickedImage;
  }

  void onSubmit() {
    if (_titleController.text.isEmpty || _image == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Oops!An error occurred!'),
                content: Text('Please fill all the fields!'),
                actions: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
      return;
    }

    print(_titleController.text);
    Provider.of<Places>(context, listen: false)
        .addItem(_titleController.text, _image);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Name of the Place'),
                    controller: _titleController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ImageInput(_saveImage),
//                  TextFormField(),
                ],
              ),
            ),
          ),
          RaisedButton.icon(
              color: Theme.of(context).accentColor,
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: onSubmit,
              icon: Icon(Icons.add),
              label: Text('Add Place'))
        ],
      ),
    );
  }
}

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _image;
  Future<void> _getImage() async {
    ImagePicker imagePicker = ImagePicker();
    final _pickedImage = await imagePicker.getImage(
      source: ImageSource.camera,
      maxHeight: 600,
      maxWidth: 600,
    );
    if (_pickedImage == null) {
      return;
    }
    setState(() {
      _image = File(_pickedImage.path);
    });
    final _appDir = await syspath.getApplicationDocumentsDirectory();
    final _imgDir = path.basename(_image.path);
    final _savedImage = await _image.copy('${_appDir.path}/$_imgDir');
    widget.onSelectImage(_savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _image == null
              ? Text(
                  'No Picture Taken Yet!',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(
          width: 25,
        ),
        Expanded(
          child: RaisedButton.icon(
              color: Theme.of(context).accentColor,
              onPressed: _getImage,
              icon: const Icon(Icons.camera),
              label: const Text('Take Picture')),
        ),
      ],
    );
  }
}
