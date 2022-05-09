import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 滑块
class SlidingBlock extends StatefulWidget {
  /// 当前值在blocks中的索引
  final num value;
  final Color? color;

  /// 可选择的内容块
  final List<String>? blocks;

  const SlidingBlock(
      {Key? key, required this.value, required this.blocks, this.color})
      : super(key: key);

  @override
  _SlidingBlockState createState() => _SlidingBlockState();
}

class _SlidingBlockState extends State<SlidingBlock> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if ((widget.blocks?.length ?? 0) < 2) {
      throw 'blocks的长度不能小于2';
    }
  }

  createBlockWidget() {
    List<Container> list = [];
    for (int i = 0; i < (widget.blocks?.length ?? 0); i++) {
      var block = widget.blocks?[i];
      list.add(
        Container(
            alignment: Alignment.center,
            width: 0.1.sw,
            height: 0.1.sw,
            decoration: const BoxDecoration(color: Colors.black54),
            child: AnimatedSwitcher(
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              duration: const Duration(milliseconds: 500),
              child: Text(
                "$block",
                key: ValueKey(widget.value),
                style: TextStyle(
                    fontWeight:
                        widget.value == i ? FontWeight.w900 : FontWeight.normal,
                    fontSize: widget.value == i ? 32 : 24,
                    color: widget.value == i
                        ? (widget.color ?? Colors.white)
                        : Colors.white12),
              ),
            )),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 0.5.sh - 0.05.sw),
        width: 0.1.sw,
        height: 1.sh,
        child: TweenAnimationBuilder(
          curve: Curves.easeOutCirc,
          duration: const Duration(milliseconds: 1000),
          tween: Tween(end: widget.value.toDouble()),
          builder: (context, value, child) {
            double decimal = 0;
            double whole = (value as double);
            if (value > widget.value.toDouble()) {
              decimal = value - whole.truncate();
              if (decimal == 0) {
                decimal = 1;
              }
            }
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -0.1.sw * (value),
                  child: Container(
                    width: 0.1.sw,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(color: Colors.grey, blurRadius: 0)
                    ]),
                    child: Column(
                      children: createBlockWidget(),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
