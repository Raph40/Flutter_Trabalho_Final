import 'package:flutter/material.dart';

class planotreino extends StatelessWidget {
  const planotreino({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: planotreinoPage(),
    );
  }
}

class planotreinoPage extends StatefulWidget {
  const planotreinoPage({super.key});

  @override
  State<planotreinoPage> createState() => _planotreinoPageState();
}

class _planotreinoPageState extends State<planotreinoPage> {
  String selectedPlan = 'Plano B'; // Inicializamos com Plano B

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Plano de Treino",
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black87,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => _showPlanSelection(context),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Mantém o alinhamento compacto
                          children: [
                            Text(
                              selectedPlan,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _getPlanDescription(selectedPlan),
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _getPlanDate(selectedPlan),
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: _getPlanExercises(selectedPlan),
            ),
          ),
        ],
      ),
    );
  }

  void _showPlanSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Plano A'),
                onTap: () => _selectPlan('Plano A'),
              ),
              ListTile(
                title: Text('Plano B'),
                onTap: () => _selectPlan('Plano B'),
              ),
              ListTile(
                title: Text('Plano C'),
                onTap: () => _selectPlan('Plano C'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectPlan(String plan) {
    setState(() {
      selectedPlan = plan;
    });
    Navigator.pop(context); // Fechar o modal
  }

  String _getPlanDescription(String plan) {
    switch (plan) {
      case 'Plano A':
        return 'Treino de Peito + Ombros';
      case 'Plano B':
        return 'Treino de Bicep + Costas';
      case 'Plano C':
        return 'Treino de Pernas';
      default:
        return '';
    }
  }

  String _getPlanDate(String plan) {
    switch (plan) {
      case 'Plano A':
        return '15-03-2024 a 10-05-2024';
      case 'Plano B':
        return '15-03-2024 a 10-05-2024';
      case 'Plano C':
        return '15-03-2024 a 10-05-2024';
      default:
        return '';
    }
  }

  List<Widget> _getPlanExercises(String plan) {
    switch (plan) {
      case 'Plano A':
        return [
          _buildExerciseItem('Bicicleta Vertical', true),
          _buildExerciseItem('Supino horizontal no Rack', false),
          _buildExerciseItem('Supino inclinado com barra', false),
          _buildExerciseItem('Butterfly', false),
          _buildExerciseItem('Press militar com barra livre à frente', false),
          _buildExerciseItem('Press rotativo com halteres', false),
          _buildExerciseItem('Abertura posterior na máquina', false),
          _buildExerciseItem('Extensão Tríceps na máquina do polia', false),
        ];
      case 'Plano B':
        return [
          _buildExerciseItem('Bicicleta Vertical', true),
          _buildExerciseItem('Remo puxador pega fechada em máq. 5 estações', false),
          _buildExerciseItem('Remada baixa', false),
          _buildExerciseItem('Puxador à frente pega larga em máq. 5 estações', false),
          _buildExerciseItem('Remo com halteres', false),
          _buildExerciseItem('Puxada à coxa', false),
          _buildExerciseItem('Bíceps Scott com barra livre', false),
          _buildExerciseItem('Bíceps curl no puxador - pega supinada', false),
        ];
      case 'Plano C':
        return [
          _buildExerciseItem('Bicicleta Vertical', true),
          _buildExerciseItem('Agachamento com barra livre', false),
          _buildExerciseItem('Lunge com halteres', false),
          _buildExerciseItem('Extensões na máquina', false),
          _buildExerciseItem('Levantamento terra', false),
          _buildExerciseItem('Abdução na máquina', false),
          _buildExerciseItem('Adução na máquina', false),
          _buildExerciseItem('Flexão na máquina deitado', false),
        ];
      default:
        return [];
    }
  }

  Widget _buildExerciseItem(String title, bool isActive) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isActive ? (Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[200]) : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[700] : Colors.grey[300]),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            Icons.fitness_center,
            color: isActive ? Colors.red : (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey),
            size: 30,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
