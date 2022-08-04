import 'package:flutter/material.dart';

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  }) : super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.linear,
      reverseCurve: Curves.easeInOutBack,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() async {
    setState(() {
      _controller.forward();
      _isAnimating = true;
      Future.delayed(const Duration(seconds: 4), () {
        _controller.reverse();
      }).then((value) => setState(() => _isAnimating = false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //    buildTapToCloseFab(),
          _ExpandingActionButton(
            directionInDegrees: 0,
            maxDistance: widget.distance,
            progress: _expandAnimation,
            child: IgnorePointer(
                ignoring: !_isAnimating, child: widget.children[0]),
          ),
          const SizedBox(height: 30),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToOpenFab() {
    return AnimatedContainer(
      // alignment: Alignment.bottomCenter,
      //transformAlignment: Alignment.bottomCenter,
      transform: Matrix4.diagonal3Values(
        _open ? -0.4 : 1.0,
        _open ? -0.4 : 1.0,
        1.0,
      ),
      duration: const Duration(milliseconds: 250),
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      child: AnimatedOpacity(
        opacity: _open ? 0.0 : 1.0,
        curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
        duration: const Duration(milliseconds: 250),
        child: FloatingActionButton(
          heroTag: 'oussaidfab',
          elevation: 12,
          onPressed: _toggle,
          child: const Icon(
            Icons.add_shopping_cart_rounded,
            color: Colors.white,
            // color: Colors.amber,
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        return child!;
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}
