//
//  Utils.swift
//  MovieDBMVVMRx
//
//  Created by Kirill Mazaev on 1/11/20.
//  Copyright © 2020 mazaev. All rights reserved.
//

import UIKit

class Utils {
    
    // URLs
    static let IMAGE_PATH = "https://image.tmdb.org/t/p/w500"
    
    // UIStoryboard names
    static let MOVIES_LIST_SB = "MoviesList"
    static let SEARCH_MOVIES_SB = "SearchMovies"
    static let FAVORITES_MOVIES_SB = "FavoritesMovies"
    static let MOVIE_OVERVIEW_SB = "MovieOverview"
    static let ACTORS_LIST_SB = "ActorsList"
    static let APP_SETTINGS_SB = "AppSettings"
    
    // UIViewCell identifiers
    static let GENRE_CELL = "genre_cell"
    static let MOVIE_CELL = "movie_cell"
    static let FAVORITES_CELL = "favorites_cell"
    static let ACTOR_CELL = "actor_cell"
    static let SETTINGS_CELL = "settings_cell"
    static let THEME_CELL = "theme_cell"
    
    // UserDefaults keys
    static let APP_THEME = "app_theme"
    static let GENRE_NAME = "genre_name"
    static let GENRE_ID = "genre_id"
    
    // Parameter keys
    static let QUERY = "query"
    static let ID = "id"
    static let API_KEY = "api_key"
    static let PAGE = "page"
    
    // UIImage names
    static let BACKDROP_NO_IMAGE = "backdrop_noimg.png"
    static let POSTER_NO_IMAGE = "poster_noimg.png"
    static let MOVIE_TB_ICON = "movie_tb.png"
    static let SEARCH_TB_ICON = "search_tb.png"
    static let FAVOR_TB_ICON = "favor_tb.png"
    static let ACTOR_TB_ICON = "actor_tb.png"
    static let APPSETT_TB_ICON = "sett_tb.png"
    static let ADD_FAB_ICON = "heart.png"
    static let DELETE_FAB_ICON = "del.png"
    
    // Default (first launch application) settings
    static let DEF_THEME = "Light"
    static let DEF_GENRE: (name: String, id: Int) = ("Action", 28)
    
    // UIView tags
    static let POSTER_TAG = 100
    static let FAB_TAG = 200
    
}
