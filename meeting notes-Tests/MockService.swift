//
//  MockService.swift
//  meeting notes-Tests
//
//  Created by Matheus Pedrosa on 08/06/21.
//

@testable import meeting_notes

final class MockService: ServiceProtocol {
    func fetchListOfMeetings(completion: @escaping (Result<[ListOfMeetingsModel], Error>) -> Void) {
        let listOfMeetingsMock = try! JSONMock.makeArrayOfModels(model: ListOfMeetingsModel.self,
                                                                 fromJSON: "list_of_meetings_success_response")
        completion(.success(listOfMeetingsMock))
    }
    
    func fetchSelectedMeeting(meetingId: String, completion: @escaping (Result<MeetingModel, Error>) -> Void) {
        let meeting = try! JSONMock.makeModel(model: MeetingModel.self, fromJSON: "meeting_success_response")
        completion(.success(meeting))
    }
}
