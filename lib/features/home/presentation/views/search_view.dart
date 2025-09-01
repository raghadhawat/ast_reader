import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_text_form_field.dart';
import 'package:ast_reader/features/home/presentation/views/widgets/date_choose_chip.dart';
import 'package:ast_reader/features/home/presentation/views/widgets/result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  DateTime? _selectedDate; // <- saved here

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        // optional: minor theming of the calendar
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: kPrimaryColor, // if you have one; else remove
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
      // use _selectedDate wherever you need (filter API, etc.)
    }
  }

  String _dateLabel() {
    if (_selectedDate == null) return 'choose a date';
    final y = _selectedDate!.year.toString().padLeft(4, '0');
    final m = _selectedDate!.month.toString().padLeft(2, '0');
    final d = _selectedDate!.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Center(child: SvgPicture.asset(Assets.imagesBlueLogo)),
          const Gap(23),

          // search
          CustomTextFormField(
            isBorder: true,
            icon: Icon(Icons.search, color: kGreyColor),
            hintText: 'put the patient name',
            onTap: () {},
          ),

          const Gap(18),

          // date chooser chip (wraps to content)
          DateChooseChip(
            label: _dateLabel(),
            onTap: _pickDate,
          ),

          const Gap(22),
          Text(
            'The Results',
            style: AppStyles.arialBold(context, 21),
          ),
          Gap(18),
          // results
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ResultCard(
                name: 'John Doe',
                dateText: '2025-8-25 . 14:25',
                statusText: 'Confusing',
                avatar: Assets.imagesTestCard,
                onDownload: () {},
              ),
              separatorBuilder: (context, index) => const Gap(18),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
