//
//  ViewController.swift
//  pryaniki-test-task
//
//  Created by MAC on 29.08.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var viewModel: MainViewModelProtocol!
    private var fetchedDataView: FetchedDataView!
    
    override func viewDidLoad() {
        viewModel = MainViewModel()
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(fetchDataButton)
        fetchDataButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fetchDataButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75).isActive = true
        createFetchedDataView()
        updateView()
    }

    lazy var fetchDataButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Fetch Data", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 75).isActive = true
        button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor.blue.cgColor
        button.addTarget(self, action: #selector(fetchDataButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private func createFetchedDataView() {
        fetchedDataView = FetchedDataView(mainVC: self)
        fetchedDataView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fetchedDataView)
        fetchedDataView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        fetchedDataView.bottomAnchor.constraint(equalTo: fetchDataButton.topAnchor, constant: -50).isActive = true
        fetchedDataView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        fetchedDataView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
   
    }
    
    private func updateView() {
        viewModel.updateViewData = { [ weak self ] viewData in
            self?.fetchedDataView.viewData = viewData
        }
    }
    
    @objc func fetchDataButtonTapped() {
        viewModel.start()
    }
    
    func showAlert(eventInitializator: String)  {
        let alert = UIAlertController(title: "Action was initiated by:", message: eventInitializator, preferredStyle: .alert)
        let okAlertButton = UIAlertAction(title: "ok", style: .default)
        alert.addAction(okAlertButton)
        
        self.present(alert, animated: true, completion: nil)
    }
}

