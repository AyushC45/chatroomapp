import 'package:chatroomapp/chat_screen.dart';
import 'package:chatroomapp/profile.dart';
import 'package:chatroomapp/settings.dart';
import 'package:flutter/material.dart';

class ChatroomSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatrooms'),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          ChatRoomOptionCard(
            title: 'Mobile App Dev',
            description: 'Talk about Mobile App Dev in here',
            icon: Icons.school, // Customize the icon for each chatroom
          ),
          ChatRoomOptionCard(
            title: 'Games',
            description: 'Talk about games in here',
            icon: Icons.games_rounded, // Customize the icon for each chatroom
          ),
          ChatRoomOptionCard(
            title: 'Money',
            description: 'Talk about money in here',
            icon: Icons.attach_money, // Customize the icon for each chatroom
          ),
          ChatRoomOptionCard(
            title: 'Sports',
            description: 'Talk about sports in here',
            icon: Icons.sports_basketball_rounded, // Customize the icon for each chatroom
          ),
        ],
      ),
    );
  }
}

class ChatRoomOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const ChatRoomOptionCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        leading: Icon(icon, size: 48.0),
        title: Text(title),
        subtitle: Text(description),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(chatRoomTitle: title),
            ),
          );
        },
      ),
    );
  }
}
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                'Chatrooms',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Chatroom Selection'),
            onTap: () {
              // Handle navigation to ChatroomSelectionScreen
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              // Handle navigation to the profile screen
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              // Handle navigation to the settings screen
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
