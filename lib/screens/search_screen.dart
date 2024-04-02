import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isAddFriend = false;
  String _input = '';

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
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: _isAddFriend,
              onChanged: _toggleAddFriend,
              activeColor: Colors.black45,
              materialTapTargetSize: MaterialTapTargetSize
                  .shrinkWrap, // Reduces the tap target size
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.all(15),
      child: ListView(
        children: [
          _buildSearchBar(),
          SizedBox.fromSize(size: const Size.fromHeight(30)),
          _buildListFoundUsers(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextFormField(
      controller: _searchController,
      onChanged: _handleSearching,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
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

  Widget _buildListFriends() {
    return Center(
      child: Text(_input),
    );
  }

  Widget _buildListFoundUsers() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy('username')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something Wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Waiting...');
        }
        final userData = snapshot.data!.docs;
        return ListView(
            shrinkWrap: true,
            children: userData.map((doc) => _buildUserItem(doc)).toList());
      },
    );
  }

  Widget _buildUserItem(DocumentSnapshot doc) {
    Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
    if (userData['username'].toString().toLowerCase().contains(_input) &&
        _input.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/home/user.png',
              width: 35,
              height: 35,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
            ),
          ),
          title: Text(userData['username']),
          onTap: () {
            print('object');
          },
        ),
      );
    }
    return const SizedBox();
  }

  void _handleSearching(String input) {
    setState(() {
      _input = input;
    });
  }

  void _toggleAddFriend(bool value) {
    setState(() {
      _isAddFriend = value;
    });
  }
}
