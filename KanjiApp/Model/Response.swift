//
//  Response.swift
//  KanjiApp
//
//  Created by 前川嵩博 on 2019/05/12.
//  Copyright © 2019年 takahiro. All rights reserved.
//

import Foundation


// APIのレスポンスに対する構造体
struct Response: Codable {
    let converted: String
    let output_type: String
    let request_id: String
}


