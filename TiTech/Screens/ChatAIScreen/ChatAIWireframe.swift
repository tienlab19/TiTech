//
//  ChatAIWireframe.swift
//  TiTech
//
//  Created by Apple on 9/7/24.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class ChatAIWireframe: BaseWireframe<ChatAIViewController> {

    // MARK: - Private properties -

    private let storyboard = UIStoryboard(name: "ChatAI", bundle: nil)
    private let service = ChatService()

    // MARK: - Module setup -

    init() {
        let moduleViewController = storyboard.instantiateViewController(ofType: ChatAIViewController.self)
        super.init(viewController: moduleViewController)

        let interactor = ChatAIInteractor(chatService: service)
        let presenter = ChatAIPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
        
        moduleViewController.title = "ChatAI"
    }

}

// MARK: - Extensions -

extension ChatAIWireframe: ChatAIWireframeInterface {

}
