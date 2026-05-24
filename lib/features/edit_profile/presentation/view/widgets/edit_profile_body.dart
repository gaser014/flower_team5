import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flowers_app/core/widgets/custom_cached_image.dart';
import 'package:flowers_app/core/widgets/custom_toast.dart';
import 'package:flowers_app/core/widgets/text_field/email_field.dart';
import 'package:flowers_app/core/widgets/text_field/phone_field.dart';
import 'package:flowers_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:flowers_app/features/edit_profile/presentation/view_model/cubit/edit_profile_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileBody extends StatefulWidget {
  const EditProfileBody({super.key});

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;

  String _selectedGender = 'female';
  String? _photoUrl;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController(text: '••••••••');

    // Fetch cached user data to prefill fields
    context.read<EditProfileCubit>().doIntent(GetCachedUserEvent());
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null && mounted) {
      context.read<EditProfileCubit>().doIntent(
        UploadProfilePhotoEvent(imagePath: image.path),
      );
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<EditProfileCubit>().doIntent(
        UpdateProfileDetailsEvent(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          gender: _selectedGender,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileStates>(
      listener: (context, state) {
        // Prefill forms when cached user loads
        if (state.loadUserState.isSuccess && !_isInitialized) {
          final user = state.loadUserState.data;
          if (user != null) {
            _firstNameController.text = user.firstName ?? '';
            _lastNameController.text = user.lastName ?? '';
            _emailController.text = user.email ?? '';
            // Remove prefix +20 if present
            String rawPhone = user.phone ?? '';
            if (rawPhone.startsWith('+20')) {
              rawPhone = rawPhone.substring(3).trim();
            } else if (rawPhone.startsWith('20')) {
              rawPhone = rawPhone.substring(2).trim();
            }
            _phoneController.text = rawPhone;
            _selectedGender = (user.gender ?? 'female').toLowerCase();
            _photoUrl = user.photo;
            _isInitialized = true;
          }
        }

        // Handle update state changes
        if (state.updateState.isSuccess) {
          CustomToast.showSuccess(
            context: context,
            message: "Profile updated successfully!",
          );
        } else if (state.updateState.isError) {
          CustomToast.showError(
            context: context,
            message:
                state.updateState.exception?.toString() ??
                "Failed to update profile",
          );
        }

        // Handle image upload state changes
        if (state.uploadPhotoState.isSuccess) {
          final user = state.uploadPhotoState.data;
          if (user != null) {
            setState(() {
              _photoUrl = user.photo;
            });
          }
          CustomToast.showSuccess(
            context: context,
            message: "Profile picture uploaded successfully!",
          );
        } else if (state.uploadPhotoState.isError) {
          CustomToast.showError(
            context: context,
            message:
                state.uploadPhotoState.exception?.toString() ??
                "Failed to upload photo",
          );
        }
      },
      builder: (context, state) {
        if (state.loadUserState.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primerColor),
          );
        }

        return SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Avatar with Camera Icon Overlay
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 80.r,
                        height: 80.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.pinkF6,
                            width: 3.r,
                          ),
                        ),
                        child: ClipOval(
                          child: state.uploadPhotoState.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primerColor,
                                  ),
                                )
                              : (_photoUrl != null && _photoUrl!.isNotEmpty
                                    ? CustomCachedImage(
                                        imagePath: _photoUrl!,
                                        width: 80.r,
                                        height: 80.r,
                                        fit: BoxFit.cover,
                                      )
                                    : SvgPicture.asset(
                                        AppAssets.iconsNoProfile,
                                        width: 80.r,
                                        height: 80.r,
                                        fit: BoxFit.cover,
                                      )),
                        ),
                      ),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: REdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.primerColor,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.iconsAddImage,
                            colorFilter: const ColorFilter.mode(
                              AppColors.white,
                              BlendMode.srcIn,
                            ),
                            width: 16.r,
                            height: 16.r,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // First Name and Last Name
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "First name",
                            style: AppFontStyle.medium14(
                              context: context,
                            ).copyWith(color: AppColors.gray53),
                          ),
                          SizedBox(height: 8.h),
                          TextFormField(
                            controller: _firstNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "First name is required";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: "Enter first name",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Last name",
                            style: AppFontStyle.medium14(
                              context: context,
                            ).copyWith(color: AppColors.gray53),
                          ),
                          SizedBox(height: 8.h),
                          TextFormField(
                            controller: _lastNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Last name is required";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: "Enter last name",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: AppFontStyle.medium14(
                        context: context,
                      ).copyWith(color: AppColors.gray53),
                    ),
                    SizedBox(height: 8.h),
                    EmailField(controller: _emailController, showLabel: false),
                  ],
                ),
                SizedBox(height: 16.h),

                // Phone Number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Phone Number",
                      style: AppFontStyle.medium14(
                        context: context,
                      ).copyWith(color: AppColors.gray53),
                    ),
                    SizedBox(height: 8.h),
                    PhoneField(controller: _phoneController, showLabel: false),
                  ],
                ),
                SizedBox(height: 16.h),

                // Password (ReadOnly with Change Button)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: AppFontStyle.medium14(
                        context: context,
                      ).copyWith(color: AppColors.gray53),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () {
                        context.push(Routes.changePassword);
                      },
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        obscuringCharacter: '★',
                        enabled: false,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.grayCF,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Change",
                              style: AppFontStyle.medium14(
                                context: context,
                              ).copyWith(color: AppColors.primerColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Gender Selection
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gender",
                      style: AppFontStyle.medium14(
                        context: context,
                      ).copyWith(color: AppColors.gray53),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              value: 'female',
                              groupValue: _selectedGender,
                              activeColor: AppColors.primerColor,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                }
                              },
                            ),
                            Text(
                              "Female",
                              style: AppFontStyle.medium14(context: context),
                            ),
                          ],
                        ),
                        SizedBox(width: 40.w),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              value: 'male',
                              groupValue: _selectedGender,
                              activeColor: AppColors.primerColor,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                }
                              },
                            ),
                            Text(
                              "Male",
                              style: AppFontStyle.medium14(context: context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 36.h),

                // Update Button
                CustomButton(
                  text: "Update",
                  isLoading: state.updateState.isLoading,
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
