import 'package:e_learning_app/utils/export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String label;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;

  const CustomTextField({
    super.key,
    required this.name,
    required this.label,
    this.prefixIcon,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
        name: name,
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              appStyle(size: 14, color: Colors.black, fw: FontWeight.w300),
          contentPadding: const EdgeInsets.all(15),
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
        onChanged: onChanged,
        validator: validator);
  }
}
