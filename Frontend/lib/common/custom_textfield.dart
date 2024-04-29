import 'package:e_learning_app/utils/export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String label;
  final Widget? prefixIcon;
  final String? initialValue;
  final TextEditingController? controller;
  final int? maxLines;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    super.key,
    required this.name,
    required this.label,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.initialValue,
    this.contentPadding = const EdgeInsets.all(15),
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
        name: name,
        enabled: enabled,
        readOnly: readOnly,
        controller: controller,
        initialValue: initialValue,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              appStyle(size: 14, color: Colors.black, fw: FontWeight.w300),
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blueGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.mainBlue),
          ),
          prefixIcon: prefixIcon,
        ),
        maxLines: maxLines,
        onChanged: onChanged,
        validator: validator);
  }
}
