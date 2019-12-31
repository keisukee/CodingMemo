# ステータスコード一覧

300番台
300	Multiple Choices	複数ページの利用が可能です。
301	Moved Parmanently	このアドレスは違うアドレスに移動しました。
302	Moved Temporarily	このアドレスは一時的に別のアドレスにおいています。
303	See Other	他のページを参照してください。
304	Not Modified	アクセスは許可されたが、対象の文書は更新されていなかった。
305	Use Proxy	LocationフィールドのProxy経由でないとアクセス許可されません。
307	Temporary Redirect	このアドレスは一時的に別のアドレスに属しています。
400番台
400	Bad Request	タイプミス等、リクエストにエラーがあります。
401	Unauthorixed	認証に失敗しました。（パスワードを適当に入れてみた時などに発生）
402	Payment Required	（将来の使用のための予約コード）
403	Forbidden	あなたにはアクセス権がありません。
404	(File)Not Found	該当アドレスのページはありません、またはそのサーバーが落ちている。
405	Method Not Allowed	許可されていないメソッドタイプのリクエストを受けた。
406	Not Acceptable	Acceptヘッダから判断された結果、受け入れられない内容を持っていた。
407	Proxy Authentication Required	最初にProxy認証が必要です。
408	Request Time-out	リクエストの待ち時間内に反応がなかった。
409	Conflict	そのリクエストは現在の状態のリソースと矛盾するため完了できなかった。
410	Gone	そのリクエストはサーバでは利用できず転送先のアドレスも分からない。
411	Length Required	定義されたContent-Lengthの無いリクエストを拒否しました。
412	Precondition Failed	1つ以上のリクエストヘッダフィールドで与えられた条件がサーバ上のテストで不正であると判断しました。
413	Request Entity Too Large	処理可能量より大きいリクエストのため拒否しました。
414	Request-URI Too Large	リクエストURIが長すぎるため拒否しました。
415	Unsupported Media Type	リクエストされたメソッドに対してリクエストされたリソースがサポートしていないフォーマットであるため、サーバはリクエストのサービスを拒否しました。
416	Requested range not satisfiable	リクエストにRangeヘッダフィールドは含まれていたが、If-Rangeリクエストヘッダフィールドがありません。
417	Expectation Failed	Expectリクエストヘッダフィールド拡張が受け入れられなかった。
500番台
500	Internal Server Error	CGIスクリプトなどでエラーが出た。
501	Not Implemented	リクエストを実行するための必要な機能をサポートしていない。
502	Bad Gateway	ゲートウェイやProxyとして動作しているサーバがリクエストを実行しようとしたら不正なレスポンスを受け取った。
503	Service Unavailable	そのアドレスは事情によりアクセスできません。
　	Mapping Server Error	クリッカブルマップで、変なアドレスを指定した。
　	Too many users	この時間このページにアクセスできる定員オーバーをしました。
　	Method Not Allowed	CGIで送信時にPOSTかGETの一方しかできないのに、違う方を行った。
504	Gateway Time-out	リクエストを完了するために必要なDNSなどのサーバからレスポンスを受信できなかった。
505	HTTP Version not supported	サポートされていないHTTPプロトコルバージョンを受けた。