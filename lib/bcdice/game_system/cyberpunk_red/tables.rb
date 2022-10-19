# frozen_string_literal: true

module BCDice
  module GameSystem
    class CyberpunkRed < Base
      NIGHT_MARKET_FOODS_TABLE = DiceTable::RangeTable.new(
        "食品とドラッグ",
        "1D100",
        [
          [1..5, "缶詰　100ed(安物)"],
          [6..10, "パック入り食品　10ed(安物)"],
          [11..15, "冷凍食品　10ed(安物)"],
          [16..20, "穀物の袋　20ed(日用)"],
          [21..25, "キブルのパック　10ed(安物)"],
          [26..30, "プレパックの袋　20ed(日用)"],
          [31..35, "ストリート・ドラッグ　20ed以下"],
          [36..40, "低品質の酒　10ed(安物)"],
          [41..45, "酒　20ed(日用)"],
          [46..50, "高品質の酒　100ed(上等)"],
          [51..55, "MRE　10ed(安物)"],
          [56..60, "生きた鶏　50ed(程々)"],
          [61..65, "生きた魚　50ed(程々)"],
          [66..70, "生の果物　50ed(程々)"],
          [71..75, "生野菜　50ed(程々)"],
          [76..80, "根菜類　20ed(日用)"],
          [81..85, "生きた豚　100ed(上等)"],
          [86..90, "珍しい果物　100ed(上等)"],
          [91..95, "珍しい野菜　100ed(上等)"],
          [96..99, "ストリート・ドラッグ　50edちょうど"],
          [100, "缶詰　100ed(安物) or ストリート・ドラッグ　50edちょうど"]
        ]
      ).freeze

      NIGHT_MARKET_MECHANIC_TABLE = DiceTable::RangeTable.new(
        "個人用電子機器",
        "1D100",
        [
          [1..5, "エージェント　100ed(上等)"],
          [6..10, "プログラムおよびハードウェア　100ed以下"],
          [11..15, "オーディオ・レコーダー　100ed(上等)"],
          [16..20, "盗聴器検出器　500ed(高級)"],
          [21..25, "化学物質分析器　1,000ed(超高級)"],
          [26..30, "コンピュータ　50ed(程々)"],
          [31..35, "サイバーデッキ　500ed(高級)"],
          [36..40, "使い捨て携帯電話　50ed(程々)"],
          [41..45, "エレキギターその他の楽器　500ed(高級)"],
          [46..50, "プログラムおよびハードウェア　500edちょうど"],
          [51..55, "メドスキャナー　1,000ed(超高級)"],
          [56..60, "追跡装置　500ed(高級)"],
          [61..65, "無線通信機　100ed(上等)"],
          [66..70, "テクスキャナー　1,000ed(超高級)"],
          [71..75, "スマート・グラス　500ed(高級)"],
          [76..80, "レーダー探知機　500ed(高級)"],
          [81..85, "スクランブラー／ディスクランブラー　500ed(高級)"],
          [86..90, "通信スキャナー／音楽プレイヤー　50ed(程々)"],
          [91..95, "ブレインダンス・ビューア　1,000ed(超高級)"],
          [96..99, "ヴァーチャリティ・ゴーグル　100ed(上等)"],
          [100, "エージェント　100ed(上等) or ヴァーチャリティ・ゴーグル　100ed(上等)"]
        ]
      ).freeze

      NIGHT_MARKET_WEAPONS_TABLE = DiceTable::RangeTable.new(
        "武器と防具",
        "1D100",
        [
          [1..5, "中型拳銃　50ed(程々)"],
          [6..10, "大型拳銃および超大型拳銃　100ed(上等)"],
          [11..15, "SMG　100ed(上等)"],
          [16..20, "大型SMG　100ed(上等)"],
          [21..25, "ショットガン　500ed(高級)"],
          [26..30, "アサルト・ライフル　500ed(高級)"],
          [31..35, "スナイパー・ライフル　500ed(高級)"],
          [36..40, "弓およびクロスボウ　100ed(上等)"],
          [41..45, "グレネード・ランチャーおよびロケット・ランチャー　500ed(高級)"],
          [46..50, "弾薬　500ed以下"],
          [51..55, "GMが選んだ特殊武器1個"],
          [56..60, "小型近接武器　50ed(程々)"],
          [61..65, "中型近接武器　50ed(程々)"],
          [66..70, "大型近接武器　100ed(上等)"],
          [71..75, "超大型近接武器　100ed(上等)"],
          [76..80, "防具　100ed以下"],
          [81..85, "防具　500edちょうど"],
          [86..90, "防具　1,000edちょうど"],
          [91..95, "武器用アタッチメント　100ed以下"],
          [96..99, "武器用アタッチメント　500ed以上"],
          [100, "中型拳銃　50ed(程々) or 武器用アタッチメント　500ed以上"]
        ]
      ).freeze

      NIGHT_MARKET_CYBERWARE_TABLE = DiceTable::RangeTable.new(
        "サイバーウェア",
        "1D100",
        [
          [1..5, "サイバーアイ　100ed(上等)"],
          [6..10, "サイバー聴覚基本システム　500ed(高級)"],
          [11..15, "ニューラル・リンク　500ed(高級)"],
          [16..20, "サイバーアーム　500ed(高級)"],
          [21..25, "サイバーレッグ　100ed(上等)"],
          [26..30, "体表用サイバーウェア　1,000edちょうど"],
          [31..35, "体表用サイバーウェア　500ed以下"],
          [36..40, "体内用サイバーウェア　1,000edちょうど"],
          [41..45, "体内用サイバーウェア　500ed以下"],
          [46..50, "サイバーアイのオプション　1,000edちょうど"],
          [51..55, "サイバーアイのオプション　500ed以下"],
          [56..60, "サイバー聴覚のオプション　1,000edちょうど"],
          [61..65, "サイバー聴覚のオプション　500ed以下"],
          [66..70, "ニューラルウェアのオプション　1,000edちょうど"],
          [71..75, "ニューラルウェアのオプション　500ed以下"],
          [76..80, "サイバー四肢のオプション　1,000edちょうど"],
          [81..85, "サイバー四肢のオプション　500ed以下"],
          [86..90, "GMが選んだファッションウェア"],
          [91..95, "GMが選んだボーグウェア"],
          [96..99, "GMが選んだ任意のサイバーウェア"],
          [100, "サイバーアイ　100ed(上等) or GMが選んだ任意のサイバーウェア"]
        ]
      ).freeze

      NIGHT_MARKET_FASHION_TABLE = DiceTable::RangeTable.new(
        "衣料品とファッションウェア",
        "1D100",
        [
          [1..5, "バッグ・レディ・シック"],
          [6..10, "ギャング・カラー"],
          [11..15, "ジェネリック・シック"],
          [16..20, "ボヘミアン"],
          [21..25, "レジャーウェア"],
          [26..30, "ノーマッド・レザー"],
          [31..35, "アジア・ポップ"],
          [36..40, "アーバン・フラッシュ"],
          [41..45, "ビジネスウェア"],
          [46..50, "ハイ・ファッション"],
          [51..55, "バイオモニタ　100ed(上等)"],
          [56..60, "ケムスキン　100ed(上等)"],
          [61..65, "EMPスレッディング　10ed(安物)"],
          [66..70, "ライト・タトゥー　100ed(上等)"],
          [71..75, "シフトタクト　100ed(上等)"],
          [76..80, "スキンウォッチ　100ed(上等)"],
          [81..85, "テックヘア　100ed(上等)"],
          [86..90, "ジェネリック・シック"],
          [91..95, "レジャーウェア"],
          [96..99, "ギャング・カラー"],
          [100, "バッグ・レディ・シック or ギャング・カラー"]
        ]
      ).freeze

      NIGHT_MARKET_SUVIVAL_TABLE = DiceTable::RangeTable.new(
        "サバイバル用品",
        "1D100",
        [
          [1..5, "対スモッグ呼吸マスク　20ed(日用)"],
          [6..10, "自動制音イヤー・プロテクタ　1,000ed(超高級)"],
          [11..15, "双眼鏡　50ed(程々)"],
          [16..20, "旅行バッグ　20ed(日用)"],
          [21..25, "懐中電灯　20ed(日用)"],
          [26..30, "ダクト・テープ　20ed(日用)"],
          [31..35, "携帯用ベッド＆寝袋　20ed(日用)"],
          [36..40, "鍵開けセット　20ed(日用)"],
          [41..45, "手錠　50ed(程々)"],
          [46..50, "メドテク・バッグ　100ed(上等)"],
          [51..55, "テント＆キャンプ用品　50ed(程々)"],
          [56..60, "ロープ(60m)　20ed(日用)"],
          [61..65, "テクツール　100ed(上等)"],
          [66..70, "パーソナル・ケアパック　20ed(日用)"],
          [71..75, "放射線防護服　1,000ed(超高級)"],
          [76..80, "発煙筒　10ed(安物)"],
          [81..85, "グラップル・ガン　100ed(上等)"],
          [86..90, "テク・バッグ　500ed(高級)"],
          [91..95, "シャベルおよび斧　50ed(程々)"],
          [96..99, "エアハイポ　50ed(程々)"],
          [100, "対スモッグ呼吸マスク　20ed(日用) or エアハイポ　50ed(程々)"]
        ]
      ).freeze

      SCREAM_SHEET_TYPE_TABLE = DiceTable::Table.new(
        "スクリームシート分類",
        "1D6",
        [
          "国際",
          "全国",
          "州",
          "地方",
          "経済",
          "ゴシップ"
        ]
      ).freeze

      SCREAM_SHEET_A_TABLE = DiceTable::Table.new(
        "ヘッドラインA",
        "1D10",
        [
          "(企業を1つ選ぶ)",
          "上院議員／議員",
          "大統領／会長／社長",
          "企業／企業群",
          "市議会",
          "サイバーサイコ",
          "殺し屋／殺人鬼",
          "退治人／暴漢",
          "悲劇的な／不運な",
          "捜査員／研究員"
        ]
      ).freeze

      SCREAM_SHEET_B_TABLE = DiceTable::Table.new(
        "ヘッドラインB",
        "1D10",
        [
          "協力を",
          "シティを",
          "妥協を／譲歩を",
          "警告を",
          "計画を",
          "スキャンダルを",
          "女性を",
          "男性を",
          "事故を",
          "希望を"
        ]
      ).freeze

      SCREAM_SHEET_C_TABLE = DiceTable::Table.new(
        "ヘッドラインC",
        "1D10",
        [
          "提案／提供",
          "脅かす／危機",
          "妥協／譲歩",
          "殺害／破綻／破棄",
          "殺害される／中止／中断",
          "死亡／終了／途絶える",
          "賞賛／表彰／好評",
          "表明／発表",
          "判明／暴露／発覚",
          "継続"
        ]
      ).freeze

      SCREAM_SHEET_OF_TABLE = DiceTable::Table.new(
        "ヘッドライン助詞",
        "1D6",
        [
          "を",
          "が",
          "に対し",
          "とともに",
          "より",
          "へ向けて"
        ]
      ).freeze

      class ScreamSheetRandomizerTable
        def roll(randomizer)
          result = ""

          dice = randomizer.roll_once(6)
          scs_type = SCREAM_SHEET_TYPE_TABLE.choice(dice)
          result += "#{scs_type}ニュース　『"

          dice = randomizer.roll_once(10)
          scs_val_a = SCREAM_SHEET_A_TABLE.choice(dice).body
          result += scs_val_a

          dice = randomizer.roll_once(6)
          scs_val_of = SCREAM_SHEET_OF_TABLE.choice(dice).body
          result += scs_val_of

          dice = randomizer.roll_once(10)
          scs_val_a = SCREAM_SHEET_A_TABLE.choice(dice).body
          result += scs_val_a

          dice = randomizer.roll_once(6)
          scs_val_of = SCREAM_SHEET_OF_TABLE.choice(dice).body
          result += scs_val_of

          dice = randomizer.roll_once(10)
          scs_val_b = SCREAM_SHEET_B_TABLE.choice(dice).body
          result += scs_val_b

          dice = randomizer.roll_once(10)
          scs_val_c = SCREAM_SHEET_C_TABLE.choice(dice).body
          result += scs_val_c

          result += "』"

          return result
        end
      end

      SCREAM_SHEET_RANDOM_TABLE = ScreamSheetRandomizerTable.new().freeze

      VENDING_MACHINE_TYPE_TABLE = DiceTable::RangeTable.new(
        "最寄りの自販機のタイプ",
        "1D6",
        [
          [1..3, "食品"],
          [4..5, "ファッション"],
          [6, "変なもの"]
        ]
      ).freeze

      VENDING_MACHINE_FOOD_TABLE = DiceTable::Table.new(
        "食品",
        "1D10",
        [
          "ラーメン",
          "ピザ",
          "ハンバーガー",
          "スマッシュ",
          "スシ",
          "暖かい肉料理",
          "キブルの1kgパック",
          "缶コーヒー",
          "缶ジュース",
          "缶入りの清涼飲料水"
        ]
      ).freeze

      VENDING_MACHINE_FASHION_TABLE = DiceTable::Table.new(
        "ファッション",
        "1D10",
        [
          "缶に入ったTシャツ",
          "性的玩具",
          "傘",
          "ネクタイ",
          "外科手術用マスク",
          "下着",
          "花束",
          "銃と弾",
          "ブレインダンス・チップ",
          "ビデオゲーム"
        ]
      ).freeze

      VENDING_MACHINE_STRANGE_TABLE = DiceTable::Table.new(
        "変なもの",
        "1D10",
        [
          "ペット用のカツラ",
          "バグ・スナック(昆虫料理)",
          "レタス1玉",
          "トビウオがまるごと入ったスープ",
          "人工培養シーフード",
          "匂いの缶詰",
          "生きたカブトムシ",
          "紙製のコスプレ衣装",
          "奇妙なカプセル・トイ",
          "使用済みのパンティ"
        ]
      ).freeze

      SHOP_STAFF_TABLE = DiceTable::Table.new(
        "店主またはレジ係",
        "1D6",
        [
          "母性的な老婆。客を自分の子供のように扱い、世話を焼いたり小言を言う。",
          "怒りっぽい年寄り。皆が嫌いで、特におまえのことが大嫌いだ。",
          "退屈しきったヨーギャンガー。両親の手でレジに繋がれている。",
          "異様になれなれしく、おまえに付きまとい続ける鬱陶しいやつ。",
          "露骨な薬物常用者。おまえにひらひら手を振って「もうどうにでもしてくれ……」と言う。",
          "理解不能な中年。何かつけておまえに文句を言おうとする。"
        ]
      ).freeze

      SHOP_PEOPLE_A_TABLE = DiceTable::Table.new(
        "変わった客その1",
        "1D6",
        [
          "ぶつぶつ独り言を言い続ける客。急に立ち止まっておまえをじろじろ見る。",
          "騒ぎ立てる迷惑な酔っぱらい。",
          "薬物に酔った客。彼にしか見えない何かを殴ろうと拳を振り回している。",
          "金欠のジョイガール／ボーイ（娼婦／男娼）。「お願いを聞いてあげるから、スマッシュをおごってくれない？」と持ちかけてくる。",
          "非番のローマン。すぐに食べられるものを探しており、おしゃべりをしたい雰囲気ではない。",
          "ストリートで襲われる不安に駆られた客。誰かに近寄られると身構える(銃を抜くかもしれない)。"
        ]
      ).freeze

      SHOP_PEOPLE_B_TABLE = DiceTable::Table.new(
        "変わった客その2",
        "1D6",
        [
          "この店に強盗に入る下見中のヨーギャンガー。強盗になる覚悟はまだ固まっていないようだ。",
          "1d6ターン後にこの店を襲う予定のギャンガー。",
          "店主を痛めつけて”みかじめ料”を取り立てようとする三流のギャンガー。",
          "かわいらしい四歳の迷子。”ママ”を探して偶然この店に入り込んだ。",
          "口論しながら入店したカップル。声はどんどんやかましくなる。",
          "場違いに高そうな服を着た金持ちのカップル。上流社会のパーティーからの帰り道に、酒を買おうとしてたまたまこの店に立ち寄った。"
        ]
      ).freeze

      class ShopPeopleTable
        def roll(randomizer)
          result = "おまえが立ち寄ったボデガには――"

          dice = randomizer.roll_once(6)
          staff = SHOP_STAFF_TABLE.choice(dice).body
          staff = staff[0..-2]
          result += staff
          result += "――といった店員と、"

          dice = randomizer.roll_once(6)
          people = SHOP_PEOPLE_A_TABLE.choice(dice).body
          people = people[0..-2]
          result += people
          result += "――という印象の客と、"

          dice = randomizer.roll_once(6)
          people = SHOP_PEOPLE_B_TABLE.choice(dice).body
          people = people[0..-2]
          result += people
          result += "――という感じの客がいるようだ。"
          result += "どうにも、嫌な予感がする。"

          return result
        end
      end

      SHOP_PEOPLE_TABLE = ShopPeopleTable.new().freeze

      TABLES = {
        "FFD" => DiceTable::Table.new(
          "身体への致命的損傷",
          "2D6",
          [
            "片腕喪失 ＞ 1本の腕が完全に失われる。おまえはその腕の手に持っていたアイテムを即座に落とす。死亡セーヴ修正値の基本値が1増える。",
            "片手喪失 ＞ 1本の手が完全に失われる。おまえはその手に持っていたアイテムを即座に落とす。死亡セーヴ修正値の基本値が1増える。",
            "肺損傷 ＞ 【移動】に-2(最低1)。死亡セーヴ修正値の基本値が1増える。",
            "肋骨損傷 ＞ おまえは1ターンに徒歩で4m(2マス)より多く移動するたび、そのターン終了時に、この致命的損傷によるボーナス・ダメージ5点を直接HPに受ける。",
            "片腕損傷 ＞ 損傷した腕は使い物にならない。おまえはその腕の手に持っていたアイテムを即座に落とす。",
            "外傷異物 ＞ 1ターンに徒歩で4m(2マス)より多く移動するたび、そのターン終了時に、この致命的損傷によるボーナス・ダメージ5点を直接HPに受ける。",
            "片脚損傷 ＞ 【移動】に-4(最低1)。",
            "筋肉断裂 ＞ 近接攻撃に-2。",
            "脊椎損傷 ＞ おまえは次のターンにアクションを行えないが、移動アクションは行える。死亡セーヴ修正値の基本値が1増える。",
            "指損傷 ＞ その手に関係したあらゆるアクションに-4。",
            "片脚喪失 ＞ 1本の脚が完全に失われる。【移動】に-6(最低1)。死亡セーヴ修正値の基本値が1増える。"
          ]
        ),
        "HFD" => DiceTable::Table.new(
          "頭部への致命的損傷",
          "2D6",
          [
            "片目喪失 ＞ 1個の目が完全に失われる。遠隔攻撃と視覚に関する〈知覚〉判定に-2。死亡セーヴ修正値の基本値が1増える。",
            "脳損傷 ＞ あらゆるアクションに-2。死亡セーヴ修正値の基本値が1増える。",
            "片目損傷 ＞ 遠隔攻撃と視覚に関する〈知覚〉判定に-2。",
            "脳震盪 ＞ あらゆるアクションに-2。",
            "顎部損傷 ＞ 声を発することに関連したあらゆるアクションに-2。",
            "外傷異物 ＞ 1ターンに徒歩で4m(2マス)より多く移動するたび、そのターン終了時に、この致命的損傷によるボーナス・ダメージ5点を直接HPに受ける。",
            "頚椎損傷 ＞ 死亡セーヴ修正値の基本値が1増える。",
            "頭蓋損傷 ＞ おまえの頭部に対する狙い撃ちは、SPを貫通した後のダメージが2倍ではなく3倍になる。死亡セーヴ修正値の基本値が1増える。",
            "片耳損傷 ＞ 1ターンに徒歩で4m(2マス)より多く移動すると、その次のターンは移動アクションを行うことができなくなる。聴覚に関する〈知覚〉判定に-2。",
            "気管損傷 ＞ 声を発することができない。死亡セーヴ修正値の基本値が1増える。",
            "片耳喪失 ＞ 1個の耳が完全に失われる。1ターンに徒歩で4m(2マス)より多く移動すると、その次のターンは移動アクションを行うことができなくなる。聴覚に関する〈知覚〉判定に-4。死亡セーヴ修正値の基本値が1増える。"
          ]
        ),
        "NCDT" => DiceTable::RangeTable.new(
          "ナイトシティにおける日中の遭遇",
          "1D100",
          [
            [1..5, "地元の警官 ＞ PCグループの半分の人数の巡回警官。P.417参照。"],
            [6..11, "企業の警備員 ＞ この地区をパトロールしている、企業の下級警備員。PCグループと同じ人数。P.417参照。"],
            [12..13, "テク ＞ PCグループの半分の人数のテク(技術者)。P.417参照。"],
            [14..17, "私立探偵 ＞ 1人の私立探偵。P.417参照。"],
            [18..20, "企業の社員 ＞ 現地企業の社員がタクシーを探している。人数はPCと同数。P.417参照。"],
            [21..27, "地元民 ＞ この辺りに住む2人の若者。P.418参照。"],
            [28..32, "リクレイマー ＞ PCは十分に装備の整ったリクレイマーの一団と出くわす。人数は団員が［PCグループの人数-2］人と、リーダーが1人だ。P.418参照。"],
            [33..37, "メディア ＞ カメラとインタビュアーの2人組のメディア。特ダネを求めて1軒の建物に張り込みしている。P.418参照。"],
            [38..41, "私立探偵 ＞ 1人の私立探偵。P.418参照。"],
            [42..46, "トラウマ・チーム ＞ AV-4が銃撃戦の真っ只中に強行着陸し、降りて来たメディックたちが、負傷した6人ほどのギャンガーたちに応急処置を施しはじめる。P.418参照。"],
            [47..57, "スカヴァーズ ＞ PCと同人数の貧相で汚らしい浮浪者たちが、焼け落ちた街区近辺にある廃墟またはゴミ箱を漁っている。P.419参照。"],
            [58..63, "ノーマッド ＞ PCと同人数のノーマッドの一団。P.419参照。"],
            [64..70, "ブースターギャング ＞ ピラーニャズというブースターギャングに所属する、低レベルなストリート・パンクたち。人数はPCと同数。P.419参照。"],
            [71..76, "ストリート・パンク ＞ 合成麻薬飲料中毒者どもが、飲み代を稼ごうとカモを探している(人数はPCと同数)。P.419参照。"],
            [77..82, "狂信者 ＞ 終末カルト”レコナーズ”が大挙して押し寄せてくる。P.419参照。"],
            [83..88, "ノーマッドのトラック ＞ 1台の壊れたトラックの周りで、スチール・ヴァロケスのノーマッドたち(人数はPCの半分；最低2人)が、何かしている。P.419参照。"],
            [89..94, "ブースターギャング ＞ アイアン・サイツというギャングのメンバーたち。人数はPCと同じ。P.419参照。"],
            [95..100, "メジャー級の犯罪者 ＞ PCたちは冷酷非情なヴィルシェンコ・シンジケート(ネオソビエトの犯罪組織)の大規模なシノギの現場に足を踏み入れてしまう。P.419参照。"]
          ]
        ),
        "NCMT" => DiceTable::RangeTable.new(
          "ナイトシティにおける深夜の遭遇",
          "1D100",
          [
            [1..10, "市警察 ＞ PCグループの半分の人数の警察官。P.422参照。"],
            [11..22, "企業の警備員 ＞ この地区をパトロールしている、企業の警備員。PCグループと同じ人数。P.422参照。"],
            [23..24, "私立探偵 ＞ 超大型拳銃とマチェーテで武装し、軽装アーマージャックを着用した私立探偵1人。P.422参照。"],
            [25, "メディア ＞ カメラとインタビュアーの2人組のメディア。特ダネを求めて1軒の建物に張り込みしている。P.422参照。"],
            [26..29, "クローマー ＞ 地元のクロマティック・ロック・バンドの筋金入りのファンの一団。P.423参照。"],
            [30..39, "エッジランナー・チーム ＞ 少人数のエッジランナーのチーム。ネットランナー1人、ソロ1人、ノーマッド1人。P.423参照。"],
            [40..42, "トラウマ・チーム ＞ AV-4が銃撃戦の真っ只中に強行着陸し、降りて来たメディックたちが、負傷した6人ほどのギャンガーたちに応急処置を施しはじめる。P.423参照。"],
            [43..45, "レンジャー ＞ 1人のローマン(保安官)と、このローマンに任命された保安官助手が、市内に隠れている浮浪者たち(地元のギャング団員)を探している。P.423参照。"],
            [46..58, "ノーマッド ＞ ワイルドマン・パックに属するノーマッドの一団。人数はPCより2人多い。P.423参照。"],
            [59..63, "狂信者 ＞ ジャーン！　まさかの時のインクィジェターズ異端審問！　カルトのインクィジェターズが総出で押し寄せてくる。P.423参照。"],
            [64..73, "ストリート・パンク ＞ ブラック・レース中毒者どもが、クスリを買うカネを欲しがっている。人数はPCより2人多い。P.423参照。"],
            [74, "メジャー級の犯罪者 ＞ PCは悪名高いスカガッタリア・ファミリーの大きな仕事の真っただ中に迷い込んだ。P.423参照。"],
            [75..79, "ギャングの抗争 ＞ すげえ。PCはこの地域で最大級のギャング団同士の、縄張りを賭けた全面衝突の場に居合わせちまった。P.423参照。"],
            [80..87, "放火魔 ＞ この地域の誰かに恨みがある、急進的なアナーキストの集団。フレイムスロワーと斧と大型拳銃で武装しサイバードアップしたギャンガーが1名が、PCより3人少ない(最低2人)ブースターを率いている。P.424参照。"],
            [88..92, "ギャングの抗争 ＞ すげえ。PCはこの地域で最大級のギャング団同士の、縄張りを賭けた全面衝突の場に居合わせちまった。P.424参照。"],
            [93..99, "メジャー級の犯罪者 ＞ PCは悪名高いスカガッタリア・ファミリーの大きな仕事の真っただ中に迷い込んだ。P.424参照。"],
            [100, "暴れまわるサイバーサイコ ＞ ギラギラと輝くメタル・ボディのサイバーサイコが1体。通行人がうかつに挑発し過ぎて最後のエッジを超えさせてしまったらしく、そいつに湧き上がる怒りを叩きつけている。P.424参照。"],
          ]
        ),
        "SCST" => SCREAM_SHEET_TYPE_TABLE,
        "SCSA" => SCREAM_SHEET_A_TABLE,
        "SCSB" => SCREAM_SHEET_B_TABLE,
        "SCSC" => SCREAM_SHEET_C_TABLE,
        "SCSR" => SCREAM_SHEET_RANDOM_TABLE,
        "VMCT" => VENDING_MACHINE_TYPE_TABLE,
        "VMCE" => VENDING_MACHINE_FOOD_TABLE,
        "VMCF" => VENDING_MACHINE_FASHION_TABLE,
        "VMCS" => VENDING_MACHINE_STRANGE_TABLE,
        "VMCR" => DiceTable::ChainTable.new(
          "最寄りの自動販売機表",
          "1D6",
          [
            VENDING_MACHINE_FOOD_TABLE,
            VENDING_MACHINE_FOOD_TABLE,
            VENDING_MACHINE_FOOD_TABLE,
            VENDING_MACHINE_FASHION_TABLE,
            VENDING_MACHINE_FASHION_TABLE,
            VENDING_MACHINE_STRANGE_TABLE
          ]
        ),
        "STOREA" => SHOP_STAFF_TABLE,
        "STOREB" => SHOP_PEOPLE_A_TABLE,
        "STOREC" => SHOP_PEOPLE_B_TABLE,
        "STORE" => SHOP_PEOPLE_TABLE
      }.freeze
    end
  end
end