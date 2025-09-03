
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SubmitAnalysisCard extends StatefulWidget {
  const SubmitAnalysisCard({
    super.key,
    this.onSubmit, // returns (patientName, notes)
  });

  final void Function(String patientName, String notes)? onSubmit;

  @override
  State<SubmitAnalysisCard> createState() => _SubmitAnalysisCardState();
}

class _SubmitAnalysisCardState extends State<SubmitAnalysisCard> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
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
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient Name',
                style: AppStyles.styleRegular13(context)
                    .copyWith(color: labelColor)),
            const SizedBox(height: 8),

            // REQUIRED
            TextFormField(
              controller: _nameCtrl,
              keyboardType: TextInputType.name,
              style: AppStyles.styleRegular17(context),
              decoration: deco('Add The Patient Name'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Field is required' : null,
            ),

            const SizedBox(height: 16),

            Text('Notes',
                style: AppStyles.styleRegular13(context)
                    .copyWith(color: labelColor)),
            const SizedBox(height: 8),

            // OPTIONAL (no validator)
            TextFormField(
              controller: _notesCtrl,
              keyboardType: TextInputType.multiline,
              minLines: 4,
              maxLines: 8,
              style: AppStyles.styleRegular17(context),
              decoration: deco('Add Notes'),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: () {
                  final ok = _formKey.currentState?.validate() ?? false;
                  if (!ok) return;
                  widget.onSubmit?.call(
                    _nameCtrl.text.trim(),
                    _notesCtrl.text.trim(), // may be empty
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
