import 'package:arrive_app/widget_screens/audioplaydiologe.dart';
import 'package:flutter/material.dart';

class AudioPlaylistScreen extends StatefulWidget {
  const AudioPlaylistScreen({super.key});

  @override
  State<AudioPlaylistScreen> createState() => _AudioPlaylistScreenState();
}

class _AudioPlaylistScreenState extends State<AudioPlaylistScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> audioList = [
    {"title": "Mara Malik Tari Raza kalia1", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia2", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia3", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia4", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia5", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia6", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia7", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia8", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia9", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia10", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia11", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia12", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia13", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia14", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia15", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia16", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia17", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia18", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia19", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia20", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia21", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia22", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia23", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia24", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia25", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia26", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia27", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia28", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia29", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia30", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia31", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia31", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia32", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia33", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia34", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia35", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia36", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia37", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia38", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia39", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia40", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    {"title": "Mara Malik Tari Raza kalia41", "subtitle": "by Ahmad Ali Hakim", "file": "assets/music/mp3file.mpeg", "thumbnail": "assets/images/thumbnail.jpg"},
    // Add more items here...
  ];

  List<Map<String, String>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = audioList;
  }

  void _filterSongs(String query) {
    setState(() {
      filteredList = audioList
          .where((song) =>
          song["title"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _openAudioDialog(Map<String, String> song) {
    showDialog(
      context: context,
      builder: (context) => AudioPlayerDialog(
        filePath: song["file"]!,
        title: song["title"]!,
        subtitle: song["subtitle"]!,
        thumbnail: song["thumbnail"]!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Search Music"),
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: _filterSongs,
              decoration: InputDecoration(
                hintText: "Search song...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final item = filteredList[index];

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  minLeadingWidth: 50,
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(item["thumbnail"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    item["title"]!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  subtitle: Text(
                    item["subtitle"]!,
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: const Icon(Icons.skip_next),
                  onTap: () {
                    _openAudioDialog(item);
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
