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
        let writtenText = inputKanjiTextField.text! as NSString
 
        // テキスト入力中の表示
        self.setRobotStatus(status: .waiting, message: AppConstant.ROBOT_ENTERING_THE_TEXT)
        
        // テキストの文字入力制限表示
        self.textCountLabel.text = "\(writtenText.length) / \(AppConstant.INPUT_TEXT_MAX_LENGTH)"

    }

    
    // テキストフィールがタップされ、入力可能になる直前
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        // 入力されたキーワードをプリント
        print("テキストフィールがタップされ、入力可能になったあと")
    }
    
    
    // MARK: TextField delegate methods.
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("テキストフィールの入力が終了しました。")

        Thread.sleep(forTimeInterval: AppConstant.ROBOT_THINKING_DELAY_SEC)

        self.setRobotStatus(status: .thinking, message: AppConstant.ROBOT_THINKING_MESSAGE)
        getHiragana(parameters: [
            "app_id": AppConstant.GOO_HIRAGANA_API_KEY,
            "sentence": self.inputKanjiTextField.text ?? "",
            "output_type": AppConstant.GOO_HIRAGANA_API_TYPE
            ])

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 文字入力制限
        let text: String = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if text.count <= AppConstant.INPUT_TEXT_MAX_LENGTH {
            return true
        }
        return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func aboutButtonTouchUpInside(_ sender: Any) {
        // About画面に遷移
        let vc: AboutViewController = AboutViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    func getHiragana(parameters: [String: Any]) {
        let urlString: String = AppConstant.GOO_HIRAGANA_API_URL
        
        guard let url = URL(string: urlString) else{
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
            let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                guard let data = data else { return }
                do {
                    let json = try JSONDecoder().decode(Response.self, from: data)
                    print(json.converted)
                    // 取得したひらがなのデータを表示する
                    self?.setRobotStatus(status: .success, message: json.converted.trimmingCharacters(in: .whitespacesAndNewlines))
                    
                } catch {
                    print("Error")
                    self?.setRobotStatus(status: .error, message: AppConstant.ROBOT_ERROR_MESSAGE)
                }
            }
            task.resume()

        }catch {
            print("Error:\(error)")
            self.setRobotStatus(status: .error, message: AppConstant.ROBOT_ERROR_MESSAGE)
            return
        }
    }

    
    // 初期表示画面の設定
    func defaultViewInit() {
        // ナビゲーションタイトル
        self.title = AppConstant.NAVIGATION_TITLE_HOME

        self.root_view.translatesAutoresizingMaskIntoConstraints = true
        self.root_view.frame = CGRect(x:0, y:UIApplication.shared.statusBarFrame.size.height + 30, width: UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height - 50)

        
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

