//
//  ViewController.swift
//  DetectScreenCaptured
//
//  Created by Yuta Tokoro on 2021/09/02.
//

import Combine
import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var sensitiveLabel: UILabel?

    var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.publisher(for: UIScreen.capturedDidChangeNotification)
            .sink { notification in
                self.detectCapturedDicChange(notification)
            }
            .store(in: &cancellables)
    }

    private func detectCapturedDicChange(_ notification: Notification) {
        guard let screen = notification.object as? UIScreen else {
            return
        }

        let sensitiveBackgroundColor: UIColor
        if screen.isCaptured {
            sensitiveBackgroundColor = .black
        } else {
            sensitiveBackgroundColor = .clear
        }

        sensitiveLabel?.backgroundColor = sensitiveBackgroundColor
    }
}
