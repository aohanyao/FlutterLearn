import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Flutter Learn",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Home"),
          actions: <Widget>[
            new IconButton(icon: new Icon( Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: new RandomWord(),
      ),
    );
  }

  //点击
  void _pushSaved(){

  }
}


//相当于adapter
class RandomWord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordState();
  }

}


//相当于holder
class RandomWordState extends State<RandomWord> {

  //所有的单词
  final _suggestions = <WordPair>[];

  //单词的样式
  final _bigerFont = const TextStyle(fontSize: 18.00);

  //存储喜欢的单词
  final _save = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSuggestions(),
    );
  }


  //创建
  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, position) { //匿名函数

        if (position.isOdd) { //奇数 加线
          return new Divider(/*
            height: 0.5,
            color: Colors.black,
          */);
        }

        // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
        final index = position ~/ 2;
        // 如果是建议列表中最后一个单词对
        if (index >= _suggestions.length) {
          // ...接着再生成10个单词对，然后添加到建议列表
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }


  // 相当于 createView
  Widget _buildRow(WordPair suggestion) {
    final alreadySaved = _save.contains(suggestion);
    return ListTile(
      //标题
      title: new Text(suggestion.asPascalCase,
        style: _bigerFont,),
      //尾标
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,),
      //点击
      onTap: (){
        //设置状态，相当于 adapter.notificationDataChange()
        setState(() {
          if(alreadySaved){
            _save.remove(suggestion);
          }else{
            _save.add(suggestion);
          }
        });
      },
    );
  }

}