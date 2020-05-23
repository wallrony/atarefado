import 'dart:ui';
import 'package:afazeres/model/todo.dart';
import 'package:afazeres/pages/add_todo_page.dart';
import 'package:afazeres/providers/todo_list_provider.dart';
import 'package:afazeres/utils/navigator.dart';
import 'package:afazeres/utils/utils.dart';
import 'package:afazeres/widgets/custom_text.dart';
import 'package:afazeres/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  //final _animatedListKey = GlobalKey<AnimatedListState>();

  final List<Map<String, dynamic>> _navigatorItens = bottomNavigatorItens();

  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();

    getData(filter: _navigatorItens[_selectedIndex]['query_filter']);

    setUpColors();
  }

  getData({String filter}) {
    Provider.of<TODOListProvider>(context, listen: false)
        .loadTodoList(filter: filter);
  }

  @override
  Widget build(BuildContext context) {
    List<TODO> list = Provider.of<TODOListProvider>(context, listen: true).list;

    return Scaffold(
      appBar: makeAppBar(context),
      backgroundColor: Colors.white.withOpacity(.999),
      body: Container(
        color: Colors.black12,
        height: double.maxFinite,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(48.0),
                  bottomRight: Radius.circular(48.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: double.maxFinite,
                    child: CustomTitle(
                      text: "Lista de Tarefas",
                      fontSize: 36,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    width: double.infinity,
                    child: CustomText(
                      text: "Hoje, ${getDatePerExtense()}",
                      color: Colors.black45,
                    ),
                  ),
                  SizedBox(height: 25),
                  list == null ? Container() : listInfo(list),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            list == null
                ? Container(
                    margin: EdgeInsets.only(top: 35),
                    child: Center(
                      child: CustomText(text: "Carregando tarefas..."),
                    ),
                  )
                : list.isEmpty
                    ? Container(
                        padding: EdgeInsets.all(30),
                        child: CustomText(
                          text:
                              "Não há nenhuma tarefa cadastrada para esse dia.",
                          color: Colors.black54,
                        ),
                      )
                    : Flexible(
                        child: todoList(list),
                      ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          color: Colors.black12,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48.0),
                    topRight: Radius.circular(48.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var i = 0; i < _navigatorItens.length; i++)
                      bottomBarItem(
                        label: _navigatorItens[i]['label'],
                        icon: _navigatorItens[i]['icon'],
                        filter: _navigatorItens[i]['query_filter'],
                        index: i,
                      ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 85, right: 10),
                child: FloatingActionButton(
                  onPressed: addTODO,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }

  bottomBarItem({String label, Icon icon, int index, String filter}) {
    bool selected = index == _selectedIndex;
    var textColor = selected ? Colors.cyan : Colors.black54;

    icon = Icon(icon.icon, color: textColor);

    return GestureDetector(
      onTap: () => changeListFilter(index, filter),
      child: AnimatedContainer(
        width: 85,
        duration: new Duration(milliseconds: 500),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            CustomText(
              color: textColor,
              text: label,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 1.5,
              width: selected ? 80 : 0,
              color: selected ? textColor : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  changeListFilter(int index, String filter) {
    setState(() {
      _selectedIndex = index;

      getData(filter: filter);
    });
  }

  addTODO() {
    push(context, AddTodoPage());
  }

  Widget listInfo(List<TODO> list) {
    int atividadesCumpridas = list.where((element) => element.realized).length;
    int atividadesPendentes = list.where((element) => !element.realized).length;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CustomText(
                  text: "${list.length}",
                  color: Colors.black45,
                  isBold: true,
                  fontSize: 36,
                ),
                CustomText(
                  text: list.length != 1 ? "Atividades" : "Atividade",
                  color: Colors.black45,
                  isBold: true,
                  fontSize: 16,
                ),
              ],
            ),
            Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CustomText(
                  text: "$atividadesCumpridas",
                  color: Colors.cyan,
                  isBold: true,
                  fontSize: 36,
                ),
                CustomText(
                  text: atividadesCumpridas != 1 ? "Cumpridas" : "Cumprida",
                  color: Colors.cyan,
                  isBold: true,
                  fontSize: 16,
                ),
              ],
            ),
            Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CustomText(
                  text: "$atividadesPendentes",
                  color: Colors.redAccent,
                  isBold: true,
                  fontSize: 36,
                ),
                CustomText(
                  text: atividadesPendentes != 1 ? "Pendentes" : "Pendente",
                  color: Colors.redAccent,
                  isBold: true,
                  fontSize: 16,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  todoList(todoList) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 300),
          child: SlideAnimation(
            verticalOffset: 15,
            horizontalOffset: 5,
            child: FadeInAnimation(
              child: makeTodoItem(
                index,
                todoList[index],
                _updateTODORealized,
                _onItemClick,
              ),
            ),
          ),
        );
      },
      itemCount: todoList.length,
    );
  }

  _updateTODORealized(int index, TODO todo) async {
    todo.realized = !todo.realized;

    await Provider.of<TODOListProvider>(context, listen: false)
        .updateTodo(index, todo);
  }

  _onItemClick(index, todo) {
    showCustomTODODialog(context, todo, _onDelete, _updateTODORealized, index);
  }

  _onDelete(int index) async {
    Navigator.of(context).pop();

    showLoadingDialog(context);

    Future.delayed(new Duration(milliseconds: 200), () async {
      await Provider.of<TODOListProvider>(context, listen: false)
          .removeTodo(index);
      await Provider.of<TODOListProvider>(context, listen: false)
          .loadTodoList();

      closeLoadingDialog(context);
    });
  }

  setUpColors() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
