//
//  SafariView.swift
//  SteamApp
//
//  Created by Artem Vorobev on 29.05.2023.
//

import SwiftUI
import SafariServices

struct SFSafariViewWrapper: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)
        vc.preferredControlTintColor = .tintColor
        vc.dismissButtonStyle = .close
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ vc: SFSafariViewController, context: Context) {}
    
    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        var dismissAction: DismissAction?
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            dismissAction?()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator()
        coordinator.dismissAction = dismiss
        return coordinator
    }
}
