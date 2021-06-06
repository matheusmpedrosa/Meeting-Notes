//
//  MeetingViewModel.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation

class MeetingViewModel {
    
    // MARK: - Properties
    
    fileprivate var meetingId: String!
    fileprivate var service: Service?
    private(set) var meetingModel: MeetingModel? = nil
    
    // MARK: - Initializer
    
    init(meetingId: String, service: Service) {
        self.meetingId = meetingId
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func fetchMeeting() {
        service?.fetchSelectedMeeting(meetingId: meetingId, completion: { [weak self] (response) in
            switch response {
            case .success(let meetingModel):
                self?.meetingModel = meetingModel
            case .failure(_):
                NSLog("%@", #function)
            }
        })
    }
    
}
