//
//  Endpoints.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation

struct Endpoints{
    
    private static var domain: String {
        return "https://api.themoviedb.org/3/"
    }
    
    private static var API_KEY: String {
        return "a81381c5b956f86229b9b2bfd78702f4"
    }
    
    public static var images: String {
        return "https://image.tmdb.org/t/p/w300"
    }
    
    
    public static var imagesSmall: String {
        return "https://image.tmdb.org/t/p/w200"
    }
    
    public static var movieNowPlaying: String {
        return domain + "movie/now_playing?api_key=" + API_KEY + "&language=en-US&page=%@"
    }
    
    public static var moviePopular: String {
        return domain + "movie/popular?api_key=" + API_KEY + "&language=en-US&page=%@"
    }
    
    public static var movieDetails: String {
        return domain + "movie/%@?api_key=" + API_KEY + "&language=en-US"
    }
    
    public static var movieVideos: String {
        return domain + "movie/%@/videos?api_key=" + API_KEY + "&language=en-US"
    }
    
    public static var serieDetails: String {
        return domain + "tv/%@?api_key=" + API_KEY + "&language=en-US"
    }
    
    public static var serieVideos: String {
        return domain + "tv/%@/videos?api_key=" + API_KEY + "&language=en-US"
    }
    
    public static var serieNowPlaying: String {
        return domain + "tv/on_the_air?api_key=" + API_KEY + "&language=en-US&page=%@"
    }
    
    public static var seriePopular: String {
        return domain + "tv/popular?api_key=" + API_KEY + "&language=en-US&page=%@"
    }
    
}
