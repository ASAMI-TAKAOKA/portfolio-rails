# 親カテゴリ
# parent_array = ['野菜', '果物', 'お肉', 'お魚', 'お惣菜・お弁当', 'ハム・ソーセージ・チルド調理品', '卵・牛乳・乳製品', '豆腐・納豆・漬物・練物', '冷凍食品・アイス', 'お米・麺・パスタ', 'パン・ジャム・シリアル', '食油・カレー・スープ・調味料', '缶詰・粉類・乾物', '菓子・スイーツ', '飲料・お水', 'お酒・ノンアルコール', '紙・生理用品・介護', '美容・衛生', '日用品・雑貨', 'キッチン用品', 'ベビー', 'ペット']

# 野菜の親カテゴリの生成
vegetable = Category.create(name: '野菜')

# 野菜の子カテゴリ
vegetable_children_array = ['サラダ野菜', '葉物野菜', 'いも・根菜・豆類・かぼちゃ', 'きのこ類', '薬味・香味野菜', '水煮・加工品', '冷凍野菜']

# 野菜の孫カテゴリ
vegetable_grandchildren_array = [
  ['アスパラガス', 'オクラ', 'かいわれ大根・スプラウト', 'キャベツ', 'きゅうり', 'トマト', 'パプリカ', 'ブロッコリー', 'ベビーリーフ・セロリ', 'レタス'], # サラダ野菜の子
  ['小松菜', '春菊', '青梗菜', '白菜', 'ほうれん草', '水菜'], # 葉物野菜の子
  ['いんげん', 'えんどう豆', 'かぼちゃ', 'ごぼう', 'さつまいも', 'さといも', 'じゃがいも', 'ズッキーニ', '大根', 'たまねぎ', '豆苗', '長いも・大和いも'], # いも・根菜・豆類・かぼちゃの子
  ['えのき', 'エリンギ', 'しいたけ', 'しめじ', 'なめこ', 'マッシュルーム', '舞茸'], # きのこ類の子
  ['ねぎ', '大葉', 'しょうが', 'パセリ', 'にら', 'にんにく・唐辛子', 'にんにくの芽・ししとう', 'みつ葉', 'みょうが'], # 薬味・香味野菜の子
  ['たけのこ水煮', '野菜・山菜水煮', 'ぬか床'], # 水煮・加工品の子
  ['冷凍野菜'] # 冷凍野菜の子
]

# 野菜の子カテゴリ、孫カテゴリの生成
vegetable_children_array.each_with_index do |children, index|
  children = vegetable.children.create(name: children)
  vegetable_grandchildren_array[index].each do |grandchildren|
    children.children.create(name: grandchildren)
  end
end


# 果物の親カテゴリの生成
fruit = Category.create(name: '果物')

# 果物の子カテゴリ
fruit_children_array = ['果物', 'カットフルーツ・ドライフルーツ', '冷凍果物']

# 果物の孫カテゴリ
fruit_grandchildren_array = [
  ['アボカド', 'オレンジ', 'キウイフルーツ', 'グレープフルーツ', 'すいか', 'パイナップル', 'バナナ', 'ぶどう', 'りんご'], # 果物の子
  ['カットフルーツ', 'ドライフルーツ'], # カットフルーツ・ドライフルーツの子
  ['冷凍果物'] # 冷凍果物の子
]

# 果物の子カテゴリ、孫カテゴリの生成
fruit_children_array.each_with_index do |children, index|
  children = fruit.children.create(name: children)
  fruit_grandchildren_array[index].each do |grandchildren|
    children.children.create(name: grandchildren)
  end
end
