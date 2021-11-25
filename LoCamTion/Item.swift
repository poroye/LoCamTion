//
//  Item.swift
//  LoCamTion
//
//  Created by ธนัท แสงเพิ่ม on 25/11/2564 BE.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var imgData: NSData?
    @objc dynamic var lat: String?
    @objc dynamic var lon: String?
}
