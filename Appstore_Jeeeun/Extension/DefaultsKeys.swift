//
//  DefaultsKeys.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/20.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import Foundation
import SwiftyUserDefaults


extension DefaultsKeys {
    
    var searchList: DefaultsKey<[String]> {
        return .init("searched", defaultValue: [])
    }
    
 
}

