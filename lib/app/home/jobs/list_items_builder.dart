import 'package:dexiheri/app/home/jobs/empty_content.dart';
import 'package:flutter/material.dart';

// new type definition
typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({Key key,@required this.snapshot,@required this.itemBuilder}) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData){
      final List<T> items = snapshot.data;
      if(items.isNotEmpty){
        // TODO: return ListView
        return _buildList(items);
      }else{
        return EmptyContent();
      }
    }else if (snapshot.hasError){
      return EmptyContent(
        title: 'Κάτι πήγε λάθος',
        message: 'Δοκιμάστε αργότερα',
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
        itemBuilder: (context, index) => itemBuilder(context, items[index]));
  }
}

