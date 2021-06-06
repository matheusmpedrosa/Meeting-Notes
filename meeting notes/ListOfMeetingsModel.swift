//
//  ListOfMeetingsModel.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation

// MARK: - List Of Meetings Model

struct ListOfMeetingsModel: Decodable {
    var id: String?
    var startAt: String?
    var endAt: String?
    var title: String?
}
