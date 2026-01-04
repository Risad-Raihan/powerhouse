// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PrayerEntriesTable extends PrayerEntries
    with TableInfo<$PrayerEntriesTable, PrayerEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrayerEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<PrayerType, String> prayer =
      GeneratedColumn<String>(
        'prayer',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PrayerType>($PrayerEntriesTable.$converterprayer);
  @override
  late final GeneratedColumnWithTypeConverter<PrayerStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PrayerStatus>($PrayerEntriesTable.$converterstatus);
  static const VerificationMeta _loggedAtUtcMeta = const VerificationMeta(
    'loggedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAtUtc = GeneratedColumn<DateTime>(
    'logged_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Asia/Dhaka'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _xpAwardedMeta = const VerificationMeta(
    'xpAwarded',
  );
  @override
  late final GeneratedColumn<int> xpAwarded = GeneratedColumn<int>(
    'xp_awarded',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    prayer,
    status,
    loggedAtUtc,
    localDate,
    timezone,
    note,
    xpAwarded,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prayer_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrayerEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('logged_at_utc')) {
      context.handle(
        _loggedAtUtcMeta,
        loggedAtUtc.isAcceptableOrUnknown(
          data['logged_at_utc']!,
          _loggedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_loggedAtUtcMeta);
    }
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('xp_awarded')) {
      context.handle(
        _xpAwardedMeta,
        xpAwarded.isAcceptableOrUnknown(data['xp_awarded']!, _xpAwardedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {localDate, prayer},
  ];
  @override
  PrayerEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrayerEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      prayer: $PrayerEntriesTable.$converterprayer.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}prayer'],
        )!,
      ),
      status: $PrayerEntriesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      loggedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at_utc'],
      )!,
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_date'],
      )!,
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      xpAwarded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_awarded'],
      )!,
    );
  }

  @override
  $PrayerEntriesTable createAlias(String alias) {
    return $PrayerEntriesTable(attachedDatabase, alias);
  }

  static TypeConverter<PrayerType, String> $converterprayer =
      prayerTypeConverter;
  static TypeConverter<PrayerStatus, String> $converterstatus =
      prayerStatusConverter;
}

class PrayerEntry extends DataClass implements Insertable<PrayerEntry> {
  final int id;
  final PrayerType prayer;
  final PrayerStatus status;
  final DateTime loggedAtUtc;
  final String localDate;
  final String timezone;
  final String? note;
  final int xpAwarded;
  const PrayerEntry({
    required this.id,
    required this.prayer,
    required this.status,
    required this.loggedAtUtc,
    required this.localDate,
    required this.timezone,
    this.note,
    required this.xpAwarded,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['prayer'] = Variable<String>(
        $PrayerEntriesTable.$converterprayer.toSql(prayer),
      );
    }
    {
      map['status'] = Variable<String>(
        $PrayerEntriesTable.$converterstatus.toSql(status),
      );
    }
    map['logged_at_utc'] = Variable<DateTime>(loggedAtUtc);
    map['local_date'] = Variable<String>(localDate);
    map['timezone'] = Variable<String>(timezone);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['xp_awarded'] = Variable<int>(xpAwarded);
    return map;
  }

  PrayerEntriesCompanion toCompanion(bool nullToAbsent) {
    return PrayerEntriesCompanion(
      id: Value(id),
      prayer: Value(prayer),
      status: Value(status),
      loggedAtUtc: Value(loggedAtUtc),
      localDate: Value(localDate),
      timezone: Value(timezone),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      xpAwarded: Value(xpAwarded),
    );
  }

