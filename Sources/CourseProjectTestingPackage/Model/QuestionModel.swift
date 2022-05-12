//
//  QuestionModel.swift
//  CourseProject2.0Testing
//
//  Created by Anastasia on 29.04.2022.
//

import UIKit

public struct QuestionsModel {
    public var questionViewModels: [QuestionModel.QuestionViewModel]
    public var answerViewModels: [QuestionModel.AnswerTextViewModel]
    public var buttonModels: [QuestionModel.NextButtonModel]
    
    public var width: Double
    public var height: Double
    
    public var color: UIColor?
    public var gradient: QuestionModel.Gradient?
    
    public init(
        questionViewModels: [QuestionModel.QuestionViewModel],
        answerViewModels: [QuestionModel.AnswerTextViewModel],
        buttonModels: [QuestionModel.NextButtonModel],
        width: Double,
        height: Double,
        color: UIColor? = nil,
        gradient: QuestionModel.Gradient? = nil
    ) {
        self.questionViewModels = questionViewModels
        self.answerViewModels = answerViewModels
        self.buttonModels = buttonModels
        self.width = width
        self.height = height
        self.color = color
        self.gradient = gradient
    }
}

public struct QuestionModel {
    public struct ViewModel {
        public var cornerRadius: CGFloat?
        public var borderWidth: CGFloat?
        public var borderColor: CGColor?
        
        public var gradient: Gradient?
        public var color: UIColor?
        
        public var topIndent: Double
        public var height: Double
        public var width: Double
        
        public var shadowColor: CGColor?
        public var shadowOffset: CGSize?
        public var shadowOpacity: Float?
        
        public var image: UIImage?
        public var imageHeight: Double?
        public var imageWidth: Double?
        
        public init(
            cornerRadius: CGFloat? = nil,
            borderWidth: CGFloat? = nil,
            borderColor: CGColor? = nil,
            gradient: Gradient? = nil,
            color: UIColor? = nil,
            topIndent: Double,
            height: Double,
            width: Double,
            shadowColor: CGColor? = nil,
            shadowOffset: CGSize? = nil,
            shadowOpacity: Float? = nil,
            image: UIImage? = nil,
            imageHeight: Double? = nil,
            imageWidth: Double? = nil
        ) {
            self.cornerRadius = cornerRadius
            self.borderWidth = borderWidth
            self.borderColor = borderColor
            self.gradient = gradient
            self.color = color
            self.topIndent = topIndent
            self.height = height
            self.width = width
            self.shadowColor = shadowColor
            self.shadowOffset = shadowOffset
            self.shadowOpacity = shadowOpacity
            self.image = image
            self.imageWidth = imageWidth
            self.imageHeight = imageHeight
        }
    }
    
    public struct QuestionViewModel {
        public var question: String
        public var numberOfLines: Int
        public var textColor: UIColor?
        
        public var answer: String?
        public var viewModel: ViewModel
        
        public init(
            question: String,
            numberOfLines: Int,
            textColor: UIColor? = nil,
            answer: String? = nil,
            viewModel: ViewModel
        ) {
            self.question = question
            self.numberOfLines = numberOfLines
            self.textColor = textColor
            self.answer = answer
            self.viewModel = viewModel
        }
    }
    
    public struct AnswerTextViewModel {
        public var viewModel: ViewModel
        public var textContainerInset: UIEdgeInsets?
        
        public init(viewModel: ViewModel, textContainerInset: UIEdgeInsets? = nil) {
            self.viewModel = viewModel
            self.textContainerInset = textContainerInset
        }
    }
    
    public struct NextButtonModel {
        public var content: String
        public var textColor: UIColor?
        public var viewModel: ViewModel
        
        public init(content: String, textColor: UIColor? = nil, viewModel: ViewModel) {
            self.content = content
            self.textColor = textColor
            self.viewModel = viewModel
        }
    }
    
    public struct Gradient {
        public var colorTop: CGColor
        public var colorBottom: CGColor
        
        public init(colorTop: CGColor, colorBottom: CGColor) {
            self.colorTop = colorTop
            self.colorBottom = colorBottom
        }
    }
    
    public init() {
        
    }
}
