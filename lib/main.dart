import 'package:flutter/material.dart';
import 'package:miniprojeto/bloc/counter_bloc.dart';

import 'package:miniprojeto/pages/todo_bloc_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Página Principal'),
      routes: <String, WidgetBuilder>{
        '/todo-bloc-page': (context) => TodoBlocPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CounterBloc _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Você apertou o botão tantas vezes:'),

            Bloc
            StreamBuilder(
              stream: _counterBloc.output,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();

                  default:
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyle(fontSize: 34),
                    );
                }
              },
            ),

            RaisedButton(
              child: Text('Lista de Tarefas'),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed('/todo-bloc-page');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: _counterBloc.increment,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
    );
  }
}