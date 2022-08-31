//
//  FetchedDataView.swift
//  pryaniki-test-task
//
//  Created by Vasily Maslov on 31.08.2022.
//

import UIKit

class FetchedDataView: UIView {

    var viewData: ViewData = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    
    weak var mainViewController: MainViewController?
    

    
    init(mainVC: MainViewController) {
        self.mainViewController = mainVC
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var activityIndicator = makeActivityIndicatorView()
    
    lazy var scrollView = makeScrollView()
    lazy var stackView = makeStackView()
    lazy var contentView = makeContentView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30).isActive = true
        
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 15
        
        switch viewData {
        case .initial:
            self.activityIndicator.isHidden = true
        case .loading:
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        case .success(let success):
            update(viewData: success)
            self.activityIndicator.isHidden = true
        case .failure(let error):
            print(error)
            self.activityIndicator.isHidden = true
        }
    }

    private func update(viewData: ResponseData) {
        for view in viewData.views {
            let containerView = makeContainerView(viewType: view, fetchedData: viewData.data)
            stackView.addArrangedSubview(containerView)
        }
    }
}
