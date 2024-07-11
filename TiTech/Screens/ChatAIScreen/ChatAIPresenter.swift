//
//  ChatAIPresenter.swift
//  TiTech
//
//  Created by Apple on 9/7/24.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class ChatAIPresenter {
    
    // MARK: - Private properties -

    private unowned let view: ChatAIViewInterface
    private let interactor: ChatAIInteractorInterface
    private let wireframe: ChatAIWireframeInterface

    // MARK: - Lifecycle -

    init(view: ChatAIViewInterface, interactor: ChatAIInteractorInterface, wireframe: ChatAIWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension ChatAIPresenter: ChatAIPresenterInterface {
    func sendChatRequest(with message: String) {
        self.interactor.handleChatRequest(message: message) { response in
            self.view.didHandleChat(result: response ?? "result: ")
        }
    }
}
