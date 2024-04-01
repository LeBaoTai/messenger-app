import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isAddFriend = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black,
        actions: [
          Text(
            'Others',
            style: TextStyle(
              fontSize: 19,
              color: _isAddFriend ? Colors.black : Colors.grey,
            ),
          ),
          Switch(
            value: _isAddFriend,
            onChanged: _toggleAddFriend,
            activeColor: Colors.black45,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _buildSearchBar(),
        SizedBox.fromSize(size: const Size.fromHeight(30)),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextFormField(
      controller: _searchController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: 'Search',
      ),
    );
  }

  void _toggleAddFriend(bool value) {
    setState(() {
      _isAddFriend = value;
    });
  }
}
