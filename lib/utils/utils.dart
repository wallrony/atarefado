import 'dart:ui';

import 'package:afazeres/model/todo.dart';
import 'package:afazeres/pages/add_todo_page.dart';
import 'package:afazeres/providers/todo_list_provider.dart';
import 'package:afazeres/utils/navigator.dart';
import 'package:afazeres/widgets/custom_button_icon.dart';
import 'package:afazeres/widgets/custom_text.dart';
import 'package:afazeres/widgets/custom_title.dart';
import 'package:afazeres/widgets/hero_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar makeAppBar(context) {
  return AppBar(
    leading: Container(),
    elevation: 0,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    centerTitle: true,
    title: Stack(
      alignment: Alignment.center,
      children: [
        Hero(
          tag: 'splash_atarefado_logo',
          child: Image.asset(
            'assets/images/atarefado_logo.png',
            fit: BoxFit.fill,
            height: 70,
          ),
        ),
      ],
    ),
  );
}

getDatePerExtense() {
  DateTime date = new DateTime.now();

  String text =
      "${date.day} de ${getMonthByIndex(date.month)} de ${date.year}.";

  return text;
}

getMonthByIndex(index) {
  switch (index) {
    case 1:
      return 'Janeiro';
    case 2:
      return 'Fevereiro';
    case 3:
      return 'Março';
    case 4:
      return 'Abril';
    case 5:
      return 'Maio';
    case 6:
      return 'Junho';
    case 7:
      return 'Julho';
    case 8:
      return 'Agosto';
    case 9:
      return 'Setembro';
    case 10:
      return 'Outubro';
    case 11:
      return 'Novembro';
    case 12:
      return 'Dezembro';
  }
}

todoNotRealizedImg({expanded = false}) {
  return imageAsset('assets/images/not_realized_todo.png', expanded);
}

todoRealizedImg({expanded = false}) {
  return imageAsset('assets/images/realized_todo.png', expanded);
}

imageAsset(String assetUrl, bool expanded) {
  return Image.asset(
    assetUrl,
    fit: BoxFit.fill,
    height: expanded ? 120 : 60,
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        shape: CircleBorder(),
        child: Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
          ),
        ),
      );
    },
  );
}

closeLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}

