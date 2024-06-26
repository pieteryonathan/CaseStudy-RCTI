//
//  StringExtensions.swift
//  CaseStudy-RCTI
//
//  Created by Pieter Yonathan on 26/06/24.
//

import Foundation

extension String {
    func formattedStringToViewsCurrency() -> String {
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
}
