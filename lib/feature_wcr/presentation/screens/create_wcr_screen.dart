import 'dart:io';
import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/select_input.dart';
import 'package:borlago/base/presentation/widgets/text_input.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/base/utils/form_validators/text.dart';
import 'package:borlago/base/utils/toast.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateWCRScreen extends StatefulWidget {
  const CreateWCRScreen({super.key, required this.imageFile});
  final XFile imageFile;

  @override
  State<CreateWCRScreen> createState() => _CreateWCRScreenState();
}

class _CreateWCRScreenState extends State<CreateWCRScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _wasteTypeController = TextEditingController();
  final _pickUpLocationController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _wasteTypeFocusNode = FocusNode();
  final _pickUpLocationFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  String? _wasteTypeError;
  String? _pickUpLocationError;
  String? _descriptionError;



  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final wasteTypeValidator = TextValidator(context);
    final pickUpLocationValidator = TextValidator(context);

    void makeRequest() async {
      setState(() {
        _isLoading = true;
      });

      // bool success = await authViewModel.login(
      //     email: _emailController.text,
      //     password: _passwordController.text
      // );

      setState(() {
        _isLoading = false;
      });

      // if(success) {
      //   _emailController.clear();
      //   _passwordController.clear();
      //   navigateToMainScreen();
      // } else {
      //    toast(message: l10n!.err_wrong);
      // }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        centerTitle: false,
        title: Text(
          l10n!.create_wcr,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface
              ),
              child: AspectRatio(
                aspectRatio: 9 / 6,
                child: Image.file(File(widget.imageFile.path)),
              ),
            ),
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child:  Column(
                  children: [
                    SelectInput(
                      controller: _wasteTypeController,
                      focusNode: _wasteTypeFocusNode,
                      inputAction: TextInputAction.next,
                      label: l10n.lbl_waste_type,
                      placeholder: l10n.plh_waste_type,
                      dialogTitle: l10n.plh_waste_type,
                      error: _wasteTypeError,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_pickUpLocationFocusNode);
                      },
                      options: Constants.wasteTypes,
                    ),
                    const SizedBox(height: 15,),
                    SelectInput(
                      controller: _pickUpLocationController,
                      focusNode: _pickUpLocationFocusNode,
                      inputAction: TextInputAction.next,
                      label: l10n.lbl_pick_up_loc,
                      placeholder: l10n.plh_pick_up_loc,
                      dialogTitle: l10n.plh_pick_up_loc,
                      error: _pickUpLocationError,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocusNode);
                      },
                      options: const ["Tesano, Glass Hostel", "GWCL Dzorwulu", "Fiesta Royal Hotel Accra"],
                    ),
                    const SizedBox(height: 15,),
                    TextInput(
                      controller: _descriptionController,
                      textInputType: TextInputType.text,
                      focusNode: _descriptionFocusNode,
                      inputAction: TextInputAction.next,
                      placeholder: l10n.plh_description,
                      label: l10n.lbl_description,
                      height: 100,
                      maxLines: 5,
                      error: _descriptionError,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    const SizedBox(height: 15,),
                    _isLoading ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: theme.colorScheme.primary
                      ),
                    ) : Button(
                        onTap: () {
                          setState(() {
                            _wasteTypeError = wasteTypeValidator(_wasteTypeController.text);
                            _pickUpLocationError = pickUpLocationValidator(_pickUpLocationController.text);
                          });

                          final errors = [_wasteTypeError, _pickUpLocationError];

                          if(errors.every((error) => error == null)) {
                            FocusScope.of(context).unfocus();
                            makeRequest();
                          }
                        },
                        text: l10n.btn_submit
                    ),
                    const SizedBox(height: 30,),
                  ],
                ),
              ),

            )
          ],
        )
      ),
    );
  }
}
