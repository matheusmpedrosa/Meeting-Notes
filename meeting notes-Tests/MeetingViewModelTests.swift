//
//  MeetingViewModelTests.swift
//  meeting notes-Tests
//
//  Created by Matheus Pedrosa on 08/06/21.
//

import XCTest
@testable import meeting_notes

class MeetingViewModelTests: XCTestCase {
    // MARK: - Properties
    
    var sut: MeetingViewModel!
    var service: MockService!
    var fetchMeetingExpectation: XCTestExpectation!
    var didShowLoading = false
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        service = MockService()
        sut = MeetingViewModel(meetingId: "8626ad29-b8f7-4347-adae-2a0cd4b8e866",
                               service: service)
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
        fetchMeetingExpectation = self.expectation(description: "Fetch Meeting with success")
        sut.fetchMeeting()
        wait(for: [fetchMeetingExpectation!], timeout: 30)
    }
    
    func testDidShowLoading() {
        sut.fetchMeeting()
        XCTAssertTrue(didShowLoading)
    }
}

extension MeetingViewModelTests: MeetingViewModelDelegate {
    func meetingViewModelDelegateDidFetchMeeting(_ viewModel: MeetingViewModel) {
        fetchMeetingExpectation?.fulfill()
    }
    
    func meetingViewModelDelegateIsLoading(_ viewModel: MeetingViewModel, isLoading: Bool) {
        didShowLoading = true
    }
    
    func meetingViewModelDelegateError(_ viewModel: MeetingViewModel) {
        // intentionally unimplemented
    }
}
