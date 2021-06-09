//
//  ListOfMeetingsViewModelTests.swift
//  meeting notes-Tests
//
//  Created by Matheus Pedrosa on 08/06/21.
//

import XCTest
@testable import meeting_notes

class ListOfMeetingsViewModelTests: XCTestCase {
    // MARK: - Properties
    
    var sut: ListOfMeetingsViewModel!
    var service: MockService!
    var fetchListOfMeetingsExpectation: XCTestExpectation!
    var listOfMeetingsIsEmpty = true
    var didShowLoading = false
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        service = MockService()
        sut = ListOfMeetingsViewModel(service: service)
        sut.viewDelegate = self
    }
    
    // MARK: - Teardown
    
    override func tearDown() {
        service = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Methods
    
    func testFetchListOfMeetings() {
        fetchListOfMeetingsExpectation = self.expectation(description: "Fetch List of Meetings with success")
        sut.fetchListOfMeetings()
        wait(for: [fetchListOfMeetingsExpectation!], timeout: 30)
    }
    
    func testDidShowLoading() {
        sut.fetchListOfMeetings()
        XCTAssertTrue(didShowLoading)
    }
    
    func testListOfMeetingsIsEmpty() {
        sut.fetchListOfMeetings()
        XCTAssertFalse(listOfMeetingsIsEmpty)
    }
    
    func testGetMeetingDate() {
        let meetingDate = sut.getMeetingDate(from: "2021-04-12T22:00:00.000Z", to: "2021-04-12T23:00:00.000Z")
        XCTAssertEqual(meetingDate, "Monday, Apr 12, 7:00 PM - 8:00 PM")
    }
    
    func testShoudHideAccessoryLabel() {
        sut.fetchListOfMeetings()
        let shoudHide = sut.shoudHideAccessoryLabelAt(at: 0)
        XCTAssertTrue(shoudHide)
    }
}

extension ListOfMeetingsViewModelTests: ListOfMeetingsViewModelDelegate {
    func listOfMeetingsViewModelDelegateDidFetchMeetings(_ viewModel: ListOfMeetingsViewModel) {
        fetchListOfMeetingsExpectation?.fulfill()
    }
    
    func listOfMeetingsViewModelDelegateIsLoading(_ viewModel: ListOfMeetingsViewModel, isLoading: Bool) {
        didShowLoading = true
    }
    
    func listOfMeetingsViewModelDelegateIsEmpty(_ viewModel: ListOfMeetingsViewModel, isEmpty: Bool) {
        listOfMeetingsIsEmpty = isEmpty
    }
    
    func listOfMeetingsViewModelDelegateError(_ viewModel: ListOfMeetingsViewModel) {
        // intentionally unimplemented
    }
}
