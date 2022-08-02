import 'package:flutter/material.dart';
import 'package:tecni_repuestos/models/models.dart';
import 'package:tecni_repuestos/theme/themes.dart';

class DialogSelectRol {
  static displaySelectRol(
      {required BuildContext context,
      void Function()? onPressed,
      required User user}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              elevation: 10,
              title: Text('Defina un rol',
                  style: CustomTextStyle.robotoExtraBold.copyWith(fontSize: 35),
                  textAlign: TextAlign.center),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: StateFull(
                user: user,
              ));
        });
  }
}

class StateFull extends StatefulWidget {
  const StateFull({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  // ignore: no_logic_in_create_state
  State<StateFull> createState() => _StateFullState(user: user);
}

class _StateFullState extends State<StateFull> {
  _StateFullState({required this.user});
  final User user;
  late bool valorRol = (user.administrator)
      ? true
      : (user.vendor)
          ? true
          : true;
  int selectedRadio = 0;

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RadioListTile(
          value: 1,
          groupValue: selectedRadio,
          onChanged: (val) {
            print('$val');
            setSelectedRadio(int.parse(val.toString()));
          },
          title: const Text('Administrador'),
        ),
        RadioListTile(
          value: 2,
          groupValue: selectedRadio,
          onChanged: (val) {
            print('$val');
            setSelectedRadio(int.parse(val.toString()));
          },
          title: const Text('Vendedor'),
        ),
        RadioListTile(
          value: 3,
          groupValue: selectedRadio,
          onChanged: (val) {
            print('$val');
            setSelectedRadio(int.parse(val.toString()));
          },
          title: const Text('Usuario'),
        )
      ],
    );
  }
}
