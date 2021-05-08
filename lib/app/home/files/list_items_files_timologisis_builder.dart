import 'package:dexiheri/app/home/files/emptyFilesTimologisis_content.dart';
import 'package:flutter/material.dart';

// new type definition
typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListFilesTimologisisItemsBuilder<T> extends StatelessWidget {
  const ListFilesTimologisisItemsBuilder(
      {Key key, @required this.snapshot, @required this.itemBuilder})
      : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        // TODO: return ListView
        return _buildList(items);
      } else {
        return EmptyFilesTimologisisContent();
      }
    } else if (snapshot.hasError) {
      return EmptyFilesTimologisisContent(
        title: 'Κάτι πήγε λάθος',
        message: 'Δοκιμάστε αργότερα',
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: Colors.black54),
        itemCount: items.length + 2,
        itemBuilder: (context, index) {
          if(index == 0 || index == items.length +1){
            return Container();
          }
          return itemBuilder(context, items[index -1]);
        });
  }
}
