//
//  MainViewController+UITextFieldDelegate.swift
//  KanjiApp
//
//  Created by 前川嵩博 on 2019/05/20.
//  Copyright © 2019 takahiro. All rights reserved.
//

import UIKit

extension MainViewController: UITextViewDelegate {
    
    // テキストフィールがタップされ、入力可能になる直前
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        // 入力されたキーワードをプリント
        print("テキストフィールがタップされ、入力可能になったあと")
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("テキストフィールの入力が終了しました。")
        
        Thread.sleep(forTimeInterval: AppConstant.ROBOT_THINKING_DELAY_SEC)
        
        self.setRobotStatus(status: .thinking, message: AppConstant.ROBOT_THINKING_MESSAGE)
        
        // 文字数制限にひっかかっている場合は、APIを打たない
        if (textField.text?.count)! > AppConstant.INPUT_TEXT_MAX_LENGTH {
            self.setRobotStatus(status: .error, message: AppConstant.ROBOT_ERROR_TOO_LONG_MESSAGE)
        }else {
            getHiragana(parameters: [
                "app_id": AppConstant.GOO_HIRAGANA_API_KEY,
                "sentence": self.inputKanjiTextField.text ?? "",
                "output_type": AppConstant.GOO_HIRAGANA_API_TYPE
                ])

        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}

