本番サーバーにSQLを投げてcsvとして出力する（自分用）

* Usage: 

	** player_shardのSQLを実行する場合
		sh Tools/getdata_for_shards.sh "path/to/sql" # ./SQL直下のパスを指定

		水平分割それぞれのDBに同じSQLを実行する。

	** defaultデータベースのSQLを実行する場合（Gamelogやguild関連）
		sh Tools/getdata_for_default.sh "path/to/sql" # ./SQL直下のパスを指定

		実行するSQLはDBを指定する
		ex) select * from rise_guild.guild_guildbattleresultenteredmembers;

* 指定するSQLのパスについて

	** ./SQLの直下のパスを指定する
		現在は"./SQL"直下しか指定できない
		今後は修正するかも(2014/06/17

	** 指定はディレクトリか.sqlファイル
		ディレクトリを指定した場合はそのディレクトリ直下の".sql"ファイルを全て
		実行する
		ファイルを指定した場合はそのファイルのみを実行する(拡張子は省く)

* 出力先

	SQLの実行結果は"./Result"の下に出力される。
	"./Result"より下のディレクトリ構造は指定したSQLのパスの"./SQL"より下の構造
	と同様になる

* 不足機能

	- SQLに「*」を含めると不具合があるかもしれない
	- SQLに「'」を含めると具具合があるかもしれない
	- 指定できるディレクトリを調整する

* 備考

　- djangoに独自のコマンドを追加してSQLを実行しているのでそのコマンドが無いと動かせられない
　- 運用時、SQLそのものはsubmoduleとして入れる