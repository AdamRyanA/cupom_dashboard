import 'package:cupom_dashboard/app/utils/utils.dart';
import 'package:cupom_dashboard/app/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewOfferPage extends StatefulWidget {
  const NewOfferPage({Key? key}) : super(key: key);

  @override
  State<NewOfferPage> createState() => _NewOfferPageState();
}

class _NewOfferPageState extends State<NewOfferPage> {

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerCategoria = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();
  
  bool twoDish = false;
  bool fiftyOff = false;
  bool dessertFree = false;
  bool fortyOff = false;
  bool thirtyOff = false;
  onTap(int n){
    setState(() {
      twoDish = false;
      fiftyOff = false;
      dessertFree = false;
      fortyOff = false;
      thirtyOff = false;

      if(n==1) twoDish = true;
      if(n==2) fiftyOff = true;
      if(n==3) dessertFree = true;
      if(n==4) fortyOff = true;
      if(n==5) thirtyOff = true;
    });
  }

  late String timeSegunda;
  late String timeTerca;
  late String timeQuarta;
  late String timeQuinta;
  late String timeSexta;
  late String timeSabado;
  late String timeDomingo;
  TimeRange? timeRange;
  selectTime() async {
    TimeRange? result = await showTimeRangePicker(
      context: context,
      start: timeRange!.startTime,
      end: timeRange!.endTime,
      ticks: 24,
      ticksOffset: -12,
      ticksLength: 15,
      ticksColor: Colors.grey,
      labels: [
        "12 pm",
        "3 am",
        "6 am",
        "9 am",
        "12 pm",
        "3 pm",
        "6 pm",
        "9 pm"
      ].asMap().entries.map((e) {
        return ClockLabel.fromIndex(
            idx: e.key, length: 8, text: e.value);
      }).toList(),
      labelOffset: 35,
      rotateLabels: false,
      padding: 60,
      strokeColor: blackColor60,
      handlerColor: primaryColor,
      selectedColor: primaryLightColor,
      timeColor: primaryColor,
      buttonStyle: TextButton.styleFrom(foregroundColor: blackColor87),
    );
    if (kDebugMode) {
      print("result $result");
    }
    return result;
  }

  initial(){
    TimeOfDay startTime = TimeOfDay.now();
    timeRange = TimeRange(
        startTime: startTime,
        endTime: TimeOfDay(hour: startTime.hour + 3, minute: startTime.minute)
    );
    print(timeRange);

    timeSegunda = 'Fechado';
    timeTerca = 'Fechado';
    timeQuarta = 'Fechado';
    timeQuinta = 'Fechado';
    timeSexta = 'Fechado';
    timeSabado = 'Fechado';
    timeDomingo = 'Fechado';
  }
  
