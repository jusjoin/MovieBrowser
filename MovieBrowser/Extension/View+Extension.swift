//
//  View+Extension.swift
//  MovieBrowser
//
//  Created by Zane Francis on 12/8/23.
//  Copyright © 2023 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
