import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final localeProvider = StateProvider<Locale>((ref) => Locale.fromSubtags(languageCode: 'en', countryCode: 'US'));