// submit_analysis_card.dart
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';
import 'package:ast_reader/core/widgets/loading_button.dart';
import 'package:flutter/material.dart';

class SubmitAnalysisCard extends StatefulWidget {
  const SubmitAnalysisCard({
    super.key,
    this.onSubmit, // (firstName, lastName, number, notes)
    this.isLoading = false, // <-- NEW
  });

  final void Function(
      String firstName, String lastName, String number, String notes)? onSubmit;
  final bool isLoading; // <-- NEW

  @override
  State<SubmitAnalysisCard> createState() => _SubmitAnalysisCardState();
}

class _SubmitAnalysisCardState extends State<SubmitAnalysisCard> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _numberCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _numberCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const fieldFill = Color(0xFFEDEDED);
    const labelColor = Colors.black87;
    final hintStyle =
        AppStyles.styleRegular13(context).copyWith(color: Colors.black45);

    InputDecoration deco(String hint) => InputDecoration(
          hintText: hint,
          hintStyle: hintStyle,
          filled: true,
          fillColor: fieldFill,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
              color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 6))
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Name row
            Text('Patient Name',
                style: AppStyles.styleRegular13(context)
                    .copyWith(color: labelColor)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstNameCtrl,
                    keyboardType: TextInputType.name,
                    style: AppStyles.styleRegular17(context),
                    decoration: deco('First name'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _lastNameCtrl,
                    keyboardType: TextInputType.name,
                    style: AppStyles.styleRegular17(context),
                    decoration: deco('Last name'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ---- Number
            Text('Patient Number',
                style: AppStyles.styleRegular13(context)
                    .copyWith(color: labelColor)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _numberCtrl,
              keyboardType: TextInputType.number,
              style: AppStyles.styleRegular17(context),
              decoration: deco('Add number'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),

            const SizedBox(height: 16),

            // ---- Notes (optional)
            Text('Notes',
                style: AppStyles.styleRegular13(context)
                    .copyWith(color: labelColor)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _notesCtrl,
              keyboardType: TextInputType.multiline,
              minLines: 4,
              maxLines: 8,
              style: AppStyles.styleRegular17(context),
              decoration: deco('Add Notes'),
            ),

            const SizedBox(height: 18),

            // ---- Button / Loading
            SizedBox(
              width: double.infinity,
              child: widget.isLoading
                  ? const ButtonLoading(
                      width: double.infinity,
                      height: 48,
                      color: Color(0xFF1C6E70),
                    )
                  : CustomButton(
                      onPressed: () {
                        final ok = _formKey.currentState?.validate() ?? false;
                        if (!ok) return;
                        widget.onSubmit?.call(
                          _firstNameCtrl.text.trim(),
                          _lastNameCtrl.text.trim(),
                          _numberCtrl.text.trim(),
                          _notesCtrl.text.trim(),
                        );
                      },
                      text: Center(
                        child: Text(
                          'Submit For Analysis',
                          style: AppStyles.arialBold(context, 17)
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
