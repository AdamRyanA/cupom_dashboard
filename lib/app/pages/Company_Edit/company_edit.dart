import 'package:cupom_dashboard/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../../data/helpers/launch_url.dart';
import '../../../domain/usecases/Authentication.dart';
import '../../utils/colors.dart';
import '../../utils/paths.dart';
import '../../utils/typography.dart';
import '../../widgets/ResponsiveView.dart';
import '../Auth_Home/auth_home_page.dart';

class CompanyEdit extends StatefulWidget {
  final ScreenArguments? screenArguments;
  const CompanyEdit(this.screenArguments, {super.key});

  @override
  State<CompanyEdit> createState() => _CompanyEditState();
}

class _CompanyEditState extends State<CompanyEdit> {


  double n = 0.9;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveView(
      child: LayoutBuilder(
          builder: (context, constraints) {
            double largura = constraints.maxWidth;
            double altura = constraints.maxHeight;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                    "Dados da Empresa",
                  style: GoogleFonts.fredoka(
                    color: blackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
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
              extendBodyBehindAppBar: true,
              backgroundColor: primaryColor,
              body: Container(
                width: double.infinity,
                height: altura,
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          /*
                          Container(
                            height: 64,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    primaryLightColor.withOpacity(0.0),
                                    whiteColor
                                  ],
                                )
                            ),
                          )
                           */
                        ],
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