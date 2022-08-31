//
//  FetchDataView + Extension.swift
//  pryaniki-test-task
//
//  Created by Vasily Maslov on 31.08.2022.
//

import UIKit
import Kingfisher


extension FetchedDataView {
    func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }
    
    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 30
        return stackView
    }
    
    func makeContentView() -> UIView {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 750).isActive = true
        return contentView
    }
    
    func makeContainerView(viewType: String, fetchedData: [FetchedData]) -> UIView {
        let view = UIView()
        let name = makeNameLabel()
        var internalView = UIView()
        var gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.1
        
        view.widthAnchor.constraint(equalToConstant: 350).isActive = true
        internalView.translatesAutoresizingMaskIntoConstraints = false
        
        name.text = viewType
        
        switch viewType {
        case "hz":
            guard let text = fetchedData[0].contentData?.text else { return view}
            view.heightAnchor.constraint(equalToConstant: 100).isActive = true
            gesture = UITapGestureRecognizer(target: self, action: #selector(showAlertFromHZ))
            view.addGestureRecognizer(gesture)
            internalView = makeHZView(text: text)
            
        case "picture":
            guard let url = fetchedData[1].contentData?.url,
                  let text = fetchedData[1].contentData?.text else { return view }
            view.heightAnchor.constraint(equalToConstant: 200).isActive = true
            gesture = UITapGestureRecognizer(target: self, action: #selector(showAlertFromPicture))
            view.addGestureRecognizer(gesture)
            internalView = makePictureView(text: text, url: url )
            
        case "selector":
            guard let selectedId = fetchedData[2].contentData?.selectedId,
                  let variants = fetchedData[2].contentData?.variants else {
                return view
            }
            view.heightAnchor.constraint(equalToConstant: 90).isActive = true
            internalView = makeSelectorView(selectedId: selectedId, variants: variants)
            
        default: break
        }
        
        view.addSubview(name)
        view.addSubview(internalView)
        
        name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        name.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        internalView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
        internalView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        internalView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        return view
    }
    
    func makeHZView(text: String) -> UIView {
        let view = UIView()
        let textLabel = makeTextLabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        textLabel.text = text
        
        view.addSubview(textLabel)
        textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        return view
    }
    
    func makePictureView(text: String, url: String) -> UIView {
        let view = UIView()
        let textLabel = makeTextLabel()
        let imageView = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 350).isActive = true
        view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        textLabel.text = text
        textLabel.textAlignment = .center
        
        guard let url = URL(string: url) else { return view}
        imageView.kf.setImage(with: url)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(textLabel)
        view.addSubview(imageView)
        textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        textLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10).isActive = true
        return view
    }
    
    func makeSelectorView(selectedId: Int, variants: [Variants]) -> UIView {
        let view = UIView()
        var segmentControll = UISegmentedControl()
        var variantsArray: [String] = []
        
        
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
       

        for variant in variants {
            variantsArray.append(variant.text)
        }
        segmentControll = UISegmentedControl(items: variantsArray)
        segmentControll.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        segmentControll.selectedSegmentIndex = 1
        segmentControll.addTarget(self, action: #selector(showAlertFromSelection(_:)), for: .valueChanged)
        view.addSubview(segmentControll)
     
        return view
        
    }
    
    func makeLabel(ofSize: CGFloat) -> UILabel {
        let label = UILabel()
        translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: ofSize)
        return label
    }
    
    func makeNameLabel() -> UILabel {
        let nameLabel = makeLabel(ofSize: 25)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return nameLabel
    }
    
    func makeTextLabel() -> UILabel {
        let textLabel = makeLabel(ofSize: 16)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return textLabel
    }
    
    func makeActivityIndicatorView() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        return activityIndicator
    }
     
    @objc func showAlertFromHZ() {
        print("show alert fom hz")
        mainViewController?.showAlert(eventInitializator: "hz")
    }
    
    @objc func showAlertFromPicture() {
        print("show alert from picture")
        mainViewController?.showAlert(eventInitializator: "picture")
    }
    
    @objc func showAlertFromSelection(_ sender: UISegmentedControl) {
        print("show alert from selection")
        
        mainViewController?.showAlert(eventInitializator: String(sender.selectedSegmentIndex + 1))
    }
}
