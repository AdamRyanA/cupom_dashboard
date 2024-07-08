import 'dart:typed_data';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupom_dashboard/app/widgets/custom_elevated_button.dart';
import 'package:cupom_dashboard/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/helpers/picker_image.dart';
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

  final _formKey = GlobalKey<FormState>();

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
                                    "Nova oferta",
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
                                                        elevation: 0
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
                                    /*
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
                                                              "Informações da Conta",
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
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ListTile(
                                                            title: Text(
                                                              "Categoria",
                                                              style: GoogleFonts.fredoka(
                                                                color: blackColor,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              "${widget.screenArguments?.company?.category?.category}",
                                                              style: GoogleFonts.fredoka(
                                                                color: blackColor87,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: blackColor87,
                                                      thickness: 0.1,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ListTile(
                                                            title: Text(
                                                              "CNPJ",
                                                              style: GoogleFonts.fredoka(
                                                                color: blackColor,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              UtilBrasilFields.obterCnpj(widget.screenArguments?.company?.docNumber ?? ""),
                                                              style: GoogleFonts.fredoka(
                                                                color: blackColor87,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: blackColor87,
                                                      thickness: 0.1,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ListTile(
                                                            title: Text(
                                                              "E-mail",
                                                              style: GoogleFonts.fredoka(
                                                                color: blackColor,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              "${widget.screenArguments?.company?.email}",
                                                              style: GoogleFonts.fredoka(
                                                                color: blackColor87,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: blackColor87,
                                                      thickness: 0.1,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ListTile(
                                                            title: Text(
                                                              "Telefone",
                                                              style: GoogleFonts.fredoka(
                                                                color: blackColor,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              UtilBrasilFields.obterTelefone(widget.screenArguments?.company?.phone ?? ""),
                                                              style: GoogleFonts.fredoka(
                                                                color: blackColor87,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: blackColor87,
                                                      thickness: 0.1,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ListTile(
                                                            title: Text(
                                                              "Endereço",
                                                              style: GoogleFonts.fredoka(
                                                                color: blackColor,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              "${widget.screenArguments?.company?.address?.addressLine1}",
                                                              style: GoogleFonts.fredoka(
                                                                color: blackColor87,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                     */
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
