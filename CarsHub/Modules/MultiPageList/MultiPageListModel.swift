//
//  MultiPageListModel.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import Foundation

struct MultiPageListModel: Decodable {
    var page: Int
    var pageSize: Int
    var totalPageCount: Int
    var wkda: [String: String]
}
