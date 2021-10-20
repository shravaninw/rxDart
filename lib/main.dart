import 'dart:async';

import 'package:rxdart/rxdart.dart';

Stream<int> list(int a, int b) async* {
  for (int i = a; i <= b; i++) {
    yield i;
  }
}

void main() {
  Stream<int> a = list(1, 5).asBroadcastStream();
  Stream<int> b = list(6, 10).asBroadcastStream();

  _filterStream(a).listen((event) {
    print('filter $event');
  });
  _mapStream(a).listen((event) {
    print('map $event');
  });
  _combineStream(a, b).listen((event) {
    print('combine $event');
  });
  _reduceStream(a).then((value) => print('reduce $value'));

  _concatStream(a, b).listen((event) {
    print('concat $event');
  });
  _zipStream(a, b).listen((event) {
    print('zip $event');
  });
  _flatMap(a).listen((event) {
    print('flat $event');
  });
  _scanStream(a).listen((event) {
    print('scan $event');
  });
  _debounceStream(a).listen((event) {
    print('debounce $event');
  });
  _distinctStream(a).listen((event) {
    print('distinct $event');
  });
  _takeUntilStream(a, b).listen((event) {
    print('take until $event');
  });
  _defaultEmpty().listen((event) {
    print('empty $event');
  });
  _concatMapStream(a).listen((event) {
    print('concatMap $event');
  });
  _distintUntilChanged(a).listen((event) {
    if (event != null) print('DisUnCh $event');
  });

  /*
  *
  *
  *
  *
   */

  _concatEagerStream(a, b).listen((event) {
    print('concatEager $event');
  });

  _mergeStream(a, b).listen((event) {
    print('merge $event');
  });
  _neverStream().listen((event) {
    print('never $event');
  });
  _raceStream(a, b).listen((event) {
    print('race $event');
  });

  _sequenceEqualsStream(a, b).listen((event) {
    print('equals $event');
  });
  _forkJoinStream(a, b).listen((event) {
    print('fork $event');
  });
}

Stream<int> _mapStream(
  Stream<int> a,
) {
  print('Programming using map');
  return Stream.castFrom(a).map((event) => event * 8);
}

Stream<int> _flatMap(Stream<int> a) {
  return Stream.castFrom(a).flatMap((element) =>
      Stream.fromIterable([element, element + 1]).map((event) => event * 2));
}

Stream<Object?> _combineStream(Stream<int> a, Stream<int> b) {
  print('Programming using combineLatest');

  return CombineLatestStream.list<int>([
    Stream.castFrom(a),
    Stream.castFrom(b),
  ]);
}

Stream<dynamic> _concatStream(Stream<int> a, Stream<int> b) {
  return Stream.castFrom(a).concatWith([Stream.castFrom(b)]);
  // return ConcatStream([
  //   Stream.fromIterable(a),
  //   //TimerStream(0, Duration(seconds: 5)),
  //   Stream.fromIterable(b)
  // ]);
}

Stream<int> _zipStream(Stream<int> a, Stream<int> b) {
  return Stream.castFrom(a).zipWith(Stream.castFrom(b), (x, y) => x + y);
}

Stream _scanStream(Stream<int> a) {
  return Stream.castFrom(a).scan((acc, curr, i) => acc + curr, 0);
}

Stream _filterStream(Stream<int> a) {
  return Stream.castFrom(a).where((event) => event % 2 == 0);
}

Future _reduceStream(Stream<int> a) {
  return Stream.castFrom(a).reduce((previous, element) => previous + element);
}

Stream _debounceStream(Stream<int> a) {
  return Stream.castFrom(a)
      .debounce((_) => TimerStream(true, Duration(seconds: 1)));
}

Stream _distinctStream(Stream<int> a) {
  return Stream.castFrom(a).distinct();
}

Stream _takeUntilStream(Stream<int> a, Stream<int> b) {
  return Stream.castFrom(a).takeUntil(TimerStream(
    Stream.castFrom(b),
    Duration(microseconds: 50),
  ));
}

Stream _defaultEmpty() {
  return Stream.empty().defaultIfEmpty(10);
}

Stream _concatMapStream(Stream<int> a) {
  return Stream.castFrom(a).asyncExpand((event) =>
      Stream.fromIterable([event, event + 1]).map((events) => events * 2));
}

Stream _distintUntilChanged(Stream<int> a) {
  return Stream.castFrom(a).scan((accumulated, value, index) {
    accumulated ??= a.elementAt(index - 1);
    return accumulated != value ? value : null;
  }, 0);
}

/*
*
*
*
*
 */

Stream<int> _concatEagerStream(Stream<int> a, Stream<int> b) {
  return ConcatEagerStream([
    Stream.castFrom(a),
    // TimerStream(0, Duration(seconds: 10)),
    Stream.castFrom(b)
  ]);
}

Stream<int> _mergeStream(Stream<int> a, Stream<int> b) {
  return MergeStream([Stream.castFrom(a), Stream.castFrom(b)]);
}

Stream<int> _raceStream(Stream<int> a, Stream<int> b) {
  return RaceStream([Stream.castFrom(a), Stream.castFrom(b)]);
}

Stream<bool> _sequenceEqualsStream(Stream<int> a, Stream<int> b) {
  return Rx.sequenceEqual(Stream.castFrom(a), Stream.castFrom(b));
}

Stream _neverStream() {
  return NeverStream();
}

Stream _forkJoinStream(Stream<int> a, Stream<int> b) {
  return ForkJoinStream.list<int>([Stream.castFrom(a), Stream.castFrom(b)]);
}
