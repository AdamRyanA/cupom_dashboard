import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:flutter/material.dart';

class CompanyPanelPage extends StatefulWidget {
  const CompanyPanelPage({Key? key}) : super(key: key);

  @override
  State<CompanyPanelPage> createState() => _CompanyPanelPageState();
}

class _CompanyPanelPageState extends State<CompanyPanelPage> {

  String cnpj = '90192020/001-29';
  String categoria = 'Restaurante';
  String nomeFantasia = 'Risoteria Malapensa';
  String email = 'RisoteriaMalapensa@gmail.com';
  String telefone = '(11) 9779-3396';
  String senha = '***************';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 375,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      image: const DecorationImage(
                          image: AssetImage(ImagesPath.background),
                          fit: BoxFit.fitWidth)
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(80, 44, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'Painel Empresas',
                          style: heading4,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 5,
                        shadowColor: greyColor.withOpacity(0.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        color: whiteColor,
                        child: Container(
                          width: 380,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: whiteColor,
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 179,
                                width: 179,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(ImagesPath.logo))
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Risoteria Malapensa LTDA',
                                style: heading5,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'CNPJ: $cnpj',
                                style: subtitle1.copyWith(color: blackColor60),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 32, 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: SizedBox(
                      width: 380,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                            decoration: BoxDecoration(
                                color: primaryLightColor,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            width: double.infinity,
                            child: Text(
                              'Informações da Conta',
                              style: button.copyWith(color: blackColor87),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          ListInfo(title: 'Categoria', subtitle: categoria),
                          ListInfo(title: 'Nome Fantasia', subtitle: nomeFantasia),
                          ListInfo(title: 'CNPJ', subtitle: cnpj),
                          ListInfo(title: 'Email', subtitle: email),
                          ListInfo(title: 'Telefone', subtitle: telefone),
                          ListInfo(title: 'Senha', subtitle: senha),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                          decoration: BoxDecoration(
                              color: primaryLightColor,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Minhas Ofertas',
                                style: button.copyWith(color: blackColor87),
                                textAlign: TextAlign.start,
                              ),
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                  foregroundColor: greyNeutro60Color
                                ),
                                  onPressed: (){
                                  Navigator.pushNamed(context, RouteGenerator.rNewOffer);
                                  },
                                  icon: Icon(
                                    Icons.add_box_outlined,
                                    color: blackColor87,
                                  ),
                                  label: Text(
                                      'Adiconar nova oferta',
                                      style: button.copyWith(color: blackColor87)
                                  )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  const ListInfo({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: greyNeutroColor))
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: body1),
              Text(subtitle, style: body2. copyWith(color: blackColor60)),
            ],
          ),
        ],
      ),
    );
  }
}
