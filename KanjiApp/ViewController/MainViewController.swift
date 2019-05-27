//
//  MainViewController.swift
//  KanjiApp
//
//  Created by 前川嵩博 on 2019/05/09.
//  Copyright © 2019 takahiro. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var root_view: UIView!
    @IBOutlet weak var outputHiraganaLabel: UILabel!
    @IBOutlet weak var inputKanjiTextField: UITextField!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var robotView: UIView!
    @IBOutlet weak var robotStatusImageView: UIImageView!
    @IBOutlet weak var monkeyView: UIView!
    @IBOutlet weak var usageLabel: UILabel!
    
    var robotStatusThinkingImage: UIImage = UIImage(named: "loading")!
    var robotStatusCompleteImage: UIImage = UIImage(named: "complete")!
    var robotStatusErrorImage: UIImage = UIImage(named: "fail")!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 初期画面の設定
        defaultViewInit()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputKanjiTextField.delegate = self
        inputKanjiTextField.returnKeyType = .done
        inputKanjiTextField.addTarget(self, action: #selector(MainViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

    }
    
    
    // テキストフィールドを監視する
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let writtenText: String = inputKanjiTextField.text else { return }
        
        // テキスト入力中の表示
        self.setRobotStatus(status: .waiting, message: AppConstant.ROBOT_ENTERING_THE_TEXT)
        
        // テキストの文字入力制限表示
        self.textCountLabel.text = "\(writtenText.count) / \(AppConstant.INPUT_TEXT_MAX_LENGTH)"
        
        // 文字数制限にひっかかっている場合は文字数カウントラベルを赤くする
        if writtenText.count > AppConstant.INPUT_TEXT_MAX_LENGTH {
            self.textCountLabel.textColor = UIColor.red
        }else {
            self.textCountLabel.textColor = UIColor.darkGray
        }

    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func aboutButtonTouchUpInside(_ sender: Any) {
        // About画面に遷移
//        let vc: AboutViewController = AboutViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
        let vc: BasicExampleViewController = BasicExampleViewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    
    
    // 初期表示画面の設定
    func defaultViewInit() {
        // ナビゲーションタイトル
        self.title = AppConstant.NAVIGATION_TITLE_HOME

        self.outputHiraganaLabel.layer.borderWidth = 0.5
        self.outputHiraganaLabel.layer.cornerRadius = 5
        self.outputHiraganaLabel.layer.borderColor = UIColor.gray.cgColor
        
        self.usageLabel.textColor = UIColor.init(red: 51/255, green: 191/255, blue: 219/255, alpha: 1.0)
        self.usageLabel.addLeftBorder(width: 1.0, color: UIColor.init(red: 51/255, green: 191/255, blue: 219/255, alpha: 1.0))
        
        self.robotView.layer.borderWidth = 0.5
        self.robotView.layer.cornerRadius = 50
        self.robotView.layer.borderColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
        
        self.monkeyView.layer.borderWidth = 0.5
        self.monkeyView.layer.cornerRadius = 50
        self.monkeyView.layer.borderColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
    }
    
    
    

    // ロボットの状態や表示するテキストを設定する
    func setRobotStatus(status: RobotStatus, message: String) {

        // メインスレッドで実行する
        DispatchQueue.main.async {
            // ロボットのテキスト設定
            self.outputHiraganaLabel.text = message

            switch status {
                // ロボット文字入力受付中
                case .waiting:
                    self.robotStatusImageView.image = self.robotStatusThinkingImage
                
                // ロボット思考中
                case .thinking:
                    self.robotStatusImageView.image = self.robotStatusThinkingImage

                // 成功
                case .success:
                    self.robotStatusImageView.image = self.robotStatusCompleteImage

                // 失敗
                case .error:
                    self.robotStatusImageView.image = self.robotStatusErrorImage

            }
        }

        
    }
    


}

