import 'package:cupom_dashboard/app/utils/colors.dart';
import 'package:cupom_dashboard/data/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../../data/helpers/maps_string.dart';
import '../../../data/models/address.dart';
import '../../../data/models/response_api.dart';
import '../../../domain/usecases/mapsProcess.dart';
import '../../widgets/ResponsiveView.dart';
import '../../widgets/custom_elevated_button.dart';

class CompanyAddressPage extends StatefulWidget {
  final ScreenArguments? screenArguments;
  const CompanyAddressPage(this.screenArguments, {super.key});

  @override
  State<CompanyAddressPage> createState() => _CompanyAddressPageState();
}

class _CompanyAddressPageState extends State<CompanyAddressPage> {

  TextEditingController controller = TextEditingController();

  bool loadingSearch = false;

  var uuid = Uuid();


  int indexSearchLocation = 1;

  List<Prediction> locationsSearch = [];

  bool searchEnabled = true;

  bool withoutDestiny = false;

  Address? address;

  updateLocation() {

    if (widget.screenArguments?.address != null) {
      setState(() {
        address = widget.screenArguments?.address;
      });
    }
    updateSessionToken();
  }

  String? sessionToken;

  updateSessionToken() {
    if (sessionToken == null) {
      print("Update session token");
      sessionToken = uuid.v4();
      print("Session token: $sessionToken");
    }
  }

  @override
  void initState() {
    updateLocation();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    updateSessionToken();
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return ResponsiveView(
      onTap: () {
        int index = 0;
        controller.text = MapsStrings.addressFormattedAll(address);
        setState(() {
          searchEnabled = false;
          locationsSearch = [];
          indexSearchLocation = 0;
        });
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: whiteColor,
              centerTitle: true,
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Selecionar endereço",
                  style: GoogleFonts.fredoka(
                    fontSize: 28,
                  ),
                ),
              ),
              actions: const [
                SizedBox(
                  width: 8,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 12, right: 24, left: 24),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      autofocus: true,
                                      controller: controller,
                                      onTap: () {
                                        controller.clear();
                                        locationsSearch = [];

                                        if (address != null) {
                                          controller.text = MapsStrings.addressFormattedAll(address);
                                        }
                                        if (!searchEnabled ) {
                                          controller.clear();
                                          locationsSearch = [];
                                        }
                                        setState(() {
                                          searchEnabled = true;
                                        });
                                      },
                                      onChanged: (valor) async {
                                        if (controller.text != "" && controller.text.length > 3) {
                                          loadingSearch = false;
                                          List<Prediction> result = [];
                                          if (address == null) {
                                            result = await MapsProcess.googleMapsPlaceSearch(
                                              controller.text,
                                              null,
                                              sessionToken ?? "",
                                              //widget.screenArguments?.location,
                                            );
                                          }else{
                                            result = await MapsProcess.googleMapsPlaceSearch(
                                              controller.text,
                                              null,
                                              sessionToken ?? "",
                                              //widget.screenArguments?.location,
                                            );
                                          }
                                          if (loadingSearch == false) {
                                            locationsSearch = result;
                                          }
                                          setState(() {

                                          });
                                        }else{
                                          loadingSearch = true;
                                          setState(() {
                                            locationsSearch = [];
                                          });
                                        }

                                      },
                                      decoration: InputDecoration(
                                        hintText: "Qual é o endereço?",
                                        labelText: "Endereço",
                                        labelStyle: GoogleFonts.kufam(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        prefixIcon: Icon(
                                          Icons.circle_sharp,
                                          size: 12,
                                          color: primaryColor,
                                        ),
                                        filled: true,
                                        fillColor: whiteColor,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: BorderSide.none
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: BorderSide(color: Colors.blue)
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),
                          searchEnabled && locationsSearch.isNotEmpty
                              ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListView.builder(
                              itemCount: locationsSearch.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                //PlacesSearchResult? mapBoxPlace = locationsSearch[index];
                                Prediction? mapBoxPlace = locationsSearch[index];
                                return ListTile(
                                  onTap: () async {
                                    if (kDebugMode) {
                                      print(mapBoxPlace.toJson());
                                      print(mapBoxPlace.structuredFormatting?.mainText);
                                      print(mapBoxPlace.structuredFormatting?.secondaryText);
                                      print(mapBoxPlace.placeId);
                                      print(mapBoxPlace.description);
                                    }
                                    Address? mapModelSelect = await MapsProcess.geoCodingGoogleOneResult(mapBoxPlace);
                                    if (kDebugMode) {
                                      print(mapModelSelect);
                                    }

                                    setState(() {
                                      address = mapModelSelect;
                                      searchEnabled = false;
                                      controller.text = MapsStrings.addressFormattedAll(mapModelSelect);
                                    });
                                    FocusScopeNode currentFocus = FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                  },
                                  title: Text("${mapBoxPlace.description}"),//MapsStrings.addressFormattedPlace(mapBoxPlace)),
                                  subtitle: Text("${mapBoxPlace.structuredFormatting?.secondaryText.toString()}"),
                                );
                              },
                            ),
                          ) : Container(),
                        ],
                      )
                  )
                ],
              ),
            ),
            bottomNavigationBar: !searchEnabled && address != null
                ? SafeArea(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomElevatedButton(
                        onPressed: () async {

                        },
                        background: primaryColor,
                        text: "Confirmar",
                      ),
                    ],
                  )
              ),
            )
                : null,
          );
        },
      ),
    );
  }
}
