class EstimatedTime {
  final int numHoras;
  final int numMinutos;
  final String tiempoEstimado;

  EstimatedTime(
      {required this.numHoras,
      required this.numMinutos,
      this.tiempoEstimado = ""});

  EstimatedTime.empty()
      : numHoras = 0,
        numMinutos = 0,
        tiempoEstimado = "";

  //copyWith
  EstimatedTime copyWith(
      {int? numHoras, int? numMinutos, String? tiempoEstimado}) {
    return EstimatedTime(
        numHoras: numHoras ?? this.numHoras,
        numMinutos: numMinutos ?? this.numMinutos,
        tiempoEstimado: tiempoEstimado ?? this.tiempoEstimado);
  }
}