  factory PrayerEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrayerEntry(
      id: serializer.fromJson<int>(json['id']),
      prayer: serializer.fromJson<PrayerType>(json['prayer']),
      status: serializer.fromJson<PrayerStatus>(json['status']),
      loggedAtUtc: serializer.fromJson<DateTime>(json['loggedAtUtc']),
      localDate: serializer.fromJson<String>(json['localDate']),
      timezone: serializer.fromJson<String>(json['timezone']),
      note: serializer.fromJson<String?>(json['note']),
      xpAwarded: serializer.fromJson<int>(json['xpAwarded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'prayer': serializer.toJson<PrayerType>(prayer),
      'status': serializer.toJson<PrayerStatus>(status),
      'loggedAtUtc': serializer.toJson<DateTime>(loggedAtUtc),
      'localDate': serializer.toJson<String>(localDate),
      'timezone': serializer.toJson<String>(timezone),
      'note': serializer.toJson<String?>(note),
      'xpAwarded': serializer.toJson<int>(xpAwarded),
    };
  }

  PrayerEntry copyWith({
    int? id,
    PrayerType? prayer,
    PrayerStatus? status,
    DateTime? loggedAtUtc,
    String? localDate,
    String? timezone,
    Value<String?> note = const Value.absent(),
    int? xpAwarded,
  }) => PrayerEntry(
    id: id ?? this.id,
    prayer: prayer ?? this.prayer,
    status: status ?? this.status,
    loggedAtUtc: loggedAtUtc ?? this.loggedAtUtc,
    localDate: localDate ?? this.localDate,
    timezone: timezone ?? this.timezone,
    note: note.present ? note.value : this.note,
    xpAwarded: xpAwarded ?? this.xpAwarded,
  );
  PrayerEntry copyWithCompanion(PrayerEntriesCompanion data) {
    return PrayerEntry(
      id: data.id.present ? data.id.value : this.id,
      prayer: data.prayer.present ? data.prayer.value : this.prayer,
      status: data.status.present ? data.status.value : this.status,
      loggedAtUtc: data.loggedAtUtc.present
          ? data.loggedAtUtc.value
          : this.loggedAtUtc,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      note: data.note.present ? data.note.value : this.note,
      xpAwarded: data.xpAwarded.present ? data.xpAwarded.value : this.xpAwarded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrayerEntry(')
          ..write('id: $id, ')
          ..write('prayer: $prayer, ')
          ..write('status: $status, ')
          ..write('loggedAtUtc: $loggedAtUtc, ')
          ..write('localDate: $localDate, ')
          ..write('timezone: $timezone, ')
          ..write('note: $note, ')
          ..write('xpAwarded: $xpAwarded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    prayer,
    status,
    loggedAtUtc,
    localDate,
    timezone,
    note,
    xpAwarded,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrayerEntry &&
          other.id == this.id &&
          other.prayer == this.prayer &&
          other.status == this.status &&
          other.loggedAtUtc == this.loggedAtUtc &&
          other.localDate == this.localDate &&
          other.timezone == this.timezone &&
          other.note == this.note &&
          other.xpAwarded == this.xpAwarded);
}

class PrayerEntriesCompanion extends UpdateCompanion<PrayerEntry> {
  final Value<int> id;
  final Value<PrayerType> prayer;
  final Value<PrayerStatus> status;
  final Value<DateTime> loggedAtUtc;
  final Value<String> localDate;
  final Value<String> timezone;
  final Value<String?> note;
  final Value<int> xpAwarded;
  const PrayerEntriesCompanion({
    this.id = const Value.absent(),
    this.prayer = const Value.absent(),
    this.status = const Value.absent(),
    this.loggedAtUtc = const Value.absent(),
    this.localDate = const Value.absent(),
    this.timezone = const Value.absent(),
    this.note = const Value.absent(),
    this.xpAwarded = const Value.absent(),
  });
  PrayerEntriesCompanion.insert({
    this.id = const Value.absent(),
    required PrayerType prayer,
    required PrayerStatus status,
    required DateTime loggedAtUtc,
    required String localDate,
    this.timezone = const Value.absent(),
    this.note = const Value.absent(),
    this.xpAwarded = const Value.absent(),
  }) : prayer = Value(prayer),
       status = Value(status),
       loggedAtUtc = Value(loggedAtUtc),
       localDate = Value(localDate);
  static Insertable<PrayerEntry> custom({
    Expression<int>? id,
    Expression<String>? prayer,
    Expression<String>? status,
    Expression<DateTime>? loggedAtUtc,
    Expression<String>? localDate,
    Expression<String>? timezone,
    Expression<String>? note,
    Expression<int>? xpAwarded,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (prayer != null) 'prayer': prayer,
      if (status != null) 'status': status,
      if (loggedAtUtc != null) 'logged_at_utc': loggedAtUtc,
      if (localDate != null) 'local_date': localDate,
      if (timezone != null) 'timezone': timezone,
      if (note != null) 'note': note,
      if (xpAwarded != null) 'xp_awarded': xpAwarded,
    });
  }

  PrayerEntriesCompanion copyWith({
    Value<int>? id,
    Value<PrayerType>? prayer,
    Value<PrayerStatus>? status,
    Value<DateTime>? loggedAtUtc,
    Value<String>? localDate,
    Value<String>? timezone,
    Value<String?>? note,
    Value<int>? xpAwarded,
  }) {
    return PrayerEntriesCompanion(
      id: id ?? this.id,
      prayer: prayer ?? this.prayer,
      status: status ?? this.status,
      loggedAtUtc: loggedAtUtc ?? this.loggedAtUtc,
      localDate: localDate ?? this.localDate,
      timezone: timezone ?? this.timezone,
      note: note ?? this.note,
      xpAwarded: xpAwarded ?? this.xpAwarded,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (prayer.present) {
      map['prayer'] = Variable<String>(
        $PrayerEntriesTable.$converterprayer.toSql(prayer.value),
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $PrayerEntriesTable.$converterstatus.toSql(status.value),
      );
    }
    if (loggedAtUtc.present) {
      map['logged_at_utc'] = Variable<DateTime>(loggedAtUtc.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (xpAwarded.present) {
      map['xp_awarded'] = Variable<int>(xpAwarded.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrayerEntriesCompanion(')
          ..write('id: $id, ')
          ..write('prayer: $prayer, ')
          ..write('status: $status, ')
          ..write('loggedAtUtc: $loggedAtUtc, ')
          ..write('localDate: $localDate, ')
          ..write('timezone: $timezone, ')
          ..write('note: $note, ')
          ..write('xpAwarded: $xpAwarded')
          ..write(')'))
        .toString();
  }
}

class $ReadingItemsTable extends ReadingItems
    with TableInfo<$ReadingItemsTable, ReadingItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReadingType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ReadingType>($ReadingItemsTable.$convertertype);
  static const VerificationMeta _totalUnitsMeta = const VerificationMeta(
    'totalUnits',
  );
  @override
  late final GeneratedColumn<int> totalUnits = GeneratedColumn<int>(
    'total_units',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverImagePathMeta = const VerificationMeta(
    'coverImagePath',
  );
  @override
  late final GeneratedColumn<String> coverImagePath = GeneratedColumn<String>(
    'cover_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addedAtUtcMeta = const VerificationMeta(
    'addedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> addedAtUtc = GeneratedColumn<DateTime>(
    'added_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReadingStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('wantToRead'),
      ).withConverter<ReadingStatus>($ReadingItemsTable.$converterstatus);
  static const VerificationMeta _statusUpdatedAtUtcMeta =
      const VerificationMeta('statusUpdatedAtUtc');
  @override
  late final GeneratedColumn<DateTime> statusUpdatedAtUtc =
      GeneratedColumn<DateTime>(
        'status_updated_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _completedAtUtcMeta = const VerificationMeta(
    'completedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> completedAtUtc =
      GeneratedColumn<DateTime>(
        'completed_at_utc',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    author,
    type,
    totalUnits,
    coverImagePath,
    addedAtUtc,
    isArchived,
    status,
    statusUpdatedAtUtc,
    completedAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('total_units')) {
      context.handle(
        _totalUnitsMeta,
        totalUnits.isAcceptableOrUnknown(data['total_units']!, _totalUnitsMeta),
      );
    }
    if (data.containsKey('cover_image_path')) {
      context.handle(
        _coverImagePathMeta,
        coverImagePath.isAcceptableOrUnknown(
          data['cover_image_path']!,
          _coverImagePathMeta,
        ),
      );
    }
    if (data.containsKey('added_at_utc')) {
      context.handle(
        _addedAtUtcMeta,
        addedAtUtc.isAcceptableOrUnknown(
          data['added_at_utc']!,
          _addedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_addedAtUtcMeta);
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('status_updated_at_utc')) {
      context.handle(
        _statusUpdatedAtUtcMeta,
        statusUpdatedAtUtc.isAcceptableOrUnknown(
          data['status_updated_at_utc']!,
          _statusUpdatedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statusUpdatedAtUtcMeta);
    }
    if (data.containsKey('completed_at_utc')) {
      context.handle(
        _completedAtUtcMeta,
        completedAtUtc.isAcceptableOrUnknown(
          data['completed_at_utc']!,
          _completedAtUtcMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      type: $ReadingItemsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      totalUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_units'],
      ),
      coverImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_image_path'],
      ),
      addedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at_utc'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      status: $ReadingItemsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      statusUpdatedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}status_updated_at_utc'],
      )!,
      completedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at_utc'],
      ),
    );
  }

  @override
  $ReadingItemsTable createAlias(String alias) {
    return $ReadingItemsTable(attachedDatabase, alias);
  }

  static TypeConverter<ReadingType, String> $convertertype =
      readingTypeConverter;
  static TypeConverter<ReadingStatus, String> $converterstatus =
      readingStatusConverter;
}

class ReadingItem extends DataClass implements Insertable<ReadingItem> {
  final int id;
  final String title;
  final String? author;
  final ReadingType type;
  final int? totalUnits;
  final String? coverImagePath;
  final DateTime addedAtUtc;
  final bool isArchived;
  final ReadingStatus status;
  final DateTime statusUpdatedAtUtc;
  final DateTime? completedAtUtc;
  const ReadingItem({
    required this.id,
    required this.title,
    this.author,
    required this.type,
    this.totalUnits,
    this.coverImagePath,
    required this.addedAtUtc,
    required this.isArchived,
    required this.status,
    required this.statusUpdatedAtUtc,
    this.completedAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    {
      map['type'] = Variable<String>(
        $ReadingItemsTable.$convertertype.toSql(type),
      );
    }
    if (!nullToAbsent || totalUnits != null) {
      map['total_units'] = Variable<int>(totalUnits);
    }
    if (!nullToAbsent || coverImagePath != null) {
      map['cover_image_path'] = Variable<String>(coverImagePath);
    }
    map['added_at_utc'] = Variable<DateTime>(addedAtUtc);
    map['is_archived'] = Variable<bool>(isArchived);
    {
      map['status'] = Variable<String>(
        $ReadingItemsTable.$converterstatus.toSql(status),
      );
    }
    map['status_updated_at_utc'] = Variable<DateTime>(statusUpdatedAtUtc);
    if (!nullToAbsent || completedAtUtc != null) {
      map['completed_at_utc'] = Variable<DateTime>(completedAtUtc);
    }
    return map;
  }

  ReadingItemsCompanion toCompanion(bool nullToAbsent) {
    return ReadingItemsCompanion(
      id: Value(id),
      title: Value(title),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      type: Value(type),
      totalUnits: totalUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(totalUnits),
      coverImagePath: coverImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(coverImagePath),
      addedAtUtc: Value(addedAtUtc),
      isArchived: Value(isArchived),
      status: Value(status),
      statusUpdatedAtUtc: Value(statusUpdatedAtUtc),
      completedAtUtc: completedAtUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAtUtc),
    );
  }

  factory ReadingItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingItem(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String?>(json['author']),
      type: serializer.fromJson<ReadingType>(json['type']),
      totalUnits: serializer.fromJson<int?>(json['totalUnits']),
      coverImagePath: serializer.fromJson<String?>(json['coverImagePath']),
      addedAtUtc: serializer.fromJson<DateTime>(json['addedAtUtc']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      status: serializer.fromJson<ReadingStatus>(json['status']),
      statusUpdatedAtUtc: serializer.fromJson<DateTime>(
        json['statusUpdatedAtUtc'],
      ),
      completedAtUtc: serializer.fromJson<DateTime?>(json['completedAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String?>(author),
      'type': serializer.toJson<ReadingType>(type),
      'totalUnits': serializer.toJson<int?>(totalUnits),
      'coverImagePath': serializer.toJson<String?>(coverImagePath),
      'addedAtUtc': serializer.toJson<DateTime>(addedAtUtc),
      'isArchived': serializer.toJson<bool>(isArchived),
      'status': serializer.toJson<ReadingStatus>(status),
      'statusUpdatedAtUtc': serializer.toJson<DateTime>(statusUpdatedAtUtc),
      'completedAtUtc': serializer.toJson<DateTime?>(completedAtUtc),
    };
  }

  ReadingItem copyWith({
    int? id,
    String? title,
    Value<String?> author = const Value.absent(),
    ReadingType? type,
    Value<int?> totalUnits = const Value.absent(),
    Value<String?> coverImagePath = const Value.absent(),
    DateTime? addedAtUtc,
    bool? isArchived,
    ReadingStatus? status,
    DateTime? statusUpdatedAtUtc,
    Value<DateTime?> completedAtUtc = const Value.absent(),
  }) => ReadingItem(
    id: id ?? this.id,
    title: title ?? this.title,
    author: author.present ? author.value : this.author,
    type: type ?? this.type,
    totalUnits: totalUnits.present ? totalUnits.value : this.totalUnits,
    coverImagePath: coverImagePath.present
        ? coverImagePath.value
        : this.coverImagePath,
    addedAtUtc: addedAtUtc ?? this.addedAtUtc,
    isArchived: isArchived ?? this.isArchived,
    status: status ?? this.status,
    statusUpdatedAtUtc: statusUpdatedAtUtc ?? this.statusUpdatedAtUtc,
    completedAtUtc: completedAtUtc.present
        ? completedAtUtc.value
        : this.completedAtUtc,
  );
  ReadingItem copyWithCompanion(ReadingItemsCompanion data) {
    return ReadingItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      type: data.type.present ? data.type.value : this.type,
      totalUnits: data.totalUnits.present
          ? data.totalUnits.value
          : this.totalUnits,
      coverImagePath: data.coverImagePath.present
          ? data.coverImagePath.value
          : this.coverImagePath,
      addedAtUtc: data.addedAtUtc.present
          ? data.addedAtUtc.value
          : this.addedAtUtc,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      status: data.status.present ? data.status.value : this.status,
      statusUpdatedAtUtc: data.statusUpdatedAtUtc.present
          ? data.statusUpdatedAtUtc.value
          : this.statusUpdatedAtUtc,
      completedAtUtc: data.completedAtUtc.present
          ? data.completedAtUtc.value
          : this.completedAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('type: $type, ')
          ..write('totalUnits: $totalUnits, ')
          ..write('coverImagePath: $coverImagePath, ')
          ..write('addedAtUtc: $addedAtUtc, ')
          ..write('isArchived: $isArchived, ')
          ..write('status: $status, ')
          ..write('statusUpdatedAtUtc: $statusUpdatedAtUtc, ')
          ..write('completedAtUtc: $completedAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    author,
    type,
    totalUnits,
    coverImagePath,
    addedAtUtc,
    isArchived,
    status,
    statusUpdatedAtUtc,
    completedAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.author == this.author &&
          other.type == this.type &&
          other.totalUnits == this.totalUnits &&
          other.coverImagePath == this.coverImagePath &&
          other.addedAtUtc == this.addedAtUtc &&
          other.isArchived == this.isArchived &&
          other.status == this.status &&
          other.statusUpdatedAtUtc == this.statusUpdatedAtUtc &&
          other.completedAtUtc == this.completedAtUtc);
}

class ReadingItemsCompanion extends UpdateCompanion<ReadingItem> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> author;
  final Value<ReadingType> type;
  final Value<int?> totalUnits;
  final Value<String?> coverImagePath;
  final Value<DateTime> addedAtUtc;
  final Value<bool> isArchived;
  final Value<ReadingStatus> status;
  final Value<DateTime> statusUpdatedAtUtc;
  final Value<DateTime?> completedAtUtc;
  const ReadingItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.type = const Value.absent(),
    this.totalUnits = const Value.absent(),
    this.coverImagePath = const Value.absent(),
    this.addedAtUtc = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.status = const Value.absent(),
    this.statusUpdatedAtUtc = const Value.absent(),
    this.completedAtUtc = const Value.absent(),
  });
  ReadingItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.author = const Value.absent(),
    required ReadingType type,
    this.totalUnits = const Value.absent(),
    this.coverImagePath = const Value.absent(),
    required DateTime addedAtUtc,
    this.isArchived = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime statusUpdatedAtUtc,
    this.completedAtUtc = const Value.absent(),
  }) : title = Value(title),
       type = Value(type),
       addedAtUtc = Value(addedAtUtc),
       statusUpdatedAtUtc = Value(statusUpdatedAtUtc);
  static Insertable<ReadingItem> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? type,
    Expression<int>? totalUnits,
    Expression<String>? coverImagePath,
    Expression<DateTime>? addedAtUtc,
    Expression<bool>? isArchived,
    Expression<String>? status,
    Expression<DateTime>? statusUpdatedAtUtc,
    Expression<DateTime>? completedAtUtc,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (type != null) 'type': type,
      if (totalUnits != null) 'total_units': totalUnits,
      if (coverImagePath != null) 'cover_image_path': coverImagePath,
      if (addedAtUtc != null) 'added_at_utc': addedAtUtc,
      if (isArchived != null) 'is_archived': isArchived,
      if (status != null) 'status': status,
      if (statusUpdatedAtUtc != null)
        'status_updated_at_utc': statusUpdatedAtUtc,
      if (completedAtUtc != null) 'completed_at_utc': completedAtUtc,
    });
  }

  ReadingItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? author,
    Value<ReadingType>? type,
    Value<int?>? totalUnits,
    Value<String?>? coverImagePath,
    Value<DateTime>? addedAtUtc,
    Value<bool>? isArchived,
    Value<ReadingStatus>? status,
    Value<DateTime>? statusUpdatedAtUtc,
    Value<DateTime?>? completedAtUtc,
  }) {
    return ReadingItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      type: type ?? this.type,
      totalUnits: totalUnits ?? this.totalUnits,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      addedAtUtc: addedAtUtc ?? this.addedAtUtc,
      isArchived: isArchived ?? this.isArchived,
      status: status ?? this.status,
      statusUpdatedAtUtc: statusUpdatedAtUtc ?? this.statusUpdatedAtUtc,
      completedAtUtc: completedAtUtc ?? this.completedAtUtc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $ReadingItemsTable.$convertertype.toSql(type.value),
      );
    }
    if (totalUnits.present) {
      map['total_units'] = Variable<int>(totalUnits.value);
    }
    if (coverImagePath.present) {
      map['cover_image_path'] = Variable<String>(coverImagePath.value);
    }
    if (addedAtUtc.present) {
      map['added_at_utc'] = Variable<DateTime>(addedAtUtc.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $ReadingItemsTable.$converterstatus.toSql(status.value),
      );
    }
    if (statusUpdatedAtUtc.present) {
      map['status_updated_at_utc'] = Variable<DateTime>(
        statusUpdatedAtUtc.value,
      );
    }
    if (completedAtUtc.present) {
      map['completed_at_utc'] = Variable<DateTime>(completedAtUtc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('type: $type, ')
          ..write('totalUnits: $totalUnits, ')
          ..write('coverImagePath: $coverImagePath, ')
          ..write('addedAtUtc: $addedAtUtc, ')
          ..write('isArchived: $isArchived, ')
          ..write('status: $status, ')
          ..write('statusUpdatedAtUtc: $statusUpdatedAtUtc, ')
          ..write('completedAtUtc: $completedAtUtc')
          ..write(')'))
        .toString();
  }
}

