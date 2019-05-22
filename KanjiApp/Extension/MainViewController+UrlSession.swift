//
//  MainViewController+UrlSession.swift
//  KanjiApp
//
//  Created by volksware_developer03 on 2019/05/23.
//  Copyright © 2019年 takahiro. All rights reserved.
//

import Foundation

extension MainViewController {
    
    // ひらがなに変換するAPIを呼び出す
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
}
