class Aluno {
  String nome;
  int matricula;
  List notas;

  Aluno(this.nome, this.matricula, this.notas);

  void lancaNota(var x) {
    this.notas.add(x);
  }
}
