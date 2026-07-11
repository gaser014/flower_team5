import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapMarkerFactory {
  static const double _scale = 3.0;

  static Future<BitmapDescriptor> svgMarker({
    required String assetPath,
    double size = 48,
    double rotationDegrees = 0,
  }) async {
    final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetPath), null);
    try {
      final double width = size * _scale;
      final double height =
          size * _scale * (pictureInfo.size.height / pictureInfo.size.width);

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final scale = width / pictureInfo.size.width;

      canvas.translate(width / 2, height / 2);
      canvas.rotate(rotationDegrees * math.pi / 180);
      canvas.scale(scale);
      canvas.translate(
        -pictureInfo.size.width / 2,
        -pictureInfo.size.height / 2,
      );
      canvas.drawPicture(pictureInfo.picture);

      final image = await recorder.endRecording().toImage(
        width.ceil(),
        height.ceil(),
      );
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

      return BitmapDescriptor.bytes(bytes, imagePixelRatio: _scale);
    } finally {
      pictureInfo.picture.dispose();
    }
  }

  static Future<BitmapDescriptor> pillMarker({
    required String label,
    required IconData icon,
    Color background = AppColors.primerColor,
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    const double height = 26;
    const double badge = 20;
    const double hPad = 4;
    const double gap = 4;
    const double fontSize = 11;

    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize * _scale,
          fontWeight: FontWeight.w400,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final double width =
        (hPad + badge + gap) * _scale + textPainter.width + hPad * _scale;
    final double totalHeight = height * _scale;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width, totalHeight),
      Radius.circular(totalHeight / 2),
    );
    canvas.drawRRect(rrect, Paint()..color = background);

    final double badgeRadius = (badge * _scale) / 2;
    final Offset badgeCenter = Offset(
      hPad * _scale + badgeRadius,
      totalHeight / 2,
    );
    canvas.drawCircle(badgeCenter, badgeRadius, Paint()..color = Colors.white);

    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 12 * _scale,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: background,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    iconPainter.paint(
      canvas,
      Offset(
        badgeCenter.dx - iconPainter.width / 2,
        badgeCenter.dy - iconPainter.height / 2,
      ),
    );

    textPainter.paint(
      canvas,
      Offset(
        (hPad + badge + gap) * _scale,
        (totalHeight - textPainter.height) / 2,
      ),
    );

    final picture = recorder.endRecording();
    final image = await picture.toImage(width.ceil(), totalHeight.ceil());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.bytes(bytes, imagePixelRatio: _scale);
  }
}
