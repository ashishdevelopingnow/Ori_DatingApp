//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  Created by DevelopingNow on 1/22/15.
//  Copyright (c) 2015 DevelopingNow. All rights reserved.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.characters.count
    }
}
