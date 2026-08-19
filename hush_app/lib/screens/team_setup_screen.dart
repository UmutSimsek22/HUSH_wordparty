import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/team.dart';
import '../models/player.dart';
import '../providers/game_provider.dart';
import '../services/sound_service.dart';
import 'game_settings_screen.dart';

class TeamSetupScreen extends StatefulWidget {
  const TeamSetupScreen({super.key});

  @override
  State<TeamSetupScreen> createState() => _TeamSetupScreenState();
}

class _TeamSetupScreenState extends State<TeamSetupScreen> {
  // 5 Presets: Kırmızı, Mavi, Sarı (Altın), Yeşil, Pembe
  final List<Color> _availableColors = const [
    Color(0xFFFF3B30), // Kırmızı
    Color(0xFF007AFF), // Mavi
    Color(0xFFFFCC00), // Sarı / Altın
    Color(0xFF34C759), // Yeşil
    Color(0xFFFF2D55), // Pembe
  ];

  late List<Team> _teams;

  @override
  void initState() {
    super.initState();
    _teams = [
      Team(
        id: 'team_1',
        name: 'Kırmızı Takım',
        color: _availableColors[0],
        players: [
          Player(id: 'p1_1', name: 'Rüzgar', teamId: 'team_1'),
          Player(id: 'p1_2', name: 'Enes', teamId: 'team_1'),
        ],
      ),
      Team(
        id: 'team_2',
        name: 'Mavi Takım',
        color: _availableColors[1],
        players: [
          Player(id: 'p2_1', name: 'İrem', teamId: 'team_2'),
          Player(id: 'p2_2', name: 'Elif', teamId: 'team_2'),
        ],
      ),
    ];
  }

  Color _getUnusedColor() {
    final usedColors = _teams.map((t) => t.color.value).toSet();
    for (var color in _availableColors) {
      if (!usedColors.contains(color.value)) {
        return color;
      }
    }
    return _availableColors[0];
  }

  void _addTeam() {
    SoundService().playClick();
    if (_teams.length >= 4) return;
    final color = _getUnusedColor();
    final index = _teams.length;
    final teamId = 'team_${DateTime.now().millisecondsSinceEpoch}';
    setState(() {
      _teams.add(
        Team(
          id: teamId,
          name: '${_getTeamColorName(color)} Takım',
          color: color,
          players: [
            Player(id: '${teamId}_p1', name: 'Oyuncu 1', teamId: teamId),
            Player(id: '${teamId}_p2', name: 'Oyuncu 2', teamId: teamId),
          ],
        ),
      );
    });
  }

  String _getTeamColorName(Color color) {
    if (color == const Color(0xFFFF3B30)) return 'Kırmızı';
    if (color == const Color(0xFF007AFF)) return 'Mavi';
    if (color == const Color(0xFFFFCC00)) return 'Sarı';
    if (color == const Color(0xFF34C759)) return 'Yeşil';
    if (color == const Color(0xFFFF2D55)) return 'Pembe';
    return 'Takım';
  }

  void _removeTeam(int index) {
    SoundService().playClick();
    if (_teams.length <= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('En az 2 takım olmalıdır!')),
      );
      return;
    }
    setState(() {
      _teams.removeAt(index);
    });
  }

  void _addPlayerToTeam(Team team) {
    SoundService().playClick();
    if (team.players.length >= 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bir takımda en fazla 4 oyuncu olabilir!')),
      );
      return;
    }
    setState(() {
      final pIndex = team.players.length + 1;
      team.players.add(
        Player(
          id: '${team.id}_p${DateTime.now().millisecondsSinceEpoch}',
          name: 'Oyuncu $pIndex',
          teamId: team.id,
        ),
      );
    });
  }

  void _removePlayerFromTeam(Team team, int pIndex) {
    SoundService().playClick();
    if (team.players.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Her takımda en az 1 oyuncu olmalıdır!')),
      );
      return;
    }
    setState(() {
      team.players.removeAt(pIndex);
    });
  }

  void _editPlayerName(Player player) {
    SoundService().playClick();
    final controller = TextEditingController(text: player.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF333333), width: 2),
        ),
        title: const Text('Oyuncu Adını Düzenle', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Oyuncu Adı',
            hintStyle: TextStyle(color: Colors.white54),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('İptal', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  player.name = controller.text.trim();
                });
              }
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007AFF)),
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  void _editTeamName(Team team) {
    SoundService().playClick();
    final controller = TextEditingController(text: team.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF333333), width: 2),
        ),
        title: const Text('Takım Adını Düzenle', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Takım Adı',
            hintStyle: TextStyle(color: Colors.white54),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('İptal', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  team.name = controller.text.trim();
                });
              }
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: team.color),
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  void _onProceed() {
    SoundService().playClick();
    for (var team in _teams) {
      if (team.players.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${team.name} takımında en az 1 oyuncu olmalıdır!')),
        );
        return;
      }
    }

    final provider = Provider.of<GameProvider>(context, listen: false);
    provider.setTeams(_teams);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GameSettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            SoundService().playClick();
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'TAKIM & OYUNCULAR',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Takımları ve oyuncuları belirleyin (En fazla 4 takım, 5 farklı renk seçeneği):',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13.5),
                  ),
                  const SizedBox(height: 16),
                  ..._teams.asMap().entries.map((entry) {
                    final index = entry.key;
                    final team = entry.value;
                    return _buildTeamCard(team, index);
                  }),
                  if (_teams.length < 4) ...[
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: _addTeam,
                      icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                      label: const Text(
                        'YENİ TAKIM EKLE',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Colors.white, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                border: Border(top: BorderSide(color: Color(0xFF333333))),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onProceed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'KURALLARA GEÇ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamCard(Team team, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: team.color, width: 2),
      ),
      child: Column(
        children: [
          // Team Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: team.color.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(backgroundColor: team.color, radius: 10),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _editTeamName(team),
                    child: Row(
                      children: [
                        Text(
                          team.name,
                          style: TextStyle(
                            color: team.color,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(Icons.edit, size: 16, color: team.color),
                      ],
                    ),
                  ),
                ),
                if (_teams.length > 2)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Color(0xFFFF3B30), size: 20),
                    onPressed: () => _removeTeam(index),
                  ),
              ],
            ),
          ),

          // Players List
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ...team.players.asMap().entries.map((pEntry) {
                  final pIdx = pEntry.key;
                  final player = pEntry.value;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF121212),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF333333)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.person, color: Color(0xFF94A3B8), size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            player.name,
                            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Color(0xFF007AFF), size: 16),
                          onPressed: () => _editPlayerName(player),
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(4),
                        ),
                        if (team.players.length > 1)
                          IconButton(
                            icon: const Icon(Icons.close, color: Color(0xFFFF3B30), size: 16),
                            onPressed: () => _removePlayerFromTeam(team, pIdx),
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(4),
                          ),
                      ],
                    ),
                  );
                }),
                if (team.players.length < 4) ...[
                  const SizedBox(height: 6),
                  TextButton.icon(
                    onPressed: () => _addPlayerToTeam(team),
                    icon: Icon(Icons.person_add, color: team.color, size: 18),
                    label: Text(
                      'Oyuncu Ekle (${team.players.length}/4)',
                      style: TextStyle(color: team.color, fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
