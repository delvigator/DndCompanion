import 'package:dnd/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class FeatureDescription extends StatefulWidget {
  const FeatureDescription({super.key});
  static String routeName = "/featureDescription";
  @override
  State<FeatureDescription> createState() => _FeatureDescriptionState();
}

class _FeatureDescriptionState extends State<FeatureDescription> {
  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    Feature feature = args["tappedFeature"];
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          )),
      body: Padding(
        padding: EdgeInsets.all(20.dp),
        child: Column(
          children: [
            Text(
              feature.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
            SizedBox(height: 4.h,),
            Center(
              child: Text(
                feature.description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: 4.h,),
            Expanded(
                child: ListView(
              children: feature.peculiarities
                  .asMap()
                  .entries
                  .map((e) => Text(
                        "${e.value.text}\n",
                        style: Theme.of(context)
                            .textTheme.bodySmall
                            ?.copyWith(color: Colors.white),
                      ))
                  .toList(),
            ))
          ],
        ),
      ),
    );
  }
}
