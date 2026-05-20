import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tawjihi_new/core/utils/constants.dart';
import 'package:tawjihi_new/core/widgets/loading_widget.dart';
import 'package:tawjihi_new/core/widgets/persistent_app_bar.dart';
import 'package:tawjihi_new/features/profile/controller/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = ProfileController.to;

  late String _selectedTrack;
  late String _selectedGov;
  late bool _canTravel;
  late List<String> _selectedPrograms;
  late List<String> _selectedChannels;

  @override
  void initState() {
    super.initState();
    _selectedTrack = controller.track.value;
    _selectedGov = controller.governorate.value;
    _canTravel = controller.canTravel.value;
    _selectedPrograms = List.from(controller.programTypes);
    _selectedChannels = List.from(controller.admissionChannels);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PersistentAppBar(
        title: l10n.edit_profile,
        showLogo: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget();
        }

        return Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildSectionTitle(l10n.academic_info ?? "Academic Info"),
              const SizedBox(height: 16),
              _buildDropdown(
                label: l10n.governorate,
                value: _selectedGov,
                items: AppConstants.governorates,
                onChanged: (val) => setState(() => _selectedGov = val!),
              ),
              SwitchListTile(
                title: Text(l10n.travel_option),
                value: _canTravel,
                onChanged: (val) => setState(() => _canTravel = val),
              ),
              const Divider(height: 48),
              _buildSectionTitle(l10n.program_types),
              ...AppConstants.programTypes.map((type) => CheckboxListTile(
                    title: Text(type),
                    value: _selectedPrograms.contains(type),
                    onChanged: (val) {
                      setState(() {
                        if (val!) _selectedPrograms.add(type);
                        else _selectedPrograms.remove(type);
                      });
                    },
                  )),
              const Divider(height: 48),
              _buildSectionTitle(l10n.admission_channels),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: AppConstants.admissionTypes.map((channel) {
                  final isSelected = _selectedChannels.contains(channel);
                  return FilterChip(
                    label: Text(channel),
                    selected: isSelected,
                    onSelected: (val) {
                      setState(() {
                        if (val) _selectedChannels.add(channel);
                        else _selectedChannels.remove(channel);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: AppColors.primaryLight,
                  foregroundColor: Colors.white,
                ),
                child: Text(l10n.save ?? "Save Changes"),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.primaryLight,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _saveProfile() async {
    await controller.updateProfile(
      newTrack: _selectedTrack,
      newGov: _selectedGov,
      newTravel: _canTravel,
      newPrograms: _selectedPrograms,
      newChannels: _selectedChannels,
    );
    Get.back();
    Get.snackbar(
      AppLocalizations.of(context)!.success ?? "Success",
      AppLocalizations.of(context)!.profile_updated ?? "Profile updated successfully",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
