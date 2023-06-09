import 'dart:io';
import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/loader.dart';
import 'package:borlago/base/presentation/widgets/page_refresher.dart';
import 'package:borlago/base/presentation/widgets/select_input.dart';
import 'package:borlago/base/presentation/widgets/text_input.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/base/utils/form_validators/text.dart';
import 'package:borlago/base/utils/toast.dart';
import 'package:borlago/feature_user/domain/models/user_location.dart';
import 'package:borlago/feature_user/presentation/user_view_model.dart';
import 'package:borlago/feature_wcr/domain/models/wcr.dart';
import 'package:borlago/feature_wcr/presentation/wcr_view_model.dart';
import 'package:borlago/feature_wcr/presentation/widgets/amount_dialog.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateWCRScreen extends StatefulWidget {
  const CreateWCRScreen({super.key, required this.imageFile});
  final XFile imageFile;

  @override
  State<CreateWCRScreen> createState() => _CreateWCRScreenState();
}

class _CreateWCRScreenState extends State<CreateWCRScreen> {
  final WCRViewModel _wcrViewModel = WCRViewModel();
  final UserViewModel _userViewModel = UserViewModel();
  late XFile? _imageFile;
  final _formKey = GlobalKey<FormState>();
  List<UserLocation?> _userLocations = [];
  bool _isLoading = false;
  bool _isLocationsLoading = false;
  bool _fetchLocationsError = false;

  final _wasteTypeController = TextEditingController();
  final _pickUpLocationController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _wasteTypeFocusNode = FocusNode();
  final _pickUpLocationFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  String? _wasteTypeError;
  String? _pickUpLocationError;
  String? _descriptionError;

  void fetchLocations() async {
    List<UserLocation?>? locations;
    setState(() {
      _isLocationsLoading = true;
      _fetchLocationsError = false;
    });

    locations = await _userViewModel.getUserLocations();

    if(locations != null) {
      setState(() {
        _userLocations = locations!;
        _isLocationsLoading = false;
      });
    } else {
      setState(() {
        _fetchLocationsError = true;
        _isLocationsLoading = false;
      });
    }
  }

  @override
  void initState() {
    _imageFile = widget.imageFile;
    fetchLocations();
    super.initState();
  }

  void showAmountDialog(double amount) {
    amountDialog(context: context, amount: amount);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final wasteTypeValidator = TextValidator(context);
    final pickUpLocationValidator = TextValidator(context);

    void makeRequest() async {
      String locationId = "";
      double? amountToPay;

      setState(() {
        _isLoading = true;
      });

      _userLocations.map((location) {
        if(location!.name == _pickUpLocationController.text) {
          locationId = location.id;
        }
      }).toList();

      amountToPay = await _wcrViewModel.createWCR(
        wastePhoto: widget.imageFile,
        pickUpLocation: locationId,
        wasteDesc: _descriptionController.text,
        wasteType: _wasteTypeController.text
      );

      if(amountToPay != null) {
        showAmountDialog(amountToPay);
      } else {
        toast(message: l10n!.err_wrong);
      }

      setState(() {
        _isLoading = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        centerTitle: false,
        title: Text(
          l10n!.lbl_create_wcr,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: _isLocationsLoading ? const Center(child: Loader(size: 30),) :
        _fetchLocationsError ? PageRefresher(onRefresh: fetchLocations) :
        SingleChildScrollView(
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
                child: _imageFile != null ?
                Image.file(File(_imageFile!.path)) :
                Container(),
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
                      options: _userLocations.map((location) => location!.name).toList(),
                    ),
                    const SizedBox(height: 15,),
                    TextInput(
                      controller: _descriptionController,
                      textInputType: TextInputType.text,
                      focusNode: _descriptionFocusNode,
                      inputAction: TextInputAction.done,
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
                    _isLoading ? const Loader(size: 24) : Button(
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