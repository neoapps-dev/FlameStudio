// ignore_for_file: library_private_types_in_public_api
import 'package:flamestudio/widgets/resizable_widget.dart';
import 'package:flutter/material.dart';

class FlameStudioEditor extends StatefulWidget {
  const FlameStudioEditor({super.key});

  @override
  _FlameStudioEditorState createState() => _FlameStudioEditorState();
}

class _FlameStudioEditorState extends State<FlameStudioEditor> {
  double _leftSidebarWidth = 200;
  double _rightSidebarWidth = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flame Studio'),
        actions: [
          IconButton(icon: const Icon(Icons.play_arrow), onPressed: () {}),
          IconButton(icon: const Icon(Icons.stop), onPressed: () {}),
          IconButton(icon: const Icon(Icons.save), onPressed: () {}),
        ],
      ),
      body: Row(
        children: [
          ResizableBar(
            isLeftBar: true,
            width: _leftSidebarWidth,
            onResize: (newWidth) {
              setState(() {
                _leftSidebarWidth = newWidth;
              });
            },
            child: SizedBox(
              width: _leftSidebarWidth,
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Hierarchy'),
                    titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView(
                      children: const [
                        ListTile(
                            leading: Icon(Icons.folder), title: Text('Scene')),
                        ListTile(
                            leading: Icon(Icons.circle),
                            title: Text('Player'),
                            dense: true,
                            contentPadding: EdgeInsets.only(left: 32)),
                        ListTile(
                            leading: Icon(Icons.square),
                            title: Text('Enemy'),
                            dense: true,
                            contentPadding: EdgeInsets.only(left: 32)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[900],
              child: const Center(child: Text('Game View')),
            ),
          ),
          ResizableBar(
            isLeftBar: false,
            width: _rightSidebarWidth,
            onResize: (newWidth) {
              setState(() {
                _rightSidebarWidth = newWidth;
              });
            },
            child: SizedBox(
              width: _rightSidebarWidth,
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Inspector'),
                    titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView(
                      children: const [
                        ListTile(title: Text('Transform')),
                        ListTile(
                            title: Text('Position'),
                            subtitle: Text('X: 0, Y: 0')),
                        ListTile(
                            title: Text('Scale'), subtitle: Text('X: 1, Y: 1')),
                        ListTile(title: Text('Rotation'), subtitle: Text('0°')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Status: Ready'),
            Text('FPS: 60'),
          ],
        ),
      ),
    );
  }
}
