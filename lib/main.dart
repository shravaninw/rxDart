import 'dart:async';

import 'package:rxdart/rxdart.dart';

Stream<String> numbers(int a, int b) async* {
  for (int i = a; i <= b; i++) {
    yield i.toString();
  }
}

Stream<String> character(int a, int b) async* {
  for (int i = a + 64; i <= b + 64; i++) {
    yield String.fromCharCode(i);
  }
}

Stream<String> duplicate() {
  List<String> a = ['1', '1', '2', '2', '1', '1', '2', '2'];
  return Stream.fromIterable(a);
}

void main() {
  _filterStream(numbers(1, 5)).listen((event) {
    print('filter $event');
  });
  _mapStream(numbers(1, 5)).listen((event) {
    print('map $event');
  });
  _combineStream(numbers(1, 5), character(1, 5)).listen((event) {
    print('combine $event');
  });
  _reduceStream(numbers(1, 5)).then((value) => print('reduce $value'));

  _concatStream(numbers(1, 5), character(1, 5)).listen((event) {
    print('concat $event');
  });
  _zipStream(numbers(1, 5), character(1, 5)).listen((event) {
    print('zip $event');
  });
  _flatMap(numbers(1, 5)).listen((event) {
    print('flat $event');
  });
  _scanStream(numbers(1, 5)).listen((event) {
    print('scan $event');
  });
  _debounceStream(numbers(1, 5)).listen((event) {
    print('debounce $event');
  });
  _distinctStream(duplicate()).listen((event) {
    print('distinct $event');
  });
  _takeUntilStream(numbers(1, 5), character(1, 5)).listen((event) {
    print('take until $event');
  });
  _defaultEmpty().listen((event) {
    print('empty $event');
  });
  _concatMapStream(numbers(1, 5)).listen((event) {
    print('concatMap $event');
  });
  _distintUntilChanged(duplicate()).listen((event) {
    if (event != null) print('DisUnCh $event');
  });

  /*
  *
  *
  *
  *
   */

  _concatEagerStream(numbers(1, 5), character(1, 5)).listen((event) {
    print('concatEager $event');
  });

  _mergeStream(numbers(1, 5), character(1, 5)).listen((event) {
    print('merge $event');
  });
  _neverStream().listen((event) {
    print('never $event');
  });
  _raceStream(numbers(1, 5), character(1, 5)).listen((event) {
    print('race $event');
  });

  _sequenceEqualsStream(numbers(1, 5), character(1, 5)).listen((event) {
    print('equals $event');
  });
  _forkJoinStream(numbers(1, 5), character(1, 5)).listen((event) {
    print('fork $event');
  });
}

Stream<String> _mapStream(
  Stream<String> a,
) {
  print('Programming using map');
  return a.map((event) => event * 8);
}

Stream<String> _flatMap(Stream<String> a) {
  return a.flatMap((element) =>
      Stream.fromIterable([element, element + 'hi']).map((event) => event * 2));
}

Stream<Object?> _combineStream(Stream<String> a, Stream<String> b) {
  print('Programming using combineLatest');

  return CombineLatestStream.list<String>([
    a,
    b,
  ]);
}

Stream<dynamic> _concatStream(Stream<String> a, Stream<String> b) {
  return a.concatWith([b]);
  // return ConcatStream([
  //   Stream.fromIterable(a),
  //   //TimerStream(0, Duration(seconds: 5)),
  //   Stream.fromIterable(b)
  // ]);
}

Stream<String> _zipStream(Stream<String> a, Stream<String> b) {
  return a.zipWith(b, (String a, String b) => a + b);
}

Stream<String> _scanStream(Stream<String> a) {
  return a.scan((String acc, String curr, int i) => acc + curr, 0.toString());
}

Stream _filterStream(Stream<String> a) {
  return a.where((event) => int.parse(event) % 2 == 0);
}

Future _reduceStream(Stream<String> a) {
  return a.reduce((previous, element) => previous + element);
}

Stream _debounceStream(Stream<String> a) {
  return a.debounce((_) => TimerStream(true, Duration(seconds: 1)));
}

Stream _distinctStream(Stream<String> a) {
  return a.distinctUnique();
}

Stream _takeUntilStream(Stream<String> a, Stream<String> b) {
  return a.takeUntil(TimerStream(
    b,
    Duration(microseconds: 50),
  ));
}

Stream _defaultEmpty() {
  return Stream.empty().defaultIfEmpty(10);
}

Stream _concatMapStream(Stream<String> a) {
  return a.asyncExpand((event) =>
      Stream.fromIterable([event, event + 'hi']).map((events) => events * 2));
}

Stream _distintUntilChanged(Stream<String> a) {
  return a.scan((accumulated, value, index) {
    if (accumulated != value) {
      accumulated = value;
      return value;
    } else
      return null;
  }, 0).where((event) => event != null);
  //return a.distinct();
}

/*
*
*
*
*
 */

Stream<String> _concatEagerStream(Stream<String> a, Stream<String> b) {
  return ConcatEagerStream([
    a,
    // TimerStream(0, Duration(seconds: 10)),
    b
  ]);
}

Stream<String> _mergeStream(Stream<String> a, Stream<String> b) {
  return MergeStream([a, b]);
}

Stream<String> _raceStream(Stream<String> a, Stream<String> b) {
  return RaceStream([a, b]);
}

Stream<bool> _sequenceEqualsStream(Stream<String> a, Stream<String> b) {
  return Rx.sequenceEqual(a, b);
}

Stream _neverStream() {
  return NeverStream();
}

Stream _forkJoinStream(Stream<String> a, Stream<String> b) {
  return ForkJoinStream.list<String>([a, b]);
}
