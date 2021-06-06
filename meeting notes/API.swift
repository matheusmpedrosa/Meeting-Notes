//
//  API.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation

// MARK: - API Target

protocol Target {
    var path: String { get }
}

// MARK: - Available APIs

enum API {
    case listOfMeetings
    case selectedMeeting(meetingId: String)
}

// MARK: - API Path

extension API: Target {
    var path: String {
        switch self {
        case .listOfMeetings:
            return "https://hg-ios-test.s3-us-west-2.amazonaws.com/meetings.json"
        case .selectedMeeting(let meetingId):
            return "https://hg-ios-test.s3-us-west-2.amazonaws.com/meetings/\(meetingId).json"
        }
    }
}
