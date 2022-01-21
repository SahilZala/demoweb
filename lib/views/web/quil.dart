
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';

class ShowQuil extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuillToolbar.basic(controller: _controller),
        Expanded(
          child: Container(
            child: QuillEditor.basic(
              controller: _controller,
              readOnly: false, // true for view only mode
            ),
          ),
        )
      ],
    );
  }

  QuillController _controller = QuillController.basic();
}