  @override
  void initState() {
    super.initState();
    initial();
  }
  
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
                          'Nova Oferta',
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
                              Text(
                                'Imagem da oferta',
                                style: heading5,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      ImagesPath.logo,
                                    )
                                  ),
                                  borderRadius: BorderRadius.circular(16)
                                ),
                              ),
                              const SizedBox(height: 8),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: greyNeutro60Color,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    side: BorderSide(color: blueColor, width: 1.5),
                                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                    fixedSize: const Size(200, 0)
                                ),
                                onPressed: (){},
                                icon: Icon(
                                  Icons.file_upload_outlined,
                                  color: blackColor87,
                                ),
                                label: Text(
                                  'Trocar Imagem',
                                  style: caption.copyWith(color: blackColor87)
                                ),
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
                              'Horários',
                              style: button.copyWith(color: blackColor87),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                            decoration: BoxDecoration(
                                color: primaryLightColor,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            width: double.infinity,
                            child: Column(
                              children: [
                                ListTime(
                                  label: 'Segunda-feira',
                                  time: timeSegunda,
                                  onSelected: (item) async {
                                    if (item == 1) {
                                      TimeRange? timeRangeSelect = await selectTime();
                                      if(timeRangeSelect != null){
                                        timeRange = timeRangeSelect;
                                        setState(() {
                                          timeSegunda = '$timeRange';
                                        });
                                      }

                                    }else if (item == 2) {
                                      setState(()=> timeSegunda = 'Fechado');
                                    }
                                  },
                                ),
                                ListTime(
                                  label: 'Terça-feira',
                                  time: timeTerca,
                                  onSelected: (item) async {
                                    if (item == 1) {
                                      TimeRange? timeRangeSelect = await selectTime();
                                      if(timeRangeSelect != null){
                                        timeRange = timeRangeSelect;
                                        setState(() {
                                          timeTerca = '$timeRange';
                                        });
                                      }

                                    }else if (item == 2) {
                                      setState(()=> timeTerca = 'Fechado');
                                    }
                                  },
                                ),
                                ListTime(
                                  label: 'Quarta-feira',
                                  time: timeQuarta,
                                  onSelected: (item) async {
                                    if (item == 1) {
                                      TimeRange? timeRangeSelect = await selectTime();
                                      if(timeRangeSelect != null){
                                        timeRange = timeRangeSelect;
                                        setState(() {
                                          timeQuarta = '$timeRange';
                                        });
                                      }

                                    }else if (item == 2) {
                                      setState(()=> timeQuarta = 'Fechado');
                                    }
                                  },
                                ),
                                ListTime(
                                  label: 'Quinta-feira',
                                  time: timeQuinta,
                                  onSelected: (item) async {
                                    if (item == 1) {
                                      TimeRange? timeRangeSelect = await selectTime();
                                      if(timeRangeSelect != null){
                                        timeRange = timeRangeSelect;
                                        setState(() {
                                          timeQuinta = '$timeRange';
                                        });
                                      }

                                    }else if (item == 2) {
                                      setState(()=> timeQuinta = 'Fechado');
                                    }
                                  },
                                ),
                                ListTime(
                                  label: 'Sexta-feira',
                                  time: timeSexta,
                                  onSelected: (item) async {
                                    if (item == 1) {
                                      TimeRange? timeRangeSelect = await selectTime();
                                      if(timeRangeSelect != null){
                                        timeRange = timeRangeSelect;
                                        setState(() {
                                          timeSexta = '$timeRange';
                                        });
                                      }

                                    }else if (item == 2) {
                                      setState(()=> timeSexta = 'Fechado');
                                    }
                                  },
                                ),
                                ListTime(
                                  label: 'Sábado',
                                  time: timeSabado,
                                  onSelected: (item) async {
                                    if (item == 1) {
                                      TimeRange? timeRangeSelect = await selectTime();
                                      if(timeRangeSelect != null){
                                        timeRange = timeRangeSelect;
                                        setState(() {
                                          timeSabado = '$timeRange';
                                        });
                                      }

                                    }else if (item == 2) {
                                      setState(()=> timeSabado = 'Fechado');
                                    }
                                  },
                                ),
                                ListTime(
                                  label: 'Domingo',
                                  time: timeDomingo,
                                  onSelected: (item) async {
                                    if (item == 1) {
                                      TimeRange? timeRangeSelect = await selectTime();
                                      if(timeRangeSelect != null){
                                        timeRange = timeRangeSelect;
                                        setState(() {
                                          timeDomingo = '$timeRange';
                                        });
                                      }

                                    }else if (item == 2) {
                                      setState(()=> timeDomingo = 'Fechado');
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                'Informações da oferta',
                                style: button.copyWith(color: blackColor87),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 24, 12, 6),
                          width: 278,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InputCustom(
                                controller: controllerName,
                                hint: '',
                                label: 'Nome da Oferta',
                                radius: 4,
                              ),
                              InputCustom(
                                controller: controllerCategoria,
                                hint: '',
                                label: 'Categoria',
                                radius: 4,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 4, 0, 16),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                            color: blackColor.withOpacity(0.12),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tipo de oferta:',
                              style: subtitle2,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                ButtonCustom(
                                    label: 'Dois pratos por um',
                                    select: twoDish,
                                    onTap: (){
                                      onTap(1);
                                    }
                                ),
                                ButtonCustom(
                                    label: '50% off',
                                    select: fiftyOff,
                                    onTap: (){
                                      onTap(2);
                                    }
                                ),
                                ButtonCustom(
                                    label: 'Sobremesa grátis',
                                    select: dessertFree,
                                    onTap: (){
                                      onTap(3);
                                    }
                                ),
                                ButtonCustom(
                                    label: '40% off',
                                    select: fortyOff,
                                    onTap: (){
                                      onTap(4);
                                    }
                                ),
                                ButtonCustom(
                                    label: '30% off',
                                    select: thirtyOff,
                                    onTap: (){
                                      onTap(5);
                                    }
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                          child: InputCustom(
                              controller: controllerDescricao,
                              hint: '',
                              label: 'Descrição da Oferta',
                            radius: 4,
                            maxLines: true,
                          ),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                              ),
                                onPressed: (){},
                                child: Text(
                                  'Salvar',
                                  style: button.copyWith(color: blackColor87),
                                )
                            ),
                            const SizedBox(width: 24),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: whiteColor,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    side: BorderSide(width: 1.5, color: blueColor)
                                ),
                                onPressed: (){},
                                child: Text(
                                  'Excluir',
                                  style: button.copyWith(color: blackColor87),
                                )
                            ),
                          ],
                        )
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

class ButtonCustom extends StatelessWidget {

  final String label;
  final bool select;
  final void Function() onTap;

  const ButtonCustom({Key? key, required this.label, required this.select, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
            decoration: BoxDecoration(
                color: select ? primaryColor : null,
                borderRadius: BorderRadius.circular(30),
              border: select ? null : Border.all(width: 1, color: blackColor)
            ),
            child: Text(
              label,
              style: button.copyWith(fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}

class ListTime extends StatelessWidget {
  final String label;
  final String time;
  final void Function(int)? onSelected;
  const ListTime({Key? key, required this.label, required this.time, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: caption.copyWith(color: blackColor60),
          ),
          PopupMenuButton(
              surfaceTintColor: whiteColor,
              splashRadius: 0,
              tooltip: '',
              onSelected: onSelected,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                        'Selecionar horário',
                        style: body2.copyWith(color: blackColor87)
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text(
                        'Fechado',
                        style: body2.copyWith(color: blackColor87)
                    ),
                  ),
                ];
              },
              child: Row(
                children: [
                  Text(
                    time,
                    style: caption.copyWith(color: blackColor60),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 16,
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}

