//
//  Encodable+Dictionarize.swift
//  WeatherForekast
//
//  Created by Ken Lâm on 6/11/20.
//  Copyright © 2020 Ken Lam. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let dict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            return dict
        } catch {
            return nil
        }
    }
    
    var json: String? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(self)
            let str = String(data: jsonData, encoding: .utf8)
            return str
        } catch {
            return nil
        }
    }
}
