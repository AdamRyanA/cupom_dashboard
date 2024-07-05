import 'package:brasil_fields/brasil_fields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupom_dashboard/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../../domain/usecases/Authentication.dart';
import '../../utils/colors.dart';
import '../../utils/paths.dart';
import '../../widgets/ResponsiveView.dart';
import '../../widgets/full_screen_image.dart';

class CompanyReviewPage extends StatefulWidget {
  final ScreenArguments? screenArguments;
  const CompanyReviewPage(this.screenArguments, {super.key});

  @override
  State<CompanyReviewPage> createState() => _CompanyReviewPageState();
}

class _CompanyReviewPageState extends State<CompanyReviewPage> {
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
              body: Container(
                width: double.infinity,
                height: altura,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(ImagesPath.background),
                            fit: BoxFit.cover,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              primaryColor,
                              primaryColor,
                            ],
                          ),
                        ),
                        child: Column(
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
