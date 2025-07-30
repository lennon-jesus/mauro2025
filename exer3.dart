void main() {
  var now = DateTime.now();
  var primeiroDia = DateTime.utc(now.year, now.month, 1);

  int diaMes = 1;
  String semana = '';
  
  print("| D | S | T | Q | Q | S | S |");
  
  for(int i = 0; i < 6; i++){
    if(i >= primeiroDia.weekday){
      semana += '$diaMes |';
      diaMes++;
    }else{
      semana += '  ';
    }
  }
  print(semana);
}
