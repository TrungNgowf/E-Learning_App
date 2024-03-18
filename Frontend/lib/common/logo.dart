import '../utils/export.dart';

class LogoText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;

  const LogoText(this.text, {super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(text,
        maxLines: 1,
        softWrap: false,
        textAlign: TextAlign.center,
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontFamily: GoogleFonts.getFont('Baumans').fontFamily,
            fontSize: size ?? 6.sp,
            color: color ?? Colors.blue,
            fontWeight: FontWeight.w600));
  }
}
