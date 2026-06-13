import 'package:flutter/material.dart';

import '../../location_data/egypt_location_loader.dart';
import 'selection_bottom_sheet.dart';

class AreaDropdownField extends StatefulWidget {
  final String? selectedGovernorateId;
  final AreaItem? selectedArea;
  final ValueChanged<AreaItem?> onChanged;
  final String? validatorText;
  final String? labelText;
  final String? hintText;

  const AreaDropdownField({
    super.key,
    this.selectedGovernorateId,
    this.selectedArea,
    required this.onChanged,
    this.validatorText,
    this.labelText,
    this.hintText,
  });

  @override
  State<AreaDropdownField> createState() => _AreaDropdownFieldState();
}

class _AreaDropdownFieldState extends State<AreaDropdownField> {
  final _controller = TextEditingController();
  List<AreaItem> _allAreas = [];
  List<AreaItem> _filteredAreas = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.selectedArea?.nameEn ?? '';
    _loadAreas();
  }

  @override
  void didUpdateWidget(AreaDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedGovernorateId !=
        widget.selectedGovernorateId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _filter();
      });
    }
    if (oldWidget.selectedArea?.id != widget.selectedArea?.id) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.text = widget.selectedArea?.nameEn ?? '';
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadAreas() async {
    setState(() => _isLoading = true);
    final areas = await EgyptLocationLoader.loadAreas();
    if (mounted) {
      setState(() {
        _allAreas = areas;
        _isLoading = false;
        _filter();
      });
    }
  }

  void _filter() {
    if (widget.selectedGovernorateId == null) {
      _filteredAreas = [];
    } else {
      _filteredAreas = _allAreas
          .where((a) => a.cityId == widget.selectedGovernorateId)
          .toList();
    }
    if (mounted) setState(() {});
  }

  bool get _enabled =>
      widget.selectedGovernorateId != null && !_isLoading;

  void _showBottomSheet() {
    final items = _filteredAreas
        .map((a) => SelectionItem(id: a.id, label: a.nameEn))
        .toList();

    showSelectionBottomSheet(
      context: context,
      title: widget.labelText ?? widget.hintText ?? '',
      items: items,
      selectedId: widget.selectedArea?.id,
    ).then((selected) {
      if (selected != null && mounted) {
        final area = _filteredAreas.firstWhere((a) => a.id == selected.id);
        widget.onChanged(area);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : const Icon(Icons.keyboard_arrow_down),
      ),
      onTap: _enabled ? _showBottomSheet : null,
      validator: widget.validatorText != null
          ? (v) => (v == null || v.isEmpty) ? widget.validatorText : null
          : null,
    );
  }
}
