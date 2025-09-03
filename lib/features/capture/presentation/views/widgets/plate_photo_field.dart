// ------------------ PlatePhotoField ------------------

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PlatePhotoField extends StatefulWidget {
  const PlatePhotoField({
    super.key,
    this.onPicked, // ⬅️ callback with File
  });

  final ValueChanged<File>? onPicked;

  @override
  State<PlatePhotoField> createState() => _PlatePhotoFieldState();
}

class _PlatePhotoFieldState extends State<PlatePhotoField> {
  final _picker = ImagePicker();
  XFile? _selectedImage;

  Future<void> _showPickSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading:
                  const Icon(Icons.photo_library, color: Color(0xff234F68)),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                final img = await _picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 92,
                  maxWidth: 3000,
                );
                if (!mounted) return;
                Navigator.pop(ctx); // close sheet
                if (img != null) {
                  setState(() => _selectedImage = img);
                  widget.onPicked?.call(File(img.path)); // ⬅️ callback here
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xff234F68)),
              title: const Text('Take a Photo'),
              onTap: () async {
                final img = await _picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 92,
                  maxWidth: 3000,
                );
                if (!mounted) return;
                Navigator.pop(ctx); // close sheet
                if (img != null) {
                  setState(() => _selectedImage = img);
                  widget.onPicked?.call(File(img.path)); // ⬅️ callback here
                }
              },
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  void _clearPhoto() {
    setState(() => _selectedImage = null);
    // (optional) notify parent that it was cleared:
    // widget.onPicked?.call(File('')); // or create an onCleared callback if you prefer
  }

  @override
  Widget build(BuildContext context) {
    const radius = 16.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _showPickSheet,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 11,
                  child: _selectedImage == null
                      ? Container(
                          color: const Color(0xFFEDEDED),
                          alignment: Alignment.center,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add_a_photo_outlined,
                                  size: 32, color: Colors.black45),
                              SizedBox(height: 6),
                              Text('Tap to add photo',
                                  style: TextStyle(color: Colors.black45)),
                            ],
                          ),
                        )
                      : Image.file(
                          File(_selectedImage!.path),
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Row(
                    children: [
                      if (_selectedImage != null)
                        InkWell(
                          onTap: _clearPhoto,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.50),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: _showPickSheet,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.55),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Change',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
