import 'package:flutter/material.dart';
class NumberPainter extends CustomPainter {
  final Color color;
  final double percentAnimated;
  final int number;
  var paddingHeight,paddingWidth,
    strokeWidth,centerPaddingHorizontal;

  NumberPainter(this.percentAnimated, this.number, this.color) : 
    assert(percentAnimated >= 0 && percentAnimated <= 1);

  @override
  void paint(Canvas canvas, Size size) {
    paddingHeight = size.height*0.18;
    paddingWidth = size.width*0.1;
    strokeWidth = size.width*0.1;
    centerPaddingHorizontal = size.width*0.05;
    
    _drawLightBox(canvas,size);
    _drawRight(canvas, size ,number<10 ? 0 : int.parse(number.toString()[0]) );
    _drawLeft(canvas, size , number<10 ? int.parse(number.toString()[0]) : int.parse(number.toString()[1]));
    
  }
    
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  _drawRight(Canvas canvas, Size size , int num, {Color color}){
    Rect leftBox = Rect.fromLTWH((size.width/2)-strokeWidth-centerPaddingHorizontal, paddingHeight, strokeWidth, size.height-2*paddingHeight);
    Rect rightBox = Rect.fromLTWH(paddingWidth, paddingHeight, strokeWidth, size.height-2*paddingHeight);

    leftBox = _applyTopHalfHeight(leftBox, num, true);
    rightBox = _applyTopHalfHeight(rightBox, num, false);

    leftBox = _applyBottomHalfHeight(leftBox, num, true);
    rightBox = _applyBottomHalfHeight(rightBox, num, false);
    // Right Bar
    canvas.drawRect(rightBox, _rightPaint(num));
    // Left Bar
    canvas.drawRect(leftBox, _leftPaint(num));
    // Top Bar
    canvas.drawRect(Rect.fromLTWH(paddingWidth + (size.width/2*percentAnimated), paddingHeight, size.width/2 - centerPaddingHorizontal - paddingWidth, strokeWidth), _topPaint(num));
    // Middle Bar
    canvas.drawRect(Rect.fromLTWH(paddingWidth -(size.width/2*percentAnimated), size.height/2-strokeWidth/2, size.width/2 - centerPaddingHorizontal - paddingWidth, strokeWidth), _middlePaint(num));
    // Bottom Bar
    canvas.drawRect(Rect.fromLTWH(paddingWidth +(size.width/2*percentAnimated), size.height -strokeWidth-paddingHeight, size.width/2 - centerPaddingHorizontal - paddingWidth, strokeWidth), _bottomPaint(num));

  }
    
  _drawLeft(Canvas canvas, Size size, int num){
    
    var leftPos = size.width/2 + centerPaddingHorizontal;
    
    var leftBox = Rect.fromLTWH(size.width - paddingWidth-strokeWidth, paddingHeight+(size.height * percentAnimated), strokeWidth, size.height-2*paddingHeight);
    var rightBox = Rect.fromLTWH( leftPos, paddingHeight-(size.height * percentAnimated), strokeWidth, size.height-2*paddingHeight); 
    

    leftBox = _applyTopHalfHeight(leftBox, num, true);
    rightBox = _applyTopHalfHeight(rightBox, num, false);
    
    leftBox = _applyBottomHalfHeight(leftBox, num, true);
    rightBox = _applyBottomHalfHeight(rightBox, num, false);
    // Left Bar
    canvas.drawRect(leftBox, _leftPaint(num));
    // Right bar
    canvas.drawRect(rightBox, _rightPaint(num));
    // Top Bar
    canvas.drawRect(Rect.fromLTWH(leftPos +(size.width/2*percentAnimated), paddingHeight, size.width/2 - centerPaddingHorizontal - paddingWidth, strokeWidth), _topPaint(num));
    // Middle Bar
    canvas.drawRect(Rect.fromLTWH(leftPos -(size.width*percentAnimated), size.height/2-strokeWidth/2, size.width/2 - centerPaddingHorizontal - paddingWidth, strokeWidth), _middlePaint(num));
    // Bottom Bar
    canvas.drawRect(Rect.fromLTWH(leftPos +(size.width/2*percentAnimated), size.height -strokeWidth-paddingHeight, size.width/2 - centerPaddingHorizontal - paddingWidth, strokeWidth), _bottomPaint(num));

  }
  Rect _applyBottomHalfHeight(Rect rect ,int num , bool isLeftBar){
    if(isLeftBar){// For Left Bar
      if(num == 5 || num == 6)
        return _getBottomHalf(rect);
      else 
        return rect;
    }else{// For Right Bar
      if(num == 2)
        return _getBottomHalf(rect);
      else 
        return rect;
    }
  }
  Rect _applyTopHalfHeight(Rect rect ,int num , bool isLeftBar){
    if(isLeftBar){// For Left Bar
      if(num == 2)
        return _getTopHalf(rect);
      else 
        return rect;
    }else{// For Right Bar
      if(num == 4 || num == 5 ||num == 9 )
        return _getTopHalf(rect);
      else 
        return rect;
    }
  }
  Rect _getTopHalf(Rect rect){
    return Rect.fromLTWH(rect.left, rect.top, rect.width, rect.height/2);
  }
  Rect _getBottomHalf(Rect rect){
    return Rect.fromLTWH(rect.left, rect.top+rect.height/2, rect.width, rect.height/2);
  }
  Paint _leftPaint(int number){
    return Paint()..color = color.withOpacity(1-percentAnimated);
  }
  Paint _rightPaint(int number){
    if(number != 1 && number != 3 && number != 7)
      return Paint()..color = color.withOpacity(1-percentAnimated);
    else
      return Paint()..color = Colors.transparent;
  }
  Paint _topPaint(int number){
    if(number != 1 && number != 4)
      return Paint()..color = color.withOpacity(1-percentAnimated);
    else
      return Paint()..color = Colors.transparent;
  }

  Paint _middlePaint(int number){
    if(number != 0 && number != 1 && number != 7)
      return Paint()..color = color.withOpacity(1-percentAnimated);
    else
      return Paint()..color = Colors.transparent;
  }
  Paint _bottomPaint(int number){
    if(number != 1 && number != 4 && number != 7)
      return Paint()..color = color.withOpacity(1-percentAnimated);
    else
      return Paint()..color = Colors.transparent;
  }

  _drawLightBox(Canvas canvas, Size size){
    
    var leftPos = size.width/2 + centerPaddingHorizontal;

    Rect leftBox = Rect.fromLTWH(paddingWidth, paddingHeight, size.width/2 - centerPaddingHorizontal - paddingWidth, size.height-2*paddingHeight);
    Rect rightBox = Rect.fromLTWH( leftPos, paddingHeight, size.width/2 - centerPaddingHorizontal - paddingWidth, size.height-2*paddingHeight); 
    
    var paint = Paint()..color = Colors.white.withOpacity(0.05);
    canvas.drawRect(leftBox,paint);
    canvas.drawRect(rightBox,paint);
    
  }
}