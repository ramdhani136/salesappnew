import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfiniteScrollSelectList extends StatefulWidget {
  @override
  _InfiniteScrollSelectListState createState() =>
      _InfiniteScrollSelectListState();
}

class _InfiniteScrollSelectListState extends State<InfiniteScrollSelectList> {
  List<String> allItems = List<String>.generate(100, (index) => 'Item $index');
  List<String> displayedItems = [];
  int visibleItemCount = 20;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filterItems('');
  }

  void filterItems(String query) {
    final List<String> filteredItems = allItems.where((item) {
      final String lowerCaseQuery = query.toLowerCase();
      final String lowerCaseItem = item.toLowerCase();
      return lowerCaseItem.contains(lowerCaseQuery);
    }).toList();

    setState(() {
      displayedItems = filteredItems;
      visibleItemCount = 20;
    });
  }

  void loadMoreItems() {
    setState(() {
      visibleItemCount += 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 2,
      child: Column(
        mainAxisSize: MainAxisSize.max, // Set mainAxisSize to MainAxisSize.max
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: TextField(
              controller: searchController,
              onChanged: filterItems,
              decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Visibility(
                    visible: true,
                    child: Icon(
                      Icons.close,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 230, 228, 228), width: 1.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 69, 69, 69), width: 2.0),
                ),
              ),
            ),
          ),
          Expanded(
            // Gunakan Expanded untuk memberikan batasan tinggi
            child: ListView.builder(
              itemCount: visibleItemCount,
              itemBuilder: (context, index) {
                if (index == visibleItemCount - 1) {
                  return InkWell(
                    child: Text('Load More'),
                    onTap: loadMoreItems,
                  );
                }

                return ListTile(
                  title: Text(displayedItems[index]),
                  onTap: () {
                    print('Selected: ${displayedItems[index]}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
