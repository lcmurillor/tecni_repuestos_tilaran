import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/providers/providers.dart';
import 'package:tecni_repuestos/services/services.dart';
import 'package:tecni_repuestos/theme/themes.dart';
import 'package:tecni_repuestos/widgets/widgets.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:intl/intl.dart';

class ShipmentDetailScreen extends StatelessWidget {
  ///Ésta widget corresponde a la pantalla en la cual se muestran los detalles del estado del envío
  ///de cada orden efectuada por el usuario. En esta el usuario puede hacer un seguimiento de su orden
  ///y una vez recibida la orden, puede marcar el paquete como recibido.
  const ShipmentDetailScreen({Key? key, required this.order}) : super(key: key);
  final Order order;
  @override
  Widget build(BuildContext context) {
    final currentPage = Provider.of<ComeFromProvider>(context);
    return Builder(builder: (context) {
      return SafeArea(
        child: Scaffold(
            body: Background(
          useBackArrow: true,
          useImg: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 110),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text('Detalles del envío',
                            textAlign: TextAlign.center,
                            style: CustomTextStyle.robotoMedium
                                .copyWith(fontSize: 40)),
                        _orderInfo(context: context, order: order),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ///Corresponde a la columna izquierda donde se describen las diferentes estapas del envío.
                              Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Center(
                                      child: Text('Etapa',
                                          style: CustomTextStyle.robotoSemiBold
                                              .copyWith(fontSize: 25)),
                                    ),
                                  ),
                                  _moldeRow(text: 'En proceso'),
                                  _moldeRow(text: 'Enviado'),
                                  _moldeRow(text: 'En camino'),
                                  _moldeRow(text: 'Entregado'),
                                ],
                              ),

                              ///Barra en el medio que muestra de manera gráfica el progreso del envío.
                              SizedBox(
                                height: 200,
                                child: FAProgressBar(
                                  borderRadius: BorderRadius.circular(25),
                                  size: 10,
                                  backgroundColor: Colors.black12,
                                  changeProgressColor: ColorStyle.mainGreen,
                                  currentValue: order.status.toDouble(),
                                  progressColor: ColorStyle.mainGreen,
                                  maxValue: 5,
                                  direction: Axis.vertical,
                                  verticalDirection: VerticalDirection.down,
                                ),
                              ),

                              ///Corresponde a la columna derecha donde se describre el estado del envio.
                              Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Center(
                                      child: Text('Estado',
                                          style: CustomTextStyle.robotoSemiBold
                                              .copyWith(fontSize: 25)),
                                    ),
                                  ),
                                  if (currentPage.getScreen() ==
                                      'adminOrder') ...{
                                    if (order.status < 2) ...{
                                      _ActionButton(
                                          order: order,
                                          currentPage: currentPage,
                                          title: 'Procesar',
                                          process: 2)
                                    } else ...{
                                      SizedBox(
                                          height: 50,
                                          width: 100,
                                          child: Icon(Icons.check,
                                              color: ColorStyle.mainGreen,
                                              size: 40))
                                    },
                                    if (order.status < 3) ...{
                                      _ActionButton(
                                          order: order,
                                          currentPage: currentPage,
                                          title: 'Enviar',
                                          process: 3)
                                    } else ...{
                                      SizedBox(
                                          height: 50,
                                          width: 100,
                                          child: Icon(Icons.check,
                                              color: ColorStyle.mainGreen,
                                              size: 40))
                                    },
                                    if (order.status < 4) ...{
                                      _ActionButton(
                                          order: order,
                                          currentPage: currentPage,
                                          title: 'En camino',
                                          process: 4)
                                    } else ...{
                                      SizedBox(
                                          height: 50,
                                          width: 100,
                                          child: Icon(Icons.check,
                                              color: ColorStyle.mainGreen,
                                              size: 40))
                                    },
                                    if (order.status < 5) ...{
                                      _ActionButton(
                                          order: order,
                                          currentPage: currentPage,
                                          process: 5)
                                    } else ...{
                                      SizedBox(
                                          height: 50,
                                          width: 100,
                                          child: Icon(Icons.check,
                                              color: ColorStyle.mainGreen,
                                              size: 40))
                                    },
                                  } else ...{
                                    _moldeRowStatus(
                                        status: order.status, proces: 2),
                                    _moldeRowStatus(
                                        status: order.status, proces: 3),
                                    _moldeRowStatus(
                                        status: order.status, proces: 4),
                                    _moldeRowStatus(
                                        status: order.status,
                                        proces: 5,
                                        currentPage: currentPage),
                                  },
                                ],
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      );
    });
  }

  SizedBox _moldeRowStatus(
      {required int status,
      required int proces,
      ComeFromProvider? currentPage}) {
    return SizedBox(
      height: 50,
      width: 100,
      child: (status >= proces)
          ? Icon(Icons.check, color: ColorStyle.mainGreen, size: 40)
          : (status == 4 && proces == 5)
              ? _ActionButton(
                  order: order, currentPage: currentPage!, process: 5)
              : const CustomProgressIndicator(),
    );
  }

  SizedBox _moldeRow({required String text}) {
    return SizedBox(
      height: 50,
      width: 100,
      child: Center(
        child: Text(text,
            style: CustomTextStyle.robotoMedium.copyWith(fontSize: 17)),
      ),
    );
  }

  ///Corresponde al espacio en la parte superior donde se muestra información relacionada al envío.
  _orderInfo({required BuildContext context, required Order order}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 30),
          _moldeRowInfo(
              title: 'Fecha estimada de llegada: ',
              value: DateFormat('dd-MM-yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(order.arrivelDate))),
          const SizedBox(height: 10),
          _moldeRowInfo(title: 'Medio de envío: ', value: order.shippingMethod),
          const SizedBox(height: 10),
          _moldeRowInfo(title: 'Código guía: ', value: order.shippingCode),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Row _moldeRowInfo(
      {required String title,
      required String value,
      Color color = const Color.fromRGBO(143, 143, 143, 1)}) {
    return Row(
      children: [
        Text(title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyle.robotoExtraBold),
        Text(
          value,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: color, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key? key,
    required this.order,
    required this.currentPage,
    this.title = 'Recibido',
    required this.process,
  }) : super(key: key);

  final Order order;
  final ComeFromProvider currentPage;
  final String title;
  final int process;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: ColorStyle.mainGreen,
      child: SizedBox(
        width: 90,
        height: 40,
        child: Center(
          child: Text(title,
              style: CustomTextStyle.robotoMedium
                  .copyWith(fontSize: 17, color: Colors.white)),
        ),
      ),
      onPressed: () {
        if (order.status < 2 && process == 2) {
          NotificationsService.displayDeleteDialog(
              context: context,
              title: 'Confirmar',
              text:
                  '¿Está seguro que desea indicar el inicio de proceso de trámite de la orden: ${order.id}?',
              onPressed: () {
                FirebaseRealtimeService.updateOrderStatus(
                        orderId: order.id, status: process)
                    .then((value) => Navigator.pushReplacementNamed(
                        context, currentPage.getScreen()));
              });
        } else if (order.status < 3 && process == 3) {
          DialogOrderCode.displaySetVoucher(context: context, order: order);
        } else if (order.status < 4 && process == 4) {
          FirebaseRealtimeService.updateOrderStatus(
                  orderId: order.id, status: process)
              .then((value) => Navigator.pushReplacementNamed(
                  context, currentPage.getScreen()));
        } else if (order.status < 5 && process == 5) {
          NotificationsService.displayDeleteDialog(
              context: context,
              title: 'Confirmar',
              text:
                  '¿Está seguro que desea indicar que le ha llegado la orden ${order.id}?',
              onPressed: () {
                FirebaseRealtimeService.updateOrderStatus(
                        orderId: order.id, status: process)
                    .then((value) => Navigator.pushReplacementNamed(
                        context, currentPage.getScreen()));
              });
        }
      },
    );
  }
}
