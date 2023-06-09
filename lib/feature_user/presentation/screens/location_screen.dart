import 'package:borlago/base/presentation/widgets/confirmationDialog.dart';
import 'package:borlago/base/presentation/widgets/float_action_button.dart';
import 'package:borlago/base/presentation/widgets/info_dialog.dart';
import 'package:borlago/base/presentation/widgets/loader.dart';
import 'package:borlago/base/presentation/widgets/page_refresher.dart';
import 'package:borlago/base/utils/toast.dart';
import 'package:borlago/feature_user/domain/models/user_location.dart';
import 'package:borlago/feature_user/presentation/user_view_model.dart';
import 'package:borlago/feature_user/presentation/widgets/location_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final UserViewModel _userViewModel = UserViewModel();
  final _refreshController = RefreshController(initialRefresh: false);
  bool _isLoading = false;
  bool _isError = false;
  List<UserLocation?> _userLocations = [];
  late double _latitude;
  late double _longitude;
  late String _name;

  void fetchLocations() async {
    List<UserLocation?>? locations;
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    locations = await _userViewModel.getUserLocations();

    if(locations != null) {
      setState(() {
        _userLocations = locations!;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }


  void addLocationRequest() {
    _userViewModel.addLocation(
      latitude: _latitude,
      longitude: _longitude,
      name: _name
    ).then((location) {
      if (location != null) {
        setState(() {
          _userLocations.insert(0, location);
        });
        toast(message: AppLocalizations.of(context)!.suc_location);
      }
    }).catchError((error) {
      toast(message: AppLocalizations.of(context)!.err_wrong);
    });
  }

  void deleteLocationRequest(String id){
    _userViewModel.deleteLocation(locationId: id).then((value) {
      if (value) {
        setState(() {
          _userLocations.removeWhere((item) => item!.id == id);
        });
      }
      toast(message: AppLocalizations.of(context)!.suc_delete);
    }).catchError((error) {
      toast(message: AppLocalizations.of(context)!.err_wrong);
    });
  }

  @override
  void initState() {
    fetchLocations();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final locationsItems = _userLocations.map((location) {
      return LocationItem(
        name: location!.name,
        onDeletePressed: () {
          deleteLocationRequest(location.id);
        },
      );
    }).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          l10n!.lbl_locations,
          style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
          ),
        ),
      ),
      body: _isLoading ? const Center(child: Loader(size: 30)) :
        _isError ? PageRefresher(onRefresh: fetchLocations) :
        SmartRefresher(
          controller: _refreshController,
          onRefresh: fetchLocations,
          header: MaterialClassicHeader(
            color: theme.colorScheme.primary,
            backgroundColor: theme.colorScheme.surface,
          ),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: locationsItems.length,
              itemBuilder: (context, index) {
                return locationsItems[index];
              }
          ),
      ),
      floatingActionButton: FloatActionButton(
        onPressed: () {
          confirmationDialog(
            context: context,
            title: l10n.txt_add_location,
            yesAction: _getLocation
          );
        },
        icon: CupertinoIcons.add
      )
    );
  }

  void showInfoDialog(String info) {
    infoDialog(context: context, info: info);
  }

  Future<void> _getLocation() async {
    final l10n = AppLocalizations.of(context);
    LocationPermission permission;

    bool locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) {
      showInfoDialog(l10n!.txt_enable_location);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showInfoDialog(l10n!.txt_enable_location);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showInfoDialog(l10n!.txt_enable_location);
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
    });

    List<Placemark> placemarks = await placemarkFromCoordinates(_latitude, _longitude);

    setState(() {
      _name = placemarks[0].street!;
    });

    addLocationRequest();
  }

}
