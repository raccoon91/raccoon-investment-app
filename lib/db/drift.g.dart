// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift.dart';

// ignore_for_file: type=lint
class $MetaTableTable extends MetaTable
    with TableInfo<$MetaTableTable, MetaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tickerMeta = const VerificationMeta('ticker');
  @override
  late final GeneratedColumn<String> ticker = GeneratedColumn<String>(
      'ticker', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, ticker, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meta_table';
  @override
  VerificationContext validateIntegrity(Insertable<MetaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ticker')) {
      context.handle(_tickerMeta,
          ticker.isAcceptableOrUnknown(data['ticker']!, _tickerMeta));
    } else if (isInserting) {
      context.missing(_tickerMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MetaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetaTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ticker: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ticker'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
    );
  }

  @override
  $MetaTableTable createAlias(String alias) {
    return $MetaTableTable(attachedDatabase, alias);
  }
}

class MetaTableData extends DataClass implements Insertable<MetaTableData> {
  final int id;
  final String ticker;
  final String type;
  const MetaTableData(
      {required this.id, required this.ticker, required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ticker'] = Variable<String>(ticker);
    map['type'] = Variable<String>(type);
    return map;
  }

  MetaTableCompanion toCompanion(bool nullToAbsent) {
    return MetaTableCompanion(
      id: Value(id),
      ticker: Value(ticker),
      type: Value(type),
    );
  }

  factory MetaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetaTableData(
      id: serializer.fromJson<int>(json['id']),
      ticker: serializer.fromJson<String>(json['ticker']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ticker': serializer.toJson<String>(ticker),
      'type': serializer.toJson<String>(type),
    };
  }

  MetaTableData copyWith({int? id, String? ticker, String? type}) =>
      MetaTableData(
        id: id ?? this.id,
        ticker: ticker ?? this.ticker,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('MetaTableData(')
          ..write('id: $id, ')
          ..write('ticker: $ticker, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ticker, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetaTableData &&
          other.id == this.id &&
          other.ticker == this.ticker &&
          other.type == this.type);
}

class MetaTableCompanion extends UpdateCompanion<MetaTableData> {
  final Value<int> id;
  final Value<String> ticker;
  final Value<String> type;
  const MetaTableCompanion({
    this.id = const Value.absent(),
    this.ticker = const Value.absent(),
    this.type = const Value.absent(),
  });
  MetaTableCompanion.insert({
    this.id = const Value.absent(),
    required String ticker,
    required String type,
  })  : ticker = Value(ticker),
        type = Value(type);
  static Insertable<MetaTableData> custom({
    Expression<int>? id,
    Expression<String>? ticker,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ticker != null) 'ticker': ticker,
      if (type != null) 'type': type,
    });
  }

