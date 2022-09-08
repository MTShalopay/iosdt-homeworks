//
//  Post.swift
//  Navigation
//
//  Created by Shalopay on 27.05.2022.
//

import Foundation
import UIKit

public struct Post {
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    
    public static func setupPost() -> [Post] {
            var tempPost = [Post]()
            tempPost.append(Post(author: "Табак Dark Side Core - SUPERNOVA (Холодок, 100 грамм)", description: "Отнесись с осторожностью! Взрывает мозг, как взрывается суперновая звезда. Концентрированный аромат ментолового льда, который невозможно курить соло. Применяется только в миксах в очень скромных пропорциях. Если переборщить, можно почувствовать себя Саб-Зиро.", image: "SUPERNOVA", likes: 112312, views: 13435345))
            tempPost.append(Post(author: "Табак Dark Side Core - DARKSIDE COLA (Кола, 100 грамм)", description: "Столь насыщенной и яркой колы мы давненько уже не пробовали. По сути, сам вкус прост: сладость и кислинка. В том-то и дело, что эти два компонента должны объединяться в реально крутое сочетание, которое не оставляет никого равнодушным. И в данном случае у создателей это получилось. Убедись сам!", image: "COLA", likes: 112311, views: 13311))
            tempPost.append(Post(author: "Табак Dark Side Core - BERGAMONSTR (100 грамм)", description: "Один из топовых ароматов, который идеально миксуется с кислыми цитрусовыми табаками. Прекрасный бергамот, который, совсем не Эрл Грей, а только лишь отдаленно на него похож. Слегка терпковатый аромат с ярким послевкусием. Отлично сочетается с хорошим черным чаем!", image: "BERGAMONSTR ", likes: 222, views: 222))
            tempPost.append(Post(author: "Табак Dark Side Core - MANGO LASSI (100 грамм)", description: "Насыщенный аромат тропического манго - спелого и сочного, освежающего и сладкого. Вкус, реально, прикольный, может показаться слегка приторным, но это лишь на первый взгляд. В целом, же удачный тропический вкус, которому, однако не хватает легкой кислинки.", image: "MANGOLASSI", likes: 333, views: 333))
                return tempPost
        }
}

public struct PostImage {
    public var image: String
    
    public static func setupImages() -> [PostImage]{
        let data = ["pucture1","pucture2","pucture3","pucture4","pucture5",
                    "pucture6","pucture7","pucture8","pucture9","pucture10",
                    "pucture11","pucture12","pucture13","pucture14","pucture15",
                    "pucture16","pucture17","pucture18","pucture19","pucture20",]
        var tempImage = [PostImage]()
        for (_, names) in data.enumerated() {
            tempImage.append(PostImage(image: names))
        }
        return tempImage
    }
    public static func makeArrayImage() -> [UIImage] {
        var tempImages = [UIImage]()
        let data = ["pucture1","pucture2","pucture3","pucture4","pucture5",
                    "pucture6","pucture7","pucture8","pucture9","pucture10",
                    "pucture11","pucture12","pucture13","pucture14","pucture15",
                    "pucture16","pucture17","pucture18","pucture19","pucture20",]
        for (_,name) in data.enumerated() {
            tempImages.append(UIImage(named: name)!)
        }
        return tempImages
    }
}

