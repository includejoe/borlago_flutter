import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key, required
    this.cameraController,
    required this.initCamera
  });

  final CameraController? cameraController;
  final Future<void> Function({required bool frontCamera}) initCamera;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _isFrontCamera = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        widget.cameraController == null ?
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue,
          ),
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Center(
            child: Text(
              "CAMERA SCREEN",
              style: theme.textTheme.headlineMedium,
            ),
          ),
        ) : GestureDetector(
          onDoubleTap: () {
            _isFrontCamera = !_isFrontCamera;
            widget.initCamera(frontCamera: _isFrontCamera);
          },
          child: Builder(
            builder: (BuildContext context) {
              var camera = widget.cameraController!.value;
              final fullSize = MediaQuery.of(context).size;
              final size = Size(fullSize.width, fullSize.height - (Platform.isIOS ? 90 : 60));
              double scale;

              try {
                scale = size.aspectRatio * camera.aspectRatio;
              } catch(_) {
                scale = 1;
              }

              if(scale < 1) scale = 1 / scale;
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Transform.scale(
                  scale: scale,
                  child: Center(
                    child: CameraPreview(widget.cameraController!)
                  ),
                ),
              );
            },
          )
        ),
        const Positioned(
          bottom: 15,
          child: InkWell(
            child: Icon(
              CupertinoIcons.camera_circle,
              size: 100,
              color: Colors.white,
            ),
          )
        )
      ],
    );
  }
}
