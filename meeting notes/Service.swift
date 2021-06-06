//
//  Service.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation

final class Service: Request {
    
    // MARK: - Fetch List Of Meetings
    
    func fetchListOfMeetings(completion: @escaping (Result<[ListOfMeetingsModel], Error>) -> Void) {
        fetch(target: .listOfMeetings, model: ListOfMeetingsModel.self) { (result) in
            completion(result)
        }
    }
    
    // MARK: - Fetch Selected Meeting
    
    func fetchSelectedMeeting(meetingId: String, completion: @escaping (Result<MeetingModel, Error>) -> Void) {
        fetch(target: .selectedMeeting(meetingId: meetingId), model: MeetingModel.self) { (result) in
            completion(result)
        }
    }
    
}
