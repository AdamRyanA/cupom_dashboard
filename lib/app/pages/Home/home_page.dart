import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double n = 0.9;

  var key1 = GlobalKey();
  var key2 = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double largura = constraints.maxWidth;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImagesPath.background),
                      fit: BoxFit.cover
                    )
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                style: TextButton.styleFrom(foregroundColor: primaryLightColor),
                                onPressed: (){},
                                child: Text(
                                    'Início',
                                  style: heading6,
                                )
                            ),
                            TextButton(
                                style: TextButton.styleFrom(foregroundColor: primaryLightColor),
                                onPressed: (){
                                  Scrollable.ensureVisible(key1.currentContext!,
                                      duration: const Duration(
                                          seconds: 1
                                      ),
                                      curve: Curves.decelerate
                                  );
                                },
                                child: Text(
                                    'Benefícios',
                                  style: heading6,
                                )
                            ),
                            TextButton(
                                style: TextButton.styleFrom(foregroundColor: primaryLightColor),
                                onPressed: (){
                                    Scrollable.ensureVisible(key2.currentContext!,
                                        duration: const Duration(
                                            seconds: 1
                                        ),
                                        curve: Curves.decelerate
                                    );
                                },
                                child: Text(
                                    'Plano',
                                  style: heading6,
                                )
                            ),
                            const SizedBox(width: 32),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                                  foregroundColor: primaryLightColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                              ),
                                onPressed: (){},
                                child: Text(
                                    'Login parceiros',
                                  style: button.copyWith(color: blueColor),
                                )
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(64, 64, 64, 128),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              ImagesPath.logo,
                              height: 183,
                              width: 183,
                            ),
                            //const SizedBox(width: 64),
                            Column(
                              children: [
                                SizedBox(
                                  width: 570,
                                  child: Text(
                                    'O app de experiências da sua cidade.',
                                    style: heading3.copyWith(color: blueDarkColor),
                                  ),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(foregroundColor: primaryLightColor),
                                      onPressed: (){},
                                      child: SizedBox(
                                        height: 64,
                                        width: 165,
                                        child: Image.asset(
                                            ImagesPath.googlePlay,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(foregroundColor: primaryLightColor),
                                      onPressed: (){},
                                      child: SizedBox(
                                        height: 57,
                                        width: 186,
                                        child: Image.asset(
                                            ImagesPath.appStore,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
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
                    ],
                  ),
                ),
                Container(
                  color: whiteColor,
                  child: Column(
                    children: [
                      //const SizedBox(height: 128),

                      const SizedBox(height: 128),
                      Container(
                        key: key1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(ImagesPath.smartphone),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 32),
                                  child: Text('Benefícios', style: heading4),
                                ),
                                const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CardCustom(
                                        icon: Icons.check_circle_outline,
                                        label: 'Melhor uso do app ao lado'
                                    ),
                                    CardCustom(
                                        icon: Icons.local_fire_department_outlined,
                                        label: 'Todas as ofertas do interior'
                                    ),
                                  ],
                                ),
                                const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CardCustom(
                                        icon: Icons.emoji_objects_outlined,
                                        label: 'O mais perfeito app'
                                    ),
                                    CardCustom(
                                        icon: Icons.card_giftcard_rounded,
                                        label: 'Somente 1 ano dá benefícios pra sempre'
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Container(
                                          width: 59,
                                          height: 15,
                                          decoration: BoxDecoration(
                                              color: blueColor,
                                            borderRadius: BorderRadius.circular(19)
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Container(
                                          width: 59,
                                          height: 15,
                                          decoration: BoxDecoration(
                                              color: greyDarkColor,
                                            borderRadius: BorderRadius.circular(19)
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Container(
                                          width: 59,
                                          height: 15,
                                          decoration: BoxDecoration(
                                              color: greyDarkColor,
                                            borderRadius: BorderRadius.circular(19)
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Container(
                                          width: 59,
                                          height: 15,
                                          decoration: BoxDecoration(
                                              color: greyDarkColor,
                                            borderRadius: BorderRadius.circular(19)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 128),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                ImagesPath.frame508,
                                fit: BoxFit.scaleDown,
                                height: 300*n,
                                width: 300*n,
                              )
                            ],
                          ),
                          SizedBox(
                            width: largura*0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(width: 240),
                                    Expanded(
                                      child: Text(
                                        'Diferenciais',
                                        style: heading4.copyWith(color: blueDarkColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(width: 240),
                                    Expanded(
                                      child: SizedBox(
                                        height: 66,
                                        child: Center(
                                          child: Text(
                                            'Nosso app',
                                            style: heading6.copyWith(color: blackColor),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const TableCustom(label: 'Fácil de usar', top: true),
                                const TableCustom(label: 'Maior cobertura no interior'),
                                const TableCustom(label: 'Mais opções de Lazer'),
                                const TableCustom(label: 'Melhor usabilidade'),
                                const TableCustom(label: 'Visualizar restaurantes gratuitamente'),
                                const TableCustom(label: 'Maior cobertura no interior'),
                                const TableCustom(label: 'Uso na hora'),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                ImagesPath.frame511,
                                fit: BoxFit.scaleDown,
                                height: 400*n,
                                width: 450*n,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 128),
                      Container(
                        key: key2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(ImagesPath.frame509),
                            SizedBox(
                              width: largura*0.4,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(width: 200),
                                      Expanded(
                                        child: Text(
                                          'Assinatura',
                                          style: heading4.copyWith(color: blueDarkColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                  TableCustom(
                                    label: '',
                                    width: 200,
                                    color: whiteColor,
                                    top: true,
                                    icon: 'Anual',
                                  ),
                                  TableCustom(
                                    label: 'Maior cobertura no interior',
                                    width: 200,
                                    color: greyNeutroColor,
                                  ),
                                  TableCustom(
                                    label: 'Maior cobertura no interior',
                                    width: 200,
                                    color: greyNeutroColor,
                                  ),
                                  TableCustom(
                                    label: 'Suporte 24/7',
                                    width: 200,
                                    color: greyNeutroColor,
                                    bottom: true,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 128),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(40),
                  //color: primaryLightColor,
                  height: 220,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Mapa do Site', style: heading6,),
                          Text('Início', style: body1.copyWith(color: blackColor60)),
                          Text('Serviços', style: body1.copyWith(color: blackColor60)),
                          Text('Planos', style: body1.copyWith(color: blackColor60)),

                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Contato', style: heading6,),
                          Text('Whatsapp: (11) 99282-92812', style: body1.copyWith(color: blackColor60)),
                          Text('Telefone Fixo: (11) 2748-9221', style: body1.copyWith(color: blackColor60)),
                          Text('E-mail: suporteapp@compartilha.com', style: body1.copyWith(color: blackColor60)),
                        ],
                      ),
                      const SizedBox(width: 64),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              'Todos os direitos reservados',
                            style: body1.copyWith(color: blackColor60),
                          ),
                          Text(
                              'CNPJ: 391.029.129/001-09',
                            style: body1.copyWith(color: blackColor60),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}

class CardCustom extends StatelessWidget {
  final IconData icon;
  final String label;
  const CardCustom({Key? key, required this.icon, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: 176,
        child: Column(
          children: [
            Container(
              height: 142,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(31, 10, 31, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: primaryLightColor,
              ),
              child: Icon(icon, size: 65),
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: heading6,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class TableCustom extends StatelessWidget {
  final bool? top;
  final bool? bottom;
  final String label;
  final Color? color;
  final String? icon;
  final double? width;
  const TableCustom({Key? key, this.top = false, required this.label, this.bottom = false, this.color, this.icon, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: blackColor.withOpacity(0.12)))
            ),
            width: width ?? 240,
            height: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 9, 12, 9),
            child: Center(
              child: Text(
                label,
                style: subtitle1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: color ?? primaryLightColor,
                  borderRadius: BorderRadius.vertical(
                    top: top! ? const Radius.circular(16) : Radius.zero,
                    bottom: bottom! ? const Radius.circular(16) : Radius.zero,
                  ),
                  border: Border(
                      top: top! ? BorderSide(color: blackColor.withOpacity(0.12)) : BorderSide.none,
                      left: BorderSide(color: blackColor.withOpacity(0.12)),
                      right: BorderSide(color: blackColor.withOpacity(0.12)),
                      bottom: BorderSide(color: blackColor.withOpacity(0.12)),
                  )
              ),
              padding: const EdgeInsets.fromLTRB(12, 9, 12, 9),
              child: Center(
                child: icon != null
                    ? Text('$icon', style: heading6)
                    : const Icon(
                    Icons.check_outlined,
                    size: 24
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


