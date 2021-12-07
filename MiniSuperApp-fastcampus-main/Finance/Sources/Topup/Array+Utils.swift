//
//  File.swift
//  
//
//  Created by Bradley.yoon on 2021/12/07.
//

import Foundation

extension Array {
  subscript(safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
}

