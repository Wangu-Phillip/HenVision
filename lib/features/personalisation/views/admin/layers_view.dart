import 'package:flutter/material.dart';

import '../../../../utils/charts/layers_chart.dart';

class LayersView extends StatefulWidget {
  const LayersView({super.key});

  @override
  State<LayersView> createState() => _LayersViewState();
}

class _LayersViewState extends State<LayersView> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: [

              LayersChart(),

            ],
          ),
        ),
      ),
    );
  }
}
