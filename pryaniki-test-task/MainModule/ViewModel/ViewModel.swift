//
//  ViewModel.swift
//  pryaniki-test-task
//
//  Created by Vasily Maslov on 31.08.2022.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

protocol MainViewModelProtocol {
    var updateViewData: ((ViewData)->())? { get set }
    
    func start()
}

final class MainViewModel: MainViewModelProtocol {
    public var updateViewData: ((ViewData) -> ())?
    
    var urlString = "https://pryaniky.com/static/json/sample.json"
    init() {
        updateViewData?(.initial)
    }
    
    public func start() {
        updateViewData?(.loading)
        
        guard let url = URL(string: urlString) else {
            updateViewData?(.failure(Error.invalidURL))
            return
        }
        AF.request(url).responseObject { (response: AFDataResponse<ResponseData>) in
            switch response.result {
            case .success(let fetchResult):
                self.updateViewData?(.success(fetchResult))
            case .failure(_):
                self.updateViewData?(.failure(Error.unknownAPIResponse))
            }
            
        }
    }
}
