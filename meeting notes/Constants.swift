//
//  Constants.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation
import UIKit

struct K {
    
    struct UI {
        static let cornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1
    }
    
    struct Locale {
        static let us = "en_US"
    }
    
    struct DateFormatter {
        static let backEnd = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        static let startDate = "EEEE, MMM d, h:mm a"
        static let endDate = " - h:mm a"
        static let meetingDate = "MM-dd-yyyy"
    }
    
    struct Constraint {
        static let top: CGFloat = 16
        static let leading: CGFloat = 16
        static let trailing: CGFloat = -16
        static let bottom: CGFloat = -16
    }
    
    struct Text {
        static let listOfMeetingsViewControllerTitle: String = "My meetings"
        static let accessoryLabelText: String = "Today"
        static let emptyListOfMeetingsText: String = "You have no meetings 😕"
        static let noMeetingData: String = "This meeting has no data 😕"
        static let somethingWentWrong: String = "Something went wrong ⚠️"
    }
    
    struct API {
        static let listOfMeetings: String = "https://hg-ios-test.s3-us-west-2.amazonaws.com/meetings.json"
        static let selectedMeeting: String = "https://hg-ios-test.s3-us-west-2.amazonaws.com/meetings/"
    }
    
    struct HTTPMethod {
        static let get: String = "GET"
    }
    
}
