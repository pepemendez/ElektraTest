//
//  Messages.swift
//  Series
//
//  Created by Jose Mendez on 23/10/21.
//

import Foundation

enum Messages: String {
    case EPISODES
    case SEASONS
    case TITLE
    case SERIES_PLAYING
    case SERIES_POPULAR
    case MOVIES_PLAYING
    case MOVIES_POPULAR
    case MOVIE_LENGHT
    case SEASONS_LENGHT
    case WATCH
    case INFO_NOT_AVAILABLE
    
    var localized: String {
        return rawValue.localized
    }
}

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

    func localize(with arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
    }
}
