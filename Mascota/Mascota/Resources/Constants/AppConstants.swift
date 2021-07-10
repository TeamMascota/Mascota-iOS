//
//  AppConstants.swift
//  Mascota
//
//  Created by apple on 2021/06/29.
//

import UIKit

struct AppConstants {
    struct Storyboard {
        static let main: String = "Main"
        static let login: String = "Login"
        static let signUp: String = "SignUp"
        static let homeStart: String = "HomeStart"
    }
    struct ViewController {
        static let login: String = "LoginViewController"
        static let rainbow: String = "RainbowViewController"
        static let signUp: String = "SignUpViewController"
        static let homeStart: String = "HomeStartViewController"
    }
    
    struct CollectionViewCells {
        static let bookPageCollectionViewCell: String = "BookPageCollectionViewCell"
        static let homeIndexCollectionViewCell: String = "HomeIndexCollectionViewCell"
        static let mascotaPeopleImageCell: String = "MascotaPeopleImageCell"
        static let partCollectionViewCell: String = "PartCollectionViewCell"
    }
    
    struct CollectionViewHeaders {
        static let homeIndexCollectionReusableView: String = "HomeIndexCollectionReusableView"
    }

    struct TableCells {
        static let bookPage: String = "BookPageTableViewCell"
        static let rainbowBookPage: String = "RainbowBookPageTableViewCell"
        static let rainbowHelpHeader: String = "RainbowHelpHeaderTableViewCell"
        static let rainbowHelpCard: String = "RainbowHelpCardTableViewCell"
        static let rainbowButton: String = "RainbowButtonTableViewCell"
    }

}
