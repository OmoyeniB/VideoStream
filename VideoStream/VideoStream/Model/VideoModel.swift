//
//  VideoModel.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 08/11/2022.
//

import Foundation

struct VideoModel: Codable {
    var decsription: String
    var photo: String
    var userID: String
    var timeStamp: Int
    var userName: String
    var videoLink: String
    var isVideo: Bool
}
