import 'package:flutter/material.dart';
import 'package:pokemon_flutter/utils/constants.dart' as constants;

class StatRowWidget extends StatefulWidget {
  final String statTitle;
  final int statNumber;

  const StatRowWidget({Key? key, required this.statTitle, required this.statNumber}) : super(key: key);

  @override
  State<StatRowWidget> createState() => _StatRowWidgetState();
}

class _StatRowWidgetState extends State<StatRowWidget> {
  bool loadStat = false;

  int maxStatInt(int statNumber) {
    if (statNumber > 100) {
      return 100;
    } else {
      return statNumber;
    }
  }

  Color statColor(int statNumber) {
    if (statNumber <= 50) {
      return Colors.red;
    } else if (statNumber > 50 && statNumber <= 65) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        loadStat = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statNumber = widget.statNumber;
    final statTitle = widget.statTitle;
    double statPercentage = maxStatInt(statNumber) / 100;

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
                width: ('sp. Defence').length * 7,
                child: Text(
                  statTitle,
                  style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),
                )),
            const SizedBox(width: constants.mediumPadding),
            Text(statNumber.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: constants.mediumPadding),
            Expanded(
              child: LayoutBuilder(builder: (_, constraints) {
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: constants.searchContainerLightThemeColor,
                        borderRadius: BorderRadius.circular(200),
                      ),
                      height: 20,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.linear,
                      height: 20,
                      width: loadStat ? statPercentage * constraints.maxWidth : 0,
                      decoration: BoxDecoration(
                        color: statColor(statNumber),
                        borderRadius: BorderRadius.circular(200),
                      ),
                    ),
                  ],
                );
              }),
            )
          ],
        ),
        const SizedBox(height: constants.largePadding),
      ],
    );
  }
}
