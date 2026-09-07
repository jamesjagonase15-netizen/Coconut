import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_routes.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({super.key, required this.cameras});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  int _selectedIndex = 0;
  bool _isInitialized = false;
  bool _isTaking = false;
  FlashMode _flashMode = FlashMode.off;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.cameras.isNotEmpty) {
      _initCamera(widget.cameras[0]);
    } else {
      setState(() => _error = 'No cameras found on this device.');
    }
  }

  Future<void> _initCamera(CameraDescription cam) async {
    final ctrl = CameraController(cam, ResolutionPreset.high,
        enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
    _controller = ctrl;
    try {
      await ctrl.initialize();
      if (mounted)
        setState(() {
          _isInitialized = true;
          _error = null;
        });
    } catch (e) {
      if (mounted)
        setState(() {
          _error = e.toString();
          _isInitialized = false;
        });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final ctrl = _controller;
    if (ctrl == null || !ctrl.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      ctrl.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera(widget.cameras[_selectedIndex]);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _switchCamera() async {
    if (widget.cameras.length < 2) return;
    setState(() => _isInitialized = false);
    await _controller?.dispose();
    _selectedIndex = (_selectedIndex + 1) % widget.cameras.length;
    await _initCamera(widget.cameras[_selectedIndex]);
  }

  Future<void> _toggleFlash() async {
    if (_controller == null || !_isInitialized) return;
    final next =
        _flashMode == FlashMode.off ? FlashMode.torch : FlashMode.off;
    await _controller!.setFlashMode(next);
    setState(() => _flashMode = next);
  }

  Future<void> _capturePhoto() async {
    if (_controller == null || !_isInitialized || _isTaking) return;
    setState(() => _isTaking = true);
    try {
      final XFile photo = await _controller!.takePicture();
      if (mounted) {
        Navigator.pushNamed(context, AppRoutes.preview, arguments: photo.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Capture failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _isTaking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(children: [
          if (_isInitialized && _controller != null)
            Positioned.fill(child: CameraPreview(_controller!))
          else if (_error != null)
            Positioned.fill(
              child: Container(
                color: const Color(0xFF111111),
                child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.camera_alt,
                        color: Colors.white24, size: 64),
                    const SizedBox(height: 16),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(_error!,
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(color: Colors.white60)),
                    ),
                  ]),
                ),
              ),
            )
          else
            const Positioned.fill(
              child: Center(
                  child: CircularProgressIndicator(
                      color: Color(0xFF81C784))),
            ),

          // Top bar
          Positioned(
            top: 0, left: 0, right: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.transparent
                  ],
                ),
              ),
              child: Row(children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Text('Camera',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
                IconButton(
                  icon: Icon(
                    _flashMode == FlashMode.off
                        ? Icons.flash_off
                        : Icons.flash_on,
                    color: _flashMode == FlashMode.off
                        ? Colors.white
                        : Colors.yellow,
                  ),
                  onPressed: _toggleFlash,
                ),
                if (widget.cameras.length > 1)
                  IconButton(
                    icon: const Icon(Icons.cameraswitch_outlined,
                        color: Colors.white),
                    onPressed: _switchCamera,
                  ),
              ]),
            ),
          ),

          if (_isInitialized) const Center(child: _ScanFrame()),

          if (_isInitialized)
            Positioned(
              top: 80, left: 20, right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  'Point at coconut leaves, bud, crown, or stem',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),
            ),

          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(32, 20, 32, 36),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.85),
                    Colors.transparent
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 54, height: 54),
                  GestureDetector(
                    onTap: _isTaking ? null : _capturePhoto,
                    child: Container(
                      width: 76, height: 76,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.white, width: 3),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color:
                              _isTaking ? Colors.grey : Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: _isTaking
                            ? const Padding(
                                padding: EdgeInsets.all(16),
                                child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Color(0xFF2E7D32)))
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 54, height: 54),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _ScanFrame extends StatelessWidget {
  const _ScanFrame();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260, height: 260,
      child: CustomPaint(painter: _ScanFramePainter()),
    );
  }
}

class _ScanFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const a = 30.0, r = 8.0;
    final w = size.width, h = size.height;

    canvas.drawPath(
        Path()
          ..moveTo(0, a)
          ..lineTo(0, r)
          ..quadraticBezierTo(0, 0, r, 0)
          ..lineTo(a, 0),
        p);
    canvas.drawPath(
        Path()
          ..moveTo(w - a, 0)
          ..lineTo(w - r, 0)
          ..quadraticBezierTo(w, 0, w, r)
          ..lineTo(w, a),
        p);
    canvas.drawPath(
        Path()
          ..moveTo(0, h - a)
          ..lineTo(0, h - r)
          ..quadraticBezierTo(0, h, r, h)
          ..lineTo(a, h),
        p);
    canvas.drawPath(
        Path()
          ..moveTo(w - a, h)
          ..lineTo(w - r, h)
          ..quadraticBezierTo(w, h, w, h - r)
          ..lineTo(w, h - a),
        p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}


