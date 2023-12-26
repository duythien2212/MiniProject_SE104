class Notificate {
  Notificate(this.title, this.message, this.time);

  final String title;
  final String message;
  final DateTime time;
}

List<Notificate> notificates = [
  Notificate('Titile 1', 'Notificate 1', DateTime.now()),
  Notificate('Titile 2', 'Notificate 2', DateTime.now()),
  Notificate('Titile 3', 'Notificate 3', DateTime.now()),
  Notificate('Titile 4', 'Notificate 4', DateTime.now()),
];
