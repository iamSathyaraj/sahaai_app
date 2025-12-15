import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/features/worker/home/presentation/providers/worker_status_provider.dart';

class AdvancedSwipeOnlineButton extends StatefulWidget {
  const AdvancedSwipeOnlineButton({super.key});

  @override
  State<AdvancedSwipeOnlineButton> createState() =>
      _AdvancedSwipeOnlineButtonState();
}

class _AdvancedSwipeOnlineButtonState extends State<AdvancedSwipeOnlineButton>
    with SingleTickerProviderStateMixin {
  double _dragPercent = 0; 
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkerStatusProvider>(
      builder: (context, provider, _) {
        if (!_isDragging) {
          _dragPercent = provider.isOnline ? 1 : 0;
        }

        final bgColor = Color.lerp(
          const Color(0xFF37474F), 
          const Color(0xFF2E7D32), 
          _dragPercent,
        )!;

        String label;
        if (provider.isLoading) {
          label = 'Updating status…';
        } else if (provider.isOnline) {
          label = 'Swipe left to go offline';
        } else {
          label = 'Swipe right to go ONLINE';
        }

        return GestureDetector(
          onHorizontalDragStart: provider.isLoading
              ? null
              : (_) {
                  setState(() => _isDragging = true);
                },
          onHorizontalDragUpdate: provider.isLoading
              ? null
              : (details) {
                  final box = context.findRenderObject() as RenderBox?;
                  if (box == null) return;
                  final width = box.size.width;

                  setState(() {
                    _dragPercent += details.delta.dx / width;
                    _dragPercent = _dragPercent.clamp(0.0, 1.0);
                  });

                  final isNowOnline = _dragPercent >= 0.5;
                  if (provider.isOnline != isNowOnline && !provider.isLoading) {
                    provider.setLocalStatus(isNowOnline); 
                  }
                },
          onHorizontalDragEnd: provider.isLoading
              ? null
              : (_) async {
                  final shouldGoOnline = _dragPercent > 0.6;
                  final shouldGoOffline = _dragPercent < 0.4;

                  setState(() => _isDragging = false);

                  if (!provider.isOnline && shouldGoOnline) {
                    await provider.goOnline();
                  } else if (provider.isOnline && shouldGoOffline) {
                    await provider.goOffline();
                  } else {
                     setState(() {
                      _dragPercent = provider.isOnline ? 1 : 0;
                    });
                  }
                },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                colors: [
                  bgColor .withOpacity(0.95),
                  bgColor.withOpacity(0.8),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: bgColor.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    const knobSize = 44.0;
                    final maxOffset = constraints.maxWidth - knobSize - 4;
                    final dx = 2 + maxOffset * _dragPercent;

                    return AnimatedPositioned(
                      duration: _isDragging
                          ? Duration.zero
                          : const Duration(milliseconds: 180),
                      left: dx,
                      curve: Curves.easeOut,
                      child: Container(
                        width: knobSize,
                        height: knobSize,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: provider.isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(10),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(
                                provider.isOnline
                                    ? Icons.power_settings_new
                                    : Icons.arrow_forward_ios_rounded,
                                size: 20,
                                color: provider.isOnline
                                    ? const Color(0xFF2E7D32)
                                    : const Color(0xFF37474F),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
