//
//  Constant.swift
//  KanjiApp
//
//  Created by 前川嵩博 on 2019/05/10.
//  Copyright © 2019 takahiro. All rights reserved.
//

import Foundation

struct AppConstant {
    static let GOO_HIRAGANA_API_URL = "https://labs.goo.ne.jp/api/hiragana"
    // goolabのAPIkeyをGOO_HIRAGANA_API_KEYに指定してください。
    static let GOO_HIRAGANA_API_KEY = "************"
    static let GOO_HIRAGANA_API_TYPE = "hiragana"

    static let NAVIGATION_TITLE_HOME = "HOME"
    static let NAVIGATION_TITLE_ABOUT = "ABOUT"

    static let HIRAGANA_ROBOT_NAME = "ひらがなロボット"

    static let USER_NAME = "さる助"
    static let USER_MESSAGE = "テキストを入力してください"

    static let ROBOT_DEFAULT_TEXT = "入力したテキストを「ひらがな」にするよ"
    static let ROBOT_ENTERING_THE_TEXT = "テキスト入力中..."
    static let ROBOT_THINKING_MESSAGE = "思考中..."
    static let ROBOT_THINKING_DELAY_SEC = 0.2
    static let ROBOT_ERROR_MESSAGE = "取得に失敗しました。 \nもう一度テキストを入力してください。"

    static let INPUT_TEXT_MAX_LENGTH = 30

}
