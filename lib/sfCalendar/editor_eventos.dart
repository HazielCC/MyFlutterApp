import 'package:agenda/sfCalendar/alma_local/provider_sf.dart';
import 'package:agenda/sfCalendar/alma_local/utilidades.dart';
import 'package:agenda/sfCalendar/eventos.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Notas/provider/theme_provider.dart';

import 'package:flutter/material.dart';

class EditEventos extends StatefulWidget {
  final Event? event;

  const EditEventos({Key? key, this.event}) : super(key: key);

  @override
  State<EditEventos> createState() => _EditEventosState();
}

class _EditEventosState extends State<EditEventos> {
  late DateTime fromDate;
  late DateTime toDate;

  final _formKey = GlobalKey<FormState>();
  final tittleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now().add(const Duration(hours: 2));
      toDate = DateTime.now().add(const Duration(hours: 3));
    } else {
      final event = widget.event!;
      tittleController.text = event.tittle;
      fromDate = event.from;
      toDate = event.to;
    }
  }

  // dispose
  @override
  void dispose() {
    tittleController.dispose();

    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final lightTheme =
        themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode;

    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: buildEditingActions(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTile(),
              const SizedBox(height: 12),
              buildDateTimePickers()
            ],
          ),
        ),
      ),
    );
  }

  // Botones en appbar
  List<Widget> buildEditingActions() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final lightTheme =
        themeProvider.hiveLocalStorage.fontStyleBox.getAt(0)!.lightMode;

    return [
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: saveForm,
        icon: Icon(
          Icons.check,
          color: lightTheme == false
              ? const Color(0xFFe8e9e9)
              : const Color(0xFF323233),
        ),
        label: Text(
          'Guardar',
          style: TextStyle(
            color: lightTheme == false
                ? const Color(0xFFe8e9e9)
                : const Color(0xFF323233),
          ),
        ),
      ),
    ];
  }

  // Recuadro especificador de titulo
  Widget buildTile() => TextFormField(
        style: const TextStyle(fontSize: 24),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          //this gonna show a messages when nothing is written
          hintText: 'Prueba',
        ),
        onFieldSubmitted: (_) => saveForm(),
        //if the tittle is not emty we show thats no rigth bro
        validator: (Tittle) => Tittle != null && Tittle.isEmpty
            ? ' el titulo no puede ser 0'
            : null,
        controller: tittleController,
      );
  // Pestañas
  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );
  // buildDropdownField genera las flechitas hacia abajo
  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );
  // buildHeader estilo de encabezado
  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          child,
        ],
      );
  //Save
  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final event = Event(
        tittle: tittleController.text,
        description: 'Descripcción',
        from: fromDate,
        to: toDate,
        isAllDay: false,
      );
      final isEditing = widget.event != null;
      final provider = Provider.of<EventProvider>(context, listen: false);

      if (isEditing) {
        provider.editEvent(event, widget.event!);
        Navigator.of(context).pop();
      } else {
        provider.addEvent(event);
      }
      Navigator.of(context).pop();
    }
  }

  //// Primera parte para seleccionar la fecha ////

  Widget buildFrom() => buildHeader(
        header: 'De que día',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utilidades.toDate(fromDate),
                onClicked: () => pickfromDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utilidades.toTime(fromDate),
                onClicked: () => pickfromDateTime(pickDate: false),
              ),
            )
          ],
        ),
      );
  // Se selecciona el dia y hora de la primera parte
  Future pickfromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);

    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate = DateTime(
        date.year,
        date.month,
        date.day,
        toDate.hour,
        toDate.minute,
      );
    }
    setState(() => fromDate = date);
  }

  // Se especifica sobre la fecha de inicio de la primera
  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      if (date == null) return null;

      final time = Duration(
        hours: initialDate.hour,
        minutes: initialDate.minute,
      );
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(
        hours: timeOfDay.hour,
        minutes: timeOfDay.minute,
      );
      return date.add(time);
    }
  }

  //// Segunda parte para seleccionar segunda fecha ////
  Widget buildTo() => buildHeader(
        header: 'A que día',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utilidades.toDate(toDate),
                onClicked: () => pickToTimeDate(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utilidades.toTime(toDate),
                onClicked: () => pickToTimeDate(pickDate: false),
              ),
            )
          ],
        ),
      );
  // Se selecciona el dia y hora de la segunda parte
  Future pickToTimeDate({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);
  }
}
