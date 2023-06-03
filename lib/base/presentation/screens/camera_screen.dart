import 'dart:io';
import 'package:borlago/feature_wcr/presentation/screens/create_wcr_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
    required this.controller,
    required this.initCamera
  });

  final CameraController controller;
  final Future<void> Function() initCamera;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  XFile? _imageFile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // TODO: Add flashlight to camera


    return Stack(
      alignment: Alignment.center,
      children: [
        _imageFile == null ? Builder(
          builder: (BuildContext context) {
            var camera = widget.controller.value;
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
                  child: CameraPreview(widget.controller)
                ),
              ),
            );
          },
        ) : Image.file(File(_imageFile!.path)),

        _imageFile == null ? Positioned(
          bottom: 15,
          child: InkWell(
            onTap: () async {
              try {
                final image = await widget.controller.takePicture();
                setState(() {
                  _imageFile = image;
                });

              } catch(error) {
                print("Taking picture error: $error");
              }
            },
            child: const Icon(
              CupertinoIcons.camera_circle,
              size: 100,
              color: Colors.white,
            ),
          )
        ) : Positioned(
            bottom: 15,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            _imageFile = null;
                          });
                        },
                        child: const Icon(
                          CupertinoIcons.xmark_circle_fill,
                          size: 60,
                          color: Colors.red,
                        )
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  CreateWCRScreen(imageFile: _imageFile!)
                            )
                        );
                      },
                      child: const Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        size: 60,
                        color: Colors.green,
                      )
                    ),
                  ],
                ),
              ),
            )
        )
      ],
    );
  }
}
