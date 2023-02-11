project(
  'dict-cedict',
  license: 'CC-BY-SA-4.0',
  version: 'build',
)

PKG = 'cedict'
URL = 'https://www.mdbg.net/chinese'
TXT = 'cedict_1_0_ts_utf-8_mdbg.txt'

tmp = custom_target('tmp',
    output: TXT,
    command: [find_program('cli/get-@0@.sh'.format(PKG))],
    env: [
      'URL=@0@/export/cedict'.format(URL),
      'PKG=@0@'.format(PKG),
      'TXT=@0@'.format(TXT),
      ]
  )

txt = custom_target('txt',
    output: PKG + '.txt',
    depends: [tmp],
    command: [
      find_program('cli/gen-@0@.py'.format(PKG)),
      get_option('mini') ? '--mini' : '--no-mini',
      '-i',
      TXT,
      '-o',
      PKG + '.txt'
      ]
  )

custom_target('dict', 
    output: [PKG + '.index', PKG + '.dict.dz'],
    depends: [txt],
    command: [
	  find_program('cli/fmt-dict.sh'),
      '--utf8',
      '--allchars',
      '-s',
      PKG.to_upper(),
      '-j'
      ],
    env: ['PKG=@0@'.format(PKG)],
    install: true,
    install_dir: get_option('datadir') / 'dictd'
  )
