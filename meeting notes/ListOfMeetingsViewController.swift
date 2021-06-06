//
//  ListOfMeetingsViewController.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import UIKit

final class ListOfMeetingsViewController: UIViewController {
    
    // MARK: - Properties
    
    fileprivate var viewModel: ListOfMeetingsViewModel!
    
    // MARK: - Initializer
    
    init(viewModel: ListOfMeetingsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fechListOfMeetings()
    }

}