class $ReadingSessionsTable extends ReadingSessions
    with TableInfo<$ReadingSessionsTable, ReadingSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _readingItemIdMeta = const VerificationMeta(
    'readingItemId',
  );
  @override
  late final GeneratedColumn<int> readingItemId = GeneratedColumn<int>(
    'reading_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressUnitsMeta = const VerificationMeta(
    'progressUnits',
  );
  @override
  late final GeneratedColumn<int> progressUnits = GeneratedColumn<int>(
    'progress_units',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    readingItemId,
    durationMinutes,
    progressUnits,
    createdAtUtc,
    localDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reading_item_id')) {
      context.handle(
        _readingItemIdMeta,
        readingItemId.isAcceptableOrUnknown(
          data['reading_item_id']!,
          _readingItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_readingItemIdMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('progress_units')) {
      context.handle(
        _progressUnitsMeta,
        progressUnits.isAcceptableOrUnknown(
          data['progress_units']!,
          _progressUnitsMeta,
        ),
      );
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      readingItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reading_item_id'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      progressUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress_units'],
      ),
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_date'],
      )!,
    );
  }

  @override
  $ReadingSessionsTable createAlias(String alias) {
    return $ReadingSessionsTable(attachedDatabase, alias);
  }
}

class ReadingSession extends DataClass implements Insertable<ReadingSession> {
  final int id;
  final int readingItemId;
  final int durationMinutes;
  final int? progressUnits;
  final DateTime createdAtUtc;
  final String localDate;
  const ReadingSession({
    required this.id,
    required this.readingItemId,
    required this.durationMinutes,
    this.progressUnits,
    required this.createdAtUtc,
    required this.localDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reading_item_id'] = Variable<int>(readingItemId);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || progressUnits != null) {
      map['progress_units'] = Variable<int>(progressUnits);
    }
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    map['local_date'] = Variable<String>(localDate);
    return map;
  }

  ReadingSessionsCompanion toCompanion(bool nullToAbsent) {
    return ReadingSessionsCompanion(
      id: Value(id),
      readingItemId: Value(readingItemId),
      durationMinutes: Value(durationMinutes),
      progressUnits: progressUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(progressUnits),
      createdAtUtc: Value(createdAtUtc),
      localDate: Value(localDate),
    );
  }

