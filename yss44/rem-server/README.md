##Rem Server

はてぶのブックマークのランダム取得用APIサーバー

##Install

git clone git@github.com:yss44/rem-server.git
cd rem-server
bundle install

##How to Run Server

    rackup

##API

###GET /user/:hatebu_username

Request:

  curl localhost/user/yss44

Response:

  {
    status: 200,
    version: 1,
    username: "yss44",
    bookmarks: [
      {
        title: "Flashはオワコンじゃなかった！Flash＋AIRを使ったAndroidゲーム開発のポイント91   users",
        url: "http://android.dtmm.co.jp/development/25041",
        summery: " Andoroidアプリを開発するというと、初心者に対してもJAVAを勧める人は多いです。 デスクトップPCでは広く使われている「Flash」に人気がないのは、現状のAndroidのブラウザ上で十分な性能を発揮できないからだと思われます。 しかし「Flash（ActionScript 3.0... 続きを読む "
      },
      {
        title: "PHPMatsuri2013で発表した資料を公開しました「ソーシャルゲーム案件におけるDB分割のPHP実装～とにかく分割ですよ。10回じゃ足りない。20回くらい分割。～」 | 株式会社インフィニットループ133 users",
        url: "http://www.infiniteloop.co.jp/blog/2013/07/phpmatsuri-db-partition/",
        summery: " 記事を書くのは初めてになります。sasakiです。 2013年7月14日から15日にかけて、PHP Matsuri 2013が開催されました。 今回は北海道開催という事で弊社もスポンサーとなり、社員の何名かはスタッフとして開催に協力しました。 また、スポンサー枠でセッション時... 続きを読む "
      },
      {
       title: "HTML5でサイトを高速化─wri.peで学ぶ、イマドキのWebアプリの作りかた（後編） | HTML5Experts.jp101 users",
       url: "http://html5experts.jp/masuidrive/wripe-2/",
       summery: " 前回の記事では、 wri.peの紹介と、HTML5のApplication Cacheを使ったHTMLや画像などの読み込み高速化の話しをしました。今回は、Web StorageのlocalStorage/sessionStorageを使い、Ajax通信部分と表示の高速化を行う手法を説明しましょう。 localStorageを用い... 続きを読む "
      }
    ]
  }
