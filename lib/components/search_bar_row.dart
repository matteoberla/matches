import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matches/components/rounded_text_field.dart';
import 'package:matches/controllers/components_handlers/search_bar_row_handlers/search_bar_row_callback.dart';

class SearchBarRow extends StatefulWidget {
  const SearchBarRow(
      {super.key,
      required this.label,
      required this.searchBarTextController,
      this.onSearch,
      this.onChanged,
      this.onClear,
      this.showScanButton = true,
      this.onScanned,
      required this.focusNode,
      this.forcedKeyboardText = false,
      this.forcedKeyboardNone = false,
      this.autofocus = true});

  final String label;
  final TextEditingController searchBarTextController;
  final VoidCallback? onSearch;
  final Function(String)? onChanged;
  final VoidCallback? onClear;
  final bool showScanButton;
  final VoidCallback? onScanned;
  final FocusNode focusNode;
  final bool forcedKeyboardText;
  final bool forcedKeyboardNone;
  final bool autofocus;

  @override
  State<SearchBarRow> createState() => _SearchBarRowState();
}

class _SearchBarRowState extends State<SearchBarRow> {
  final SearchBarRowCallback searchBarRowCallback = SearchBarRowCallback();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                widget.focusNode.requestFocus();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: RoundedTextField(
                  label: widget.label,
                  hintText: "Inserisci",
                  controller: widget.searchBarTextController,
                  onChanged: widget.onChanged,
                  onSearch: widget.onSearch,
                  focusNode: widget.focusNode,
                  onKey: (event) {
                    searchBarRowCallback.onKey(
                        event, widget.searchBarTextController, widget.onSearch);
                  },
                  onClearPressed: () {
                    widget.searchBarTextController.clear();
                    if (widget.onClear != null) {
                      widget.onClear!();
                    }
                  },
                  forcedKeyboardText: widget.forcedKeyboardText,
                  forcedKeyboardNone: widget.forcedKeyboardNone,
                  autofocus: widget.autofocus,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onSearch,
            icon: const Icon(Icons.search),
          ),
          Visibility(
            visible: widget.showScanButton,
            child: IconButton(
              onPressed: widget.onScanned,
              icon: const Icon(CupertinoIcons.barcode),
            ),
          ),
        ],
      ),
    );
  }
}
