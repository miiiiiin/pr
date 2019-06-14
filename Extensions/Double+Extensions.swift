//
//  Double+Extensions.swift
//  Weather
//
//  Created by Min on 13/06/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import Foundation

extension Double {
    
    var formatAsDegree: String {
        return String(format: "%.0f°", self) //self is a instance of double
    }
}
