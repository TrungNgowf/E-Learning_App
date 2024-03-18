import '../utils/export.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;

  const ReusableText(this.text,
      {super.key, this.style, this.textAlign, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(text,
        textAlign: textAlign ?? TextAlign.center,
        maxLines: maxLines ?? 1,
        overflow: TextOverflow.fade,
        style: style ??
            appStyle(size: 4, color: Colors.black, fw: FontWeight.normal));
  }
}

TextStyle appStyle({double? size, Color? color, FontWeight? fw}) {
  return GoogleFonts.lexend(
      fontSize: size == null ? 13.sp : size.sp,
      color: color ?? Colors.black,
      fontWeight: fw ?? FontWeight.normal);
}
