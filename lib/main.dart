import 'dart:async';

import 'package:rxdart/rxdart.dart';

void main() {
  List<int> a = [
    1,
    2,
    2,
    1,
    3,
  ];
  List<int> b = [6, 7, 8, 9, 10];
  _filterStream(a).listen((event) {
    print('filter $event');
  });
  _mapStream(a).listen((event) {
    print('map $event');
  });
  _combineStream(a, b).listen((event) {
    print('combine $event');
  });
  _reduceStream(a).listen((event) {
    print('reduce $event');
  });

  //
  // _bufferStream().listen((event) {
  //   print('buffer $event');
  // });
  // _bufferCount().listen((event) {
  //   print('bufCount $event');
  // });
  _concatStream(a, b).listen((event) {
    print('concat $event');
  });
  _zipStream(a, b).listen((event) {
    print('zip $event');
  });
  // _concatEagerStream(a, b).listen((event) {
  //   print('concatEager $event');
  // });
  // _deferStream(a).listen((event) {
  //   print('defer $event');
  // });
  // _mergeStream(a, b).listen((event) {
  //   print('merge $event');
  // });
  // _neverStream().listen((event) {
  //   print('never $event');
  // });
  // _raceStream(a, b).listen((event) {
  //   print('race $event');
  // });
  // // _repeatStream(5).listen((event) {
  // //   print('repeat $event');
  // // });
  // _sequenceEqualsStream(a, b).listen((event) {
  //   print('equals $event');
  // });
  // _forkJoinStream(a, b).listen((event) {
  //   print('fork $event');
  // });
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
}

Stream<int> _mapStream(
  List<int> a,
) {
  print('Programming using map');
  return Stream.fromIterable(a).map((event) => event * 8);
}

Stream<int> _flatMap(List<int> a) {
  return Stream.fromIterable(a).flatMap((element) =>
      Stream.fromIterable([element, element + 1]).map((event) => event * 2));
}

Stream<Object?> _combineStream(List<int> a, List<int> b) {
  print('Programming using combineLatest');

  return CombineLatestStream.list<int>([
    Stream.fromIterable(a),
    Stream.fromIterable(b),
  ]);
}

Stream<int> _concatStream(List<int> a, List<int> b) {
  return Stream.fromIterable(a).concatWith([Stream.fromIterable(b)]);
  // return ConcatStream([
  //   Stream.fromIterable(a),
  //   //TimerStream(0, Duration(seconds: 5)),
  //   Stream.fromIterable(b)
  // ]);
}

Stream<int> _zipStream(List<int> a, List<int> b) {
  return Stream.fromIterable(a)
      .zipWith(Stream.fromIterable(b), (int x, int y) => x + y);
}

Stream<int> _scanStream(List<int> a) {
  return Stream.fromIterable(a).scan((acc, curr, i) => acc + curr, 0);
}

// Stream<int> _concatEagerStream(List<int> a, List<int> b) {
//   return ConcatEagerStream([
//     Stream.fromIterable(a),
//     // TimerStream(0, Duration(seconds: 10)),
//     Stream.fromIterable(b)
//   ]);
// }

// Stream<int> _deferStream(List<int> a) {
//   return DeferStream(() => Stream.value(a[3]));
// }
//
// Stream<int> _mergeStream(List<int> a, List<int> b) {
//   return MergeStream([Stream.fromIterable(a), Stream.fromIterable(b)]);
// }
//
// Stream<int> _raceStream(List<int> a, List<int> b) {
//   return RaceStream([Stream.fromIterable(a), Stream.fromIterable(b)]);
// }

// Stream<int> _repeatStream(int n) {
//   return RepeatStream((int n) => Stream.value(n), 3);
// // }
// Stream<bool> _sequenceEqualsStream(List<int> a, List<int> b) {
//   return Rx.sequenceEqual(Stream.fromIterable(a), Stream.fromIterable(b));
// }
//
// Stream _neverStream() {
//   return NeverStream();
// }
//
// Stream _forkJoinStream(List<int> a, List<int> b) {
//   return ForkJoinStream.list<int>(
//       [Stream.fromIterable(a), Stream.fromIterable(b)]);
// }
//
// Stream _bufferStream() {
//   print('Programming using buffer');
//
//   return Stream.periodic(Duration(seconds: 1), (a) => a + 1)
//       .buffer(Stream.periodic(Duration(seconds: 2), (a) => a + 1));
// }
//
// Stream _bufferCount() {
//   return RangeStream(1, 10).bufferCount(3);
// }
Stream _filterStream(List<int> a) {
  return Stream.fromIterable(a).where((event) => event % 2 == 0);
}

Stream _reduceStream(List<int> a) {
  return Stream.fromIterable(a)
      .reduce((previous, element) => previous + element)
      .asStream();
}

Stream _debounceStream(List<int> a) {
  return Stream.fromIterable(a)
      .debounce((_) => TimerStream(true, Duration(seconds: 1)));
}

Stream _distinctStream(List<int> a) {
  return Stream.fromIterable(a).distinct();
}

Stream _takeUntilStream(List<int> a, List<int> b) {
  return Stream.fromIterable(a).takeUntil(TimerStream(
    Stream.fromIterable(b),
    Duration(microseconds: 50),
  ));
}

Stream _defaultEmpty() {
  return Stream.empty().defaultIfEmpty(10);
}

Stream _concatMapStream(List<int> a) {
  return Stream.fromIterable(a).asyncExpand((event) =>
      Stream.fromIterable([event, event + 1]).map((events) => events * 2));
}

Stream _distintUntilChanged(List<int> a) {
  return Stream.fromIterable(a).scan(
      (accumulated, value, index) => accumulated != value ? value : null, 0);
}
