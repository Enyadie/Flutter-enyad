import 'package:enyad_store_3/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class SChoiceChip extends StatelessWidget {
  const SChoiceChip({
    super.key,
    this.onSelected,
    required this.selected,
    required this.text,
  });

  final void Function(bool)? onSelected;
  final bool selected;
  final String text;

  @override
  Widget build(BuildContext context) {
    final isColor = SHelperFunction.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor
            ? const SizedBox()
            : Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: SColors.white),
              ),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? SColors.white : null),
        avatar: isColor
            ? SRoundedContainer(
                width: 50,
                height: 50,
                backgroundColor: SHelperFunction.getColor(text)!)
            : null,
        shape: isColor ? const CircleBorder() : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        padding: const EdgeInsets.all(0),

        ///center the icon
        selectedColor: SHelperFunction.getColor(text),
        backgroundColor: SHelperFunction.getColor(text),
      ),
    );
  }
}
