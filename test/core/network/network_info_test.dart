import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockNetworkInfoImpl mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfoImpl();
  });

  group('device connected', () {
    test(
      'shoult get if device is connected',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        final result = await mockNetworkInfo.isConnected;

        // assert
        verify(mockNetworkInfo.isConnected);
        expect(result, true);
      },
    );

    test(
      'shoult get if device is not connected',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // act
        final result = await mockNetworkInfo.isConnected;

        // assert
        verify(mockNetworkInfo.isConnected);
        expect(result, false);
      },
    );
  });

  group('device online', () {
    test(
      'shoult get if device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isOnLine).thenAnswer((_) async => true);

        // act
        final result = await mockNetworkInfo.isOnLine;

        // assert
        verify(mockNetworkInfo.isOnLine);
        expect(result, true);
      },
    );

    test(
      'shoult get if device is not online',
      () async {
        // arrange
        when(mockNetworkInfo.isOnLine).thenAnswer((_) async => false);

        // act
        final result = await mockNetworkInfo.isOnLine;

        // assert
        verify(mockNetworkInfo.isOnLine);
        expect(result, false);
      },
    );
  });
}
