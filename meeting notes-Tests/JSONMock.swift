//
//  JSONMock.swift
//  meeting notes-Tests
//
//  Created by Matheus Pedrosa on 08/06/21.
//

import Foundation

class JSONMock {
    static func makeArrayOfModels<T: Decodable>(model: T.Type, fromJSON json: String) throws -> [T] {
        let bundle = Bundle(for: self)
        let filePath = bundle.url(
            forResource: json,
            withExtension: "json"
        )

        let content = try Data(contentsOf: filePath!)
        return try JSONDecoder().decode(
            [T].self,
            from: content
        )
    }
    
    static func makeModel<T: Decodable>(model: T.Type, fromJSON json: String) throws -> T {
        let bundle = Bundle(for: self)
        let filePath = bundle.url(
            forResource: json,
            withExtension: "json"
        )
        
        let content = try Data(contentsOf: filePath!)
        return try JSONDecoder().decode(
            T.self,
            from: content
        )
    }
}
