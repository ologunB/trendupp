///
//  Generated code. Do not modify.
//  source: fonts.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const FileSpec$json =   {
  '1': 'FileSpec',
  '2':   [
      {'1': 'filename', '3': 1, '4': 1, '5': 9, '10': 'filename'},
      {'1': 'file_size', '3': 2, '4': 1, '5': 3, '10': 'fileSize'},
      {'1': 'hash', '3': 3, '4': 1, '5': 12, '10': 'hash'},
  ],
};

const IntRange$json =   {
  '1': 'IntRange',
  '2':   [
      {'1': 'start', '3': 1, '4': 1, '5': 5, '10': 'start'},
      {'1': 'end', '3': 2, '4': 1, '5': 5, '7': '0', '10': 'end'},
  ],
};

const FloatRange$json =   {
  '1': 'FloatRange',
  '2':   [
      {'1': 'start', '3': 1, '4': 1, '5': 2, '10': 'start'},
      {'1': 'end', '3': 2, '4': 1, '5': 2, '7': '0', '10': 'end'},
  ],
};

const Font$json =   {
  '1': 'Font',
  '2':   [
      {
      '1': 'file',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.fonts.FileSpec',
      '10': 'file'
    },
      {
      '1': 'weight',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.fonts.IntRange',
      '10': 'weight'
    },
      {
      '1': 'width',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.fonts.FloatRange',
      '10': 'width'
    },
      {
      '1': 'italic',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.fonts.FloatRange',
      '10': 'italic'
    },
      {'1': 'ttc_index', '3': 7, '4': 1, '5': 5, '10': 'ttcIndex'},
  ],
  '9':   [
      {'1': 5, '2': 6},
      {'1': 6, '2': 7},
  ],
};

const FontFamily$json =   {
  '1': 'FontFamily',
  '2':   [
      {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
      {'1': 'version', '3': 2, '4': 1, '5': 5, '10': 'version'},
      {
      '1': 'fonts',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.fonts.Font',
      '10': 'fonts'
    },
  ],
};

const Directory$json =   {
  '1': 'Directory',
  '2':   [
      {
      '1': 'family',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.fonts.FontFamily',
      '10': 'family'
    },
      {'1': 'name_lookup', '3': 2, '4': 3, '5': 5, '10': 'nameLookup'},
      {'1': 'strings', '3': 3, '4': 3, '5': 9, '10': 'strings'},
      {'1': 'prefetch', '3': 4, '4': 3, '5': 5, '10': 'prefetch'},
      {'1': 'version', '3': 5, '4': 1, '5': 5, '10': 'version'},
      {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
  ],
};
