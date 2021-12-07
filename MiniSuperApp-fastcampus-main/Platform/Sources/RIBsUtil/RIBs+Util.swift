//
//  File.swift
//  
//
//  Created by Bradley.yoon on 2021/12/07.
//

import Foundation

public enum DismissButtonType {
    case back, close
    
    public var iconSystemName: String {
        switch self {
        case .back:
            return "chevron.backward"
        case .close:
            return "xmark"
        }
    }
    
}
