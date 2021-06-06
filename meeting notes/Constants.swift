//
//  Constants.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation
import UIKit

struct K {
    
    struct EmptyState {
        static let identifier: String = "EmptyStateCell"
        static let title: String = "You have no meetings"
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
