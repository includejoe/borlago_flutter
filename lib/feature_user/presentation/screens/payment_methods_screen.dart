import 'package:borlago/base/presentation/widgets/empty_list_placeholder.dart';
import 'package:borlago/base/presentation/widgets/float_action_button.dart';
import 'package:borlago/base/presentation/widgets/loader.dart';
import 'package:borlago/base/presentation/widgets/page_refresher.dart';
import 'package:borlago/feature_user/domain/models/payment_method.dart';
import 'package:borlago/feature_user/presentation/screens/settings_screen.dart';
import 'package:borlago/feature_user/presentation/user_view_model.dart';
import 'package:borlago/feature_user/presentation/widgets/payment_method_item.dart';
import 'package:borlago/feature_user/presentation/widgets/payment_methods_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final UserViewModel _userViewModel = UserViewModel();
  final _refreshController = RefreshController(initialRefresh: false);
  List<PaymentMethod?> _paymentMethods = [];
  bool _isLoading = false;
  bool _isError = false;

  void fetchPaymentMethods() async  {
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

  @override
  void initState() {
    fetchPaymentMethods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final List<PaymentMethodItem> paymentMethodItems = _paymentMethods.map(
      (paymentMethod) {
        return PaymentMethodItem(
          method: paymentMethod!,
          fetchPaymentMethods: fetchPaymentMethods,
        );
    }).toList();

    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          automaticallyImplyLeading: true,
          title: Text(
            l10n!.lbl_payment_method,
            style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.onPrimary
            ),
          ),
        ),
        body: _isLoading ? const Center(child: Loader(size: 30,),) :
            _isError ? PageRefresher(onRefresh: fetchPaymentMethods) :
            SmartRefresher(
              controller: _refreshController,
              onRefresh: fetchPaymentMethods,
              header: MaterialClassicHeader(
                color: theme.colorScheme.primary,
                backgroundColor: theme.colorScheme.surface,
              ),
              child: _paymentMethods.isNotEmpty ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: paymentMethodItems.length,
                  itemBuilder: (context, index) {
                    return paymentMethodItems[index];
                  }
              ) : EmptyListPlaceholder(
                  icon: CupertinoIcons.creditcard_fill,
                  message: l10n.txt_no_payment_methods
              )
            ),
        floatingActionButton: FloatActionButton(
            onPressed: () {
              paymentMethodsDialog(context: context);
            },
            icon: CupertinoIcons.add
        )
    );
  }
}
