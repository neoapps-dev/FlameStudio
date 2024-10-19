// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ResizableBar extends StatefulWidget {
  final Widget child;
  final bool isLeftBar;
  final double width;
  final Function(double) onResize;

  const ResizableBar({
    super.key,
    required this.child,
    required this.isLeftBar,
    required this.width,
    required this.onResize,
  });

  @override
  _ResizableWidgetState createState() => _ResizableWidgetState();
}

class _ResizableWidgetState extends State<ResizableBar> {
  late double _width;
  final double _minWidth = 100;
  final double _maxWidth = 500;

  @override
  void initState() {
    super.initState();
    _width = widget.width;
  }

  void _handleDrag(DragUpdateDetails details) {
    double newWidth = _width + (widget.isLeftBar ? 1 : -1) * details.delta.dx;
    if (newWidth >= _minWidth && newWidth <= _maxWidth) {
      setState(() {
        _width = newWidth;
      });
      widget.onResize(_width);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!widget.isLeftBar) _buildDragHandle(),
        SizedBox(width: _width, child: widget.child),
        if (widget.isLeftBar) _buildDragHandle(),
      ],
    );
  }

  Widget _buildDragHandle() {
    return GestureDetector(
      onHorizontalDragUpdate: _handleDrag,
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeLeftRight,
        child: Container(
          width: 8,
          color: Colors.grey[800],
          child: Center(
            child: Container(
              width: 2,
              height: 30,
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
