import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';

class blobsbg extends StatelessWidget {
  const blobsbg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -300,
          left: -300,
          child: Blob.animatedRandom(
            size: 800,
            duration: Duration(seconds: 10),
            edgesCount: 6,
            loop: true,
            minGrowth: 6,
            styles: BlobStyles(
                fillType: BlobFillType.fill,
                gradient: RadialGradient(
                  colors: [Colors.blue, Colors.white],
                  radius: 2,
                ).createShader(Rect.fromCenter(
                    center: Offset.zero, width: 800, height: 800))),
          ),
        ),
        Positioned(
          bottom: -200,
          left: -200,
          child: Blob.animatedRandom(
            size: 600,
            duration: Duration(seconds: 10),
            edgesCount: 6,
            loop: true,
            minGrowth: 7,
            styles: BlobStyles(
                fillType: BlobFillType.fill,
                gradient: RadialGradient(
                  colors: [Colors.green, Colors.white],
                  radius: 2,
                ).createShader(Rect.fromCenter(
                    center: Offset.zero, width: 600, height: 600))),
          ),
        ),
        Positioned(
          bottom: 00,
          right: -200,
          child: Blob.animatedRandom(
            size: 600,
            duration: Duration(seconds: 10),
            edgesCount: 6,
            loop: true,
            minGrowth: 7,
            styles: BlobStyles(
                fillType: BlobFillType.fill,
                gradient: RadialGradient(
                  colors: [Colors.red, Colors.white],
                  radius: 2,
                ).createShader(Rect.fromCenter(
                    center: Offset.zero, width: 600, height: 600))),
          ),
        ),
      ],
    );
  }
}
