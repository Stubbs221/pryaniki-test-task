//
//  ViewData.swift
//  pryaniki-test-task
//
//  Created by MAC on 29.08.2022.
//

import Foundation
import ObjectMapper

enum ViewData {
    
    case initial
    case loading(ResponseData)
    case success(ResponseData)
    case failure(ResponseData)
}

struct ResponseData: Mappable {
    
    var data: [FetchedData] = []
    var view: [String] = []
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        data <- map["data"]
        view <- map["view"]
    }
    
    
}

struct FetchedData: Mappable {

    var name: String = ""
    var contentData: ContentData?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        contentData <- map["data"]
    }
}

struct ContentData: Mappable {

    var text: String?
    var url: String?
    var selectedId: Int?
    var variants: [Variants] = []
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        text <- map["text"]
        url <- map["url"]
        selectedId <- map["selectedId"]
        variants <- map["variants"]
    }
}

struct Variants: Mappable {

    var id: Int = 0
    var text: String = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        text <- map["text"]
    }
    
}
