//
//  MeetingModel.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation

// MARK: - Meeting Model

struct MeetingModel: Decodable {
    var id: String?
    var startAt: String?
    var endAt: String?
    var title: String?
    var htmlContent: String?
}
