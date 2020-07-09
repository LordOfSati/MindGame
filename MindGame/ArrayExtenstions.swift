//
//  ArrayExtenstions.swift
//  MindGame
//
//  Created by Sathish Kumar on 09/07/2020.
//  Copyright © 2020 Sathish Kumar. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
