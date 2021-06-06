//
//  ListOfMeetingsViewModel.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation

protocol ListOfMeetingsViewModelDelegate: AnyObject {
    func listOfMeetingsViewModelDelegateDidFetchMeetings(_ viewModel: ListOfMeetingsViewModel)
}

class ListOfMeetingsViewModel {
    
    // MARK: - Properties
    
    private(set) var listOfMeetings: [ListOfMeetingsModel]? = []
    private(set) var service: Service!
    weak var viewDelegate: ListOfMeetingsViewModelDelegate?
    
    // MARK: - Initializer
    
    init(service: Service) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func fechListOfMeetings() {
        service.fetchListOfMeetings { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let listOfMeetings):
                self.listOfMeetings = listOfMeetings
                self.viewDelegate?.listOfMeetingsViewModelDelegateDidFetchMeetings(self)
            case .failure(_):
                NSLog("FAILURE %@", #function)
            }
        }
    }
    
}
