//
//  MeetingViewModel.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation

protocol MeetingViewModelDelegate: AnyObject {
    func meetingViewModelDelegateDidFetchMeeting(_ viewModel: MeetingViewModel)
}

class MeetingViewModel {
    
    // MARK: - Properties
    
    fileprivate var meetingId: String!
    fileprivate var service: Service?
    private(set) var meetingModel: MeetingModel? = nil
    weak var viewDelegate: MeetingViewModelDelegate?
    
    // MARK: - Initializer
    
    init(meetingId: String, service: Service) {
        self.meetingId = meetingId
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func fetchMeeting() {
        service?.fetchSelectedMeeting(meetingId: meetingId, completion: { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let meetingModel):
                self.meetingModel = meetingModel
                self.viewDelegate?.meetingViewModelDelegateDidFetchMeeting(self)
            case .failure(_):
                NSLog("%@", #function)
            }
        })
    }
    
}
