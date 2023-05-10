# フロント側へのResponseのkeysをsnake_caseからcamelCaseへ変換
# TODO:上手く変換されるようにする。
ActiveModelSerializers.config.key_transform = :camel_lower