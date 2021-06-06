//
//  MeetingViewController.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import UIKit

class MeetingViewController: UIViewController {
    
    // MARK: - Properties
    
    fileprivate var viewModel: MeetingViewModel!
    
    // MARK: - Initializer
    
    init(viewModel: MeetingViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMeeting()
        title = viewModel.meetingModel?.title
    }

}
