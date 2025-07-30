void main() {
  int informado = 7;
  final atual = DateTime.now();;

  if(atual.month > informado)
    print("O mês atual é maior que o informado");
  else if (atual.month == informado)
    print("O mês atual é igual ao informado");
  else
    print("O mês atual é menor que o informado");
}  