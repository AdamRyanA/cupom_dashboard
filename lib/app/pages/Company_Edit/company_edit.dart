import 'dart:typed_data';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:cupom_dashboard/data/models/address.dart';
import 'package:cupom_dashboard/data/models/models.dart';
import 'package:cupom_dashboard/domain/usecases/company_process.dart';
import 'package:diacritic/diacritic.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../../data/helpers/picker_image.dart';
import '../../../data/models/categorys.dart';
import '../../../data/models/response_api.dart';
import '../../../domain/usecases/Authentication.dart';
import '../../../domain/usecases/category_process.dart';
import '../../utils/colors.dart';
import '../../utils/paths.dart';
import '../../widgets/InputRegister.dart';
import '../../widgets/ResponsiveView.dart';
import '../../widgets/custom_elevated_button.dart';

class CompanyEdit extends StatefulWidget {
  final ScreenArguments? screenArguments;
  const CompanyEdit(this.screenArguments, {super.key});

  @override
  State<CompanyEdit> createState() => _CompanyEditState();
}

class _CompanyEditState extends State<CompanyEdit> {


  double n = 0.9;

  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDocNumber = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Uint8List? _imageBase64;

  bool loading = false;

  Address address = Address.toNull();

  Categorys? selectCategory;

  List<Categorys> categorys = [

  ];

  getCategorys() async {
    ResponseAPI? responseAPI = await CategoryProcess.get();
    if (responseAPI != null) {
      if (responseAPI.categorys != null) {
        setState(() {
          categorys = responseAPI.categorys!;
        });
      }
    }
    updateFields();
  }

  updateFields() async {
    if (widget.screenArguments?.company != null) {
      controllerName.text = widget.screenArguments?.company?.name ?? "";
      controllerEmail.text = widget.screenArguments?.company?.email ?? "";
      phoneController.text = widget.screenArguments?.company?.phone ?? "";
      controllerDocNumber.text = widget.screenArguments?.company?.docNumber ?? "";
      if(widget.screenArguments?.company?.address != null) {
        address = widget.screenArguments!.company!.address!;
      }
      if (widget.screenArguments?.company?.photo != null) {
        _imageBase64 = await PickerImage.loadImageFromNetwork("${widget.screenArguments?.company?.photo}");
      }
      if (widget.screenArguments?.company?.category != null) {
        selectCategory = widget.screenArguments?.company?.category;
      }
    }
    setState(() {
      loading = false;
    });
  }

  save(BuildContext context) async {
    setState(() {
      loading = true;
    });
    EasyLoading.show(status: "Salvando...");
    ResponseAPI? responseResult;
    responseResult = await CompanyProcess.put(
      id: '${widget.screenArguments?.company?.id}',
      name: controllerName.text,
      email: controllerEmail.text,
      phone: UtilBrasilFields.removeCaracteres(phoneController.text),
      docNumber: UtilBrasilFields.removeCaracteres(controllerDocNumber.text),
      category: "",
      address: address,
      photo: _imageBase64 == null ? null : PickerImage.convertUint8ListToBase64(_imageBase64!),
    );
    EasyLoading.dismiss();
    if (responseResult != null) {
      EasyLoading.showToast("Atualizado empresa");
      if (widget.screenArguments?.company?.address == null) {
        Authentication.checkUser(context, true);
      }else{
        Navigator.pop(context);
      }
    }else{
      EasyLoading.showToast("Erro ao salvar empresa");
    }
    setState(() {
      loading = false;
    });
  }


