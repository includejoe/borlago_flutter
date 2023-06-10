import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/base/presentation/widgets/button.dart';
import 'package:borlago/base/presentation/widgets/loader.dart';
import 'package:borlago/base/presentation/widgets/main_page_view.dart';
import 'package:borlago/base/presentation/widgets/page_refresher.dart';
import 'package:borlago/base/utils/constants.dart';
import 'package:borlago/base/utils/toast.dart';
import 'package:borlago/feature_authentication/providers/authentication_provider.dart';
import 'package:borlago/feature_user/domain/models/payment_method.dart';
import 'package:borlago/feature_user/domain/models/payment_type.dart';
import 'package:borlago/feature_user/presentation/user_view_model.dart';
import 'package:borlago/feature_user/presentation/widgets/payment_method_logo.dart';
import 'package:borlago/feature_wcr/domain/models/wcr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MakePaymentScreen extends StatefulWidget {
  const MakePaymentScreen({super.key, required this.wcr, required this.justCreated});
  final WCR wcr;
  final bool justCreated;

  @override
  State<MakePaymentScreen> createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  final _userViewModel = UserViewModel();
  List<PaymentMethod?> _paymentMethods = [];
  String? _selectedMethodId;
  bool _isLoading = false;
  bool _isError = false;
  bool _paymentInitiated = false;

  setSelectedMethodId(String id) {
    setState(() {
      _selectedMethodId = id;
    });
  }

  void fetchPaymentMethods() async {
    List<PaymentMethod?>? methods;
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    methods = await _userViewModel.getPaymentMethods();

    if(methods != null) {
      setState(() {
        _paymentMethods = methods!;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }

  void navigateHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => const MainPageView()
    ));
  }

  @override
  void initState() {
    fetchPaymentMethods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final currency = getIt.get<AuthenticationProvider>().currency;
    final user = getIt.get<AuthenticationProvider>().user;

    void makeRequest() async {
      setState(() {
        _isLoading = true;
        _paymentInitiated = false;
      });

      await Future.delayed(const Duration(seconds: 3)).then((_) {
        setState(() {
          _isLoading = false;
          _paymentInitiated = true;
        });
      });

      if(_paymentInitiated) {

      } else {
        toast(message: l10n!.err_wrong);
      }

      setState(() {
        _isLoading = false;
      });
    }


    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        automaticallyImplyLeading: !widget.justCreated,
        leading: widget.justCreated ? IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MainPageView())
            );
          },
        ) : null,
        title: Text(
          l10n!.lbl_make_payment,
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: _isLoading ? const Center(child: Loader(size: 30)) :
          _paymentInitiated ? SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 100),
                  const SizedBox(height: 20),
                  Text(
                    l10n.lbl_payment_initiated,
                    style: theme.textTheme.headlineMedium
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l10n.txt_payment_initiated,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium
                  ),
                  const SizedBox(height: 20),
                  Button(
                    text: l10n.btn_completed,
                    // text: l10n.btn_completed,
                    onTap: navigateHome,
                  )
                ],
              ),
            )),
          ) :
          _isError ? PageRefresher(onRefresh: fetchPaymentMethods) :
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(400),
                  color: theme.colorScheme.surface
                ),
                child: Center(
                  child: Text(
                      "$currency ${widget.wcr.price}",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 30,
                        color: theme.colorScheme.onSurface
                      ),
                    ),
                ),
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _paymentMethods.map((method) {
                  PaymentType? paymentType;
                  Constants.paymentTypes.forEach((key, value) {
                    if(key == user!.country) {
                      for (var type in value) {
                        if(type.name == method!.name) {
                          paymentType = type;
                        }
                      }
                    }
                  });
                  return InkWell(
                    onTap: (){
                      setSelectedMethodId(method.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration:  BoxDecoration(
                        border: Border.all(
                          color: _selectedMethodId == method!.id ?
                          theme.colorScheme.primary : Colors.transparent,
                          width: 2
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(8))
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PaymentMethodLogo(
                            logoUrl: paymentType!.logo,
                            size: 45
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                method.name,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                method.accountNumber,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }).toList()
              ),
              const SizedBox(height: 25),
              Button(
                onTap: () {
                  if(_selectedMethodId == null) {
                    toast(message: l10n.err_select_payment);
                    return;
                  } else {
                    makeRequest();
                  }
                },
                text: l10n.btn_pay,
              )
            ],
          ),
        )
      )
    );
  }
}
