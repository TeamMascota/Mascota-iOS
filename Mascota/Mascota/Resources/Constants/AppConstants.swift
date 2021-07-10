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
        static let indexEdit: String = "IndexEdit"
        static let indexDetail: String = "IndexDetail"
    }
    struct ViewController {
        static let login: String = "LoginViewController"
        static let rainbow: String = "RainbowViewController"
        static let signUp: String = "SignUpViewController"
        static let homeStart: String = "HomeStartViewController"
        static let indexEdit: String = "IndexEditViewController"
    }
    
    struct Views {
        static let customLabelAlertView: String = "CustomLabelAlertView"
        static let customTextFieldAlertView: String = "CustomTextFieldAlertView"
        static let indexDetail: String = "IndexDetailViewController"
    }
    
    struct CollectionViewCells {
        static let bookPageCollectionViewCell: String = "BookPageCollectionViewCell"
        static let homeIndexCollectionViewCell: String = "HomeIndexCollectionViewCell"
        static let mascotaPeopleImageCell: String = "MascotaPeopleImageCell"
        static let partCollectionViewCell: String = "PartCollectionViewCell"
        static let indexEditCollectionViewCell: String = "IndexEditCollectionViewCell"
        static let indexEditPrologueCollectionViewCell: String = "IndexEditPrologueCollectionViewCell"
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
        
        static let indexDetailTableViewCell: String = "IndexDetailTableViewCell"
        
    }
    
    struct TableViewHeaders {
        static let indexDetailHeaderView: String = "IndexDetailHeaderView"
    }

}
