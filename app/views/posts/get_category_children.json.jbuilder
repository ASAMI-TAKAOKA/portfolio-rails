# ①get_category_childrenアクションで抽出したレコードを繰り返し処理し、配列を作成する。
json.array! @category_children do |children|
  # ②各IDと名前を、①で作成した配列に格納する。
  json.id children.id
  json.name children.name
end