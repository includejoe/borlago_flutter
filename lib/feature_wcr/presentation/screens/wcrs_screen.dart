import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:borlago/base/presentation/widgets/loader.dart';
import 'package:borlago/base/presentation/widgets/page_refresher.dart';
import 'package:borlago/feature_wcr/domain/models/wcr.dart';
import 'package:borlago/feature_wcr/presentation/wcr_view_model.dart';
import 'package:borlago/feature_wcr/presentation/widgets/wcr_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WCRsScreen extends StatefulWidget {
  const WCRsScreen({super.key});

  @override
  State<WCRsScreen> createState() => _WCRsScreenState();
}

class _WCRsScreenState extends State<WCRsScreen> {
  final WCRViewModel _wcrViewModel = WCRViewModel();
  final _refreshController = RefreshController(initialRefresh: false);
  bool _isLoading = false;
  bool _isError = false;
  List<WCR?> _wcrs = [];

  void fetchWCRs() async {
    List<WCR?>? wcrs;
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    wcrs = await _wcrViewModel.listWCR();

    if(wcrs != null) {
      setState(() {
        _wcrs = wcrs!;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  @override
  void initState() {
    fetchWCRs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final wcrItems = _wcrs.map((wcr) {
      return WCRItem(
        id: wcr!.publicId,
        time: wcr.createdAt,
        status: wcr.status,
        wasteType: wcr.wasteType
      );
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          l10n!.lbl_wcrs,
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)
            ),
            color: theme.scaffoldBackgroundColor,
          ),
          height: MediaQuery.of(context).size.height,
          child: _isLoading ? const Center(child: Loader(size: 30),) :
            _isError ? PageRefresher(onRefresh: fetchWCRs) :
            SmartRefresher(
              controller: _refreshController,
              onRefresh: fetchWCRs,
              header: MaterialClassicHeader(
                color: theme.colorScheme.primary,
                backgroundColor: theme.colorScheme.background,
              ),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: wcrItems.length,
                itemBuilder: (context, index) {
                  return wcrItems[index];
                }
              ),
            )
      ),
    );
  }
}
