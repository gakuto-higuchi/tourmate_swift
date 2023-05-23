# 開発段階のため、主にdevelopブランチで開発しています。
# 最初はflutterで開発していたのですが、多くの企業がswiftを使われているので、慣れもかねて開発言語をswiftに変更しました。
# こちらは私と昨今の話題のGPT4の共同開発プロジェクトです(実質個人開発)

---
GPT4にプロンプトを投げ、返答を元に私が開発するという手法でプロジェクトに取り組んでいます。

## アプリケーションのアイデア

---
アイデア: 地図上でユーザが作成した観光計画やアクティビティを共有できるアプリ。ユーザは自分の興味に応じてカスタマイズ可能な観光プランを検索し、他のユーザと意見交換ができる。map上から視覚的に観光地を調べるとこができるため、簡単に周辺の観光地を探すとこができる。

## 目的・目標

---

+ ユーザが簡単に観光プランやアクティビティを検索・カスタマイズできることで、旅行計画のストレスを軽減する。
+ コミュニティ機能を通じて、ユーザ間で観光情報や楽しみを共有し、旅行お満足度を向上させる。
+ ユーザが自分の観光経験やおすすめスポットを投稿することで、地域の観光業に貢献し、穴場スポットの発掘を促す。地域経済の活性化につながる。

## 市場調査

---

### APP Store内にある観光アプリの調査

+ 観光アプリは複数あるものの、基本的には既存の観光ガイドブックのような機能を持つものが多い。観光プランもあるが、旅のしおりを友人と共有する程度で、他のユーザ(不特定多数)とのコミュニケーションは取ることはできない。
+ 自分だけの旅行プラン・旅のしおりを作成できるアプリはある。旅行者同士に限定される。
+ 観光地の情報を提供しているアプリは複数あるが、観光プランを提供しているアプリはない。
+ 私が開発したいアプリに一番近い既存のアプリは"RECOTRIP"
  + ユーザが観光情報を発信し、いいねやコメントを受け取ることができる。
  + また、埋め込みではあるものの、位置情報も提供されている
  + フォロー機能もある、新着、イベント掲載、お得なクーポンも提供(じゃらん。ANAなど)

+ RECOTRIP
  + 株式会社islab
  + お気に入りのスポットはリストに保存して旅行計画に役立てることができる
  + 写真・口コミをみんなにシェア
  + 記録はマイページやマップ上に保存
  + ランキングあり
  + セール情報・キャンペーン開催・プレゼントが当たる
  + 海外旅行も対応

+ Instagram
  + 周辺地からinstagrmをやっているお店を表示
  + 検索して観光地をピックアップできる
  + ユーザ同士のコミュニケーションはできない
  + 店自身があげているだけあって、魅力的な写真が多い
  + 現在地から目的地までの距離を提示
  + 4段階評価で値段帯もわかる
  + レビューはない
  + あくまで観光地の提供で、観光プランは提供していない

appstoreのレビューが最近更新されていないため、あまり動いていない印象
まだ完全に調べきれてはないが、年齢層が高い印象

### 既存のアプリの問題点

+ BtoCで成り立っており、ユーザ同士のコミュニケーションが取れない
+ 旅行プランを作成する機能はあるが、不特定多数のユーザに旅行プランを共有する機能がない
+ 旅行プランが非常に多く、日帰りや休日に少し遊びに行く程度の観光プランが少ない
+ 既存のアプリ"RECOTRIP"は、whooやzenlyのようなmapが常には表示されていないため、一目で自分(または検索地点)からの周辺の観光地・店が分かりずらい
+ 年齢層が高く、ユーザが少ない

### これらのアプリと差別化するためには

+ 既存のアプリの評価の高い機能を取り入れた上で、コミュニティ機能の充実
+ ターゲットを人口の多い20代前半に絞る
+ ただのmap機能としても使用してもらう
+ 共有することでインセンティブを与える
+ ユーザが操作しやすく、シンプルなUI
+ ただ旅行プランを提供するのではなく、日帰り・ちょっとした休日の遊びに行行くような観光プランも提供する(軽い観光・遊び/昼に〇〇カフェに行って〇〇総合施設で遊んで帰るみたいな)

## ターゲット層

---

### 初期リリースは主に若い世代の旅行好き(20代)をターゲットを絞る

この層はスマートフォンやアプリの利用が一般的であり、新しいアプリやサービスを積極的に試す傾向にある。またSNSや口コミで情報を広げやすいため、アプリの認知度向上につながる

## マネタイズ方法

---

### 広告とアフィリエイトマーケティング・SNS

リリース初期段階では、広告とアフィリエイトマーケティングの2つに絞る。
これらの方法は、初期投資が比較的低く、アプリの成長に合わせて収益が拡大しやすいため。
ユーザーベースが十分に拡大した後、プレミアム会員制度や地元企業とのコラボレーションなど、他のマネタイズ方法を段階的に導入する。

## マーケティング戦略 (初期リリース時)

---

### ソーシャルメディア活用

ターゲット層が頻繁に利用するinstagramやtwitter・tiktokなどのソーシャルメディアで、アプリの魅力を伝える投稿をおこなう。口コミによる拡散効果を狙う。

### アプリストア最適化(ASO)

アプリストアでの検索結果で上位に表示されるように、適切なキーワードやアイコン、スクリーンショット、説明文を用意し、アプリストア最適化 (ASO)を行う。

### 友達招待制度

ユーザがアプリを友達に紹介するインセンティブを提供することで、新規ユーザの獲得を促進する。
