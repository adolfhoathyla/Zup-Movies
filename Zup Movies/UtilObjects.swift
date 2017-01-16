//
//  UtilObjects.swift
//  Zup Movies
//
//  Created by Adolfho Athyla on 16/01/17.
//  Copyright © 2017 a7hyla. All rights reserved.
//

import UIKit

class UtilObjects: NSObject {

    static func simpleAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
    
}
