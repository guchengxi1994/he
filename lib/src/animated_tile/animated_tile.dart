import 'package:flutter/material.dart';
import 'package:he/src/animated_tile/tile_state.dart';

class AnimatedTile extends StatefulWidget {
  const AnimatedTile(
      {super.key,
      required this.title,
      this.description,
      this.color = Colors.blueAccent,
      this.icon = const Icon(Icons.abc),
      this.height = 150,
      this.width = 200,
      this.onTap});
  final String title;
  final String? description;
  final Color color;
  final Widget icon;
  final double width;
  final double height;
  final VoidCallback? onTap;

  @override
  State<AnimatedTile> createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<AnimatedTile> {
  late final ValueNotifier<TileState> _tileState = ValueNotifier(TileState());
  final double maxAngle = 0.15; // 最大旋转角度（弧度）

  @override
  void dispose() {
    _tileState.dispose();
    super.dispose();
  }

  void _updateRotation(Offset position, Size size) {
    double dx = (position.dx - size.width / 2) / (size.width / 2); // -1 ~ 1
    double dy = (position.dy - size.height / 2) / (size.height / 2); // -1 ~ 1

    // 计算旋转角度，映射到 [-maxAngle, maxAngle]
    double newXRotation = dy * -maxAngle;
    double newYRotation = dx * maxAngle;
    TileState newState = _tileState.value.copyWith(
      xRotation: newXRotation, // 控制前后倾斜
      yRotation: newYRotation, // 控制左右倾斜
    );
    if (_tileState.value != newState) {
      _tileState.value = newState;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _tileState,
      builder: (c, s, _) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (event) {
            _tileState.value = TileState(showIcon: true);
          },
          onHover: (event) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            final Offset localPosition = box.globalToLocal(event.position);
            _updateRotation(localPosition, box.size);
          },
          onExit: (_) => _tileState.value = TileState(),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015) // 透视效果
              ..rotateX(s.xRotation)
              ..rotateY(s.yRotation),
            child: GestureDetector(
              onTap: () {
                widget.onTap?.call();
              },
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(-s.yRotation * 20, s.xRotation * 20),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: Duration(milliseconds: 300),
                      alignment:
                          s.showIcon ? Alignment.topLeft : Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          widget.title,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 40,
                      child: AnimatedOpacity(
                        opacity: s.showIcon ? 1 : 0,
                        duration: Duration(milliseconds: 300),
                        child: SizedBox(
                          width: 180,
                          child: Text(
                            widget.description ?? "",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                            maxLines: 4,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    if (s.showIcon)
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: widget.icon,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double iconSize = 18;
  Color iconColor = Colors.white;
}
