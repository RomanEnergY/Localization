//
//  MainViewController.swift
//  Localization
//
//  Created by ZverikRS on 03.03.2024.
//

import UIKit
import SnapKit

// MARK: - displayLogic

protocol MainDisplayLogic: AnyObject {
    func reloadView()
}

// MARK: - class

final class MainViewController: UIViewController {
    
    // MARK: - public properties
    
    private let presenter: MainBusinessLogic
    private weak var mainView: MainView?
    
    // MARK: - initializers
    
    init(presenter: MainBusinessLogic) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let customView = MainView()
        view = customView
        mainView = customView
        title = "Localizable"
    }
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.viewDidAppear()
    }
}

// MARK: - extension for MainDisplayLogic

extension MainViewController: MainDisplayLogic {
    func reloadView() {
        mainView?.model = presenter.viewModel
    }
}