  factory ReadingSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingSession(
      id: serializer.fromJson<int>(json['id']),
      readingItemId: serializer.fromJson<int>(json['readingItemId']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      progressUnits: serializer.fromJson<int?>(json['progressUnits']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
      localDate: serializer.fromJson<String>(json['localDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'readingItemId': serializer.toJson<int>(readingItemId),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'progressUnits': serializer.toJson<int?>(progressUnits),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
      'localDate': serializer.toJson<String>(localDate),
    };
  }

  ReadingSession copyWith({
    int? id,
    int? readingItemId,
    int? durationMinutes,
    Value<int?> progressUnits = const Value.absent(),
    DateTime? createdAtUtc,
    String? localDate,
  }) => ReadingSession(
    id: id ?? this.id,
    readingItemId: readingItemId ?? this.readingItemId,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    progressUnits: progressUnits.present
        ? progressUnits.value
        : this.progressUnits,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    localDate: localDate ?? this.localDate,
  );
  ReadingSession copyWithCompanion(ReadingSessionsCompanion data) {
    return ReadingSession(
      id: data.id.present ? data.id.value : this.id,
      readingItemId: data.readingItemId.present
          ? data.readingItemId.value
          : this.readingItemId,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      progressUnits: data.progressUnits.present
          ? data.progressUnits.value
          : this.progressUnits,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingSession(')
          ..write('id: $id, ')
          ..write('readingItemId: $readingItemId, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('progressUnits: $progressUnits, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('localDate: $localDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    readingItemId,
    durationMinutes,
    progressUnits,
    createdAtUtc,
    localDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingSession &&
          other.id == this.id &&
          other.readingItemId == this.readingItemId &&
          other.durationMinutes == this.durationMinutes &&
          other.progressUnits == this.progressUnits &&
          other.createdAtUtc == this.createdAtUtc &&
          other.localDate == this.localDate);
}

class ReadingSessionsCompanion extends UpdateCompanion<ReadingSession> {
  final Value<int> id;
  final Value<int> readingItemId;
  final Value<int> durationMinutes;
  final Value<int?> progressUnits;
  final Value<DateTime> createdAtUtc;
  final Value<String> localDate;
  const ReadingSessionsCompanion({
    this.id = const Value.absent(),
    this.readingItemId = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.progressUnits = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.localDate = const Value.absent(),
  });
  ReadingSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int readingItemId,
    required int durationMinutes,
    this.progressUnits = const Value.absent(),
    required DateTime createdAtUtc,
    required String localDate,
  }) : readingItemId = Value(readingItemId),
       durationMinutes = Value(durationMinutes),
       createdAtUtc = Value(createdAtUtc),
       localDate = Value(localDate);
  static Insertable<ReadingSession> custom({
    Expression<int>? id,
    Expression<int>? readingItemId,
    Expression<int>? durationMinutes,
    Expression<int>? progressUnits,
    Expression<DateTime>? createdAtUtc,
    Expression<String>? localDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (readingItemId != null) 'reading_item_id': readingItemId,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (progressUnits != null) 'progress_units': progressUnits,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (localDate != null) 'local_date': localDate,
    });
  }

  ReadingSessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? readingItemId,
    Value<int>? durationMinutes,
    Value<int?>? progressUnits,
    Value<DateTime>? createdAtUtc,
    Value<String>? localDate,
  }) {
    return ReadingSessionsCompanion(
      id: id ?? this.id,
      readingItemId: readingItemId ?? this.readingItemId,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      progressUnits: progressUnits ?? this.progressUnits,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      localDate: localDate ?? this.localDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (readingItemId.present) {
      map['reading_item_id'] = Variable<int>(readingItemId.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (progressUnits.present) {
      map['progress_units'] = Variable<int>(progressUnits.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingSessionsCompanion(')
          ..write('id: $id, ')
          ..write('readingItemId: $readingItemId, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('progressUnits: $progressUnits, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('localDate: $localDate')
          ..write(')'))
        .toString();
  }
}

class $CaptureItemsTable extends CaptureItems
    with TableInfo<$CaptureItemsTable, CaptureItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CaptureItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CaptureType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CaptureType>($CaptureItemsTable.$convertertype);
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _linkedModuleMeta = const VerificationMeta(
    'linkedModule',
  );
  @override
  late final GeneratedColumn<String> linkedModule = GeneratedColumn<String>(
    'linked_module',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _linkedIdMeta = const VerificationMeta(
    'linkedId',
  );
  @override
  late final GeneratedColumn<int> linkedId = GeneratedColumn<int>(
    'linked_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    content,
    createdAtUtc,
    localDate,
    linkedModule,
    linkedId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'capture_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CaptureItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    if (data.containsKey('linked_module')) {
      context.handle(
        _linkedModuleMeta,
        linkedModule.isAcceptableOrUnknown(
          data['linked_module']!,
          _linkedModuleMeta,
        ),
      );
    }
    if (data.containsKey('linked_id')) {
      context.handle(
        _linkedIdMeta,
        linkedId.isAcceptableOrUnknown(data['linked_id']!, _linkedIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CaptureItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CaptureItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: $CaptureItemsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_date'],
      )!,
      linkedModule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_module'],
      ),
      linkedId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}linked_id'],
      ),
    );
  }

  @override
  $CaptureItemsTable createAlias(String alias) {
    return $CaptureItemsTable(attachedDatabase, alias);
  }

  static TypeConverter<CaptureType, String> $convertertype =
      captureTypeConverter;
}

class CaptureItem extends DataClass implements Insertable<CaptureItem> {
  final int id;
  final CaptureType type;
  final String content;
  final DateTime createdAtUtc;
  final String localDate;
  final String? linkedModule;
  final int? linkedId;
  const CaptureItem({
    required this.id,
    required this.type,
    required this.content,
    required this.createdAtUtc,
    required this.localDate,
    this.linkedModule,
    this.linkedId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] = Variable<String>(
        $CaptureItemsTable.$convertertype.toSql(type),
      );
    }
    map['content'] = Variable<String>(content);
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    map['local_date'] = Variable<String>(localDate);
    if (!nullToAbsent || linkedModule != null) {
      map['linked_module'] = Variable<String>(linkedModule);
    }
    if (!nullToAbsent || linkedId != null) {
      map['linked_id'] = Variable<int>(linkedId);
    }
    return map;
  }

  CaptureItemsCompanion toCompanion(bool nullToAbsent) {
    return CaptureItemsCompanion(
      id: Value(id),
      type: Value(type),
      content: Value(content),
      createdAtUtc: Value(createdAtUtc),
      localDate: Value(localDate),
      linkedModule: linkedModule == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedModule),
      linkedId: linkedId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedId),
    );
  }

  factory CaptureItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CaptureItem(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<CaptureType>(json['type']),
      content: serializer.fromJson<String>(json['content']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
      localDate: serializer.fromJson<String>(json['localDate']),
      linkedModule: serializer.fromJson<String?>(json['linkedModule']),
      linkedId: serializer.fromJson<int?>(json['linkedId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<CaptureType>(type),
      'content': serializer.toJson<String>(content),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
      'localDate': serializer.toJson<String>(localDate),
      'linkedModule': serializer.toJson<String?>(linkedModule),
      'linkedId': serializer.toJson<int?>(linkedId),
    };
  }

  CaptureItem copyWith({
    int? id,
    CaptureType? type,
    String? content,
    DateTime? createdAtUtc,
    String? localDate,
    Value<String?> linkedModule = const Value.absent(),
    Value<int?> linkedId = const Value.absent(),
  }) => CaptureItem(
    id: id ?? this.id,
    type: type ?? this.type,
    content: content ?? this.content,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    localDate: localDate ?? this.localDate,
    linkedModule: linkedModule.present ? linkedModule.value : this.linkedModule,
    linkedId: linkedId.present ? linkedId.value : this.linkedId,
  );
  CaptureItem copyWithCompanion(CaptureItemsCompanion data) {
    return CaptureItem(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      linkedModule: data.linkedModule.present
          ? data.linkedModule.value
          : this.linkedModule,
      linkedId: data.linkedId.present ? data.linkedId.value : this.linkedId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CaptureItem(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('localDate: $localDate, ')
          ..write('linkedModule: $linkedModule, ')
          ..write('linkedId: $linkedId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    content,
    createdAtUtc,
    localDate,
    linkedModule,
    linkedId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CaptureItem &&
          other.id == this.id &&
          other.type == this.type &&
          other.content == this.content &&
          other.createdAtUtc == this.createdAtUtc &&
          other.localDate == this.localDate &&
          other.linkedModule == this.linkedModule &&
          other.linkedId == this.linkedId);
}

class CaptureItemsCompanion extends UpdateCompanion<CaptureItem> {
  final Value<int> id;
  final Value<CaptureType> type;
  final Value<String> content;
  final Value<DateTime> createdAtUtc;
  final Value<String> localDate;
  final Value<String?> linkedModule;
  final Value<int?> linkedId;
  const CaptureItemsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.localDate = const Value.absent(),
    this.linkedModule = const Value.absent(),
    this.linkedId = const Value.absent(),
  });
  CaptureItemsCompanion.insert({
    this.id = const Value.absent(),
    required CaptureType type,
    required String content,
    required DateTime createdAtUtc,
    required String localDate,
    this.linkedModule = const Value.absent(),
    this.linkedId = const Value.absent(),
  }) : type = Value(type),
       content = Value(content),
       createdAtUtc = Value(createdAtUtc),
       localDate = Value(localDate);
  static Insertable<CaptureItem> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? content,
    Expression<DateTime>? createdAtUtc,
    Expression<String>? localDate,
    Expression<String>? linkedModule,
    Expression<int>? linkedId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (localDate != null) 'local_date': localDate,
      if (linkedModule != null) 'linked_module': linkedModule,
      if (linkedId != null) 'linked_id': linkedId,
    });
  }

  CaptureItemsCompanion copyWith({
    Value<int>? id,
    Value<CaptureType>? type,
    Value<String>? content,
    Value<DateTime>? createdAtUtc,
    Value<String>? localDate,
    Value<String?>? linkedModule,
    Value<int?>? linkedId,
  }) {
    return CaptureItemsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      localDate: localDate ?? this.localDate,
      linkedModule: linkedModule ?? this.linkedModule,
      linkedId: linkedId ?? this.linkedId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $CaptureItemsTable.$convertertype.toSql(type.value),
      );
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    if (linkedModule.present) {
      map['linked_module'] = Variable<String>(linkedModule.value);
    }
    if (linkedId.present) {
      map['linked_id'] = Variable<int>(linkedId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CaptureItemsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('localDate: $localDate, ')
          ..write('linkedModule: $linkedModule, ')
          ..write('linkedId: $linkedId')
          ..write(')'))
        .toString();
  }
}

class $XpEventsTable extends XpEvents with TableInfo<$XpEventsTable, XpEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $XpEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<int> sourceId = GeneratedColumn<int>(
    'source_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    sourceId,
    xp,
    reason,
    createdAtUtc,
    localDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'xp_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<XpEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    } else if (isInserting) {
      context.missing(_xpMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  XpEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return XpEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_id'],
      ),
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_date'],
      )!,
    );
  }

  @override
  $XpEventsTable createAlias(String alias) {
    return $XpEventsTable(attachedDatabase, alias);
  }
}

