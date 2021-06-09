//
//  Service.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation

protocol ServiceProtocol {
    func fetchListOfMeetings(completion: @escaping (Result<[ListOfMeetingsModel], Error>) -> Void)
    func fetchSelectedMeeting(meetingId: String, completion: @escaping (Result<MeetingModel, Error>) -> Void)
}

final class Service: ServiceProtocol {
    // MARK: - Propeties
    
    fileprivate let request = Request()
    
    // MARK: - Fetch List Of Meetings
    
    func fetchListOfMeetings(completion: @escaping (Result<[ListOfMeetingsModel], Error>) -> Void) {
        request.fetch(target: .listOfMeetings, model: ListOfMeetingsModel.self) { (result) in
            completion(result)
        }
    }
    
    // MARK: - Fetch Selected Meeting
    
    func fetchSelectedMeeting(meetingId: String, completion: @escaping (Result<MeetingModel, Error>) -> Void) {
        request.fetch(target: .selectedMeeting(meetingId: meetingId), model: MeetingModel.self) { (result) in
            completion(result)
        }
    }
}
