String formatDate(DateTime date) {
  //Necesito que formatee la fecha de esta forma: 15-Nov-2023 17h15
  int day = date.day;
  int month = date.month;
  int year = date.year;
  int hour = date.hour;
  int minute = date.minute;

  final months = [
    "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"
  ];

  String dayStr = day.toString();

  // Si la fecha llega con un solo digito, le agrego un 0 adelante
  if (day < 10) {
    dayStr = "0$day";
  }

  // Si la hora llega con un solo digito, le agrego un 0 adelante
  String hourStr = hour.toString();
  if (hour < 10) {
    hourStr = "0$hour";
  }

  // Si los minutos llegan con un solo digito, le agrego un 0 adelante
  String minuteStr = minute.toString();
  if (minute < 10) {
    minuteStr = "0$minute";
  }

  return "$dayStr-${months[month - 1]}-$year ${hourStr}h$minuteStr";

}