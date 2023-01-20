import 'package:abntplaybic/modules/perfil/controller/perfilProvider.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';

class TipoPerfilPage extends StatefulWidget {
  const TipoPerfilPage({super.key});

  @override
  State<TipoPerfilPage> createState() => _TipoPerfilPageState();
}

class _TipoPerfilPageState extends State<TipoPerfilPage> {
  var mensagem = {
    PerfilTipo.profesor:
        "Como professor, você pode criar turmas para seus alunos utilizarem da plataforma, verificar erros e acertos de cada aluno, e liberar as atividades quando desejar",
    PerfilTipo.aluno:
        "Como aluno, você pode utilizar da plataforma de estudos e se quiser, ingressar numa turma e competir com seus amigos semanalmente no ranking da turma."
  };
  PerfilTipo tipoSelected = PerfilTipo.aluno;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Que tipo de conta deseja utilizar?",
                  style: TextStyle(fontFamily: "PassionOne", fontSize: 24),
                ),
                SizedBox(
                    width: size.width * 0.65,
                    height: size.width * 0.65,
                    child: Image.asset("src/images/coruja_login.png")),
                ListTile(
                  onTap: () {
                    setState(() {
                      tipoSelected = PerfilTipo.profesor;
                    });
                  },
                  title: Text(
                    "Professor",
                    style: TextStyle(
                      fontFamily: "PassionOne",
                      fontSize: 32,
                      color: tipoSelected.index == 0 ? branco : Colors.black,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                      side: BorderSide(
                          color: primary,
                          width: tipoSelected.index == 0 ? 0 : 2)),
                  tileColor:
                      tipoSelected.index == 0 ? lilas : Colors.transparent,
                  trailing: Radio<PerfilTipo>(
                    value: PerfilTipo.profesor,
                    groupValue: tipoSelected,
                    fillColor: MaterialStateProperty.all(primary),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          tipoSelected = val;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  onTap: () {
                    setState(() {
                      tipoSelected = PerfilTipo.aluno;
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                      side: BorderSide(
                          color: primary,
                          width: tipoSelected.index == 1 ? 0 : 2)),
                  tileColor:
                      tipoSelected.index == 1 ? lilas : Colors.transparent,
                  title: Text(
                    "Aluno",
                    style: TextStyle(
                      fontFamily: "PassionOne",
                      fontSize: 32,
                      color: tipoSelected.index == 1 ? branco : Colors.black,
                    ),
                  ),
                  trailing: Radio<PerfilTipo>(
                    value: PerfilTipo.aluno,
                    groupValue: tipoSelected,
                    fillColor: MaterialStateProperty.all(primary),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          tipoSelected = val;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  height: (size.width - 20) * 0.55,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Text(
                    mensagem[tipoSelected]!,
                    style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    fixedSize: Size(size.width * 0.65, 62),
                  ),
                  child: const Text(
                    "Continuar",
                    style: TextStyle(
                        fontFamily: "PassionOne",
                        fontSize: 32,
                        color: Colors.white),
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
