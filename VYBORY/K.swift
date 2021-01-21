//
//  K.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 13.01.2021.
//

import Foundation
import UIKit

struct K {
    
    //    MARK: - Colors, Images
    struct Color {
        
        static let MyBlue = UIColor(named: "myBlue")!
        static let MyPrimaLabel = UIColor(named: "myPrimaLabel")!
    }
    
    struct Image {
        
        static let BookImages = ["01_book_01", "01_book_02", "01_book_03", "01_book_04"]
        static let heart = UIImage(systemName: "heart")
        static let heartFill = UIImage(systemName: "heart.fill")
        
    }
    //    MARK: - Database
    struct Database {
        
        static let NilItem = "Виключена."
        
        struct Table {
            static let Books = "books"
            static let Chapters = "chapters"
            static let Articles = "articles"
            
        }
        
        struct Row {
            static let Title = "title"
            static let Number = "number"
            static let Content = "content"
            static let Favourite = "favourite"
            static let ChapterNumber = "chapter_number"
            static let BookNumber = "book_number"
        }
    }
    //    MARK: - Placeholder
    struct Placeholder {
        
        struct Image {
            static let Dog = UIImage(named: "dog_1")
            static let DogCry = UIImage(named: "dog_2")
        }
        
        struct Text {
            static let Protocols = "ПРОТОКОЛИ В РОЗРОБЦІ"
            static let FindSomething = "ЩОСЬ ЗНАЙТИ?"
            static let NothingFound = "НІЧОГО НЕ ЗНАЙДЕНО"
        }
        
    }
    //    MARK: - AboutUs
    struct AboutUsText {
        
        struct URLs {
            struct SocialMedia {
                static let Facebook = URL(string: "https://www.facebook.com/cn.opora")
                static let Twitter = URL(string: "https://twitter.com/opora")
                static let Telegram = URL(string: "https://t.me/opora_news")
                static let Instagram = URL(string: "https://www.instagram.com/cn.opora/")
                static let YouTube = URL(string: "https://www.youtube.com/user/oporavideo")
                
            }
            
            struct Platforms {
                static let Website = URL(string: "https://oporaua.org/")!
                static let Map = URL(string: "https://oporaua.org/map-reports")!
                static let Dani = URL(string: "https://danivyboriv.net/")!
                static let Analizator = URL(string: "https://fb.oporaua.org/")!
            }
        }
        
        struct Text {
            
            static let WebsiteLinkString = "Вебсайт \n"
            static let MapLinkString = "Мапа порушень \n"
            static let DaniLinkString = "Все про виборчі дані та соцмережі \n"
            static let AnalizatorLinkString = "Аналізатор політичної реклами \n \n"
            
            static let String1 =                                                                 """
            Громадянська мережа ОПОРА – одна з провідних неурядових та позапартійних всеукраїнських організацій громадського контролю у сфері виборів.
            З 2007 року ОПОРА аналізує виборчий процес, проводить спостереження за всіма його етапами, працює над удосконаленням виборчого законодавства відповідно до міжнародних стандартів. Загалом за цей час до моніторингу виборів було залучено понад 20 тисяч кваліфікованих спостерігачів.

            Для своїх спостерігачів, та усіх інших учасників виборчого процесу ми розробили цей мобільний додаток із виборчим кодексом та верифікатором протоколу, який знадобиться вам у ніч підрахунку голосів. Тепер виборчий кодекс буде завжди із вами, а зручний пошук дозволить швидко знайти необхідну статтю.

            Отримати усю оперативну інформацію про перебіг Місцевих виборів 2020 року Ви можете тут: \n \n
            """
            static let String2 = "І не забувайте стежити за нами в соціальних мережах:"
            
        }
    }
    //    MARK: - Identifiers
    struct Identifiers {
        
        struct Segue {
            static let GoToChapter = "goToChapter"
            static let GoToAboutUs = "goToAboutUs"
            static let GoToArticles = "goToArticles"
            static let GoToArticle = "goToArticle"
            static let GoToFavoriteArticle = "goToFavoriteArticle"
            static let GoToSearchArticle = "goToSearchArticle"
        }
        
        struct Cell {
            static let BookCell = "BookCell"
            static let ChapterCell = "ChapterCell"
            static let ArticleCell = "ArticleCell"
            static let FavoriteCell = "FavoriteCell"
            static let SearchResultCell = "SearchResultCell"
        }
    }
}
