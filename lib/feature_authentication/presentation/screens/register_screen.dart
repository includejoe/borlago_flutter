import 'package:borlago/base/presentation/widgets/app_logo.dart';
import 'package:borlago/feature_authentication/presentation/auth_view_model.dart';
import 'package:borlago/feature_authentication/presentation/widgets/register_field_set_0.dart';
import 'package:borlago/feature_authentication/presentation/widgets/register_field_set_1.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthenticationViewModel _authViewModel = AuthenticationViewModel();
  final _formKey = GlobalKey<FormState>();
  int _currentFieldSet = 0;

  // controllers
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _genderController = TextEditingController();
  final _countryController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();



  @override void dispose() {
    super.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _countryController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> makeRegisterRequest() async {
      bool success = false;
      success = await _authViewModel.register(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          gender: _genderController.text,
          country: _countryController.text,
          phone: _phoneController.text,
          password: _passwordController.text
      );

      if(success) {
        _emailController.clear();
        _firstNameController.clear();
        _lastNameController.clear();
        _genderController.clear();
        _countryController.clear();
        _phoneController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
      }

      return success;
    }

    void nextFieldSet () {
      setState(() {
        _currentFieldSet++;
      });
    }

    void previousFieldSet() {
      setState(() {
        _currentFieldSet--;
      });
    }

    final fieldSets = [
      RegisterFieldSet0(
        emailController: _emailController,
        firstNameController: _firstNameController,
        lastNameController: _lastNameController,
        phoneController: _phoneController,
        nextFieldSet: nextFieldSet
      ),
      RegisterFieldSet1(
        genderController: _genderController,
        countryController: _countryController,
        passwordController: _passwordController,
        confirmPasswordController: _confirmPasswordController,
        previousFieldSet: previousFieldSet,
        register: makeRegisterRequest
      )
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: const Center(child: AppLogo()),
                  ),
                  fieldSets[_currentFieldSet],
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}