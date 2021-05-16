import 'dart:math';

import 'package:extrac_app/Services/querying.dart';
import 'package:extrac_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PieChartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double total = 0;
    kCategoriesList.forEach((element) => total += element.amount);
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, constraint) => Container(
          decoration: BoxDecoration(
              color: kSecondaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 17,
                  offset: Offset(-5, -5),
                  color: Colors.white,
                ),
                BoxShadow(
                  spreadRadius: -2,
                  blurRadius: 10,
                  offset: Offset(7, 7),
                  color: kNeumorphicColor,
                ),
              ]),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: constraint.maxWidth * 0.7,
                  child: CustomPaint(
                    child: Center(),
                    foregroundPainter: PieChart(
                        width: constraint.maxWidth * 0.4,
                        categories: kCategoriesList),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: constraint.maxWidth * 0.5,
                  decoration: BoxDecoration(
                      color: kSecondaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          offset: Offset(-1, -1),
                          color: Colors.white,
                        ),
                        BoxShadow(
                          spreadRadius: -2,
                          blurRadius: 10,
                          offset: Offset(5, 5),
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ]),
                  child: Center(
                    child: TotalMonthlyExpenses(
                      style: kLabelStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PieChart extends CustomPainter {
  PieChart({@required this.categories, @required this.width});

  final List<Category> categories;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;
    double total = 0;
    categories.forEach((expense) => total += expense.amount);
    double startRadian = -pi / 2;
    for (var index = 0; index < categories.length; index++) {
      final currentCategory = categories.elementAt(index);
      final sweepRadian = currentCategory.amount / total * 2 * pi;
      paint.color = kCategoriesColors.elementAt(index % categories.length);
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          startRadian, sweepRadian, false, paint);
      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Category {
  Category(this.name, {@required this.amount});
  final String name;
  final double amount;
}
