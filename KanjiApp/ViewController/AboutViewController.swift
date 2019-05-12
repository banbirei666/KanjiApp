//
//  AboutViewController.swift
//  KanjiApp
//
//  Created by 前川嵩博 on 2019/05/11.
//  Copyright © 2019年 takahiro. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var cautionLabel: UILabel!
    @IBOutlet weak var aboutAppLabel: UILabel!
    @IBOutlet weak var aboutAppVersionTextView: UITextView!
    @IBOutlet weak var agreementTextView: UITextView!
    
    // アプリのバージョンを取得
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ナビゲーションタイトル
        self.title = AppConstant.NAVIGATION_TITLE_ABOUT
        
        // 本アプリについて
        self.aboutAppLabel.textColor = UIColor.init(red: 51/255, green: 191/255, blue: 219/255, alpha: 1.0)
        self.aboutAppLabel.addLeftBorder(width: 1.0, color: UIColor.init(red: 51/255, green: 191/255, blue: 219/255, alpha: 1.0))
        
        // 現在のアプリバージョン
        self.aboutAppVersionTextView.text = "現在のアプリバージョン: \(self.version)"
        
        // 利用規約
        self.agreementTextView.layer.borderWidth = 0.5
        self.agreementTextView.layer.borderColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor

        // 注意事項
        self.cautionLabel.textColor = UIColor.init(red: 51/255, green: 191/255, blue: 219/255, alpha: 1.0)
        self.cautionLabel.addLeftBorder(width: 1.0, color: UIColor.init(red: 51/255, green: 191/255, blue: 219/255, alpha: 1.0))
        

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
