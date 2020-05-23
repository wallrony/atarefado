import 'package:afazeres/model/todo.dart';
import 'package:afazeres/providers/todo_list_provider.dart';
import 'package:afazeres/utils/utils.dart';
import 'package:afazeres/widgets/custom_button.dart';
import 'package:afazeres/widgets/custom_button_icon.dart';
import 'package:afazeres/widgets/custom_form_field.dart';
import 'package:afazeres/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddTodoPage extends StatefulWidget {
  final TODO todoToEdit;

  AddTodoPage({this.todoToEdit});

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _addTodoFormKey = GlobalKey<FormState>();

  final _todoNameController = TextEditingController();
  final _todoDescriptionController = TextEditingController();
  final _todoDateController = TextEditingController();

  String _dateFieldText = "Escolha a data da tarefa *";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.todoToEdit != null) {
      _dateFieldText = widget.todoToEdit.date;
      _todoNameController.text = widget.todoToEdit.name;
      _todoDescriptionController.text = widget.todoToEdit.description;
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black12,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.999),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Container(
          width: double.maxFinite,
          child: CustomText(
            text: widget.todoToEdit != null
                ? "Editar Tarefa"
                : "Adicionar Tarefa",
            align: TextAlign.right,
            isBold: true,
            fontSize: 26,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
          );

          return true;
        },
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.black12,
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(
                top: 25,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(48),
                  bottomRight: Radius.circular(48),
                ),
              ),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    addTodoForm(),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: CustomButton(
                        onPressed: () {
                          if (widget.todoToEdit != null) {
                            editTodo(
                              _todoNameController.text,
                              _todoDescriptionController.text,
                              _dateFieldText,
                            );
                          } else {
                            saveTodo(
                              _todoNameController.text,
                              _todoDescriptionController.text,
                              _dateFieldText,
                            );
                          }
                        },
                        label: "Finalizar",
                        bottomBtn: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: CustomText(
                text:
                "Obs.: itens com pequenos asterísticos são obrigatórios, viu?",
                fontSize: 12,
                color: Colors.black54,
                align: TextAlign.justify,
              ),
            ),
          ],),
        ),
      ),
    );
  }

  addTODOFormTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: "Adicionar Tarefa",
          fontSize: 20,
          isBold: true,
        ),
        Icon(
          Icons.add,
          size: 48,
          color: Colors.cyan,
        )
      ],
    );
  }

  addTodoForm() {
    return Builder(builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _addTodoFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomFormField(
                _todoNameController,
                label: "Nome da tarefa *",
                validateFunction: verifyTODOName,
              ),
              SizedBox(height: 4),
              CustomFormField(
                _todoDescriptionController,
                label: "Descrição da tarefa",
                validateFunction: verifyTODODescription,
                maxLines: 2,
              ),
              SizedBox(height: 16),
              CustomButtonIcon(
                label: _dateFieldText,
                icon: Icon(Icons.calendar_today),
                isBold: false,
                backgroundColor: Colors.black.withOpacity(.03),
                itensColor: Colors.black87,
                fullWidth: true,
                onPressed: () async {
                  var selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year),
                    lastDate: DateTime(DateTime.now().year + 2),
                  );

                  if (selectedDate == null) {
                    setState(() {
                      _dateFieldText = "Escolha a data da tarefa *";
                    });

                    return;
                  }

                  _todoDateController.text =
                      "${selectedDate.day < 10 ? "0${selectedDate.day}" : selectedDate.day}/${selectedDate.month < 10 ? "0${selectedDate.month}" : selectedDate.month}/${selectedDate.year}";

                  setState(() {
                    _dateFieldText = _todoDateController.text;
                  });
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  editTodo(String name, String description, String date) async {
    if (!_addTodoFormKey.currentState.validate()) {
      return;
    } else if (date.isEmpty) {
      Toast.show(
        "Você precisa adicionar a data da tarefa!",
        context,
        duration: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );

      return;
    }

    showLoadingDialog(context);

    TODO todo = new TODO(
      id: widget.todoToEdit.id,
      name: name,
      description: description,
      date: date,
      realized: false,
    );

    await Provider.of<TODOListProvider>(context, listen: false)
        .updateTodo(-1, todo);

    closeLoadingDialog(context);
    Navigator.of(context).pop();
  }

  saveTodo(String name, String description, String date) async {
    if (!_addTodoFormKey.currentState.validate()) {
      return;
    } else if (date.isEmpty) {
      Toast.show(
        "Você precisa adicionar a data da tarefa!",
        context,
        duration: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );

      return;
    }

    showLoadingDialog(context);

    TODO todo = new TODO(
        name: name, description: description, date: date, realized: false);

    await Provider.of<TODOListProvider>(context, listen: false).addTodo(todo);

    closeLoadingDialog(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    Navigator.of(context).pop();
  }

  verifyTODOName(String text) {
    var result;

    if (text.isEmpty) {
      result = "Você precisa digitar o nome da tarefa!";
    }

    return result;
  }

  verifyTODODescription(String text) {
    return null;
  }
}
