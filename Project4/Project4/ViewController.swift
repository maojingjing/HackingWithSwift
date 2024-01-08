//
//  ViewController.swift
//  Project4
//
//  Created by Jingjing Mao on 1/7/24.
//

import UIKit
import WebKit

class ViewController: UIViewController,
                      WKNavigationDelegate{
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com", "xyz.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem( title: "Open", style: .plain, target: self, action: #selector(openTapped)
        )
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        
        let goBackButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(goBackTapped))
        let goForwardButton = UIBarButtonItem(title: "foward", style: .plain, target: self, action: #selector(goForwardTapped))
        
        toolbarItems = [progressButton, spacer, refresh, goBackButton, goForwardButton]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else {return}
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if (isURLDisallowed(url)) {
            let ac = UIAlertController(title: "alert", message: "The URL is not allowed", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
            decisionHandler(.cancel)
            return
        }
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(.cancel)
    }
    
    func isURLDisallowed(_ url:URL?) -> Bool {
        guard let url = url else {
            return false
        }
        
        let disallowHosts = ["xyz.com"]
        return disallowHosts.contains(url.host ?? "")
    }
    
    
    @objc func goBackTapped() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func goForwardTapped() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
}

