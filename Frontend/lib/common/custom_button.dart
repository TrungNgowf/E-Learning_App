import '../common/export.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Widget? child;
  final double? height;
  final double? width;
  final Color? backGroundColor;
  final Border? border;
  final Color? textColor;
  final List<BoxShadow>? boxShadow;
  final void Function()? onTap;

  const CustomButton(
      {super.key,
      this.text,
      this.child,
      this.height,
      this.width,
      this.backGroundColor,
      this.border,
      this.onTap,
      this.fontSize,
      this.textColor,
      this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 3,
          child: Container(
            padding: EdgeInsets.all(2.swp),
            width: width ?? 30.swp,
            height: height ?? 5.shp,
            decoration: BoxDecoration(
                color: backGroundColor ?? Colors.white,
                border: border,
                borderRadius: BorderRadius.circular(10),
                boxShadow: boxShadow),
            child: Center(
              child: child ??
                  ReusableText(
                    text ?? "",
                    style: appStyle(
                        color: textColor ?? Colors.black,
                        size: fontSize ?? 15,
                        fw: FontWeight.w600),
                  ),
            ),
          ),
        ));
  }
}
