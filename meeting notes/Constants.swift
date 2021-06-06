//
//  Constants.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation
import UIKit

struct K {
    
    struct Locale {
        static let us = "en_US"
    }
    
    struct DateFormatter {
        static let backEnd = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        static let startDate = "EEEE, MMM d, h:mm a"
        static let endDate = " - h:mm a"
    }
    
    struct Constraint {
        static let top: CGFloat = 16
        static let leading: CGFloat = 16
        static let trailing: CGFloat = -16
        static let bottom: CGFloat = -16
    }
    
    struct Title {
        static let listOfMeetingsViewControllerTitle: String = "My meetings"
        static let accessoryLabelTitle: String = "Today"
    }
    
    struct Color {
        static let hugo: UIColor = #colorLiteral(red: 0, green: 0.4117647059, blue: 0.8980392157, alpha: 1)
    }
    
    struct API {
        static let listOfMeetings: String = "https://hg-ios-test.s3-us-west-2.amazonaws.com/meetings.json"
        static let selectedMeeting: String = "https://hg-ios-test.s3-us-west-2.amazonaws.com/meetings/"
    }
    
    struct HTTPMethod {
        static let get: String = "GET"
    }
    
}
