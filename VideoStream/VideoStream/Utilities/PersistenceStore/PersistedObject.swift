//
//  PersistedObject.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 11/11/2022.
//

import Foundation
import RealmSwift

class PersistedObject: Object {
    @objc dynamic var decsription: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var userID: String = ""
    @objc dynamic var timeStamp: Int = 0
    @objc dynamic var userName: String = ""
    @objc dynamic var videoLink: String = ""
    @objc dynamic var isVideo: Bool = false
}