  @override
  void initState() {
    getCategorys();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                body: loading ? Center(
                  child: CircularProgressIndicator(
                    color: whiteColor,
                  ),
                ) : Container(
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
                        const SizedBox(
                          height: 64,
                        ),
                        kIsWeb ? Container(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder()
                              ),
                              onPressed: () async {
                                Uint8List? resultUint8List;
                                resultUint8List = await PickerImage.getImage("galeria");
                                if (resultUint8List != null) {
                                  setState(() {
                                    _imageBase64 = resultUint8List;
                                  });
                                }
                              },
                              child: CircleAvatar(
                                radius: 100,
                                backgroundColor: Colors.grey,
                                backgroundImage: _imageBase64 == null
                                    ? null
                                    : MemoryImage(_imageBase64!),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: _imageBase64 == null
                                      ? const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_a_photo,
                                        size: 80,
                                        color: Colors.white,
                                      ),
                                    ],
                                  )
                                      : Container(),
                                ),
                              )
                          ),
                        )
                            : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: _imageBase64 == null
                                          ? null
                                          : MemoryImage(_imageBase64!),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: _imageBase64 == null
                                            ? const Icon(FontAwesomeIcons.userLarge,
                                          size: 50,
                                          color: Colors.white,
                                        )
                                            : Container(),
                                      ),
                                    ),
                                  ),
                                  _imageBase64 != null ? Positioned(
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.red,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _imageBase64 = null;
                                          });
                                        },
                                        icon: const Icon(FontAwesomeIcons.xmark),
                                        color: whiteColor,
                                      ),
                                    ),
                                  ) : Positioned(
                                    right: 0,
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: CustomElevatedButton(
                                      onPressed: () async {
                                        Uint8List? resultUint8List;
                                        resultUint8List = await PickerImage.getImage("camera");
                                        if (resultUint8List != null) {
                                          setState(() {
                                            _imageBase64 = resultUint8List;
                                          });
                                        }
                                      },
                                      text: "Câmera",
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: CustomElevatedButton(
                                      onPressed: () async {
                                        Uint8List? resultUint8List;
                                        resultUint8List = await PickerImage.getImage("galeria");
                                        if (resultUint8List != null) {
                                          setState(() {
                                            _imageBase64 = resultUint8List;
                                          });
                                        }
                                      },
                                      text: "Galeria",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        InputRegister(
                          colorCard: Colors.transparent,
                          texto: 'Nome do estabelecimento',
                          controllerName: controllerName,
                          hintText: 'Digite o nome da estabelecimento',
                          validator: (valor) {
                            if (controllerName.text.length > 3) {
                              return null;
                            }else{
                              return "Digite o nome da estabelecimento";
                            }
                          },
                          onSubmitted: (valor) {
                            save(context);
                          },
                        ),
                        InputRegister(
                          colorCard: Colors.transparent,
                          texto: 'CNPJ',
                          controllerName: controllerDocNumber,
                          hintText: 'Digite o CNPJ',
                          keyboardType: TextInputType.number,
                          enabled: false,
                          validator: (valor) {
                            if (UtilBrasilFields.isCNPJValido(controllerDocNumber.text)) {
                              return null;
                            }else{
                              return "CNPJ Inválido";
                            }
                          },
                          format: [
                            FilteringTextInputFormatter.digitsOnly,
                            CnpjInputFormatter(),
                          ],
                          onSubmitted: (valor) {
                            save(context);
                          },
                        ),
                        InputRegister(
                          colorCard: Colors.transparent,
                          texto: 'E-mail',
                          controllerName: controllerEmail,
                          hintText: 'Digite seu E-mail',
                          enabled: false,
                          validator: (valor) {
                            if (EmailValidator.validate(controllerEmail.text)) {
                              return null;
                            }else{
                              return "Digite um E-mail válido";
                            }
                          },
                          onSubmitted: (valor) {
                            save(context);
                          },
                        ),
                        InputRegister(
                          colorCard: Colors.transparent,
                          texto: 'Telefone',
                          controllerName: phoneController,
                          hintText: 'Digite seu Telefone',
                          keyboardType: TextInputType.number,
                          validator: (valor) {
                            if (UtilBrasilFields.removeCaracteres(phoneController.text).length == 11) {
                              return null;
                            }else{
                              return "Digite um telefone válido";
                            }
                          },
                          format: [
                            TelefoneInputFormatter(),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onSubmitted: (valor) {
                            save(context);
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 300,
                          child: DropdownSearch<Categorys?>(
                            popupProps: const PopupProps.dialog(
                              showSelectedItems: true,
                              showSearchBox: true,
                            ),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                suffixIconColor: blackColor,
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(color: whiteColor, width: 1)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: primaryColor)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: primaryColor)
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(color: Colors.red)
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(color: Colors.red)
                                ),
                                //labelStyle: paragraphXS.apply(fontSizeDelta: 3),
                                labelText: "Categoria",
                                labelStyle: TextStyle(
                                    color: blackColor
                                ),
                                hintText: "Selecione uma categoria...",
                                //floatingLabelStyle: paragraphXS.apply(fontSizeDelta: 7),
                              ),
                            ),
                            validator: (Categorys? item) {
                              if (item == null) {
                                return "Selecione uma categoria";
                              }else{
                                return null;
                              }
                            },
                            selectedItem: selectCategory,
                            items: categorys,
                            itemAsString: (Categorys? data) => data?.category ?? "Selecione uma categoria",
                            onChanged: (Categorys? data) {
                              if (kDebugMode) {
                                print(data);
                              }
                              selectCategory = data;
                            },
                            compareFn: (item, selectedItem) => item.toString().toLowerCase() == removeDiacritics(selectedItem.toString().toLowerCase()),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 300,
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (kDebugMode) {
                                        print("Validate");
                                      }
                                      if (loading == false) {
                                        save(context);
                                      }
                                    }else{
                                      if (kDebugMode) {
                                        print("Not validate");
                                      }
                                    }
                                  },
                                  text: "Salvar",
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}