//
//  String+Extensions.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import Foundation


extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isValidEmailAddress: Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: self)
    }
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    func localizedString(locale: Locale) -> String {
        let path = Bundle.main.path(forResource: locale.identifier, ofType: "lproj")
        let bundle = path.flatMap { Bundle(path: $0) } ?? .main
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
