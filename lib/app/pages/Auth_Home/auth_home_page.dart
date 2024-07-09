import 'package:brasil_fields/brasil_fields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupom_dashboard/app/utils/route_generator.dart';
import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:cupom_dashboard/data/models/models.dart';
import 'package:cupom_dashboard/data/models/response_api.dart';
import 'package:cupom_dashboard/domain/usecases/offer_process.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../../data/models/offer.dart';
import '../../../domain/usecases/Authentication.dart';
import '../../utils/colors.dart';
import '../../utils/paths.dart';
import '../../widgets/ResponsiveView.dart';
import '../../widgets/full_screen_image.dart';

class AuthHomePage extends StatefulWidget {
  final ScreenArguments? screenArguments;
  const AuthHomePage(this.screenArguments, {super.key});

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {


  List<Offer> offers = [];

  getOffers() async {
    ResponseAPI? responseAPI = await OfferProcess.get(company: widget.screenArguments?.company?.id);
    if (responseAPI != null) {
      if (responseAPI.offers != null) {
        setState(() {
          offers = responseAPI.offers!;
        });
      }
    }
  }


  @override
  void initState() {
    getOffers();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ResponsiveView(
      child: LayoutBuilder(
          builder: (context, constraints) {
            double largura = constraints.maxWidth;
            double altura = constraints.maxHeight;
            return Scaffold(
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
                              Expanded(
                                child: Text(
                                  "Painel Empresas",
                                  style: GoogleFonts.fredoka(
                                    color: blackColor,
                                    fontSize: 34,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  PanaraConfirmDialog.showAnimatedFromBottom(
                                      context,
                                      title: "Deseja realmente sair?",
                                      message: "Você será redirecionado a tela de autenticação",
                                      confirmButtonText: "Confirmar",
                                      cancelButtonText: "Cancelar",
                                      onTapConfirm: () async {
                                        Navigator.of(context).pop();
                                        Authentication.signOut(context);
                                      },
                                      onTapCancel: (){
                                        Navigator.pop(context);
                                      },
                                      panaraDialogType: PanaraDialogType.warning
                                  );
                                },
                                style: TextButton.styleFrom(foregroundColor: primaryLightColor),
                                child: Text(
                                  "Sair",
                                  style: GoogleFonts.fredoka(
                                    color: blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
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
                                                child: CachedNetworkImage(
                                                  imageUrl: "${widget.screenArguments?.company?.photo}",
                                                  imageBuilder: (context, imageProvider) => GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (BuildContext context) {
                                                            return FullScreenImage(
                                                              initialIndex: 0,
                                                              images: ["${widget.screenArguments?.company?.photo}"],
                                                            );
                                                          })
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit.cover
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  fit: BoxFit.fitWidth,
                                                  width: 180,
                                                  height: 180,
                                                  errorWidget: (context, url, error) => const Icon(
                                                    FontAwesomeIcons.building,
                                                  ),
                                                )
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
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "${widget.screenArguments?.company?.name}",
                                                  style: GoogleFonts.fredoka(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 24,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "CNPJ: ${UtilBrasilFields.obterCnpj("${widget.screenArguments?.company?.docNumber}")}",
                                                  style: GoogleFonts.fredoka(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16,
                                                      color: greyColorText
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
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
                                                          title: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  "Informações da Conta",
                                                                  style: GoogleFonts.fredoka(
                                                                    color: blackColor,
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              IconButton(
                                                                  onPressed: () async {
                                                                    ScreenArguments? screenArgumentsNavigator = widget.screenArguments;
                                                                    await Navigator.pushNamed(context, RouteGenerator.rCompanyEdit, arguments: screenArgumentsNavigator);
                                                                  },
                                                                  icon: Icon(
                                                                      FontAwesomeIcons.edit,
                                                                    color: blackColor,
                                                                  )
                                                              )
                                                            ],
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
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ListTile(
                                                        title: Text(
                                                          "Minhas Ofertas",
                                                          style: GoogleFonts.fredoka(
                                                            color: blackColor,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        tileColor: greyListTile,
                                                        trailing: TextButton.icon(
                                                          onPressed: () async {
                                                            if (widget.screenArguments?.company?.enabled == true) {
                                                              ScreenArguments? screenArgumentsNavigator = widget.screenArguments;
                                                              screenArgumentsNavigator?.offer = null;
                                                              await Navigator.pushNamed(context, RouteGenerator.rOfferPage, arguments: screenArgumentsNavigator);
                                                              getOffers();
                                                            }else{
                                                              PanaraInfoDialog.show(context,
                                                                  message: "Sua empresa ainda não foi aprovada. Aguarde a aprovação para adicionar ofertas.",
                                                                  buttonText: "Ok",
                                                                  onTapDismiss: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  panaraDialogType: PanaraDialogType.warning
                                                              );
                                                            }
                                                          },
                                                          icon: Icon(
                                                            FontAwesomeIcons.add,
                                                            color: blackColor,
                                                          ),
                                                          label: Text("Adicionar nova oferta",
                                                            style: GoogleFonts.fredoka(
                                                              color: blackColor,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ListView.builder(
                                                  itemCount: offers.length,
                                                  shrinkWrap: true,
                                                  physics: const ScrollPhysics(),
                                                  itemBuilder: (BuildContext context, int index) {
                                                    Offer offer = offers[index];
                                                    return Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: ListTile(
                                                              leading: Card(
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(15.0),
                                                                    side: BorderSide(
                                                                      color: greyColorText,
                                                                      width: 1.0,
                                                                    ),
                                                                  ),
                                                                  semanticContainer: true,
                                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                  child: CachedNetworkImage(
                                                                    imageUrl: "${widget.screenArguments?.company?.photo}",
                                                                    imageBuilder: (context, imageProvider) => GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.push(context, MaterialPageRoute(
                                                                            builder: (BuildContext context) {
                                                                              return FullScreenImage(
                                                                                initialIndex: 0,
                                                                                images: ["${widget.screenArguments?.company?.photo}"],
                                                                              );
                                                                            })
                                                                        );
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          image: DecorationImage(
                                                                              image: imageProvider,
                                                                              fit: BoxFit.cover
                                                                          ),
                                                                        ),
                                                                        width: 64,
                                                                        height: 64,
                                                                      ),
                                                                    ),
                                                                    fit: BoxFit.fill,
                                                                    width: 64,
                                                                    height: 64,
                                                                    errorWidget: (context, url, error) => const Icon(
                                                                      FontAwesomeIcons.building,
                                                                    ),
                                                                  )
                                                              ),
                                                              title: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      "${offer.name}",
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                      child: ChoiceChip.elevated(
                                                                        label: Text(
                                                                          "${offer.typeOffer?.name}",
                                                                          style: GoogleFonts.fredoka(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 14,
                                                                              color: blackColor
                                                                          ),
                                                                        ),
                                                                        selectedColor: primaryColor,
                                                                        backgroundColor: greyListTile,
                                                                        checkmarkColor: blackColor,
                                                                        selected: true,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                      onPressed: () async {
                                                                        ScreenArguments? screenArgumentsResult = widget.screenArguments;
                                                                        screenArgumentsResult?.offer = offer;
                                                                        await Navigator.pushNamed(context, RouteGenerator.rOfferPage, arguments: screenArgumentsResult);
                                                                        getOffers();
                                                                      },
                                                                      icon: const Icon(
                                                                          FontAwesomeIcons.penToSquare
                                                                      )
                                                                  ),
                                                                  IconButton(
                                                                      onPressed: () async {
                                                                        ResponseAPI? responseAPI = await OfferProcess.delete(
                                                                            id: offer.id,
                                                                            company: offer.company?.id
                                                                        );
                                                                        if (responseAPI != null) {
                                                                          await PanaraInfoDialog.show(
                                                                              context,
                                                                              message: "Oferta deletada",
                                                                              buttonText: "OK",
                                                                              onTapDismiss: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              panaraDialogType: PanaraDialogType.success
                                                                          );
                                                                          getOffers();
                                                                        }else{
                                                                          await PanaraInfoDialog.show(
                                                                              context,
                                                                              message: "Erro ao deletar oferta",
                                                                              buttonText: "OK",
                                                                              onTapDismiss: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              panaraDialogType: PanaraDialogType.error
                                                                          );
                                                                          getOffers();
                                                                        }
                                                                      },
                                                                      icon: const Icon(
                                                                          FontAwesomeIcons.trash
                                                                      )
                                                                  ),
                                                                ],
                                                              ),
                                                              tileColor: greyListTile,
                                                                minTileHeight: 80
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),

                                                const SizedBox(
                                                  height: 16,
                                                ),
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
            );
          }
      ),
    );
  }
}
