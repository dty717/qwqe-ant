//
//  File.swift
//  FoodTracker
//
//  Created by dty on 2018/10/1.
//  Copyright © 2018年 dty. All rights reserved.
//

import UIKit
import os.log
class  Meal :NSObject, NSCoding{
    var name:String
    var rating:Int!
    var photo:UIImage?
    
    static let documentDir=FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveUrl=documentDir.appendingPathComponent("meals")
//    override init() {
//        super.init()
//    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name,forKey:PropertyKey.name)
        aCoder.encode(photo,forKey:PropertyKey.photo)
        aCoder.encode(rating,forKey:PropertyKey.rating)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name=aDecoder.decodeObject(forKey:PropertyKey.name) as? String else {
            os_log("Unable to decode the name", log:OSLog.default,type: .debug)
            return nil
        }
        let photo=aDecoder.decodeObject(forKey:PropertyKey.photo) as?UIImage
        let rating=aDecoder.decodeObject(forKey:PropertyKey.rating) as! Int;
        self.init(name:name,rating:rating,photo:photo)
    }
    init?(name:String, rating:Int, photo:UIImage?) {
        guard !name.isEmpty else{
            return nil;
        }
        guard rating>=0&&rating<=5 else{
            return nil
        }
        self.name=name
        self.rating=rating
        self.photo=photo
    }
    struct PropertyKey {
        static let name="name"
        static let photo="photo"
        static let rating="rating"
    }
}
