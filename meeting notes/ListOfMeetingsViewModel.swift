//
//  ListOfMeetingsViewModel.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation

class ListOfMeetingsViewModel {
    
    // MARK: - Properties
    
    private(set) var listOfMeetings: [ListOfMeetingsModel]? = nil
    fileprivate var service: Service!
    
    // MARK: - Initializer
    
    init(service: Service) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func fechListOfMeetings() {
        service.fetchListOfMeetings { [weak self] (response) in
            switch response {
            case .success(let listOfMeetings):
                self?.listOfMeetings = listOfMeetings
            case .failure(_):
                NSLog("%@", #function)
            }
        }
    }
    
}
