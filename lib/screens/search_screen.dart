import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new friend'),
      ),
      body: _buildBodySearch(),
    );
  }

  Widget _buildBodySearch() {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        _buildSearchBar(),
        SizedBox.fromSize(size: const Size.fromHeight(30)),
        Text('child'),
        Text('child'),
        Text('child'),
        Text('child'),
        Text('child'),
        Text('child'),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextFormField(
      controller: _searchController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'Search',
      ),
    );
  }
}
