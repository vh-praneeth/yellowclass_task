import 'dart:core';
import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;

List<String> movies = ["Spiderman 3"];
List<String> directors = ["Peter Parker"];
List<String> images = ["https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/tobey-maguire-andrew-garfield-tom-holland-1607527815.jpg"];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies List',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'Movies List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              textColor: Colors.red, // foreground
              color: Colors.lightGreen,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
              child: Text('Add/Edit movies', style: TextStyle(fontSize: 20.0),),
            ),
            const Text( 'Movies list:', ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(movies[index]),
                  subtitle: Text(directors[index]),
                  leading: CircleAvatar(backgroundImage: NetworkImage(images[index])),
                  trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.delete), Icon(Icons.edit),
                      ]
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add/Edit movies"),
      ),
      body: const MyStatefulWidget(),
    );
  }
}


/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String movie='', director='', image='';


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Movie name',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty)
                return 'Please enter some text';
              else
                movie = value;
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Director name',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty)
                return 'Please enter some text';
              else
                director = value;
              return null;
            },
          ),

          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Image link',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty)
                return 'Please enter some text';
              else
                image = value;
              return null;
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // if movie exists, remove it and add again
                  if (movies.contains(movie)) {
                    int index = movies.indexOf(movie);
                    movies.removeAt(index);
                    directors.removeAt(index);
                    images.removeAt(index);
                  }

                  movies.add(movie);
                  directors.add(director);
                  images.add(image);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ],
      ),
    );
  }
}
