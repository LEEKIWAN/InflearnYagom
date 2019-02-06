//
//  ViewController.swift
//  WebView
//
//  Created by 이기완 on 22/01/2019.
//  Copyright © 2019 이기완. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    
    var url: String? = "http://www.naver.com"
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    
    @IBOutlet weak var goBackButton: UIBarButtonItem!
    @IBOutlet weak var goForwardButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var exportURLButton: UIBarButtonItem!
    @IBOutlet weak var closeWebViewButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.navigationDelegate = self
        
//
//        if (self.url) {
//            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
//        }
        
        HTTPCookieStorage.shared.cookieAcceptPolicy = .always
        
        if let url = self.url {
            self.webView.load(URLRequest(url: URL(string: url)!))
        }
    }

    @IBAction func goBackTouched(_ sender: UIBarButtonItem) {
        self.webView.goBack()
    }
    
    @IBAction func goForwardTouched(_ sender: UIBarButtonItem) {
        self.webView.goForward()
    }
    
    
    @IBAction func refreshTouched(_ sender: UIBarButtonItem) {
        self.webView.reload()
    }
    
    
    @IBAction func exportURLTouched(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let exportAction = UIAlertAction(title: NSLocalizedString("Safari에서 보기", comment: ""), style: .default, handler: { action in
            if let url = URL(string: self.url!) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        
        alertController.addAction(exportAction)
        
        let copyAction = UIAlertAction(title: NSLocalizedString("링크 복사", comment: ""), style: .default, handler: { action in
            UIPasteboard.general.string = self.url
        })
        
        alertController.addAction(copyAction)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("취소", comment: ""), style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    @IBAction func closeWebViewTouched(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.indicatorView.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicatorView.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        
        self.goBackButton.isEnabled = webView.canGoBack;
        self.goForwardButton.isEnabled = webView.canGoForward;

        
        
        self.webView.evaluateJavaScript("document.title") { (value: Any?, error: Error?) in
            
            guard let title: String = value as? String else {
                return
            }
            
            print(title)
        }
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.indicatorView.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

