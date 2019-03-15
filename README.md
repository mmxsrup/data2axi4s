# data2axi4s
Convert data signal to axi4-stream signal

## Description
入力から与えられるデータを AXI4-Stream プロトコルに変換してデータを送信する.
ただし, 入力から与えられるデータは常に来ているという状況を考え, 出力も常に出すことにしている. だから, `tready` 信号は使っていない.

## Usage
`data2axi4s.sv` を使いたいプロジェクトに RTLモジュールとして入れる.