showCustomTODODialog(BuildContext context, TODO todo, Function onDelete,
    Function updateTODORealized, int index) {
  Navigator.push(
    context,
    new HeroDialogRoute(
      builder: (BuildContext context) {
        todo = Provider.of<TODOListProvider>(context, listen: true).list[index];

        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AlertDialog(
                          contentPadding: EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          titlePadding: EdgeInsets.all(0),
                          title: Container(
                            child: Row(
                              children: [
                                Hero(
                                  tag: '${todo.id}-${todo.date}',
                                  child: GestureDetector(
                                    onTap: () {
                                      updateTODORealized(index, todo);
                                    },
                                    child: AnimatedCrossFade(
                                      crossFadeState: todo.realized
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      firstChild:
                                          todoRealizedImg(expanded: true),
                                      secondChild:
                                          todoNotRealizedImg(expanded: true),
                                      duration: new Duration(milliseconds: 300),
                                    ),
                                  ),
                                ),
                                Column(children: [
                                  SizedBox(height: 8),
                                  Container(
                                    width: 125,
                                    child: CustomTitle(
                                      text: "${todo.name}",
                                      fontSize: 20,
                                    ),
                                  ),
                                  Container(
                                    width: 125,
                                    child: CustomTitle(
                                        text: "${todo.description}",
                                        fontSize: 14,
                                        color: Colors.black45),
                                  )
                                ]),
                              ],
                            ),
                          ),
                          content: Container(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Wrap(
                                  children: [
                                    CustomButtonIcon(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        push(
                                          context,
                                          AddTodoPage(
                                            todoToEdit: todo,
                                          ),
                                        );
                                      },
                                      label: "Editar",
                                      backgroundColor: Colors.transparent,
                                      withElevation: false,
                                      itensColor: Colors.black,
                                      fullWidth: false,
                                    ),
                                    CustomButtonIcon(
                                      icon: Icon(Icons.delete_forever),
                                      onPressed: () => onDelete(index),
                                      label: "Deletar",
                                      backgroundColor: Colors.transparent,
                                      withElevation: false,
                                      itensColor: Colors.black,
                                      fullWidth: false,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

makeTodoItem(int index, TODO todo, updateRealized, onItemClick) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Flexible(
        flex: 1,
        child: AnimatedContainer(
          duration: new Duration(milliseconds: 500),
          child: GestureDetector(
            onTap: () => updateRealized(index, todo),
            child: Hero(
              tag: '${todo.id}-${todo.date}',
              child: Container(
                child: AnimatedCrossFade(
                  crossFadeState: todo.realized
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: Container(
                    height: 50,
                    width: 50,
                    child: todoRealizedImg(expanded: true),
                  ),
                  secondChild: Container(
                    height: 50,
                    width: 50,
                    child: todoNotRealizedImg(expanded: true),
                  ),
                  duration: new Duration(milliseconds: 300),
                ),
              ),
            ),
          ),
        ),
      ),
      Flexible(
        flex: 8,
        child: GestureDetector(
          onTap: () => onItemClick(index, todo),
          child: AnimatedContainer(
            duration: new Duration(milliseconds: 400),
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: todo.realized ? Colors.cyan.withOpacity(.2) : Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: .7,
                  color: Colors.white.withOpacity(.2),
                  offset: Offset(2, 2),
                  spreadRadius: 2,
                ),
                BoxShadow(
                  blurRadius: .7,
                  color: todo.realized
                      ? Colors.cyan.withOpacity(.2)
                      : Colors.white.withOpacity(.2),
                  offset: Offset(2, 2),
                  spreadRadius: 2,
                ),
              ],
              borderRadius: BorderRadius.circular(
                6,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: todo.name,
                      fontSize: 18,
                    ),
                    todo.description.isNotEmpty
                        ? CustomText(
                            text: todo.description.length >= 25
                                ? "${todo.description.substring(0, 25)}..."
                                : todo.description,
                            fontSize: 14,
                            color: Colors.black45,
                          )
                        : Container(),
                  ],
                ),
                CustomText(text: todo.date, fontSize: 12),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

getActualDate() {
  var datetime = DateTime.now();

  var day = datetime.day < 10 ? "0${datetime.day}" : datetime.day;
  var month = datetime.month < 10 ? "0${datetime.month}" : datetime.month;

  var actualDate = "$day/$month/${datetime.year}";

  return actualDate;
}

getWeekDates() {
  var datetime = DateTime.now();

  datetime = datetime.subtract(new Duration(days: datetime.weekday));

  var dateList = <String>[];

  for (var i = 0; i <= 6; i++) {
    datetime = datetime.add(new Duration(days: 1));

    var day = datetime.day < 10 ? "0${datetime.day}" : datetime.day;
    var month = datetime.month < 10 ? "0${datetime.month}" : datetime.month;

    dateList.add("$day/$month/${datetime.year}");
  }

  return dateList;
}

List<Map<String, dynamic>> bottomNavigatorItens() {
  var actualDate = getActualDate();
  var weekDates = getWeekDates();

  var actualDayQuery = "todo_date=\"$actualDate\"";
  var weekQuery = "";

  for (int i = 0; i < weekDates.length; i++) {
    weekQuery += "todo_date=\"${weekDates[i]}\"";

    if (i < weekDates.length - 1) {
      weekQuery += " OR ";
    }
  }

  return [
    {
      "label": "Diário",
      "icon": Icon(Icons.calendar_view_day),
      "query_filter": actualDayQuery,
    },
    {
      "label": "Semanal",
      "icon": Icon(Icons.calendar_today),
      "query_filter": weekQuery
    },
    {
      "label": "Todos",
      "icon": Icon(Icons.line_style),
    },
  ];
}
