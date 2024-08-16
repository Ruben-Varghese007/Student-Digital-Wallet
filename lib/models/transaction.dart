class Transaction {
  final int id;
  final String to;
  final String amount;
  final String date;
  final String description;

  Transaction(
    this.id,
    this.to,
    this.amount,
    this.date,
    this.description,
  );
}

final List<Transaction> transactions = [
  Transaction(
    1,
    'Bay Store',
    '350.00',
    '30 October 2023 12:13',
    'HITS',
  ),
  Transaction(
    2,
    'Garage Cafe',
    '950.00',
    '12 October 2023 12:45',
    'HITS',
  ),
  Transaction(
    3,
    'Office',
    '250.00',
    '08 October 2023 15:30',
    'HITS',
  ),
  Transaction(
    4,
    'Azhagar',
    '120.00',
    '03 October 2023 12:30',
    'HITS',
  ),
  Transaction(
    5,
    'Snow Cube',
    '20.00',
    '28 September 2023 10:15',
    'HITS',
  ),
  Transaction(
    6,
    'Xerox',
    '180.00',
    '23 September 2023 10:30',
    'HITS',
  ),
  Transaction(
    7,
    'Oriental Bakery',
    '150.00',
    '4 September 2023 12:13',
    'HITS',
  ),
  Transaction(
    8,
    'Melange',
    '325.00',
    '18 August 2023 12:13',
    'HITS',
  ),
  Transaction(
    9,
    'Mr.Burger',
    '230.00',
    '12 August 2023 12:13',
    'HITS',
  ),
  Transaction(
    10,
    'Garage Cafe',
    '120.00',
    '04 August 2023 12:13',
    'HITS',
  ),
];
