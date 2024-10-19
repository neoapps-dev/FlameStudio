// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class FlameStudioEditor extends StatefulWidget {
  const FlameStudioEditor({super.key});

  @override
  _FlameStudioEditorState createState() => _FlameStudioEditorState();
}

class _FlameStudioEditorState extends State<FlameStudioEditor>
    with SingleTickerProviderStateMixin {
  final double _leftSidebarWidth = 250;
  final double _rightSidebarWidth = 300;
  late TabController _tabController;
  final List<GameObjectWidget> _gameObjects = [];
  GameObjectWidget? _selectedObject;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addGameObject(GameObjectType type) {
    late final GameObjectWidget newObject;

    newObject = GameObjectWidget(
      key: UniqueKey(),
      type: type,
      position: const Offset(100, 100),
      onTap: () {
        _selectObject(newObject);
      },
    );

    setState(() {
      _gameObjects.add(newObject);
      _selectedObject = newObject;
    });
  }

  void _selectObject(GameObjectWidget? object) {
    setState(() {
      _selectedObject = object;
    });
  }

  void _updateObjectPosition(Offset newPosition) {
    if (_selectedObject != null) {
      setState(() {
        _selectedObject = _selectedObject!.copyWith(position: newPosition);
        final index =
            _gameObjects.indexWhere((obj) => obj.key == _selectedObject!.key);
        if (index != -1) {
          _gameObjects[index] = _selectedObject!;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flame Studio',
            style: TextStyle(fontFamily: 'RobotoMono')),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
              tooltip: 'New Project'),
          IconButton(
              icon: const Icon(Icons.folder_open),
              onPressed: () {},
              tooltip: 'Open Project'),
          IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {},
              tooltip: 'Run Game'),
          IconButton(
              icon: const Icon(Icons.stop),
              onPressed: () {},
              tooltip: 'Stop Game'),
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {},
              tooltip: 'Save Project'),
        ],
      ),
      body: Column(
        children: [
          _buildToolbar(),
          Expanded(
            child: Row(
              children: [
                _buildLeftSidebar(),
                Expanded(
                  child: _buildCentralArea(),
                ),
                _buildRightSidebar(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildToolbar() {
    return Container(
      height: 40,
      color: Colors.grey[800],
      child: Row(
        children: [
          IconButton(
              icon: const Icon(Icons.pan_tool),
              onPressed: () {},
              tooltip: 'Select'),
          IconButton(
            icon: const Icon(Icons.crop_square),
            onPressed: () => _addGameObject(GameObjectType.rectangle),
            tooltip: 'Create Rectangle',
          ),
          IconButton(
            icon: const Icon(Icons.circle),
            onPressed: () => _addGameObject(GameObjectType.circle),
            tooltip: 'Create Circle',
          ),
        ],
      ),
    );
  }

  Widget _buildLeftSidebar() {
    return Container(
      width: _leftSidebarWidth,
      color: Colors.grey[900],
      child: Column(
        children: [
          const ListTile(
            title: Text('Hierarchy',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView(
              children: [
                ExpansionTile(
                  leading: const Icon(Icons.folder),
                  title: const Text('Scene'),
                  children: [
                    for (final object in _gameObjects)
                      ListTile(
                        leading: object.type == GameObjectType.rectangle
                            ? const Icon(Icons.square)
                            : const Icon(Icons.circle),
                        title: Text(object.type == GameObjectType.rectangle
                            ? 'Rectangle'
                            : 'Circle'),
                        dense: true,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCentralArea() {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Game View'),
            Tab(text: 'Code Editor'),
            Tab(text: 'Asset Manager'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildGameView(),
              _buildCodeEditor(),
              _buildAssetManager(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGameView() {
    return GestureDetector(
      onPanUpdate: (details) => _updateObjectPosition(details.localPosition),
      child: Container(
        color: Colors.grey[800],
        child: Stack(
          children: _gameObjects,
        ),
      ),
    );
  }

  Widget _buildCodeEditor() {
    return Container(
      color: Colors.grey[800],
      child: const Center(
        child: Text('Code Editor'),
      ),
    );
  }

  Widget _buildAssetManager() {
    return Container(
      color: Colors.grey[800],
      child: const Center(
        child: Text('Asset Manager'),
      ),
    );
  }

  Widget _buildRightSidebar() {
    return Container(
      width: _rightSidebarWidth,
      color: Colors.grey[900],
      child: Column(
        children: [
          const ListTile(
            title: Text('Inspector',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView(
              children: [
                if (_selectedObject != null)
                  ListTile(
                    leading: _selectedObject!.type == GameObjectType.rectangle
                        ? const Icon(Icons.square)
                        : const Icon(Icons.circle),
                    title: Text(
                        _selectedObject!.type == GameObjectType.rectangle
                            ? 'Rectangle'
                            : 'Circle'),
                    dense: true,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 40,
      color: Colors.grey[800],
      child: const Row(
        children: [
          Text('Project: idk tbh', style: TextStyle(fontSize: 12)),
          Spacer(),
          Text('Scene: That scene down the street',
              style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

enum GameObjectType { rectangle, circle }

class GameObjectWidget extends StatelessWidget {
  final GameObjectType type;
  final Offset position;
  final VoidCallback onTap;

  const GameObjectWidget({
    super.key,
    required this.type,
    required this.position,
    required this.onTap,
  });

  GameObjectWidget copyWith({Offset? position}) {
    return GameObjectWidget(
      type: type,
      position: position ?? this.position,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onTap: onTap,
        child: type == GameObjectType.rectangle
            ? Container(
                width: 50,
                height: 50,
                color: Colors.red,
              )
            : Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
      ),
    );
  }
}
