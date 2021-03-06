//
//  EmojiStyle.swift
//  Mascota
//
//  Created by 김윤서 on 2021/07/14.
//

import UIKit

enum EmojiColor {
    case darkGray
    case lightGray
}

struct EmojiStyle {
    enum Human: Int {
        case deny = 6
        case angry
        case loss
        case sad
        case accept
        
        func image(color: EmojiColor? = .darkGray) -> UIImage? {
            var imageString = "emoHuman"
            switch self {
            case .deny:
                imageString += "Deny"
            case .angry:
                imageString += "Angry"
            case .loss:
                imageString += "Loss"
            case .sad:
                imageString += "Sad"
            case .accept:
                imageString += "Accept"
            }
            
            switch color {
            case .darkGray:
                imageString += "Darkgray"
            case .lightGray:
                imageString += "Lightgray"
            case .none: break
            }
            
            return UIImage(named: imageString)
        }
        
        func text() -> String {
            switch self {
            case .deny:
                return "부인"
            case .angry:
                return "화남"
            case .loss:
                return "상실"
            case .sad:
                return "우울"
            case .accept:
                return "수용"
            }
        }
    }
    
    enum Dog: Int {
        case love = 0
        case joy
        case usual
        case sad
        case angry
        case boring
        
        func image(color: EmojiColor? = .darkGray) -> UIImage? {
            var imageString = "emoDog"
            switch self {
            case .love:
                imageString += "Love"
            case .joy:
                imageString += "Joy"
            case .usual:
                imageString += "Usual"
            case .sad:
                imageString += "Sad"
            case .angry:
                imageString += "Angry"
            case .boring:
                imageString += "Boring"
            }
            
            switch color {
            case .darkGray:
                imageString += "Darkgray"
            case .lightGray:
                imageString += "Lightgray"
            case .none: break
            }
            
            return UIImage(named: imageString)
        }
        
        func text() -> String {
            switch self {
            case .love:
                return "사랑"
            case .joy:
                return "기쁨"
            case .usual:
                return "보통"
            case .sad:
                return "우울"
            case .angry:
                return "화남"
            case .boring:
                return "심심"
            }
        }
    }
    
    enum Cat: Int {
        case love = 0
        case joy
        case usual
        case sad
        case angry
        case boring
        
        func image(color: EmojiColor? = .darkGray) -> UIImage? {
            var imageString = "emoCat"
            switch self {
            case .love:
                imageString += "Love"
            case .joy:
                imageString += "Joy"
            case .usual:
                imageString += "Usual"
            case .sad:
                imageString += "Sad"
            case .angry:
                imageString += "Angry"
            case .boring:
                imageString += "Boring"
            }
            
            switch color {
            case .darkGray:
                imageString += "Darkgray"
            case .lightGray:
                imageString += "Lightgray"
            case .none: break
            }
            
            return UIImage(named: imageString)
        }
        
        func text() -> String {
            switch self {
            case .love:
                return "사랑"
            case .joy:
                return "기쁨"
            case .usual:
                return "보통"
            case .sad:
                return "우울"
            case .angry:
                return "화남"
            case .boring:
                return "심심"
            }
        }
    }
    
    func getEmoji(kind: Int, feeling: Int, color: EmojiColor? = .darkGray) -> UIImage? {
        switch kind {
        case 0:
            let human = Human.init(rawValue: feeling)
            return human?.image(color: color)
        case 1:
            let dog = Dog.init(rawValue: feeling)
            return dog?.image(color: color)
        case 2:
            let cat = Cat.init(rawValue: feeling)
            return cat?.image(color: color)
        default:
            return UIImage()
        }
    }
    
    func getEmojiText(kind: Int, feeling: Int, color: EmojiColor? = .darkGray) -> String {
        switch kind {
        case 0:
            let human = Human.init(rawValue: feeling)
            return human?.text() ?? ""
        case 1:
            let dog = Dog.init(rawValue: feeling)
            return dog?.text() ?? ""
        case 2:
            let cat = Cat.init(rawValue: feeling)
            return cat?.text() ?? ""
        default:
            return ""
        }
    }
}