class XpEvent extends DataClass implements Insertable<XpEvent> {
  final int id;
  final String source;
  final int? sourceId;
  final int xp;
  final String? reason;
  final DateTime createdAtUtc;
  final String localDate;
  const XpEvent({
    required this.id,
    required this.source,
    this.sourceId,
    required this.xp,
    this.reason,
    required this.createdAtUtc,
    required this.localDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<int>(sourceId);
    }
    map['xp'] = Variable<int>(xp);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    map['local_date'] = Variable<String>(localDate);
    return map;
  }

  XpEventsCompanion toCompanion(bool nullToAbsent) {
    return XpEventsCompanion(
      id: Value(id),
      source: Value(source),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      xp: Value(xp),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      createdAtUtc: Value(createdAtUtc),
      localDate: Value(localDate),
    );
  }

  factory XpEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return XpEvent(
      id: serializer.fromJson<int>(json['id']),
      source: serializer.fromJson<String>(json['source']),
      sourceId: serializer.fromJson<int?>(json['sourceId']),
      xp: serializer.fromJson<int>(json['xp']),
      reason: serializer.fromJson<String?>(json['reason']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
      localDate: serializer.fromJson<String>(json['localDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'source': serializer.toJson<String>(source),
      'sourceId': serializer.toJson<int?>(sourceId),
      'xp': serializer.toJson<int>(xp),
      'reason': serializer.toJson<String?>(reason),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
      'localDate': serializer.toJson<String>(localDate),
    };
  }

  XpEvent copyWith({
    int? id,
    String? source,
    Value<int?> sourceId = const Value.absent(),
    int? xp,
    Value<String?> reason = const Value.absent(),
    DateTime? createdAtUtc,
    String? localDate,
  }) => XpEvent(
    id: id ?? this.id,
    source: source ?? this.source,
    sourceId: sourceId.present ? sourceId.value : this.sourceId,
    xp: xp ?? this.xp,
    reason: reason.present ? reason.value : this.reason,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    localDate: localDate ?? this.localDate,
  );
  XpEvent copyWithCompanion(XpEventsCompanion data) {
    return XpEvent(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      xp: data.xp.present ? data.xp.value : this.xp,
      reason: data.reason.present ? data.reason.value : this.reason,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('XpEvent(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId, ')
          ..write('xp: $xp, ')
          ..write('reason: $reason, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('localDate: $localDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, source, sourceId, xp, reason, createdAtUtc, localDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is XpEvent &&
          other.id == this.id &&
          other.source == this.source &&
          other.sourceId == this.sourceId &&
          other.xp == this.xp &&
          other.reason == this.reason &&
          other.createdAtUtc == this.createdAtUtc &&
          other.localDate == this.localDate);
}

class XpEventsCompanion extends UpdateCompanion<XpEvent> {
  final Value<int> id;
  final Value<String> source;
  final Value<int?> sourceId;
  final Value<int> xp;
  final Value<String?> reason;
  final Value<DateTime> createdAtUtc;
  final Value<String> localDate;
  const XpEventsCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.xp = const Value.absent(),
    this.reason = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.localDate = const Value.absent(),
  });
  XpEventsCompanion.insert({
    this.id = const Value.absent(),
    required String source,
    this.sourceId = const Value.absent(),
    required int xp,
    this.reason = const Value.absent(),
    required DateTime createdAtUtc,
    required String localDate,
  }) : source = Value(source),
       xp = Value(xp),
       createdAtUtc = Value(createdAtUtc),
       localDate = Value(localDate);
  static Insertable<XpEvent> custom({
    Expression<int>? id,
    Expression<String>? source,
    Expression<int>? sourceId,
    Expression<int>? xp,
    Expression<String>? reason,
    Expression<DateTime>? createdAtUtc,
    Expression<String>? localDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (sourceId != null) 'source_id': sourceId,
      if (xp != null) 'xp': xp,
      if (reason != null) 'reason': reason,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (localDate != null) 'local_date': localDate,
    });
  }

  XpEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? source,
    Value<int?>? sourceId,
    Value<int>? xp,
    Value<String?>? reason,
    Value<DateTime>? createdAtUtc,
    Value<String>? localDate,
  }) {
    return XpEventsCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      sourceId: sourceId ?? this.sourceId,
      xp: xp ?? this.xp,
      reason: reason ?? this.reason,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      localDate: localDate ?? this.localDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<int>(sourceId.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('XpEventsCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId, ')
          ..write('xp: $xp, ')
          ..write('reason: $reason, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('localDate: $localDate')
          ..write(')'))
        .toString();
  }
}

class $InsightEntriesTable extends InsightEntries
    with TableInfo<$InsightEntriesTable, InsightEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InsightEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generatedAtUtcMeta = const VerificationMeta(
    'generatedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAtUtc =
      GeneratedColumn<DateTime>(
        'generated_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _expiresAtUtcMeta = const VerificationMeta(
    'expiresAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAtUtc = GeneratedColumn<DateTime>(
    'expires_at_utc',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    message,
    generatedAtUtc,
    expiresAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'insight_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<InsightEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('generated_at_utc')) {
      context.handle(
        _generatedAtUtcMeta,
        generatedAtUtc.isAcceptableOrUnknown(
          data['generated_at_utc']!,
          _generatedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtUtcMeta);
    }
    if (data.containsKey('expires_at_utc')) {
      context.handle(
        _expiresAtUtcMeta,
        expiresAtUtc.isAcceptableOrUnknown(
          data['expires_at_utc']!,
          _expiresAtUtcMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InsightEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InsightEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      generatedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at_utc'],
      )!,
      expiresAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at_utc'],
      ),
    );
  }

  @override
  $InsightEntriesTable createAlias(String alias) {
    return $InsightEntriesTable(attachedDatabase, alias);
  }
}

class InsightEntry extends DataClass implements Insertable<InsightEntry> {
  final int id;
  final String type;
  final String message;
  final DateTime generatedAtUtc;
  final DateTime? expiresAtUtc;
  const InsightEntry({
    required this.id,
    required this.type,
    required this.message,
    required this.generatedAtUtc,
    this.expiresAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['message'] = Variable<String>(message);
    map['generated_at_utc'] = Variable<DateTime>(generatedAtUtc);
    if (!nullToAbsent || expiresAtUtc != null) {
      map['expires_at_utc'] = Variable<DateTime>(expiresAtUtc);
    }
    return map;
  }

  InsightEntriesCompanion toCompanion(bool nullToAbsent) {
    return InsightEntriesCompanion(
      id: Value(id),
      type: Value(type),
      message: Value(message),
      generatedAtUtc: Value(generatedAtUtc),
      expiresAtUtc: expiresAtUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAtUtc),
    );
  }

