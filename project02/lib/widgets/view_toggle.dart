import 'package:flutter/cupertino.dart';

///
/// Custom widget to toggle between list and grid view
/// 
/// @param isListView: current view state
/// @param onToggle: callback function to toggle view
/// @return ToggleViewButtons widget
/// 
/// @author: Jason Chen
/// @version: 1.0.0
/// @since: 2025-03-27
/// 

class ToggleViewButtons extends StatefulWidget {
  final bool isListView;
  final ValueChanged<bool> onToggle;

  const ToggleViewButtons({
    super.key,
    required this.isListView,
    required this.onToggle,
  });

  @override
  State<ToggleViewButtons> createState() => _ToggleViewButtonsState();
}

class _ToggleViewButtonsState extends State<ToggleViewButtons> {
  late bool isListView;

  @override
  void initState() {
    super.initState();
    isListView = widget.isListView;
  }

  void _toggleView(bool value) {
    setState(() => isListView = value);
    widget.onToggle(isListView);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _toggleView(true),
          child: Icon(
            CupertinoIcons.list_bullet,
            color:
                isListView
                    ? CupertinoTheme.of(context).primaryColor
                    : CupertinoColors.systemGrey,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => _toggleView(false),
          child: Icon(
            CupertinoIcons.square_grid_2x2,
            color:
                !isListView
                    ? CupertinoTheme.of(context).primaryColor
                    : CupertinoColors.systemGrey,
          ),
        ),
      ],
    );
  }
}
