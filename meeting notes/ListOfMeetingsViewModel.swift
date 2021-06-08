//
//  ListOfMeetingsViewModel.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation

protocol ListOfMeetingsViewModelDelegate: AnyObject {
    func listOfMeetingsViewModelDelegateDidFetchMeetings(_ viewModel: ListOfMeetingsViewModel)
    func listOfMeetingsViewModelDelegateIsLoading(_ viewModel: ListOfMeetingsViewModel, isLoading: Bool)
    func listOfMeetingsViewModelDelegateIsEmpty(_ viewModel: ListOfMeetingsViewModel, isEmpty: Bool)
    func listOfMeetingsViewModelDelegateError(_ viewModel: ListOfMeetingsViewModel)
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
    
    func fetchListOfMeetings() {
        viewDelegate?.listOfMeetingsViewModelDelegateIsLoading(self, isLoading: true)
        service.fetchListOfMeetings { [weak self] (response) in
            guard let self = self else { return }
            self.viewDelegate?.listOfMeetingsViewModelDelegateIsLoading(self, isLoading: false)
            switch response {
            case .success(let listOfMeetings):
                self.listOfMeetings = listOfMeetings
                self.viewDelegate?.listOfMeetingsViewModelDelegateIsEmpty(self, isEmpty: listOfMeetings.isEmpty)
                self.viewDelegate?.listOfMeetingsViewModelDelegateDidFetchMeetings(self)
            case .failure(_):
                self.viewDelegate?.listOfMeetingsViewModelDelegateError(self)
            }
        }
    }
    
    func getMeetingDate(from startDate: String?, to endDate: String?) -> String? {
        guard let startDate = formatStartDate(startDate), let endDate = formatEndDate(endDate) else {
            return nil
        }
        return startDate + endDate
    }
    
    func shoudHideAccessoryLabelAt(at row: Int) -> Bool {
        let meetingDateString = listOfMeetings?[row].startAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = K.DateFormatter.backEnd
        let currentDate = Date()
        guard let meetingDate = dateFormatter.date(from: meetingDateString ?? "") else { return true }
        dateFormatter.dateFormat = K.DateFormatter.meetingDate
        let currentDay = dateFormatter.string(from: currentDate)
        let meetingDay = dateFormatter.string(from: meetingDate)
        return currentDay != meetingDay
    }
    
    // MARK: - Private Methods
    
    fileprivate func formatStartDate(_ date: String?) -> String? {
        let startDateFormatter = DateFormatter()
        startDateFormatter.dateFormat = K.DateFormatter.backEnd
        startDateFormatter.locale = Locale(identifier: K.Locale.us)
        guard let date = startDateFormatter.date(from: date ?? "") else { return nil }
        startDateFormatter.dateFormat = K.DateFormatter.startDate
        return startDateFormatter.string(from: date)
    }
    
    fileprivate func formatEndDate(_ date: String?) -> String? {
        let endDateFormatter = DateFormatter()
        endDateFormatter.dateFormat = K.DateFormatter.backEnd
        endDateFormatter.locale = Locale(identifier: K.Locale.us)
        guard let date = endDateFormatter.date(from: date ?? "") else { return nil }
        endDateFormatter.dateFormat = K.DateFormatter.endDate
        return endDateFormatter.string(from: date)
    }
    
}
