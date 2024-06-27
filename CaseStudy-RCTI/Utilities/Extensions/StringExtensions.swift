//
//  StringExtensions.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 26/06/24.
//

import Foundation

extension String {
    func formattedViews() -> String {
        guard let num = Double(self.replacingOccurrences(of: ",", with: "")) else {
            return self
        }
        
        let thousand = num / 1000
        let million = num / 1_000_000
        let billion = num / 1_000_000_000
        
        if billion >= 1.0 {
            return String(format: "%.1fB", billion)
        } else if million >= 1.0 {
            return String(format: "%.1fM", million)
        } else if thousand >= 1.0 {
            return String(format: "%.1fK", thousand)
        } else {
            return self
        }
    }
    
    func formattedSubscribers() -> String {
        // Extract the number from the string
        guard let number = Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) else {
            return self
        }
        
        // Define suffixes and formatting rules
        let suffixes = ["", "K", "M", "B", "T"]
        var index = 0
        var value = Double(number)
        
        // Determine the appropriate suffix
        while value >= 1000 && index < suffixes.count - 1 {
            value /= 1000
            index += 1
        }
        
        // Format the value
        let formattedValue = String(format: "%.0f", value)
        
        return "\(formattedValue)\(suffixes[index]) Subscribers"
    }
}