  factory InsightEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InsightEntry(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      message: serializer.fromJson<String>(json['message']),
      generatedAtUtc: serializer.fromJson<DateTime>(json['generatedAtUtc']),
      expiresAtUtc: serializer.fromJson<DateTime?>(json['expiresAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'message': serializer.toJson<String>(message),
      'generatedAtUtc': serializer.toJson<DateTime>(generatedAtUtc),
      'expiresAtUtc': serializer.toJson<DateTime?>(expiresAtUtc),
    };
  }

  InsightEntry copyWith({
    int? id,
    String? type,
    String? message,
    DateTime? generatedAtUtc,
    Value<DateTime?> expiresAtUtc = const Value.absent(),
  }) => InsightEntry(
    id: id ?? this.id,
    type: type ?? this.type,
    message: message ?? this.message,
    generatedAtUtc: generatedAtUtc ?? this.generatedAtUtc,
    expiresAtUtc: expiresAtUtc.present ? expiresAtUtc.value : this.expiresAtUtc,
  );
  InsightEntry copyWithCompanion(InsightEntriesCompanion data) {
    return InsightEntry(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      message: data.message.present ? data.message.value : this.message,
      generatedAtUtc: data.generatedAtUtc.present
          ? data.generatedAtUtc.value
          : this.generatedAtUtc,
      expiresAtUtc: data.expiresAtUtc.present
          ? data.expiresAtUtc.value
          : this.expiresAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InsightEntry(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('message: $message, ')
          ..write('generatedAtUtc: $generatedAtUtc, ')
          ..write('expiresAtUtc: $expiresAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, message, generatedAtUtc, expiresAtUtc);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InsightEntry &&
          other.id == this.id &&
          other.type == this.type &&
          other.message == this.message &&
          other.generatedAtUtc == this.generatedAtUtc &&
          other.expiresAtUtc == this.expiresAtUtc);
}

class InsightEntriesCompanion extends UpdateCompanion<InsightEntry> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> message;
  final Value<DateTime> generatedAtUtc;
  final Value<DateTime?> expiresAtUtc;
  const InsightEntriesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.message = const Value.absent(),
    this.generatedAtUtc = const Value.absent(),
    this.expiresAtUtc = const Value.absent(),
  });
  InsightEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required String message,
    required DateTime generatedAtUtc,
    this.expiresAtUtc = const Value.absent(),
  }) : type = Value(type),
       message = Value(message),
       generatedAtUtc = Value(generatedAtUtc);
  static Insertable<InsightEntry> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? message,
    Expression<DateTime>? generatedAtUtc,
    Expression<DateTime>? expiresAtUtc,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (message != null) 'message': message,
      if (generatedAtUtc != null) 'generated_at_utc': generatedAtUtc,
      if (expiresAtUtc != null) 'expires_at_utc': expiresAtUtc,
    });
  }

  InsightEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<String>? message,
    Value<DateTime>? generatedAtUtc,
    Value<DateTime?>? expiresAtUtc,
  }) {
    return InsightEntriesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      message: message ?? this.message,
      generatedAtUtc: generatedAtUtc ?? this.generatedAtUtc,
      expiresAtUtc: expiresAtUtc ?? this.expiresAtUtc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (generatedAtUtc.present) {
      map['generated_at_utc'] = Variable<DateTime>(generatedAtUtc.value);
    }
    if (expiresAtUtc.present) {
      map['expires_at_utc'] = Variable<DateTime>(expiresAtUtc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InsightEntriesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('message: $message, ')
          ..write('generatedAtUtc: $generatedAtUtc, ')
          ..write('expiresAtUtc: $expiresAtUtc')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PrayerEntriesTable prayerEntries = $PrayerEntriesTable(this);
  late final $ReadingItemsTable readingItems = $ReadingItemsTable(this);
  late final $ReadingSessionsTable readingSessions = $ReadingSessionsTable(
    this,
  );
  late final $CaptureItemsTable captureItems = $CaptureItemsTable(this);
  late final $XpEventsTable xpEvents = $XpEventsTable(this);
  late final $InsightEntriesTable insightEntries = $InsightEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    prayerEntries,
    readingItems,
    readingSessions,
    captureItems,
    xpEvents,
    insightEntries,
  ];
}

typedef $$PrayerEntriesTableCreateCompanionBuilder =
    PrayerEntriesCompanion Function({
      Value<int> id,
      required PrayerType prayer,
      required PrayerStatus status,
      required DateTime loggedAtUtc,
      required String localDate,
      Value<String> timezone,
      Value<String?> note,
      Value<int> xpAwarded,
    });
typedef $$PrayerEntriesTableUpdateCompanionBuilder =
    PrayerEntriesCompanion Function({
      Value<int> id,
      Value<PrayerType> prayer,
      Value<PrayerStatus> status,
      Value<DateTime> loggedAtUtc,
      Value<String> localDate,
      Value<String> timezone,
      Value<String?> note,
      Value<int> xpAwarded,
    });

class $$PrayerEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $PrayerEntriesTable> {
  $$PrayerEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PrayerType, PrayerType, String> get prayer =>
      $composableBuilder(
        column: $table.prayer,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<PrayerStatus, PrayerStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get loggedAtUtc => $composableBuilder(
    column: $table.loggedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpAwarded => $composableBuilder(
    column: $table.xpAwarded,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrayerEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PrayerEntriesTable> {
  $$PrayerEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prayer => $composableBuilder(
    column: $table.prayer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAtUtc => $composableBuilder(
    column: $table.loggedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpAwarded => $composableBuilder(
    column: $table.xpAwarded,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrayerEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrayerEntriesTable> {
  $$PrayerEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PrayerType, String> get prayer =>
      $composableBuilder(column: $table.prayer, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PrayerStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAtUtc => $composableBuilder(
    column: $table.loggedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get xpAwarded =>
      $composableBuilder(column: $table.xpAwarded, builder: (column) => column);
}

class $$PrayerEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrayerEntriesTable,
          PrayerEntry,
          $$PrayerEntriesTableFilterComposer,
          $$PrayerEntriesTableOrderingComposer,
          $$PrayerEntriesTableAnnotationComposer,
          $$PrayerEntriesTableCreateCompanionBuilder,
          $$PrayerEntriesTableUpdateCompanionBuilder,
          (
            PrayerEntry,
            BaseReferences<_$AppDatabase, $PrayerEntriesTable, PrayerEntry>,
          ),
          PrayerEntry,
          PrefetchHooks Function()
        > {
  $$PrayerEntriesTableTableManager(_$AppDatabase db, $PrayerEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrayerEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrayerEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrayerEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<PrayerType> prayer = const Value.absent(),
                Value<PrayerStatus> status = const Value.absent(),
                Value<DateTime> loggedAtUtc = const Value.absent(),
                Value<String> localDate = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> xpAwarded = const Value.absent(),
              }) => PrayerEntriesCompanion(
                id: id,
                prayer: prayer,
                status: status,
                loggedAtUtc: loggedAtUtc,
                localDate: localDate,
                timezone: timezone,
                note: note,
                xpAwarded: xpAwarded,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required PrayerType prayer,
                required PrayerStatus status,
                required DateTime loggedAtUtc,
                required String localDate,
                Value<String> timezone = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> xpAwarded = const Value.absent(),
              }) => PrayerEntriesCompanion.insert(
                id: id,
                prayer: prayer,
                status: status,
                loggedAtUtc: loggedAtUtc,
                localDate: localDate,
                timezone: timezone,
                note: note,
                xpAwarded: xpAwarded,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrayerEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrayerEntriesTable,
      PrayerEntry,
      $$PrayerEntriesTableFilterComposer,
      $$PrayerEntriesTableOrderingComposer,
      $$PrayerEntriesTableAnnotationComposer,
      $$PrayerEntriesTableCreateCompanionBuilder,
      $$PrayerEntriesTableUpdateCompanionBuilder,
      (
        PrayerEntry,
        BaseReferences<_$AppDatabase, $PrayerEntriesTable, PrayerEntry>,
      ),
      PrayerEntry,
      PrefetchHooks Function()
    >;
typedef $$ReadingItemsTableCreateCompanionBuilder =
    ReadingItemsCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> author,
      required ReadingType type,
      Value<int?> totalUnits,
      Value<String?> coverImagePath,
      required DateTime addedAtUtc,
      Value<bool> isArchived,
      Value<ReadingStatus> status,
      required DateTime statusUpdatedAtUtc,
      Value<DateTime?> completedAtUtc,
    });
typedef $$ReadingItemsTableUpdateCompanionBuilder =
    ReadingItemsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> author,
      Value<ReadingType> type,
      Value<int?> totalUnits,
      Value<String?> coverImagePath,
      Value<DateTime> addedAtUtc,
      Value<bool> isArchived,
      Value<ReadingStatus> status,
      Value<DateTime> statusUpdatedAtUtc,
      Value<DateTime?> completedAtUtc,
    });

class $$ReadingItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingItemsTable> {
  $$ReadingItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReadingType, ReadingType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get totalUnits => $composableBuilder(
    column: $table.totalUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverImagePath => $composableBuilder(
    column: $table.coverImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAtUtc => $composableBuilder(
    column: $table.addedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReadingStatus, ReadingStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get statusUpdatedAtUtc => $composableBuilder(
    column: $table.statusUpdatedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAtUtc => $composableBuilder(
    column: $table.completedAtUtc,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReadingItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingItemsTable> {
  $$ReadingItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalUnits => $composableBuilder(
    column: $table.totalUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverImagePath => $composableBuilder(
    column: $table.coverImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAtUtc => $composableBuilder(
    column: $table.addedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get statusUpdatedAtUtc => $composableBuilder(
    column: $table.statusUpdatedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAtUtc => $composableBuilder(
    column: $table.completedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReadingItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingItemsTable> {
  $$ReadingItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReadingType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get totalUnits => $composableBuilder(
    column: $table.totalUnits,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverImagePath => $composableBuilder(
    column: $table.coverImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get addedAtUtc => $composableBuilder(
    column: $table.addedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ReadingStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get statusUpdatedAtUtc => $composableBuilder(
    column: $table.statusUpdatedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAtUtc => $composableBuilder(
    column: $table.completedAtUtc,
    builder: (column) => column,
  );
}

class $$ReadingItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingItemsTable,
          ReadingItem,
          $$ReadingItemsTableFilterComposer,
          $$ReadingItemsTableOrderingComposer,
          $$ReadingItemsTableAnnotationComposer,
          $$ReadingItemsTableCreateCompanionBuilder,
          $$ReadingItemsTableUpdateCompanionBuilder,
          (
            ReadingItem,
            BaseReferences<_$AppDatabase, $ReadingItemsTable, ReadingItem>,
          ),
          ReadingItem,
          PrefetchHooks Function()
        > {
  $$ReadingItemsTableTableManager(_$AppDatabase db, $ReadingItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<ReadingType> type = const Value.absent(),
                Value<int?> totalUnits = const Value.absent(),
                Value<String?> coverImagePath = const Value.absent(),
                Value<DateTime> addedAtUtc = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<ReadingStatus> status = const Value.absent(),
                Value<DateTime> statusUpdatedAtUtc = const Value.absent(),
                Value<DateTime?> completedAtUtc = const Value.absent(),
              }) => ReadingItemsCompanion(
                id: id,
                title: title,
                author: author,
                type: type,
                totalUnits: totalUnits,
                coverImagePath: coverImagePath,
                addedAtUtc: addedAtUtc,
                isArchived: isArchived,
                status: status,
                statusUpdatedAtUtc: statusUpdatedAtUtc,
                completedAtUtc: completedAtUtc,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> author = const Value.absent(),
                required ReadingType type,
                Value<int?> totalUnits = const Value.absent(),
                Value<String?> coverImagePath = const Value.absent(),
                required DateTime addedAtUtc,
                Value<bool> isArchived = const Value.absent(),
                Value<ReadingStatus> status = const Value.absent(),
                required DateTime statusUpdatedAtUtc,
                Value<DateTime?> completedAtUtc = const Value.absent(),
              }) => ReadingItemsCompanion.insert(
                id: id,
                title: title,
                author: author,
                type: type,
                totalUnits: totalUnits,
                coverImagePath: coverImagePath,
                addedAtUtc: addedAtUtc,
                isArchived: isArchived,
                status: status,
                statusUpdatedAtUtc: statusUpdatedAtUtc,
                completedAtUtc: completedAtUtc,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReadingItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingItemsTable,
      ReadingItem,
      $$ReadingItemsTableFilterComposer,
      $$ReadingItemsTableOrderingComposer,
      $$ReadingItemsTableAnnotationComposer,
      $$ReadingItemsTableCreateCompanionBuilder,
      $$ReadingItemsTableUpdateCompanionBuilder,
      (
        ReadingItem,
        BaseReferences<_$AppDatabase, $ReadingItemsTable, ReadingItem>,
      ),
      ReadingItem,
      PrefetchHooks Function()
    >;
typedef $$ReadingSessionsTableCreateCompanionBuilder =
    ReadingSessionsCompanion Function({
      Value<int> id,
      required int readingItemId,
      required int durationMinutes,
      Value<int?> progressUnits,
      required DateTime createdAtUtc,
      required String localDate,
    });
typedef $$ReadingSessionsTableUpdateCompanionBuilder =
    ReadingSessionsCompanion Function({
      Value<int> id,
      Value<int> readingItemId,
      Value<int> durationMinutes,
      Value<int?> progressUnits,
      Value<DateTime> createdAtUtc,
      Value<String> localDate,
    });

class $$ReadingSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingSessionsTable> {
  $$ReadingSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get readingItemId => $composableBuilder(
    column: $table.readingItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progressUnits => $composableBuilder(
    column: $table.progressUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReadingSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingSessionsTable> {
  $$ReadingSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get readingItemId => $composableBuilder(
    column: $table.readingItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progressUnits => $composableBuilder(
    column: $table.progressUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReadingSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingSessionsTable> {
  $$ReadingSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get readingItemId => $composableBuilder(
    column: $table.readingItemId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get progressUnits => $composableBuilder(
    column: $table.progressUnits,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);
}

class $$ReadingSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingSessionsTable,
          ReadingSession,
          $$ReadingSessionsTableFilterComposer,
          $$ReadingSessionsTableOrderingComposer,
          $$ReadingSessionsTableAnnotationComposer,
          $$ReadingSessionsTableCreateCompanionBuilder,
          $$ReadingSessionsTableUpdateCompanionBuilder,
          (
            ReadingSession,
            BaseReferences<
              _$AppDatabase,
              $ReadingSessionsTable,
              ReadingSession
            >,
          ),
          ReadingSession,
          PrefetchHooks Function()
        > {
  $$ReadingSessionsTableTableManager(
    _$AppDatabase db,
    $ReadingSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> readingItemId = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<int?> progressUnits = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<String> localDate = const Value.absent(),
              }) => ReadingSessionsCompanion(
                id: id,
                readingItemId: readingItemId,
                durationMinutes: durationMinutes,
                progressUnits: progressUnits,
                createdAtUtc: createdAtUtc,
                localDate: localDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int readingItemId,
                required int durationMinutes,
                Value<int?> progressUnits = const Value.absent(),
                required DateTime createdAtUtc,
                required String localDate,
              }) => ReadingSessionsCompanion.insert(
                id: id,
                readingItemId: readingItemId,
                durationMinutes: durationMinutes,
                progressUnits: progressUnits,
                createdAtUtc: createdAtUtc,
                localDate: localDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReadingSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingSessionsTable,
      ReadingSession,
      $$ReadingSessionsTableFilterComposer,
      $$ReadingSessionsTableOrderingComposer,
      $$ReadingSessionsTableAnnotationComposer,
      $$ReadingSessionsTableCreateCompanionBuilder,
      $$ReadingSessionsTableUpdateCompanionBuilder,
      (
        ReadingSession,
        BaseReferences<_$AppDatabase, $ReadingSessionsTable, ReadingSession>,
      ),
      ReadingSession,
      PrefetchHooks Function()
    >;
typedef $$CaptureItemsTableCreateCompanionBuilder =
    CaptureItemsCompanion Function({
      Value<int> id,
      required CaptureType type,
      required String content,
      required DateTime createdAtUtc,
      required String localDate,
      Value<String?> linkedModule,
      Value<int?> linkedId,
    });
typedef $$CaptureItemsTableUpdateCompanionBuilder =
    CaptureItemsCompanion Function({
      Value<int> id,
      Value<CaptureType> type,
      Value<String> content,
      Value<DateTime> createdAtUtc,
      Value<String> localDate,
      Value<String?> linkedModule,
      Value<int?> linkedId,
    });

class $$CaptureItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CaptureItemsTable> {
  $$CaptureItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CaptureType, CaptureType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get linkedModule => $composableBuilder(
    column: $table.linkedModule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get linkedId => $composableBuilder(
    column: $table.linkedId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CaptureItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CaptureItemsTable> {
  $$CaptureItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linkedModule => $composableBuilder(
    column: $table.linkedModule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get linkedId => $composableBuilder(
    column: $table.linkedId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CaptureItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CaptureItemsTable> {
  $$CaptureItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CaptureType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<String> get linkedModule => $composableBuilder(
    column: $table.linkedModule,
    builder: (column) => column,
  );

  GeneratedColumn<int> get linkedId =>
      $composableBuilder(column: $table.linkedId, builder: (column) => column);
}

class $$CaptureItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CaptureItemsTable,
          CaptureItem,
          $$CaptureItemsTableFilterComposer,
          $$CaptureItemsTableOrderingComposer,
          $$CaptureItemsTableAnnotationComposer,
          $$CaptureItemsTableCreateCompanionBuilder,
          $$CaptureItemsTableUpdateCompanionBuilder,
          (
            CaptureItem,
            BaseReferences<_$AppDatabase, $CaptureItemsTable, CaptureItem>,
          ),
          CaptureItem,
          PrefetchHooks Function()
        > {
  $$CaptureItemsTableTableManager(_$AppDatabase db, $CaptureItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CaptureItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CaptureItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CaptureItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<CaptureType> type = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<String> localDate = const Value.absent(),
                Value<String?> linkedModule = const Value.absent(),
                Value<int?> linkedId = const Value.absent(),
              }) => CaptureItemsCompanion(
                id: id,
                type: type,
                content: content,
                createdAtUtc: createdAtUtc,
                localDate: localDate,
                linkedModule: linkedModule,
                linkedId: linkedId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required CaptureType type,
                required String content,
                required DateTime createdAtUtc,
                required String localDate,
                Value<String?> linkedModule = const Value.absent(),
                Value<int?> linkedId = const Value.absent(),
              }) => CaptureItemsCompanion.insert(
                id: id,
                type: type,
                content: content,
                createdAtUtc: createdAtUtc,
                localDate: localDate,
                linkedModule: linkedModule,
                linkedId: linkedId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CaptureItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CaptureItemsTable,
      CaptureItem,
      $$CaptureItemsTableFilterComposer,
      $$CaptureItemsTableOrderingComposer,
      $$CaptureItemsTableAnnotationComposer,
      $$CaptureItemsTableCreateCompanionBuilder,
      $$CaptureItemsTableUpdateCompanionBuilder,
      (
        CaptureItem,
        BaseReferences<_$AppDatabase, $CaptureItemsTable, CaptureItem>,
      ),
      CaptureItem,
      PrefetchHooks Function()
    >;
typedef $$XpEventsTableCreateCompanionBuilder =
    XpEventsCompanion Function({
      Value<int> id,
      required String source,
      Value<int?> sourceId,
      required int xp,
      Value<String?> reason,
      required DateTime createdAtUtc,
      required String localDate,
    });
typedef $$XpEventsTableUpdateCompanionBuilder =
    XpEventsCompanion Function({
      Value<int> id,
      Value<String> source,
      Value<int?> sourceId,
      Value<int> xp,
      Value<String?> reason,
      Value<DateTime> createdAtUtc,
      Value<String> localDate,
    });

class $$XpEventsTableFilterComposer
    extends Composer<_$AppDatabase, $XpEventsTable> {
  $$XpEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$XpEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $XpEventsTable> {
  $$XpEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$XpEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $XpEventsTable> {
  $$XpEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);
}

class $$XpEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $XpEventsTable,
          XpEvent,
          $$XpEventsTableFilterComposer,
          $$XpEventsTableOrderingComposer,
          $$XpEventsTableAnnotationComposer,
          $$XpEventsTableCreateCompanionBuilder,
          $$XpEventsTableUpdateCompanionBuilder,
          (XpEvent, BaseReferences<_$AppDatabase, $XpEventsTable, XpEvent>),
          XpEvent,
          PrefetchHooks Function()
        > {
  $$XpEventsTableTableManager(_$AppDatabase db, $XpEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$XpEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$XpEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$XpEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int?> sourceId = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<String> localDate = const Value.absent(),
              }) => XpEventsCompanion(
                id: id,
                source: source,
                sourceId: sourceId,
                xp: xp,
                reason: reason,
                createdAtUtc: createdAtUtc,
                localDate: localDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String source,
                Value<int?> sourceId = const Value.absent(),
                required int xp,
                Value<String?> reason = const Value.absent(),
                required DateTime createdAtUtc,
                required String localDate,
              }) => XpEventsCompanion.insert(
                id: id,
                source: source,
                sourceId: sourceId,
                xp: xp,
                reason: reason,
                createdAtUtc: createdAtUtc,
                localDate: localDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$XpEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $XpEventsTable,
      XpEvent,
      $$XpEventsTableFilterComposer,
      $$XpEventsTableOrderingComposer,
      $$XpEventsTableAnnotationComposer,
      $$XpEventsTableCreateCompanionBuilder,
      $$XpEventsTableUpdateCompanionBuilder,
      (XpEvent, BaseReferences<_$AppDatabase, $XpEventsTable, XpEvent>),
      XpEvent,
      PrefetchHooks Function()
    >;
typedef $$InsightEntriesTableCreateCompanionBuilder =
    InsightEntriesCompanion Function({
      Value<int> id,
      required String type,
      required String message,
      required DateTime generatedAtUtc,
      Value<DateTime?> expiresAtUtc,
    });
typedef $$InsightEntriesTableUpdateCompanionBuilder =
    InsightEntriesCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<String> message,
      Value<DateTime> generatedAtUtc,
      Value<DateTime?> expiresAtUtc,
    });

class $$InsightEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $InsightEntriesTable> {
  $$InsightEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAtUtc => $composableBuilder(
    column: $table.generatedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAtUtc => $composableBuilder(
    column: $table.expiresAtUtc,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InsightEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $InsightEntriesTable> {
  $$InsightEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAtUtc => $composableBuilder(
    column: $table.generatedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAtUtc => $composableBuilder(
    column: $table.expiresAtUtc,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InsightEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InsightEntriesTable> {
  $$InsightEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAtUtc => $composableBuilder(
    column: $table.generatedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expiresAtUtc => $composableBuilder(
    column: $table.expiresAtUtc,
    builder: (column) => column,
  );
}

class $$InsightEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InsightEntriesTable,
          InsightEntry,
          $$InsightEntriesTableFilterComposer,
          $$InsightEntriesTableOrderingComposer,
          $$InsightEntriesTableAnnotationComposer,
          $$InsightEntriesTableCreateCompanionBuilder,
          $$InsightEntriesTableUpdateCompanionBuilder,
          (
            InsightEntry,
            BaseReferences<_$AppDatabase, $InsightEntriesTable, InsightEntry>,
          ),
          InsightEntry,
          PrefetchHooks Function()
        > {
  $$InsightEntriesTableTableManager(
    _$AppDatabase db,
    $InsightEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InsightEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InsightEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InsightEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<DateTime> generatedAtUtc = const Value.absent(),
                Value<DateTime?> expiresAtUtc = const Value.absent(),
              }) => InsightEntriesCompanion(
                id: id,
                type: type,
                message: message,
                generatedAtUtc: generatedAtUtc,
                expiresAtUtc: expiresAtUtc,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required String message,
                required DateTime generatedAtUtc,
                Value<DateTime?> expiresAtUtc = const Value.absent(),
              }) => InsightEntriesCompanion.insert(
                id: id,
                type: type,
                message: message,
                generatedAtUtc: generatedAtUtc,
                expiresAtUtc: expiresAtUtc,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InsightEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InsightEntriesTable,
      InsightEntry,
      $$InsightEntriesTableFilterComposer,
      $$InsightEntriesTableOrderingComposer,
      $$InsightEntriesTableAnnotationComposer,
      $$InsightEntriesTableCreateCompanionBuilder,
      $$InsightEntriesTableUpdateCompanionBuilder,
      (
        InsightEntry,
        BaseReferences<_$AppDatabase, $InsightEntriesTable, InsightEntry>,
      ),
      InsightEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PrayerEntriesTableTableManager get prayerEntries =>
      $$PrayerEntriesTableTableManager(_db, _db.prayerEntries);
  $$ReadingItemsTableTableManager get readingItems =>
      $$ReadingItemsTableTableManager(_db, _db.readingItems);
  $$ReadingSessionsTableTableManager get readingSessions =>
      $$ReadingSessionsTableTableManager(_db, _db.readingSessions);
  $$CaptureItemsTableTableManager get captureItems =>
      $$CaptureItemsTableTableManager(_db, _db.captureItems);
  $$XpEventsTableTableManager get xpEvents =>
      $$XpEventsTableTableManager(_db, _db.xpEvents);
  $$InsightEntriesTableTableManager get insightEntries =>
      $$InsightEntriesTableTableManager(_db, _db.insightEntries);
}
