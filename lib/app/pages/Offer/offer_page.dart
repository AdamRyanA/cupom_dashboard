import 'dart:typed_data';
import 'package:cupom_dashboard/app/widgets/custom_elevated_button.dart';
import 'package:cupom_dashboard/data/models/models.dart';
import 'package:cupom_dashboard/data/models/type_offer.dart';
import 'package:cupom_dashboard/domain/usecases/offer_process.dart';
import 'package:cupom_dashboard/domain/usecases/type_offers_process.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:time_range_picker/time_range_picker.dart';
import '../../../data/helpers/picker_image.dart';
import '../../../data/helpers/time_range_convert.dart';
import '../../../data/models/response_api.dart';
import '../../utils/colors.dart';
import '../../utils/paths.dart';
import '../../widgets/ResponsiveView.dart';
import '../../widgets/full_screen_image.dart';
import '../../widgets/inputRegisterOffer.dart';

class OfferPage extends StatefulWidget {
  final ScreenArguments? screenArguments;
  const OfferPage(this.screenArguments, {super.key});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {


  TextEditingController offerName = TextEditingController();
  TextEditingController categoryOffer = TextEditingController();
  TextEditingController descriptionOffer = TextEditingController();

  Uint8List? _imageBase64;

  List<TypeOffer> typeOffers = [];
  TypeOffer? selectTypeOffers;

  GlobalKey keyMonday = GlobalKey();
  GlobalKey keyTuesday = GlobalKey();
  GlobalKey keyWednesday = GlobalKey();
  GlobalKey keyThursday = GlobalKey();
  GlobalKey keyFriday = GlobalKey();
  GlobalKey keySaturday = GlobalKey();
  GlobalKey keySunday = GlobalKey();

  TimeRange? monday = TimeRange(startTime: const TimeOfDay(hour: 11, minute: 30), endTime: const TimeOfDay(hour: 22, minute: 00));
  TimeRange? tuesday = TimeRange(startTime: const TimeOfDay(hour: 11, minute: 30), endTime: const TimeOfDay(hour: 22, minute: 00));
  TimeRange? wednesday = TimeRange(startTime: const TimeOfDay(hour: 11, minute: 30), endTime: const TimeOfDay(hour: 22, minute: 00));
  TimeRange? thursday = TimeRange(startTime: const TimeOfDay(hour: 11, minute: 30), endTime: const TimeOfDay(hour: 22, minute: 00));
  TimeRange? friday = TimeRange(startTime: const TimeOfDay(hour: 11, minute: 30), endTime: const TimeOfDay(hour: 22, minute: 00));
  TimeRange? saturday = TimeRange(startTime: const TimeOfDay(hour: 11, minute: 30), endTime: const TimeOfDay(hour: 22, minute: 00));
  TimeRange? sunday = TimeRange(startTime: const TimeOfDay(hour: 11, minute: 30), endTime: const TimeOfDay(hour: 22, minute: 00));

  final _formKey = GlobalKey<FormState>();

  getTypeOffers() async {
    ResponseAPI? responseAPI = await TypeOffersProcess.get(categoryId: "${widget.screenArguments?.company?.category?.id}");
    if (responseAPI != null) {
      if (responseAPI.typeOffers != null) {
        setState(() {
          typeOffers = responseAPI.typeOffers!;
        });
      }
    }
    setState(() {

    });
    updateData();
  }

  updateData() async {
    if (widget.screenArguments?.offer != null) {
      offerName.text = widget.screenArguments?.offer?.name ?? "";
      categoryOffer.text = widget.screenArguments?.offer?.categoryOffer ?? "";
      descriptionOffer.text = widget.screenArguments?.offer?.descriptionOffer ?? "";
      selectTypeOffers = widget.screenArguments?.offer?.typeOffer;
      monday = widget.screenArguments?.offer?.monday;
      tuesday = widget.screenArguments?.offer?.tuesday;
      wednesday = widget.screenArguments?.offer?.wednesday;
      thursday = widget.screenArguments?.offer?.thursday;
      friday = widget.screenArguments?.offer?.friday;
      if (widget.screenArguments?.offer?.saturday == null) {
        saturday = null;
      }else{
        saturday = widget.screenArguments?.offer?.saturday;
      }
      sunday = widget.screenArguments?.offer?.sunday;
      if (widget.screenArguments?.offer?.photo != null) {
        _imageBase64 = await PickerImage.loadImageFromNetwork("${widget.screenArguments?.offer?.photo}");
      }
    }
    setState(() {

    });
  }

  save(BuildContext context) async {
    EasyLoading.show(status: "Salvando...");
    ResponseAPI? responseResult;
    if (widget.screenArguments?.offer != null) {
      responseResult = await OfferProcess.put(
          id: widget.screenArguments?.offer?.id,
          company: "${widget.screenArguments?.company?.id}",
          name: offerName.text,
          category: "${widget.screenArguments?.company?.category?.id}",
          categoryOffer: categoryOffer.text,
          descriptionOffer: descriptionOffer.text,
          photo: _imageBase64 == null ? null : PickerImage.convertUint8ListToBase64(_imageBase64!),
          typeOffer: selectTypeOffers?.id,
          mondayStart: parseStringTimeOfDay(monday?.startTime),
          mondayEnd: parseStringTimeOfDay(monday?.endTime),
          tuesdayStart: parseStringTimeOfDay(tuesday?.startTime),
          tuesdayEnd: parseStringTimeOfDay(tuesday?.endTime),
          wednesdayStart: parseStringTimeOfDay(wednesday?.startTime),
          wednesdayEnd: parseStringTimeOfDay(wednesday?.endTime),
          thursdayStart: parseStringTimeOfDay(thursday?.startTime),
          thursdayEnd: parseStringTimeOfDay(thursday?.endTime),
          fridayStart: parseStringTimeOfDay(friday?.startTime),
          fridayEnd: parseStringTimeOfDay(friday?.endTime),
          saturdayStart: parseStringTimeOfDay(saturday?.startTime),
          saturdayEnd: parseStringTimeOfDay(saturday?.endTime),
          sundayStart: parseStringTimeOfDay(sunday?.startTime),
          sundayEnd: parseStringTimeOfDay(sunday?.endTime)
      );
    }else{
      responseResult = await OfferProcess.post(
          company: "${widget.screenArguments?.company?.id}",
          name: offerName.text,
          category: "${widget.screenArguments?.company?.category?.id}",
          categoryOffer: categoryOffer.text,
          descriptionOffer: descriptionOffer.text,
          photo: _imageBase64 == null ? null : PickerImage.convertUint8ListToBase64(_imageBase64!),
          typeOffer: selectTypeOffers?.id,
          mondayStart: parseStringTimeOfDay(monday?.startTime),
          mondayEnd: parseStringTimeOfDay(monday?.endTime),
          tuesdayStart: parseStringTimeOfDay(tuesday?.startTime),
          tuesdayEnd: parseStringTimeOfDay(tuesday?.endTime),
          wednesdayStart: parseStringTimeOfDay(wednesday?.startTime),
          wednesdayEnd: parseStringTimeOfDay(wednesday?.endTime),
          thursdayStart: parseStringTimeOfDay(thursday?.startTime),
          thursdayEnd: parseStringTimeOfDay(thursday?.endTime),
          fridayStart: parseStringTimeOfDay(friday?.startTime),
          fridayEnd: parseStringTimeOfDay(friday?.endTime),
          saturdayStart: parseStringTimeOfDay(saturday?.startTime),
          saturdayEnd: parseStringTimeOfDay(saturday?.endTime),
          sundayStart: parseStringTimeOfDay(sunday?.startTime),
          sundayEnd: parseStringTimeOfDay(sunday?.endTime)
      );
    }
    EasyLoading.dismiss();
    if (responseResult != null) {
      await PanaraInfoDialog.show(
          context,
          message: "Oferta salva",
          buttonText: "OK",
          onTapDismiss: () {
            Navigator.pop(context);
          },
          panaraDialogType: PanaraDialogType.success
      );
      Navigator.pop(context);
    }else{
      await PanaraInfoDialog.show(
          context,
          message: "Erro ao salvar oferta",
          buttonText: "OK",
          onTapDismiss: () {
            Navigator.pop(context);
          },
          panaraDialogType: PanaraDialogType.error
      );
    }
  }

  @override
  void initState() {
    getTypeOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveView(
      child: LayoutBuilder(
          builder: (context, constraints) {
            double largura = constraints.maxWidth;
            double altura = constraints.maxHeight;
            return Form(
              key: _formKey,
              child: Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: whiteColor,
                body: SizedBox(
                  width: double.infinity,
                  height: altura,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              ImagesPath.background2,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.arrowLeft,
                                      color: blackColor,
                                    )
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.screenArguments?.offer == null
                                        ? "Nova oferta"
                                        : "Atualizar oferta",
                                    style: GoogleFonts.fredoka(
                                      color: blackColor,
                                      fontSize: 34,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    color: whiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Container()
                                              ),
                                              FormField(
                                                initialValue: _imageBase64,
                                                validator: (valor) {
                                                  if (_imageBase64 != null) {
                                                    return null;
                                                  }
                                                  return "Selecione a imagem da oferta";
                                                },
                                                builder: (FormFieldState<dynamic> state) {
                                                  return Column(
                                                    children: [
                                                      Card(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15.0),
                                                          side: BorderSide(
                                                            color: greyColorText,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        semanticContainer: true,
                                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            if (_imageBase64 != null) {
                                                              Navigator.push(context, MaterialPageRoute(
                                                                  builder: (BuildContext context) {
                                                                    return FullScreenImage(
                                                                      initialIndex: 0,
                                                                      imagesUint8List: [_imageBase64!],
                                                                      images: [],
                                                                    );
                                                                  })
                                                              );
                                                            }
                                                          },
                                                          child: Container(
                                                            height: 180,
                                                            width: 180,
                                                            decoration: BoxDecoration(
                                                              color: Colors.grey,
                                                              image: _imageBase64 == null
                                                                  ? null
                                                                  : DecorationImage(
                                                                image: MemoryImage(_imageBase64!),
                                                                fit: BoxFit.cover,
                                                              ),
                                                              borderRadius: BorderRadius.circular(20), // Adjust this value for rounded corners
                                                            ),
                                                            child: _imageBase64 == null
                                                                ? const Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Icon(
                                                                  Icons.add_a_photo,
                                                                  size: 80,
                                                                  color: Colors.white,
                                                                ),
                                                              ],
                                                            ) : null,
                                                          ),
                                                        ),
                                                      ),
                                                      state.hasError ? Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                "${state.errorText}",
                                                                style: const TextStyle(color: Colors.red)
                                                            )
                                                          ],
                                                        ),
                                                      ) : Container(),
                                                    ],
                                                  );
                                                },
                                              ),
                                              Expanded(
                                                  child: Container()
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Container()
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      Uint8List? resultUint8List;
                                                      resultUint8List = await PickerImage.getImage("galeria");
                                                      if (resultUint8List != null) {
                                                        setState(() {
                                                          _imageBase64 = resultUint8List;
                                                        });
                                                      }
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide(color: blackColor)
                                                        ),
                                                        elevation: 0,
                                                      backgroundColor: greyListTile,
                                                      foregroundColor: blackColor
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons.upload,
                                                          color: blackColor,
                                                        ),
                                                        Expanded(
                                                          child: FittedBox(
                                                            fit: BoxFit.scaleDown,
                                                            child: Text(
                                                              "Trocar Imagem",
                                                              style: GoogleFonts.fredoka(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 16,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container()
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ListTile(
                                                            title: Text(
                                                              "Horários",
                                                              style: GoogleFonts.fredoka(
                                                                color: blackColor,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            tileColor: greyListTile,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    Card(
                                                      color: greyListTile,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: ListTile(
                                                                  title: Text(
                                                                    "Segunda-feira",
                                                                    style: GoogleFonts.fredoka(
                                                                      color: blackColor,
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  trailing: TextButton.icon(
                                                                    key: keyMonday,
                                                                    onPressed: () async {
                                                                      RenderBox box = keyMonday.currentContext?.findRenderObject() as RenderBox;
                                                                      Offset offset = box.localToGlobal(Offset.zero); //this is global position
                                                                      showMenu(
                                                                          context: context,
                                                                          position: RelativeRect.fromLTRB(
                                                                            offset.dx,
                                                                            offset.dy,
                                                                            MediaQuery.of(context).size.width - offset.dx,
                                                                            MediaQuery.of(context).size.height - offset.dy,
                                                                          ),
                                                                          items: [
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  monday = await showTimeRangePicker(
                                                                                    context: context,
                                                                                    start: monday?.startTime,
                                                                                    end: monday?.endTime
                                                                                  );
                                                                                  if (kDebugMode) {
                                                                                    print("startTime ${monday?.startTime}");
                                                                                    print("endTime ${monday?.endTime}");
                                                                                  }
                                                                                  setState(() {

                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                    "Selecionar horário",
                                                                                  style: GoogleFonts.fredoka(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            ),
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  setState(() {
                                                                                    monday = null;
                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                    "Fechado",
                                                                                  style: GoogleFonts.fredoka(
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            )
                                                                          ]
                                                                      );
                                                                    },
                                                                    label: Text(
                                                                      timeRangeConvert(monday),
                                                                      style: GoogleFonts.fredoka(
                                                                          fontSize: 12,
                                                                          color: blackColor87
                                                                      ),
                                                                    ),
                                                                    iconAlignment: IconAlignment.end,
                                                                    icon: Icon(
                                                                        FontAwesomeIcons.caretDown,
                                                                      color: blackColor87,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: ListTile(
                                                                  title: Text(
                                                                    "Terça-feira",
                                                                    style: GoogleFonts.fredoka(
                                                                      color: blackColor,
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  trailing: TextButton.icon(
                                                                    key: keyTuesday,
                                                                    onPressed: () async {
                                                                      RenderBox box = keyTuesday.currentContext?.findRenderObject() as RenderBox;
                                                                      Offset offset = box.localToGlobal(Offset.zero); //this is global position
                                                                      showMenu(
                                                                          context: context,
                                                                          position: RelativeRect.fromLTRB(
                                                                            offset.dx,
                                                                            offset.dy,
                                                                            MediaQuery.of(context).size.width - offset.dx,
                                                                            MediaQuery.of(context).size.height - offset.dy,
                                                                          ),
                                                                          items: [
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  tuesday = await showTimeRangePicker(
                                                                                      context: context,
                                                                                      start: tuesday?.startTime,
                                                                                      end: tuesday?.endTime
                                                                                  );
                                                                                  if (kDebugMode) {
                                                                                    print("startTime ${tuesday?.startTime}");
                                                                                    print("endTime ${tuesday?.endTime}");
                                                                                  }
                                                                                  setState(() {

                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  "Selecionar horário",
                                                                                  style: GoogleFonts.fredoka(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            ),
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  setState(() {
                                                                                    tuesday = null;
                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  "Fechado",
                                                                                  style: GoogleFonts.fredoka(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            )
                                                                          ]
                                                                      );
                                                                    },
                                                                    label: Text(
                                                                      timeRangeConvert(tuesday),
                                                                      style: GoogleFonts.fredoka(
                                                                          fontSize: 12,
                                                                          color: blackColor87
                                                                      ),
                                                                    ),
                                                                    iconAlignment: IconAlignment.end,
                                                                    icon: Icon(
                                                                      FontAwesomeIcons.caretDown,
                                                                      color: blackColor87,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: ListTile(
                                                                  title: Text(
                                                                    "Quarta-feira",
                                                                    style: GoogleFonts.fredoka(
                                                                      color: blackColor,
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  trailing: TextButton.icon(
                                                                    key: keyWednesday,
                                                                    onPressed: () async {
                                                                      RenderBox box = keyWednesday.currentContext?.findRenderObject() as RenderBox;
                                                                      Offset offset = box.localToGlobal(Offset.zero); //this is global position
                                                                      showMenu(
                                                                          context: context,
                                                                          position: RelativeRect.fromLTRB(
                                                                            offset.dx,
                                                                            offset.dy,
                                                                            MediaQuery.of(context).size.width - offset.dx,
                                                                            MediaQuery.of(context).size.height - offset.dy,
                                                                          ),
                                                                          items: [
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  wednesday = await showTimeRangePicker(
                                                                                      context: context,
                                                                                      start: wednesday?.startTime,
                                                                                      end: wednesday?.endTime
                                                                                  );
                                                                                  if (kDebugMode) {
                                                                                    print("startTime ${wednesday?.startTime}");
                                                                                    print("endTime ${wednesday?.endTime}");
                                                                                  }
                                                                                  setState(() {

                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  "Selecionar horário",
                                                                                  style: GoogleFonts.fredoka(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            ),
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  setState(() {
                                                                                    wednesday = null;
                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  "Fechado",
                                                                                  style: GoogleFonts.fredoka(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            )
                                                                          ]
                                                                      );
                                                                    },
                                                                    label: Text(
                                                                      timeRangeConvert(wednesday),
                                                                      style: GoogleFonts.fredoka(
                                                                          fontSize: 12,
                                                                          color: blackColor87
                                                                      ),
                                                                    ),
                                                                    iconAlignment: IconAlignment.end,
                                                                    icon: Icon(
                                                                      FontAwesomeIcons.caretDown,
                                                                      color: blackColor87,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: ListTile(
                                                                  title: Text(
                                                                    "Quinta-feira",
                                                                    style: GoogleFonts.fredoka(
                                                                      color: blackColor,
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  trailing: TextButton.icon(
                                                                    key: keyThursday,
                                                                    onPressed: () async {
                                                                      RenderBox box = keyThursday.currentContext?.findRenderObject() as RenderBox;
                                                                      Offset offset = box.localToGlobal(Offset.zero); //this is global position
                                                                      showMenu(
                                                                          context: context,
                                                                          position: RelativeRect.fromLTRB(
                                                                            offset.dx,
                                                                            offset.dy,
                                                                            MediaQuery.of(context).size.width - offset.dx,
                                                                            MediaQuery.of(context).size.height - offset.dy,
                                                                          ),
                                                                          items: [
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  thursday = await showTimeRangePicker(
                                                                                      context: context,
                                                                                      start: thursday?.startTime,
                                                                                      end: thursday?.endTime
                                                                                  );
                                                                                  if (kDebugMode) {
                                                                                    print("startTime ${thursday?.startTime}");
                                                                                    print("endTime ${thursday?.endTime}");
                                                                                  }
                                                                                  setState(() {

                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  "Selecionar horário",
                                                                                  style: GoogleFonts.fredoka(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            ),
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  setState(() {
                                                                                    thursday = null;
                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  "Fechado",
                                                                                  style: GoogleFonts.fredoka(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            )
                                                                          ]
                                                                      );
                                                                    },
                                                                    label: Text(
                                                                      timeRangeConvert(thursday),
                                                                      style: GoogleFonts.fredoka(
                                                                          fontSize: 12,
                                                                          color: blackColor87
                                                                      ),
                                                                    ),
                                                                    iconAlignment: IconAlignment.end,
                                                                    icon: Icon(
                                                                      FontAwesomeIcons.caretDown,
                                                                      color: blackColor87,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: ListTile(
                                                                  title: Text(
                                                                    "Sexta-feira",
                                                                    style: GoogleFonts.fredoka(
                                                                      color: blackColor,
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  trailing: TextButton.icon(
                                                                    key: keyFriday,
                                                                    onPressed: () async {
                                                                      RenderBox box = keyFriday.currentContext?.findRenderObject() as RenderBox;
                                                                      Offset offset = box.localToGlobal(Offset.zero); //this is global position
                                                                      showMenu(
                                                                          context: context,
                                                                          position: RelativeRect.fromLTRB(
                                                                            offset.dx,
                                                                            offset.dy,
                                                                            MediaQuery.of(context).size.width - offset.dx,
                                                                            MediaQuery.of(context).size.height - offset.dy,
                                                                          ),
                                                                          items: [
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  friday = await showTimeRangePicker(
                                                                                      context: context,
                                                                                      start: friday?.startTime,
                                                                                      end: friday?.endTime
                                                                                  );
                                                                                  if (kDebugMode) {
                                                                                    print("startTime ${friday?.startTime}");
                                                                                    print("endTime ${friday?.endTime}");
                                                                                  }
                                                                                  setState(() {

                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  "Selecionar horário",
                                                                                  style: GoogleFonts.fredoka(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            ),
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  setState(() {
                                                                                    friday = null;
                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  "Fechado",
                                                                                  style: GoogleFonts.fredoka(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            )
                                                                          ]
                                                                      );
                                                                    },
                                                                    label: Text(
                                                                      timeRangeConvert(friday),
                                                                      style: GoogleFonts.fredoka(
                                                                          fontSize: 12,
                                                                          color: blackColor87
                                                                      ),
                                                                    ),
                                                                    iconAlignment: IconAlignment.end,
                                                                    icon: Icon(
                                                                      FontAwesomeIcons.caretDown,
                                                                      color: blackColor87,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: ListTile(
                                                                  title: Text(
                                                                    "Sábado",
                                                                    style: GoogleFonts.fredoka(
                                                                      color: blackColor,
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  trailing: TextButton.icon(
                                                                    key: keySaturday,
                                                                    onPressed: () async {
                                                                      RenderBox box = keySaturday.currentContext?.findRenderObject() as RenderBox;
                                                                      Offset offset = box.localToGlobal(Offset.zero); //this is global position
                                                                      showMenu(
                                                                          context: context,
                                                                          position: RelativeRect.fromLTRB(
                                                                            offset.dx,
                                                                            offset.dy,
                                                                            MediaQuery.of(context).size.width - offset.dx,
                                                                            MediaQuery.of(context).size.height - offset.dy,
                                                                          ),
                                                                          items: [
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  saturday = await showTimeRangePicker(
                                                                                      context: context,
                                                                                      start: saturday?.startTime,
                                                                                      end: saturday?.endTime
                                                                                  );
                                                                                  if (kDebugMode) {
                                                                                    print("startTime ${saturday?.startTime}");
                                                                                    print("endTime ${saturday?.endTime}");
                                                                                  }
                                                                                  setState(() {

                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  "Selecionar horário",
                                                                                  style: GoogleFonts.fredoka(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            ),
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  setState(() {
                                                                                    saturday = null;
                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  "Fechado",
                                                                                  style: GoogleFonts.fredoka(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            )
                                                                          ]
                                                                      );
                                                                    },
                                                                    label: Text(
                                                                      timeRangeConvert(saturday),
                                                                      style: GoogleFonts.fredoka(
                                                                          fontSize: 12,
                                                                          color: blackColor87
                                                                      ),
                                                                    ),
                                                                    iconAlignment: IconAlignment.end,
                                                                    icon: Icon(
                                                                      FontAwesomeIcons.caretDown,
                                                                      color: blackColor87,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: ListTile(
                                                                  title: Text(
                                                                    "Domingo",
                                                                    style: GoogleFonts.fredoka(
                                                                      color: blackColor,
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w400,
                                                                    ),
                                                                  ),
                                                                  trailing: TextButton.icon(
                                                                    key: keySunday,
                                                                    onPressed: () async {
                                                                      RenderBox box = keySunday.currentContext?.findRenderObject() as RenderBox;
                                                                      Offset offset = box.localToGlobal(Offset.zero); //this is global position
                                                                      showMenu(
                                                                          context: context,
                                                                          position: RelativeRect.fromLTRB(
                                                                            offset.dx,
                                                                            offset.dy,
                                                                            MediaQuery.of(context).size.width - offset.dx,
                                                                            MediaQuery.of(context).size.height - offset.dy,
                                                                          ),
                                                                          items: [
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  sunday = await showTimeRangePicker(
                                                                                      context: context,
                                                                                      start: sunday?.startTime,
                                                                                      end: sunday?.endTime
                                                                                  );
                                                                                  if (kDebugMode) {
                                                                                    print("startTime ${sunday?.startTime}");
                                                                                    print("endTime ${sunday?.endTime}");
                                                                                  }
                                                                                  setState(() {

                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  "Selecionar horário",
                                                                                  style: GoogleFonts.fredoka(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            ),
                                                                            PopupMenuItem(
                                                                                value: 0,
                                                                                onTap: () async {
                                                                                  setState(() {
                                                                                    sunday = null;
                                                                                  });
                                                                                },
                                                                                child: Text(
                                                                                  "Fechado",
                                                                                  style: GoogleFonts.fredoka(
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400
                                                                                  ),
                                                                                )
                                                                            )
                                                                          ]
                                                                      );
                                                                    },
                                                                    label: Text(
                                                                      timeRangeConvert(sunday),
                                                                      style: GoogleFonts.fredoka(
                                                                          fontSize: 12,
                                                                          color: blackColor87
                                                                      ),
                                                                    ),
                                                                    iconAlignment: IconAlignment.end,
                                                                    icon: Icon(
                                                                      FontAwesomeIcons.caretDown,
                                                                      color: blackColor87,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                    ),

                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ListTile(
                                                          title: Text(
                                                            "Informações da oferta",
                                                            style: GoogleFonts.fredoka(
                                                              color: blackColor,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          tileColor: greyListTile,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  InputRegisterOffer(
                                                    colorCard: Colors.transparent,
                                                    texto: 'Nome da oferta',
                                                    controllerName: offerName,
                                                    hintText: 'Digite o nome da oferta',
                                                    keyboardType: TextInputType.text,
                                                    validator: (valor) {
                                                      if (offerName.text.length > 3) {
                                                        return null;
                                                      }else{
                                                        return "Digite o nome da oferta";
                                                      }
                                                    },
                                                    onSubmitted: (valor) {
                                                      //onPressedElevatedButton!();
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  InputRegisterOffer(
                                                    colorCard: Colors.transparent,
                                                    texto: 'Categoria',
                                                    controllerName: categoryOffer,
                                                    hintText: 'Digite o categoria da oferta',
                                                    keyboardType: TextInputType.text,
                                                    validator: (valor) {
                                                      if (categoryOffer.text.length > 3) {
                                                        return null;
                                                      }else{
                                                        return "Digite a categoria da oferta";
                                                      }
                                                    },
                                                    onSubmitted: (valor) {
                                                      //onPressedElevatedButton!();
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Divider(
                                                    color: blackColor87,
                                                    thickness: 0.1,
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  FormField(
                                                    initialValue: selectTypeOffers,
                                                    validator: (validator) {
                                                      if (selectTypeOffers != null) {
                                                        return null;
                                                      }
                                                      return "Selecione o tipo de oferta";
                                                    },
                                                    builder: (FormFieldState<dynamic> state) {
                                                      return Column(
                                                        children: [
                                                          Padding(
                                                              padding: const EdgeInsets.all(8),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: FittedBox(
                                                                      fit: BoxFit.scaleDown,
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Text(
                                                                        "Tipo da oferta:",
                                                                        style: GoogleFonts.fredoka(
                                                                          color: blackColor,
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        textAlign: TextAlign.left,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Container(),
                                                                  )
                                                                ],
                                                              )
                                                          ),
                                                          SizedBox(
                                                              height: 32,
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: ListView.builder(
                                                                      itemCount: typeOffers.length,
                                                                      shrinkWrap: true,
                                                                      scrollDirection: Axis.horizontal,
                                                                      itemBuilder: (BuildContext context, int index) {
                                                                        TypeOffer typeOffer = typeOffers[index];
                                                                        return Padding(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                          child: ChoiceChip.elevated(
                                                                            label: Text(
                                                                              "${typeOffer.name}",
                                                                              style: GoogleFonts.fredoka(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 14
                                                                              ),
                                                                            ),
                                                                            selectedColor: primaryColor,
                                                                            backgroundColor: greyListTile,
                                                                            checkmarkColor: blackColor,
                                                                            selected: selectTypeOffers?.id == typeOffer.id ? true : false,
                                                                            onSelected: (bool selected) {
                                                                              setState(() {
                                                                                selectTypeOffers = selectTypeOffers != typeOffer ? typeOffer : null;
                                                                              });
                                                                            },
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                          ),
                                                          state.hasError ? Padding(
                                                            padding: EdgeInsets.symmetric(vertical: 4),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                    "${state.errorText}",
                                                                    style: const TextStyle(color: Colors.red)
                                                                )
                                                              ],
                                                            ),
                                                          ) : Container(),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  InputRegisterOffer(
                                                    colorCard: Colors.transparent,
                                                    texto: 'Descrição da oferta',
                                                    controllerName: descriptionOffer,
                                                    hintText: 'Digite a descrição da oferta',
                                                    keyboardType: TextInputType.text,
                                                    maxLines: 5,
                                                    validator: (valor) {
                                                      if (descriptionOffer.text.length > 10) {
                                                        return null;
                                                      }else{
                                                        return "Digite a descrição da oferta";
                                                      }
                                                    },
                                                    onSubmitted: (valor) {
                                                      //onPressedElevatedButton!();
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(
                                                    children: [
                                                      CustomElevatedButton(
                                                          onPressed: () {
                                                            if (_formKey.currentState!.validate()) {
                                                              if (kDebugMode) {
                                                                print("Validado");
                                                                save(context);
                                                              }
                                                            }else{
                                                              if (kDebugMode) {
                                                                print("Não validado");
                                                              }
                                                            }
                                                          },
                                                          text: "Salvar",
                                                          background: primaryColor
                                                      ),
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      CustomElevatedButton(
                                                          onPressed: () {

                                                          },
                                                          text: "Excluir",
                                                          background: whiteColor
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