  MetaTableCompanion copyWith(
      {Value<int>? id, Value<String>? ticker, Value<String>? type}) {
    return MetaTableCompanion(
      id: id ?? this.id,
      ticker: ticker ?? this.ticker,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ticker.present) {
      map['ticker'] = Variable<String>(ticker.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetaTableCompanion(')
          ..write('id: $id, ')
          ..write('ticker: $ticker, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $ValueTableTable extends ValueTable
    with TableInfo<$ValueTableTable, ValueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ValueTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _openMeta = const VerificationMeta('open');
  @override
  late final GeneratedColumn<double> open = GeneratedColumn<double>(
      'open', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _highMeta = const VerificationMeta('high');
  @override
  late final GeneratedColumn<double> high = GeneratedColumn<double>(
      'high', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _lowMeta = const VerificationMeta('low');
  @override
  late final GeneratedColumn<double> low = GeneratedColumn<double>(
      'low', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _closeMeta = const VerificationMeta('close');
  @override
  late final GeneratedColumn<double> close = GeneratedColumn<double>(
      'close', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<int> volume = GeneratedColumn<int>(
      'volume', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<int> symbol = GeneratedColumn<int>(
      'symbol', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES meta_table (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [timestamp, open, high, low, close, volume, symbol];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'value_table';
  @override
  VerificationContext validateIntegrity(Insertable<ValueTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('open')) {
      context.handle(
          _openMeta, open.isAcceptableOrUnknown(data['open']!, _openMeta));
    } else if (isInserting) {
      context.missing(_openMeta);
    }
    if (data.containsKey('high')) {
      context.handle(
          _highMeta, high.isAcceptableOrUnknown(data['high']!, _highMeta));
    } else if (isInserting) {
      context.missing(_highMeta);
    }
    if (data.containsKey('low')) {
      context.handle(
          _lowMeta, low.isAcceptableOrUnknown(data['low']!, _lowMeta));
    } else if (isInserting) {
      context.missing(_lowMeta);
    }
    if (data.containsKey('close')) {
      context.handle(
          _closeMeta, close.isAcceptableOrUnknown(data['close']!, _closeMeta));
    } else if (isInserting) {
      context.missing(_closeMeta);
    }
    if (data.containsKey('volume')) {
      context.handle(_volumeMeta,
          volume.isAcceptableOrUnknown(data['volume']!, _volumeMeta));
    } else if (isInserting) {
      context.missing(_volumeMeta);
    }
    if (data.containsKey('symbol')) {
      context.handle(_symbolMeta,
          symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta));
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {timestamp, symbol};
  @override
  ValueTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ValueTableData(
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timestamp'])!,
      open: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}open'])!,
      high: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}high'])!,
      low: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}low'])!,
      close: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}close'])!,
      volume: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}volume'])!,
      symbol: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}symbol'])!,
    );
  }

  @override
  $ValueTableTable createAlias(String alias) {
    return $ValueTableTable(attachedDatabase, alias);
  }
}

class ValueTableData extends DataClass implements Insertable<ValueTableData> {
  final int timestamp;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;
  final int symbol;
  const ValueTableData(
      {required this.timestamp,
      required this.open,
      required this.high,
      required this.low,
      required this.close,
      required this.volume,
      required this.symbol});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['timestamp'] = Variable<int>(timestamp);
    map['open'] = Variable<double>(open);
    map['high'] = Variable<double>(high);
    map['low'] = Variable<double>(low);
    map['close'] = Variable<double>(close);
    map['volume'] = Variable<int>(volume);
    map['symbol'] = Variable<int>(symbol);
    return map;
  }

  ValueTableCompanion toCompanion(bool nullToAbsent) {
    return ValueTableCompanion(
      timestamp: Value(timestamp),
      open: Value(open),
      high: Value(high),
      low: Value(low),
      close: Value(close),
      volume: Value(volume),
      symbol: Value(symbol),
    );
  }

  factory ValueTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ValueTableData(
      timestamp: serializer.fromJson<int>(json['timestamp']),
      open: serializer.fromJson<double>(json['open']),
      high: serializer.fromJson<double>(json['high']),
      low: serializer.fromJson<double>(json['low']),
      close: serializer.fromJson<double>(json['close']),
      volume: serializer.fromJson<int>(json['volume']),
      symbol: serializer.fromJson<int>(json['symbol']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'timestamp': serializer.toJson<int>(timestamp),
      'open': serializer.toJson<double>(open),
      'high': serializer.toJson<double>(high),
      'low': serializer.toJson<double>(low),
      'close': serializer.toJson<double>(close),
      'volume': serializer.toJson<int>(volume),
      'symbol': serializer.toJson<int>(symbol),
    };
  }

  ValueTableData copyWith(
          {int? timestamp,
          double? open,
          double? high,
          double? low,
          double? close,
          int? volume,
          int? symbol}) =>
      ValueTableData(
        timestamp: timestamp ?? this.timestamp,
        open: open ?? this.open,
        high: high ?? this.high,
        low: low ?? this.low,
        close: close ?? this.close,
        volume: volume ?? this.volume,
        symbol: symbol ?? this.symbol,
      );
  @override
  String toString() {
    return (StringBuffer('ValueTableData(')
          ..write('timestamp: $timestamp, ')
          ..write('open: $open, ')
          ..write('high: $high, ')
          ..write('low: $low, ')
          ..write('close: $close, ')
          ..write('volume: $volume, ')
          ..write('symbol: $symbol')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(timestamp, open, high, low, close, volume, symbol);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ValueTableData &&
          other.timestamp == this.timestamp &&
          other.open == this.open &&
          other.high == this.high &&
          other.low == this.low &&
          other.close == this.close &&
          other.volume == this.volume &&
          other.symbol == this.symbol);
}

class ValueTableCompanion extends UpdateCompanion<ValueTableData> {
  final Value<int> timestamp;
  final Value<double> open;
  final Value<double> high;
  final Value<double> low;
  final Value<double> close;
  final Value<int> volume;
  final Value<int> symbol;
  final Value<int> rowid;
  const ValueTableCompanion({
    this.timestamp = const Value.absent(),
    this.open = const Value.absent(),
    this.high = const Value.absent(),
    this.low = const Value.absent(),
    this.close = const Value.absent(),
    this.volume = const Value.absent(),
    this.symbol = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ValueTableCompanion.insert({
    required int timestamp,
    required double open,
    required double high,
    required double low,
    required double close,
    required int volume,
    required int symbol,
    this.rowid = const Value.absent(),
  })  : timestamp = Value(timestamp),
        open = Value(open),
        high = Value(high),
        low = Value(low),
        close = Value(close),
        volume = Value(volume),
        symbol = Value(symbol);
  static Insertable<ValueTableData> custom({
    Expression<int>? timestamp,
    Expression<double>? open,
    Expression<double>? high,
    Expression<double>? low,
    Expression<double>? close,
    Expression<int>? volume,
    Expression<int>? symbol,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (timestamp != null) 'timestamp': timestamp,
      if (open != null) 'open': open,
      if (high != null) 'high': high,
      if (low != null) 'low': low,
      if (close != null) 'close': close,
      if (volume != null) 'volume': volume,
      if (symbol != null) 'symbol': symbol,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ValueTableCompanion copyWith(
      {Value<int>? timestamp,
      Value<double>? open,
      Value<double>? high,
      Value<double>? low,
      Value<double>? close,
      Value<int>? volume,
      Value<int>? symbol,
      Value<int>? rowid}) {
    return ValueTableCompanion(
      timestamp: timestamp ?? this.timestamp,
      open: open ?? this.open,
      high: high ?? this.high,
      low: low ?? this.low,
      close: close ?? this.close,
      volume: volume ?? this.volume,
      symbol: symbol ?? this.symbol,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (open.present) {
      map['open'] = Variable<double>(open.value);
    }
    if (high.present) {
      map['high'] = Variable<double>(high.value);
    }
    if (low.present) {
      map['low'] = Variable<double>(low.value);
    }
    if (close.present) {
      map['close'] = Variable<double>(close.value);
    }
    if (volume.present) {
      map['volume'] = Variable<int>(volume.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<int>(symbol.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ValueTableCompanion(')
          ..write('timestamp: $timestamp, ')
          ..write('open: $open, ')
          ..write('high: $high, ')
          ..write('low: $low, ')
          ..write('close: $close, ')
          ..write('volume: $volume, ')
          ..write('symbol: $symbol, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Drift extends GeneratedDatabase {
  _$Drift(QueryExecutor e) : super(e);
  late final $MetaTableTable metaTable = $MetaTableTable(this);
  late final $ValueTableTable valueTable = $ValueTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [metaTable, valueTable];
}
