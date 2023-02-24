import 'package:commons/commons.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final void Function(String value)? onSubmitSearch;
  const SearchField(
      {super.key, this.focusNode, this.controller, this.onSubmitSearch});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool _show = false;
  late FocusNode _focusNode;
  String _text = '';

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) _close();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.t;

    return LayoutBuilder(
      builder: (ctx, box) {
        return AnimatedContainer(
          width: _show ? box.maxWidth : 36,
          height: 36,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: Decorate.r8,
            border: Border.all(
                width: 1, color: _show ? theme.primary_03 : Colors.transparent),
          ),
          child: TextField(
            onChanged: (value) => _text = value,
            controller: widget.controller,
            focusNode: _focusNode,
            scrollPadding: EdgeInsets.zero,
            decoration: theme.noneTextInput.copyWith(
              contentPadding: Spaces.h10,
              suffixIconConstraints:
                  const BoxConstraints(maxWidth: 36, maxHeight: 36),
              suffixIcon: IconButton(
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      _show = true;
                    });

                    _focusNode.requestFocus();
                  }
                },
                icon: SvgPicture.asset(
                  SvgIcon.search_icon,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _close() {
    if (_text.trim().isEmpty) {
      if (mounted) {
        setState(() {
          _show = false;
        });
      }
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }
}
