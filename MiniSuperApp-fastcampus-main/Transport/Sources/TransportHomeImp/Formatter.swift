//
//  File.swift
//  
//
//  Created by Bradley.yoon on 2021/12/08.
//
import Foundation

struct Formatter {
    static let blanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
