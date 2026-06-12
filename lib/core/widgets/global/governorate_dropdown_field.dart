import 'package:flutter/material.dart';

import '../../location_data/egypt_location_loader.dart';
import 'selection_bottom_sheet.dart';

class GovernorateDropdownField extends StatefulWidget {
  final CityItem? selectedGovernorate;
  final ValueChanged<CityItem?> onChanged;
  final String? validatorText;
  final String? labelText;
  final String? hintText;

  const GovernorateDropdownField({
    super.key,
    this.selectedGovernorate,
    required this.onChanged,
    this.validatorText,
    this.labelText,
    this.hintText,
  });

  @override
  State<GovernorateDropdownField> createState() =>
      _GovernorateDropdownFieldState();
}

class _GovernorateDropdownFieldState
    extends State<GovernorateDropdownField> {
  final _controller = TextEditingController();
  List<CityItem> _governorates = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.selectedGovernorate?.nameEn ?? '';
    _loadGovernorates();
  }

  @override
  void didUpdateWidget(GovernorateDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedGovernorate?.id !=
        widget.selectedGovernorate?.id) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.text = widget.selectedGovernorate?.nameEn ?? '';
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadGovernorates() async {
    setState(() => _isLoading = true);
    final cities = await EgyptLocationLoader.loadCities();
    if (mounted) {
      setState(() {
        _governorates = cities;
        _isLoading = false;
      });
    }
  }

  void _showBottomSheet() {
    final items = _governorates
        .map((g) => SelectionItem(id: g.id, label: g.nameEn))
        .toList();

    showSelectionBottomSheet(
      context: context,
      title: widget.labelText ?? widget.hintText ?? '',
      items: items,
      selectedId: widget.selectedGovernorate?.id,
    ).then((selected) {
      if (selected != null && mounted) {
        final gov = _governorates.firstWhere((g) => g.id == selected.id);
        widget.onChanged(gov);
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
      onTap: _isLoading ? null : _showBottomSheet,
      validator: widget.validatorText != null
          ? (v) => (v == null || v.isEmpty) ? widget.validatorText : null
          : null,
    );
  }
}
